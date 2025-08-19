import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../../data/models/coupon_gifting_models.dart';
import '../bloc/coupon_manager_bloc.dart';
import '../bloc/coupon_manager_event.dart';
import '../bloc/coupon_manager_state.dart';
import '../widgets/elegant_coupon_card.dart';

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
      appBar: _buildSimpleAppBar(),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
        ),
      ),
    );
  }

  Widget _buildCouponsView(CouponManagerLoaded state) {
    return Scaffold(
      appBar: _buildSimpleAppBar(),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCouponsList(_getAllCoupons(state.couponsData)),
                _buildCouponsList(_getActiveCoupons(state.couponsData)),
                _buildCouponsList(state.couponsData.usedCoupons),
                _buildCouponsList(_getExpiredCoupons(state.couponsData)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildSimpleAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: const Text(
        'My Coupons',
        style: TextStyle(
          color: Color(0xFF1A202C),
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.refresh_rounded,
            color: Color(0xFF6F3FCC),
          ),
          onPressed: () {
            context.read<CouponManagerBloc>().add(const RefreshAllCoupons());
          },
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TabBar(
        controller: _tabController,
        indicatorColor: const Color(0xFF6F3FCC),
        indicatorWeight: 2,
        labelColor: const Color(0xFF6F3FCC),
        unselectedLabelColor: const Color(0xFF718096),
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
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

  Widget _buildCouponsList(List<UserCouponDetailModel> coupons) {
    if (coupons.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: coupons.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: ElegantCouponCard(coupon: coupons[index]),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_rounded,
              size: 64,
              color: const Color(0xFF6F3FCC).withOpacity(0.3),
            ),
            const SizedBox(height: 24),
            const Text(
              'No coupons found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your coupons will appear here',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF4A5568),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorStateView(String message) {
    return Scaffold(
      appBar: _buildSimpleAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: const Color(0xFFE53E3E).withOpacity(0.5),
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
                  color: Color(0xFF4A5568),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.read<CouponManagerBloc>().add(const RefreshAllCoupons());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F3FCC),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
    ];
  }

  List<UserCouponDetailModel> _getActiveCoupons(UserCouponsResponseModel data) {
    final allCoupons = _getAllCoupons(data);
    return allCoupons.where((coupon) {
      return coupon.status.toLowerCase() == 'active' &&
          DateTime.now().isBefore(coupon.expiryDate);
    }).toList();
  }

  List<UserCouponDetailModel> _getExpiredCoupons(
    UserCouponsResponseModel data,
  ) {
    final allCoupons = _getAllCoupons(data);
    return allCoupons.where((coupon) {
      // Only show expired if: expired by date AND not already used
      return DateTime.now().isAfter(coupon.expiryDate) && 
             coupon.status.toLowerCase() != 'used';
    }).toList();
  }
}
