import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../../data/models/user_coupon_model.dart';
import '../bloc/user_coupons_bloc.dart';
import '../bloc/user_coupons_event.dart';
import '../bloc/user_coupons_state.dart';

/// Page displaying user's acquired coupons
class UserCouponsPage extends StatelessWidget {
  const UserCouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserCouponsBloc>()..add(const LoadUserCoupons()),
      child: const UserCouponsView(),
    );
  }
}

class UserCouponsView extends StatefulWidget {
  const UserCouponsView({super.key});

  @override
  State<UserCouponsView> createState() => _UserCouponsViewState();
}

class _UserCouponsViewState extends State<UserCouponsView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<UserCouponsBloc>().loadNextPage();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onTabChanged() {
    final status = _getStatusFromIndex(_tabController.index);
    context.read<UserCouponsBloc>().add(RefreshUserCoupons(status: status));
  }

  String? _getStatusFromIndex(int index) {
    switch (index) {
      case 0:
        return null; // All coupons
      case 1:
        return 'active';
      case 2:
        return 'used';
      case 3:
        return 'expired';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('My Coupons'),
        backgroundColor: const Color(0xFF6F3FCC),
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          onTap: (_) => _onTabChanged(),
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Active'),
            Tab(text: 'Used'),
            Tab(text: 'Expired'),
          ],
        ),
      ),
      body: BlocBuilder<UserCouponsBloc, UserCouponsState>(
        builder: (context, state) {
          if (state is UserCouponsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserCouponsError) {
            return _buildErrorWidget(state.message);
          } else if (state is UserCouponsLoaded) {
            return _buildLoadedWidget(state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadedWidget(UserCouponsLoaded state) {
    if (state.coupons.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        // Stats Header
        _buildStatsHeader(state),
        // Coupons List
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              final status = _getStatusFromIndex(_tabController.index);
              context.read<UserCouponsBloc>().add(RefreshUserCoupons(status: status));
            },
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: state.coupons.length + (state.hasReachedMax ? 0 : 1),
              itemBuilder: (context, index) {
                if (index >= state.coupons.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: UserCouponCard(coupon: state.coupons[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsHeader(UserCouponsLoaded state) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total',
              state.totalCount.toString(),
              Colors.blue[600]!,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Active',
              state.activeCount.toString(),
              Colors.green[600]!,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Used',
              state.usedCount.toString(),
              Colors.orange[600]!,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatCard(
              'Expired',
              state.expiredCount.toString(),
              Colors.red[600]!,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_offer_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No coupons found',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Your claimed coupons will appear here',
            style: TextStyle(fontSize: 14, color: Colors.grey),
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
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error loading coupons',
            style: TextStyle(fontSize: 18, color: Colors.grey[800]),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              final status = _getStatusFromIndex(_tabController.index);
              context.read<UserCouponsBloc>().add(RefreshUserCoupons(status: status));
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

/// Individual user coupon card widget
class UserCouponCard extends StatelessWidget {
  const UserCouponCard({super.key, required this.coupon});

  final UserCouponModel coupon;

  @override
  Widget build(BuildContext context) {
    final color = _getCouponColor();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: coupon.isValid ? color.withOpacity(0.3) : Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Coupon Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: coupon.isValid
                    ? [color, color.withOpacity(0.8)]
                    : [Colors.grey[400]!, Colors.grey[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coupon.discountDisplay,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        coupon.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(),
              ],
            ),
          ),
          // Coupon Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coupon.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.store, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        coupon.vendorName,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                if (coupon.minCartValue > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.shopping_cart, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Min order: ₹${coupon.minCartValue.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expires: ${_getFormattedDate(coupon.expiryDate)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: coupon.isExpired ? Colors.red : Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (coupon.redemptionCode != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Text(
                          coupon.redemptionCode!,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Courier',
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
    );
  }

  Widget _buildStatusBadge() {
    Color backgroundColor;
    Color textColor;
    String statusText;

    if (coupon.isUsed) {
      backgroundColor = Colors.orange;
      textColor = Colors.white;
      statusText = 'Used';
    } else if (coupon.isExpired) {
      backgroundColor = Colors.red;
      textColor = Colors.white;
      statusText = 'Expired';
    } else {
      backgroundColor = Colors.green;
      textColor = Colors.white;
      statusText = 'Active';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getCouponColor() {
    if (!coupon.isValid) return Colors.grey;
    
    // Generate color based on discount type
    switch (coupon.discountType.toLowerCase()) {
      case 'percentage':
        return const Color(0xFF6F3FCC);
      case 'fixedamount':
        return const Color(0xFF4CAF50);
      default:
        return const Color(0xFFFF9800);
    }
  }

  String _getFormattedDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
