import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/injection/injection.dart';
import '../../data/models/coupon_gifting_models.dart';
import '../bloc/coupon_manager_bloc.dart';
import '../bloc/coupon_manager_event.dart';
import '../bloc/coupon_manager_state.dart';

class CleanCouponsPage extends StatelessWidget {
  const CleanCouponsPage({super.key});

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
    return Row(
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

    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        physics: const BouncingScrollPhysics(),
        itemCount: coupons.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 30.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildModernCouponCard(coupons[index], index),
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

  Widget _buildModernCouponCard(UserCouponDetailModel coupon, int index) {
    // Define colors based on coupon status
    Color primaryColor;
    Color backgroundColor;
    Color textColor;
    IconData statusIcon;

    if (coupon.isActive) {
      primaryColor = const Color(0xFF10B981);
      backgroundColor = const Color(0xFF10B981).withOpacity(0.05);
      textColor = const Color(0xFF10B981);
      statusIcon = Icons.check_circle;
    } else if (coupon.isUsed) {
      primaryColor = const Color(0xFF6366F1);
      backgroundColor = const Color(0xFF6366F1).withOpacity(0.05);
      textColor = const Color(0xFF6366F1);
      statusIcon = Icons.history;
    } else {
      primaryColor = const Color(0xFFEF4444);
      backgroundColor = const Color(0xFFEF4444).withOpacity(0.05);
      textColor = const Color(0xFFEF4444);
      statusIcon = Icons.schedule;
    }

    // Generate gradient colors based on index for visual variety
    final gradients = [
      [const Color(0xFF6F3FCC), const Color(0xFF9F7AEA)],
      [const Color(0xFF38B2AC), const Color(0xFF4FD1C7)],
      [const Color(0xFFED8936), const Color(0xFFF56500)],
      [const Color(0xFF3182CE), const Color(0xFF63B3ED)],
      [const Color(0xFF38A169), const Color(0xFF68D391)],
      [const Color(0xFFE53E3E), const Color(0xFFF56565)],
    ];

    final gradientColors = gradients[index % gradients.length];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: gradientColors[0].withAlpha(58), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: gradientColors[0].withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              // Background gradient accent
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        gradientColors[0].withOpacity(0.1),
                        gradientColors[1].withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row with vendor and status
                    Row(
                      children: [
                        // Vendor info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                coupon.vendorName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A202C),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                coupon.title,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // Status indicator
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: primaryColor.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(statusIcon, size: 14, color: textColor),
                              const SizedBox(width: 4),
                              Text(
                                coupon.statusDisplay,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Discount value
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: gradientColors),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            coupon.discountDisplay,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const Spacer(),

                        // Expiry info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'Valid until',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF6B7280),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _formatDate(coupon.expiryDate),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A202C),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Bottom row with coupon code and action
                    Row(
                      children: [
                        // Coupon code
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.qr_code,
                                  size: 16,
                                  color: Color(0xFF6B7280),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    coupon.uniqueCode,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF4A5568),
                                      letterSpacing: 0.5,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Action button
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6F3FCC).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                // Handle coupon tap (show QR, copy code, etc.)
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Color(0xFF6F3FCC),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
