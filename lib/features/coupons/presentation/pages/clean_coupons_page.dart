import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../../data/models/coupon_gifting_models.dart';
import '../bloc/coupon_manager_bloc.dart';
import '../bloc/coupon_manager_event.dart';
import '../bloc/coupon_manager_state.dart';
import '../widgets/modern_coupon_card.dart';

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
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
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
      backgroundColor: const Color(0xFFFAFBFC),
      appBar: _buildModernAppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Color(0xFF6F3FCC), strokeWidth: 3),
            SizedBox(height: 24),
            Text(
              'Loading your coupons...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4A5568),
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
      backgroundColor: const Color(0xFFFAFBFC),
      appBar: _buildModernAppBar(),
      body: Column(
        children: [
          // Statistics Cards
          _buildStatsSection(
            allCoupons,
            activeCoupons,
            usedCoupons,
            expiredCoupons,
          ),

          // Tab Bar
          _buildModernTabBar(),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCouponsList(allCoupons, 'All Coupons'),
                _buildCouponsList(activeCoupons, 'Active Coupons'),
                _buildCouponsList(usedCoupons, 'Used Coupons'),
                _buildCouponsList(expiredCoupons, 'Expired Coupons'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildModernAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: const Row(
        children: [
          Icon(Icons.local_offer_outlined, color: Color(0xFF6F3FCC), size: 24),
          SizedBox(width: 12),
          Text(
            'My Coupons',
            style: TextStyle(
              color: Color(0xFF1A202C),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF6F3FCC).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.refresh_rounded,
              color: Color(0xFF6F3FCC),
              size: 22,
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              context.read<CouponManagerBloc>().add(const RefreshAllCoupons());
            },
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildStatsSection(
    List<UserCouponDetailModel> allCoupons,
    List<UserCouponDetailModel> activeCoupons,
    List<UserCouponDetailModel> usedCoupons,
    List<UserCouponDetailModel> expiredCoupons,
  ) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              '${activeCoupons.length}',
              'Active',
              const Color(0xFF10B981),
              Icons.check_circle_outline,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              '${usedCoupons.length}',
              'Used',
              const Color(0xFF6366F1),
              Icons.history,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              '${expiredCoupons.length}',
              'Expired',
              const Color(0xFFEF4444),
              Icons.schedule,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              '${allCoupons.length}',
              'Total',
              const Color(0xFF8B5CF6),
              Icons.receipt_long,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A202C),
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF6F3FCC),
          borderRadius: BorderRadius.circular(8),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF6B7280),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'Active'),
          Tab(text: 'Used'),
          Tab(text: 'Expired'),
        ],
      ),
    );
  }

  Widget _buildCouponsList(List<UserCouponDetailModel> coupons, String title) {
    if (coupons.isEmpty) {
      return _buildEmptyState(title);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: coupons.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ModernCouponCard(coupon: coupons[index]),
        );
      },
    );
  }

  Widget _buildEmptyState(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF6F3FCC).withOpacity(0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 72,
                color: const Color(0xFF6F3FCC).withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'No ${title.toLowerCase()}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _getEmptyStateMessage(title),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getEmptyStateMessage(String title) {
    switch (title) {
      case 'Active Coupons':
        return 'You don\'t have any active coupons.\nCheck back later for new deals!';
      case 'Used Coupons':
        return 'You haven\'t used any coupons yet.\nStart saving with your active coupons!';
      case 'Expired Coupons':
        return 'No expired coupons.\nGreat job using your coupons on time!';
      default:
        return 'Your coupons will appear here.\nPull down to refresh.';
    }
  }

  Widget _buildErrorStateView(String message) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      appBar: _buildModernAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Icon(
                  Icons.error_outline,
                  size: 72,
                  color: const Color(0xFFEF4444).withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Something went wrong',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A202C),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    context.read<CouponManagerBloc>().add(
                      const RefreshAllCoupons(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F3FCC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Try Again',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
