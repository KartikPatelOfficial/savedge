import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/coupons/data/models/coupon_gifting_models.dart';
import 'package:savedge/features/coupons/data/models/user_coupon_model.dart';
import 'package:savedge/features/coupons/presentation/bloc/coupon_manager_bloc.dart';
import 'package:savedge/features/coupons/presentation/bloc/coupon_manager_event.dart';
import 'package:savedge/features/coupons/presentation/bloc/coupon_manager_state.dart';
import 'package:savedge/features/coupons/presentation/pages/coupon_confirmation_page.dart';
import 'package:savedge/features/coupons/presentation/pages/redeemed_coupon_page.dart';
import 'package:savedge/features/coupons/presentation/widgets/coupon_card.dart';
import 'package:savedge/features/coupons/presentation/widgets/coupon_filter_sheet.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CouponManagerBloc>()..add(const LoadAllCoupons()),
      child: const CouponsView(),
    );
  }
}

class CouponsView extends StatefulWidget {
  const CouponsView({super.key});

  @override
  State<CouponsView> createState() => _CouponsViewState();
}

class _CouponsViewState extends State<CouponsView> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Add shadow to filters when scrolled
    final scrolled = _scrollController.offset > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: BlocBuilder<CouponManagerBloc, CouponManagerState>(
          builder: (context, state) {
            if (state is CouponManagerLoading) {
              return _buildLoadingView();
            } else if (state is CouponManagerError) {
              return _buildErrorView(state.message);
            } else if (state is CouponManagerLoaded) {
              return _buildCouponsView(context, state);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6F3FCC),
                strokeWidth: 3,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Loading your coupons...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Getting your best deals ready',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.error_outline,
                size: 48,
                color: const Color(0xFFEF4444).withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            _buildRetryButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponsView(BuildContext context, CouponManagerLoaded state) {
    // Get the coupons to display (filtered or all)
    final coupons = state.filteredCoupons ?? _getAllCoupons(state.couponsData);
    final activeFilterCount = _getActiveFilterCount(state);

    return RefreshIndicator(
      onRefresh: () async {
        HapticFeedback.lightImpact();
        context.read<CouponManagerBloc>().add(const RefreshAllCoupons());
        // Wait for the refresh to complete
        await Future.delayed(const Duration(milliseconds: 500));
      },
      color: const Color(0xFF6F3FCC),
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          // Collapsing Header like Profile Page
          _buildCollapsingHeader(activeFilterCount),

          // Spacing before coupons
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Coupons List or Empty State
          coupons.isEmpty
              ? SliverFillRemaining(
                  child: _buildEmptyState(state.selectedStatus),
                )
              : _buildCouponsSliverList(coupons),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _buildCollapsingHeader(int activeFilterCount) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: _isScrolled ? 2 : 0,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Calculate how much the header has collapsed
          final double collapsedPercentage =
              ((constraints.maxHeight - kToolbarHeight) /
                      (120 - kToolbarHeight))
                  .clamp(0.0, 1.0);

          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(
              left: 16,
              bottom: 16 * collapsedPercentage + 8,
            ),
            title: Text(
              'My Coupons',
              style: TextStyle(
                color: Color(0xFF1A202C),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
      ),
      actions: [
        // Filter button with badge
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.tune_rounded, color: Color(0xFF6F3FCC)),
              onPressed: () => _showFilterSheet(
                context,
                context.read<CouponManagerBloc>().state as CouponManagerLoaded,
              ),
            ),
            if (activeFilterCount > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '$activeFilterCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildCouponsSliverList(List<UserCouponDetailModel> coupons) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final coupon = coupons[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CouponCard(
              coupon: coupon,
              onTap: () => _handleCouponTap(coupon),
            ),
          );
        }, childCount: coupons.length),
      ),
    );
  }

  Widget _buildEmptyState(String? selectedStatus) {
    IconData icon;
    String message;
    String submessage;
    Color color;

    switch (selectedStatus) {
      case 'Active':
        icon = Icons.local_offer_outlined;
        message = 'No active coupons found';
        submessage = 'Browse stores to find amazing deals!';
        color = const Color(0xFF10B981);
        break;
      case 'Used':
        icon = Icons.check_circle_outline;
        message = 'No used coupons yet';
        submessage = 'Start saving with your active coupons!';
        color = const Color(0xFF6366F1);
        break;
      case 'Expired':
        icon = Icons.schedule_outlined;
        message = 'No expired coupons';
        submessage = 'Great job using your coupons on time!';
        color = const Color(0xFFEF4444);
        break;
      default:
        icon = Icons.wallet_giftcard_outlined;
        message = 'No coupons found';
        submessage = 'Your savings will appear here';
        color = const Color(0xFF6F3FCC);
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: color.withValues(alpha: 0.2),
                  width: 2,
                ),
              ),
              child: Icon(icon, size: 48, color: color.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              submessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRetryButton() {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF6F3FCC), Color(0xFF9F7AEA)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6F3FCC).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            context.read<CouponManagerBloc>().add(const RefreshAllCoupons());
          },
          borderRadius: BorderRadius.circular(16),
          child: const Center(
            child: Text(
              'Try Again',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context, CouponManagerLoaded state) {
    HapticFeedback.lightImpact();

    // Capture bloc reference before opening bottom sheet
    final bloc = context.read<CouponManagerBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CouponFilterSheet(
        selectedStatus: state.selectedStatus ?? 'All',
        selectedCategories: state.selectedCategories ?? [],
        couponsData: state.couponsData,
        onFiltersChanged: (status, categories) {
          // Apply both filters using captured bloc reference
          bloc.add(
            ApplyFilters(
              status: status,
              categories: categories,
              vendorId: null,
            ),
          );
        },
      ),
    );
  }

  int _getActiveFilterCount(CouponManagerLoaded state) {
    int count = 0;
    if (state.selectedStatus != null && state.selectedStatus != 'All') {
      count++;
    }
    if (state.selectedCategories != null &&
        state.selectedCategories!.isNotEmpty) {
      count++;
    }
    if (state.selectedVendorId != null) {
      count++;
    }
    return count;
  }

  void _handleCouponTap(UserCouponDetailModel coupon) async {
    HapticFeedback.lightImpact();

    if (coupon.isExpired) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('This coupon has expired.')));
      return;
    }

    if (coupon.isUsed) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) =>
              RedeemedCouponPage(userCoupon: _convertToUserCouponModel(coupon)),
        ),
      );
      return;
    }

    // Active coupon → go to confirmation to use
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => CouponConfirmationPage(
          userCoupon: coupon,
          confirmationType: CouponConfirmationType.use,
        ),
      ),
    );

    // Refresh coupons if the action was successful
    if (result == true && mounted) {
      context.read<CouponManagerBloc>().add(const RefreshAllCoupons());
    }
  }

  UserCouponModel _convertToUserCouponModel(UserCouponDetailModel userCoupon) {
    return UserCouponModel(
      id: userCoupon.id,
      couponId: userCoupon.couponId,
      title: userCoupon.title,
      description: userCoupon.description ?? userCoupon.title,
      discountValue: userCoupon.discountValue,
      discountType: userCoupon.discountType,
      discountDisplay: userCoupon.discountDisplay,
      minCartValue: userCoupon.minCartValue ?? 0.0,
      maxDiscountAmount: 0.0,
      vendorId: userCoupon.vendorId,
      vendorUserId: userCoupon.vendorUserId,
      vendorName: userCoupon.vendorName,
      expiryDate: userCoupon.expiryDate.toIso8601String(),
      isUsed: userCoupon.isUsed,
      usedAt: userCoupon.redeemedDate?.toIso8601String(),
      claimedAt: userCoupon.acquiredDate.toIso8601String(),
      isGifted: userCoupon.isGifted,
      terms: null,
      imageUrl: userCoupon.imageUrl,
      redemptionCode: userCoupon.uniqueCode,
    );
  }

  List<UserCouponDetailModel> _getAllCoupons(UserCouponsResponseModel data) {
    return [
      ...data.purchasedCoupons,
      ...data.giftedReceivedCoupons,
      ...data.usedCoupons,
      ...data.expiredCoupons,
    ];
  }
}
