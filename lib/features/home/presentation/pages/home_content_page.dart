import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/city/presentation/bloc/city_bloc.dart';
import 'package:savedge/features/city/presentation/bloc/city_state.dart';
import 'package:savedge/features/city/presentation/widgets/city_selection_sheet.dart';
import 'package:savedge/features/favorites/presentation/pages/favorites_page.dart';
import 'package:savedge/features/free_trial/presentation/bloc/free_trial_bloc.dart';
import 'package:savedge/features/promotion/presentation/bloc/promotion_bloc.dart';
import 'package:savedge/features/promotion/presentation/widgets/promotion_banner.dart';
import 'package:savedge/features/promotion/presentation/widgets/promotion_enrollment_dialog.dart';
import 'package:savedge/features/home/presentation/widgets/widgets.dart';
import 'package:savedge/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:savedge/features/stores/presentation/pages/stores_page.dart';
import 'package:savedge/features/stores/presentation/pages/vendor_detail_page.dart';
import 'package:savedge/features/subscription/presentation/bloc/subscription_plan_bloc.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/presentation/bloc/coupons_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_event.dart';
import 'package:savedge/core/widgets/login_prompt.dart';

/// Beautiful home content page with modern design and real data integration
class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key, this.onMenuTap, this.isGuest = false});
  final VoidCallback? onMenuTap;
  final bool isGuest;

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  late final CouponsBloc _couponsBloc;
  late final VendorsBloc _vendorsBloc;
  int _topOffersRefreshKey = 0;
  late final SubscriptionPlanBloc _subscriptionBloc;
  late final FreeTrialBloc _freeTrialBloc;
  late final PromotionBloc _promotionBloc;

  bool _isEmployee = false;
  bool _hasLoadedFreeTrialStatus = false;
  bool _hasShownPromotionDialog = false;
  String _userName = 'Welcome';

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  @override
  void initState() {
    super.initState();
    _couponsBloc = getIt<CouponsBloc>();
    _vendorsBloc = getIt<VendorsBloc>();
    _subscriptionBloc = getIt<SubscriptionPlanBloc>();
    _freeTrialBloc = getIt<FreeTrialBloc>();
    _promotionBloc = getIt<PromotionBloc>();
    _loadInitialData();
    if (!widget.isGuest) {
      _loadUserProfile();
    }
  }

  void _loadInitialData() {
    // Get city ID from CityBloc state
    final cityState = context.read<CityBloc>().state;
    final cityId = cityState is CitiesLoaded ? cityState.selectedCityId : null;

    // Load Hot Deals (special offers) with city filter
    _couponsBloc.add(LoadSpecialOfferCoupons(cityId: cityId));
    _subscriptionBloc.add(const LoadSubscriptionPlans());
    if (!widget.isGuest) {
      _promotionBloc.add(const PromotionEvent.checkStatus());
    }
  }

  /// Reload data when city changes
  void _onCityChanged(int? cityId) {
    _couponsBloc.add(LoadSpecialOfferCoupons(cityId: cityId));
    // TopOffersSection manages its own bloc and reacts to cityId changes via didUpdateWidget
    setState(() {}); // Trigger rebuild to pass new cityId to TopOffersSection
  }

  Future<void> _loadUserProfile() async {
    var isEmployee = false;
    var displayName = 'Welcome';

    try {
      final UserProfileResponse3 profile = await _authRepository
          .getCurrentUserProfile();
      isEmployee = profile.isEmployee;
      displayName = profile.fullName.isNotEmpty ? profile.fullName : 'Welcome';
    } catch (_) {
      // Default values already set; fall through so UI keeps showing fallback
    }

    if (!mounted) return;

    setState(() {
      _isEmployee = isEmployee;
      _userName = displayName;
    });

    _maybeLoadFreeTrialStatus(isEmployee);
  }

  void _maybeLoadFreeTrialStatus(bool isEmployee) {
    if (_hasLoadedFreeTrialStatus || isEmployee) {
      return;
    }

    _hasLoadedFreeTrialStatus = true;
    _freeTrialBloc.add(const FreeTrialEvent.loadStatus());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _couponsBloc),
        BlocProvider.value(value: _vendorsBloc),
        BlocProvider.value(value: _subscriptionBloc),
        BlocProvider.value(value: _freeTrialBloc),
        BlocProvider.value(value: _promotionBloc),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CityBloc, CityState>(
            listener: (context, state) {
              if (state is CitiesLoaded) {
                _onCityChanged(state.selectedCityId);
              }
            },
          ),
          BlocListener<PromotionBloc, PromotionState>(
            listener: (context, state) {
              state.whenOrNull(
                active: (status) {
                  if (!status.isEnrolled && !_hasShownPromotionDialog) {
                    _hasShownPromotionDialog = true;
                    PromotionEnrollmentDialog.show(context);
                  }
                },
              );
            },
          ),
        ],
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: _buildMainContent(),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: const Color(0xFF1A202C),
      backgroundColor: Colors.transparent,
      displacement: 80,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          _buildModernAppBar(),
          SliverToBoxAdapter(
            child: AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 600),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(child: widget),
                  ),
                  children: [
                    _buildHotDealsSection(),
                    _buildCategoriesSection(),
                    const PromotionBanner(),
                    BlocBuilder<PromotionBloc, PromotionState>(
                      builder: (context, state) {
                        final isPromotionActive = state.maybeWhen(
                          active: (status) => status.isPromotionActive,
                          orElse: () => false,
                        );
                        if (isPromotionActive) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SubscriptionCarousel(isGuest: widget.isGuest),
                        );
                      },
                    ),
                    _buildTopOffersSection(),
                    // Bottom padding to prevent content from being hidden
                    // behind the floating bottom navigation bar
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernAppBar() {
    return SliverAppBar(
      expandedHeight: 90,
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: false,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
             color: Colors.transparent,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              child: Column(
                children: [
                  // Top row with menu and action buttons
                  Row(
                    children: [
                      // Menu button
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A202C),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1A202C).withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _onMenuTap,
                            borderRadius: BorderRadius.circular(16),
                            child: const Center(
                              child: Icon(
                                Icons.segment_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // City selector button
                      Expanded(child: _buildCityButton()),
                      const SizedBox(width: 16),
                      // Action buttons
                      _buildNotificationButton(),
                      const SizedBox(width: 12),
                      _buildActionButton(
                        icon: Icons.favorite_border_rounded,
                        onTap: _onFavoriteTap,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCityButton() {
    return BlocBuilder<CityBloc, CityState>(
      builder: (context, state) {
        String cityName = 'Select City';
        if (state is CitiesLoaded && state.selectedCityName != null) {
          cityName = state.selectedCityName!;
        }

        return GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            CitySelectionSheet.show(context);
          },
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 6,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Color(0xFF1A202C),
                ),
                const SizedBox(width: 4),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 80),
                  child: Text(
                    cityName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A202C),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: Color(0xFF1A202C),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasBadge = false,
  }) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Center(
                child: Icon(icon, size: 20, color: const Color(0xFF1A202C)),
              ),
            ),
          ),
          if (hasBadge)
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationButton() {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        final unreadCount = state.unreadCount;

        return Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Stack(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _onNotificationTap,
                  borderRadius: BorderRadius.circular(12),
                  child: const Center(
                    child: Icon(
                      Icons.notifications_outlined,
                      size: 20,
                      color: Color(0xFF1A202C),
                    ),
                  ),
                ),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        unreadCount > 99 ? '99+' : unreadCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: unreadCount > 99 ? 8 : 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoriesSection() {
    return CategoriesSection(onCategoryTap: _onCategoryTap);
  }

  Widget _buildHotDealsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: const HotDealsSection(),
    );
  }

  Widget _buildTopOffersSection() {
    final cityState = context.read<CityBloc>().state;
    final cityId = cityState is CitiesLoaded ? cityState.selectedCityId : null;
    return TopOffersSection(
      key: ValueKey('top_offers_$_topOffersRefreshKey'),
      onVendorTap: _onVendorTap,
      cityId: cityId,
    );
  }

  // Event handlers
  void _onFavoriteTap() {
    HapticFeedback.lightImpact();
    if (widget.isGuest) {
      LoginPrompt.show(context, message: 'Sign in to save your favorite stores.');
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoritesPage()),
    );
  }

  void _onNotificationTap() {
    HapticFeedback.lightImpact();
    if (widget.isGuest) {
      LoginPrompt.show(context, message: 'Sign in to view your notifications.');
      return;
    }
    Navigator.pushNamed(context, '/notifications');
  }

  void _onMenuTap() {
    HapticFeedback.lightImpact();
    if (widget.onMenuTap != null) {
      widget.onMenuTap!();
    } else {
      _scaffoldKey.currentState?.openDrawer();
    }
  }

  void _onCategoryTap(String category) {
    HapticFeedback.lightImpact();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StoresPage(initialCategory: category),
      ),
    );
  }

  void _onDrawerMenuItemTap(String menuTitle) {
    HapticFeedback.lightImpact();
    debugPrint('Drawer menu item tapped: $menuTitle');
  }

  void _onVendorTap(Vendor vendor) {
    HapticFeedback.lightImpact();
    // Navigate to vendor detail page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendorDetailPage(vendorId: vendor.id),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    HapticFeedback.lightImpact();

    // Get city ID from CityBloc state
    final cityState = context.read<CityBloc>().state;
    final cityId = cityState is CitiesLoaded ? cityState.selectedCityId : null;

    // Reload all data from BLoCs
    // Refresh Hot Deals (special offers) with city filter
    _couponsBloc.add(RefreshSpecialOfferCoupons(cityId: cityId));
    // Refresh Top Offers by recreating the section's bloc
    setState(() => _topOffersRefreshKey++);
    if (!widget.isGuest) {
      _subscriptionBloc.add(const LoadSubscriptionPlans());
      if (!_isEmployee) {
        _freeTrialBloc.add(const FreeTrialEvent.loadStatus());
      }
      _promotionBloc.add(const PromotionEvent.checkStatus());
    }

    // Wait for data to load (approximate time)
    await Future.delayed(const Duration(milliseconds: 800));
  }
}
