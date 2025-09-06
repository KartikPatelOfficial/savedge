import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/home/presentation/widgets/widgets.dart';
import 'package:savedge/features/stores/presentation/pages/stores_page.dart';
import 'package:savedge/features/stores/presentation/pages/vendor_detail_page.dart';
import 'package:savedge/features/subscription/presentation/bloc/subscription_plan_bloc.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/presentation/bloc/coupons_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_event.dart';

/// Beautiful home content page with modern design and real data integration
class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  late final CouponsBloc _couponsBloc;
  late final VendorsBloc _vendorsBloc;
  late final SubscriptionPlanBloc _subscriptionBloc;
  final GlobalKey<SubscriptionPlansSectionState> _subscriptionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _couponsBloc = getIt<CouponsBloc>();
    _vendorsBloc = getIt<VendorsBloc>();
    _subscriptionBloc = getIt<SubscriptionPlanBloc>();
    _loadInitialData();
  }

  void _loadInitialData() {
    _couponsBloc.add(const LoadFeaturedCoupons(pageSize: 5));
    _vendorsBloc.add(const LoadVendors(pageSize: 10));
    _subscriptionBloc.add(const LoadSubscriptionPlans());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _couponsBloc.close();
    _vendorsBloc.close();
    _subscriptionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _couponsBloc),
        BlocProvider.value(value: _vendorsBloc),
        BlocProvider.value(value: _subscriptionBloc),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: HomeDrawer(
          userName: 'Welcome',
          onMenuItemTap: _onDrawerMenuItemTap,
        ),
        body: _buildMainContent(),
      ),
    );
  }

  Widget _buildMainContent() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: const Color(0xFF1A202C),
      backgroundColor: Colors.white,
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
                    _buildSubscriptionPlansSection(),
                    _buildTopOffersSection(),
                    const SizedBox(height: 40),
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
      expandedHeight: 80,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
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
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _onMenuTap,
                            borderRadius: BorderRadius.circular(12),
                            child: const Center(
                              child: Icon(
                                Icons.menu_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Action buttons
                      _buildActionButton(
                        icon: Icons.favorite_outline,
                        onTap: _onFavoriteTap,
                      ),
                      const SizedBox(width: 12),
                      _buildActionButton(
                        icon: Icons.notifications_none,
                        onTap: _onNotificationTap,
                        hasBadge: true,
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

  Widget _buildCategoriesSection() {
    return CategoriesSection(onCategoryTap: _onCategoryTap);
  }

  Widget _buildSubscriptionPlansSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SubscriptionPlansSection(key: _subscriptionKey),
    );
  }

  Widget _buildHotDealsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: const HotDealsSection(),
    );
  }

  Widget _buildTopOffersSection() {
    return TopOffersSection(onVendorTap: _onVendorTap);
  }

  // Event handlers
  void _onFavoriteTap() {
    HapticFeedback.lightImpact();
    debugPrint('Favorite tap');
  }

  void _onNotificationTap() {
    HapticFeedback.lightImpact();
    debugPrint('Notification tap');
  }

  void _onMenuTap() {
    HapticFeedback.lightImpact();
    _scaffoldKey.currentState?.openDrawer();
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

    // Reload all data from BLoCs
    _couponsBloc.add(const LoadFeaturedCoupons(pageSize: 5));
    // Use refresh event to avoid duplicate vendors on pull-to-refresh
    _vendorsBloc.add(const RefreshVendors());
    _subscriptionBloc.add(const LoadSubscriptionPlans());

    // Also refresh subscription section if it has its own state
    _subscriptionKey.currentState?.checkSubscriptionStatus();

    // Wait for data to load (approximate time)
    await Future.delayed(const Duration(milliseconds: 800));
  }
}
