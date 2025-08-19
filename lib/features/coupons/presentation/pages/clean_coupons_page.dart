import 'package:flutter/material.dart';
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
      backgroundColor: Colors.grey[50],
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
              title: const Text(
                'My Coupons',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xFF2563EB),
                  indicatorWeight: 3,
                  labelColor: const Color(0xFF2563EB),
                  unselectedLabelColor: Colors.grey[600],
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
              ),
            ),
          ),
        ],
        body: BlocBuilder<CouponManagerBloc, CouponManagerState>(
          builder: (context, state) {
            if (state is CouponManagerLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF2563EB),
                ),
              );
            } else if (state is CouponManagerError) {
              return _buildErrorWidget(state.message);
            } else if (state is CouponManagerLoaded) {
              return _buildCouponsContent(state);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildCouponsContent(CouponManagerLoaded state) {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildCouponsList(_getAllCoupons(state.couponsData)),
        _buildCouponsList(_getActiveCoupons(state.couponsData)),
        _buildCouponsList(state.couponsData.usedCoupons),
        _buildCouponsList(_getExpiredCoupons(state.couponsData)),
      ],
    );
  }

  Widget _buildCouponsList(List<UserCouponDetailModel> coupons) {
    if (coupons.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<CouponManagerBloc>().add(const RefreshAllCoupons());
      },
      color: const Color(0xFF2563EB),
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: coupons.length,
        itemBuilder: (context, index) {
          return ElegantCouponCard(
            coupon: coupons[index],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.receipt_long_rounded,
              size: 40,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No coupons found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your coupons will appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.error_outline_rounded,
              size: 40,
              color: Colors.red[400],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<CouponManagerBloc>().add(const RefreshAllCoupons());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Try Again'),
          ),
        ],
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

  List<UserCouponDetailModel> _getExpiredCoupons(UserCouponsResponseModel data) {
    final allCoupons = _getAllCoupons(data);
    return allCoupons.where((coupon) {
      return DateTime.now().isAfter(coupon.expiryDate);
    }).toList();
  }
}