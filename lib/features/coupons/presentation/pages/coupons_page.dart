import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/coupons/data/models/coupon_gifting_models.dart';
import 'package:savedge/features/coupons/data/models/user_coupon_model.dart';
import 'package:savedge/features/coupons/presentation/bloc/coupon_manager_bloc.dart';
import 'package:savedge/features/coupons/presentation/bloc/coupon_manager_event.dart';
import 'package:savedge/features/coupons/presentation/bloc/coupon_manager_state.dart';
import 'package:savedge/features/coupons/presentation/pages/coupon_confirmation_page.dart';
import 'package:savedge/features/coupons/presentation/pages/redeemed_coupon_page.dart';
import 'package:savedge/features/coupons/presentation/widgets/stacked_coupon_card.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CouponManagerBloc>()..add(const LoadAllCoupons()),
      child: const CleanCouponsView(),
    );
  }
}

class CleanCouponsView extends StatefulWidget {
  const CleanCouponsView({super.key});

  @override
  State<CleanCouponsView> createState() => _CleanCouponsViewState();
}

class _CleanCouponsViewState extends State<CleanCouponsView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<CouponManagerBloc, CouponManagerState>(
        builder: (context, state) {
          if (state is CouponManagerLoading) {
            return _buildLoadingView();
          } else if (state is CouponManagerError) {
            return _buildErrorStateView(state.message);
          } else if (state is CouponManagerLoaded) {
            return _buildCouponsView(state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
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

  Widget _buildLoadingView() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildMinimalHeader(),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6F3FCC).withOpacity(0.1),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponsView(CouponManagerLoaded state) {
    final allCoupons = _getAllCoupons(state.couponsData);
    final activeCoupons = _getActiveCoupons(state.couponsData);
    final usedCoupons = state.couponsData.usedCoupons;
    final expiredCoupons = state.couponsData.expiredCoupons;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Minimal Header
              _buildMinimalHeader(),

              // Floating Tab Bar
              _buildFloatingTabBar(
                activeCoupons.length,
                usedCoupons.length,
                expiredCoupons.length,
                allCoupons.length,
              ),

              const SizedBox(height: 20),

              // Content with smooth transitions
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildCouponsList(allCoupons, 'All Coupons', 0),
                    _buildCouponsList(activeCoupons, 'Active Coupons', 1),
                    _buildCouponsList(usedCoupons, 'Used Coupons', 2),
                    _buildCouponsList(expiredCoupons, 'Expired Coupons', 3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinimalHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        children: [
          // Title with icon
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'My Coupons',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Refresh button
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  context.read<CouponManagerBloc>().add(
                    const RefreshAllCoupons(),
                  );
                },
                borderRadius: BorderRadius.circular(14),
                child: const Icon(
                  Icons.refresh_rounded,
                  color: Color(0xFF6F3FCC),
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingTabBar(
    int activeCount,
    int usedCount,
    int expiredCount,
    int totalCount,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicator: BoxDecoration(
          color: const Color(0xFF6F3FCC),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6F3FCC).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF6B7280),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        tabs: [
          Tab(child: _buildTabContent('All', totalCount, totalCount > 0)),
          Tab(child: _buildTabContent('Active', activeCount, activeCount > 0)),
          Tab(child: _buildTabContent('Used', usedCount, usedCount > 0)),
          Tab(
            child: _buildTabContent('Expired', expiredCount, expiredCount > 0),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(String label, int count, bool hasCount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (hasCount) ...[
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color:
                    _selectedIndex ==
                        ['All', 'Active', 'Used', 'Expired'].indexOf(label)
                    ? Colors.white.withOpacity(0.2)
                    : const Color(0xFF6F3FCC).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color:
                      _selectedIndex ==
                          ['All', 'Active', 'Used', 'Expired'].indexOf(label)
                      ? Colors.white
                      : const Color(0xFF6F3FCC),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCouponsList(
    List<UserCouponDetailModel> coupons,
    String title,
    int tabIndex,
  ) {
    if (coupons.isEmpty) {
      return _buildEmptyState(title);
    }

    // Group coupons by couponId (same offer type)
    final groupedCoupons = <int, List<UserCouponDetailModel>>{};
    for (final coupon in coupons) {
      groupedCoupons.putIfAbsent(coupon.couponId, () => []).add(coupon);
    }

    // Convert to list of groups and sort by purchase date
    final couponGroups = groupedCoupons.values.toList()
      ..sort((a, b) => b.first.acquiredDate.compareTo(a.first.acquiredDate));

    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        physics: const BouncingScrollPhysics(),
        itemCount: couponGroups.length,
        itemBuilder: (context, index) {
          final group = couponGroups[index];
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: StackedCouponCard(
                    coupons: group,
                    onTap: _handleCouponTap,
                    index: index,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(String title) {
    IconData icon;
    String message;
    Color color;

    switch (title) {
      case 'Active Coupons':
        icon = Icons.local_offer_outlined;
        message =
            'No active coupons found\nBrowse stores to find amazing deals!';
        color = const Color(0xFF10B981);
        break;
      case 'Used Coupons':
        icon = Icons.check_circle_outline;
        message = 'No used coupons yet\nStart saving with your active coupons!';
        color = const Color(0xFF6366F1);
        break;
      case 'Expired Coupons':
        icon = Icons.schedule_outlined;
        message = 'No expired coupons\nGreat job using your coupons on time!';
        color = const Color(0xFFEF4444);
        break;
      default:
        icon = Icons.wallet_giftcard_outlined;
        message = 'No coupons found\nYour savings will appear here';
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
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: color.withOpacity(0.2), width: 2),
              ),
              child: Icon(icon, size: 48, color: color.withOpacity(0.7)),
            ),
            const SizedBox(height: 24),
            Text(
              message.split('\n')[0],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message.split('\n')[1],
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

  Widget _buildErrorStateView(String message) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildMinimalHeader(),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: const Color(0xFFEF4444).withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.error_outline,
                          size: 48,
                          color: const Color(0xFFEF4444).withOpacity(0.7),
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
                      Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6F3FCC), Color(0xFF9F7AEA)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF6F3FCC).withOpacity(0.3),
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
                              context.read<CouponManagerBloc>().add(
                                const RefreshAllCoupons(),
                              );
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference < 0) {
      return 'Expired';
    } else if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference <= 7) {
      return '$difference days';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  // Helper methods to filter coupons
  List<UserCouponDetailModel> _getAllCoupons(UserCouponsResponseModel data) {
    return [
      ...data.purchasedCoupons,
      ...data.giftedReceivedCoupons,
      ...data.usedCoupons,
      ...data.expiredCoupons,
    ];
  }

  List<UserCouponDetailModel> _getActiveCoupons(UserCouponsResponseModel data) {
    // Use purchased and gifted received coupons that are active (unused and not expired)
    return [
      ...data.purchasedCoupons.where((coupon) => coupon.isActive),
      ...data.giftedReceivedCoupons.where((coupon) => coupon.isActive),
    ];
  }
}
