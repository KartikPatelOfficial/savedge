import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:savedge/features/auth/data/datasources/otp_auth_remote_data_source.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';
import 'package:savedge/features/coupons/data/models/coupon_gifting_models.dart';
import 'package:savedge/features/coupons/presentation/bloc/gifting_bloc.dart';
import 'package:savedge/features/coupons/presentation/bloc/gifting_event.dart';
import 'package:savedge/features/coupons/presentation/bloc/gifting_state.dart';
import 'package:savedge/features/coupons/presentation/bloc/user_coupons_bloc.dart';
import 'package:savedge/features/coupons/presentation/bloc/user_coupons_event.dart';
import 'package:savedge/features/coupons/presentation/bloc/user_coupons_state.dart';
import 'package:savedge/features/coupons/presentation/widgets/points_transfer_dialog.dart';

/// Comprehensive gift page for sending gifts and viewing gift history
class GiftPage extends StatefulWidget {
  const GiftPage({super.key});

  @override
  State<GiftPage> createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<UserCouponsBloc>()..add(const LoadUserCoupons()),
        ),
        BlocProvider(create: (_) => getIt<GiftingBloc>()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.white,
          title: const Text(
            'Send & Receive Gifts',
            style: TextStyle(
              color: Color(0xFF1A202C),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF6F3FCC),
            unselectedLabelColor: const Color(0xFF718096),
            indicatorColor: const Color(0xFF6F3FCC),
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(icon: Icon(Icons.card_giftcard), text: 'Send Gifts'),
              Tab(icon: Icon(Icons.inbox), text: 'Received'),
              Tab(icon: Icon(Icons.history), text: 'Sent History'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildSendGiftsTab(),
            _buildReceivedGiftsTab(),
            _buildSentHistoryTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildSendGiftsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with info
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6F3FCC), Color(0xFF9C27B0)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.card_giftcard,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Share the Joy!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Gift your available coupons or transfer points to colleagues within your organization.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Gift Options
          Row(
            children: [
              Expanded(
                child: _buildGiftOption(
                  icon: Icons.stars,
                  title: 'Transfer Points',
                  subtitle: 'Send points to a phone number',
                  color: const Color(0xFFD69E2E),
                  onTap: () => _showPointsTransferDialog(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Available Coupons Section
          const Text(
            'Your Available Coupons',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 16),

          BlocBuilder<UserCouponsBloc, UserCouponsState>(
            builder: (context, state) {
              if (state is UserCouponsLoading) {
                return _buildLoadingCoupons();
              } else if (state is UserCouponsLoaded) {
                final availableCoupons = state.coupons
                    .where((coupon) => coupon.statusText == 'Active')
                    .toList();

                if (availableCoupons.isEmpty) {
                  return _buildNoCouponsAvailable();
                }

                return Column(
                  children: availableCoupons.map((coupon) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: _buildCouponGiftCard(coupon),
                    );
                  }).toList(),
                );
              } else if (state is UserCouponsError) {
                return _buildErrorCard(state.message);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedGiftsTab() {
    return BlocProvider(
      create: (_) => getIt<GiftingBloc>()..add(const LoadReceivedGifts()),
      child: BlocBuilder<GiftingBloc, GiftingState>(
        builder: (context, state) {
          if (state is GiftingLoading) {
            return _buildLoadingView();
          } else if (state is ReceivedGiftsLoaded) {
            if (state.receivedCoupons.isEmpty && state.receivedPoints.isEmpty) {
              return _buildNoReceivedGifts();
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.receivedCoupons.isNotEmpty) ...[
                    const Text(
                      'Received Coupons',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...state.receivedCoupons.map(
                      (coupon) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: _buildReceivedCouponCard(coupon),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (state.receivedPoints.isNotEmpty) ...[
                    const Text(
                      'Received Points',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...state.receivedPoints.map(
                      (points) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: _buildReceivedPointsCard(points),
                      ),
                    ),
                  ],
                ],
              ),
            );
          } else if (state is GiftingError) {
            return _buildErrorView(state.message);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSentHistoryTab() {
    return BlocProvider(
      create: (_) => getIt<GiftingBloc>()..add(const LoadGiftingHistory()),
      child: BlocBuilder<GiftingBloc, GiftingState>(
        builder: (context, state) {
          if (state is GiftingLoading) {
            return _buildLoadingView();
          } else if (state is GiftingHistoryLoaded) {
            if (state.giftedCoupons.isEmpty &&
                state.transferredPoints.isEmpty) {
              return _buildNoSentGifts();
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.giftedCoupons.isNotEmpty) ...[
                    const Text(
                      'Gifted Coupons',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...state.giftedCoupons.map(
                      (coupon) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: _buildSentCouponCard(coupon),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (state.transferredPoints.isNotEmpty) ...[
                    const Text(
                      'Transferred Points',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...state.transferredPoints.map(
                      (points) => Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: _buildSentPointsCard(points),
                      ),
                    ),
                  ],
                ],
              ),
            );
          } else if (state is GiftingError) {
            return _buildErrorView(state.message);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildGiftOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Color(0xFF718096)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponGiftCard(dynamic coupon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              coupon.discountDisplay ?? '${coupon.discountValue}%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coupon.title ?? coupon.couponTitle ?? 'Coupon',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A202C),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  coupon.vendorName ?? 'Vendor',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF4A5568),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _showGiftCouponDialog(coupon),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6F3FCC),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            icon: const Icon(Icons.card_giftcard, size: 18),
            label: const Text(
              'Gift',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedCouponCard(dynamic coupon) {
    // Support history model as well as ad-hoc maps
    final String title = coupon is GiftedCouponHistoryModel
        ? (coupon.couponTitle ?? 'Coupon')
        : (coupon.title ?? coupon.couponTitle ?? 'Coupon');
    final String vendor = coupon is GiftedCouponHistoryModel
        ? 'Vendor'
        : (coupon.vendorName ?? 'Vendor');
    final String when = coupon is GiftedCouponHistoryModel
        ? (coupon.giftedDate?.toLocal().toString() ?? 'Recently')
        : (coupon.receivedAt ?? 'Recently');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF38A169).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF38A169).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF38A169).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.card_giftcard,
                  color: Color(0xFF38A169),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gift from Colleague',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF38A169),
                      ),
                    ),
                    Text(
                      when,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'GIFT',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A202C),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      vendor,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (coupon.message != null && coupon.message!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '"${coupon.message}"',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildReceivedPointsCard(dynamic points) {
    final int amount = points is PointsTransferHistoryModel
        ? points.points
        : (points.amount ?? 0);
    final String when = points is PointsTransferHistoryModel
        ? points.transferDate.toLocal().toString()
        : (points.receivedAt ?? 'Recently');
    final String sender = points is PointsTransferHistoryModel
        ? _formatTransferContact(points, sent: false)
        : (points.senderName ?? 'Colleague');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD69E2E).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD69E2E).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFD69E2E).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.stars,
                  color: Color(0xFFD69E2E),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Points from $sender',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFD69E2E),
                      ),
                    ),
                    Text(
                      when,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFD69E2E).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '+$amount pts',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFD69E2E),
                  ),
                ),
              ),
            ],
          ),
          if (points.message != null && points.message!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '"${points.message}"',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSentCouponCard(dynamic coupon) {
    final String title = coupon is GiftedCouponHistoryModel
        ? (coupon.couponTitle ?? 'Coupon')
        : (coupon.title ?? coupon.couponTitle ?? 'Coupon');
    final String vendor = coupon is GiftedCouponHistoryModel
        ? 'Vendor'
        : (coupon.vendorName ?? 'Vendor');
    final String when = coupon is GiftedCouponHistoryModel
        ? (coupon.giftedDate?.toLocal().toString() ?? 'Recently')
        : (coupon.sentAt ?? 'Recently');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF718096).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF718096).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.card_giftcard,
                  color: Color(0xFF718096),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sent to Colleague',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF718096),
                      ),
                    ),
                    Text(
                      when,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'GIFT',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A202C),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      vendor,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTransferContact(
    PointsTransferHistoryModel transfer, {
    required bool sent,
  }) {
    final raw = sent ? transfer.toUserId : transfer.fromUserId;
    if (raw.isEmpty) {
      return 'Colleague';
    }

    final trimmed = raw.trim();
    if (trimmed.contains('@')) {
      return trimmed;
    }

    if (trimmed.length <= 4) {
      return trimmed;
    }

    return '••••${trimmed.substring(trimmed.length - 4)}';
  }

  Widget _buildSentPointsCard(dynamic points) {
    final int amount = points is PointsTransferHistoryModel
        ? points.points
        : (points.amount ?? 0);
    final String when = points is PointsTransferHistoryModel
        ? points.transferDate.toLocal().toString()
        : (points.sentAt ?? 'Recently');
    final String recipient = points is PointsTransferHistoryModel
        ? _formatTransferContact(points, sent: true)
        : (points.recipientName ?? 'Colleague');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF718096).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF718096).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.stars, color: Color(0xFF718096), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sent to $recipient',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF718096),
                  ),
                ),
                Text(
                  when,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF718096),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF718096).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '-$amount pts',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF718096),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCoupons() {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
    );
  }

  Widget _buildNoCouponsAvailable() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.local_offer_outlined,
              size: 48,
              color: Color(0xFF6F3FCC),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Available Coupons',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'You do not have any active coupons. Redeem the coupon if you are a member or buy a new coupon first to gift.',
            style: TextStyle(fontSize: 14, color: Color(0xFF718096)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoReceivedGifts() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF38A169).withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.inbox_outlined,
                size: 48,
                color: Color(0xFF38A169),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Received Gifts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You haven\'t received any gifts from colleagues yet.',
              style: TextStyle(fontSize: 14, color: Color(0xFF718096)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoSentGifts() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF718096).withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.history_outlined,
                size: 48,
                color: Color(0xFF718096),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Sent Gifts',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You haven\'t sent any gifts to colleagues yet.',
              style: TextStyle(fontSize: 14, color: Color(0xFF718096)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE53E3E).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE53E3E).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFE53E3E), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 14, color: Color(0xFFE53E3E)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Color(0xFFE53E3E)),
            const SizedBox(height: 16),
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
              style: const TextStyle(fontSize: 14, color: Color(0xFF718096)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showGiftToPhoneDialog() {
    showDialog(
      context: context,
      builder: (context) => const _GiftToPhoneDialog(),
    );
  }

  void _showPointsTransferDialog() {
    showDialog(
      context: context,
      builder: (context) => const PointsTransferDialog(),
    );
  }

  void _showGiftCouponDialog(dynamic coupon) {
    // Open the gift-to-phone dialog with preselected coupon
    showDialog(
      context: context,
      builder: (context) => _GiftToPhoneDialog(preselectedCoupon: coupon),
    );
  }
}

// Multi-step dialog: select coupon -> enter phone -> verify OTP -> send
class _GiftToPhoneDialog extends StatefulWidget {
  const _GiftToPhoneDialog({this.preselectedCoupon});

  final dynamic preselectedCoupon; // expects UserCouponModel-like

  @override
  State<_GiftToPhoneDialog> createState() => _GiftToPhoneDialogState();
}

class _GiftToPhoneDialogState extends State<_GiftToPhoneDialog> {
  int _step = 0; // 0: select coupon, 1: phone, 2: otp, 3: confirm
  dynamic _selectedCoupon;
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _messageController = TextEditingController();
  String? _generatedOtp; // kept for UI state; not used for real verify
  bool _otpSent = false;
  bool _sendingOtp = false;
  bool _verifyingOtp = false;
  String? _recipientUserId;
  String? _recipientName;
  String? _senderPhone;
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    _selectedCoupon = widget.preselectedCoupon;
    if (_selectedCoupon != null) {
      _step = 1; // skip selection if preselected
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: BlocProvider(
            create: (_) => getIt<GiftingBloc>(),
            child: BlocConsumer<GiftingBloc, GiftingState>(
              listener: (context, state) {
                if (state is GiftingSuccess) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: const Color(0xFF38A169),
                    ),
                  );
                } else if (state is GiftingError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: const Color(0xFFE53E3E),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final blocContext = context;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.card_giftcard,
                          color: Color(0xFF6F3FCC),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _step == 0
                                ? 'Select a Coupon'
                                : _step == 1
                                ? 'Enter Recipient\'s Phone'
                                : _step == 2
                                ? 'Verify OTP'
                                : 'Confirm & Send',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_step == 0) _buildCouponSelection(),
                    if (_step == 1) _buildPhoneEntry(),
                    if (_step == 2) _buildOtpVerification(),
                    if (_step == 3)
                      _buildConfirmSend(blocContext, state is GiftingLoading),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCouponSelection() {
    return BlocProvider(
      create: (_) =>
          getIt<UserCouponsBloc>()
            ..add(const LoadUserCoupons(status: 'active')),
      child: BlocBuilder<UserCouponsBloc, UserCouponsState>(
        builder: (context, state) {
          if (state is UserCouponsLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
              ),
            );
          } else if (state is UserCouponsLoaded) {
            final active = state.coupons.where((c) => c.isValid).toList();
            if (active.isEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.local_offer_outlined,
                    size: 40,
                    color: Color(0xFF6F3FCC),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'You do not have any active coupons. Redeem the coupon if you are a member or buy a new coupon first to gift.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF4A5568)),
                  ),
                ],
              );
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose one of your active coupons to gift',
                  style: TextStyle(color: Color(0xFF4A5568)),
                ),
                const SizedBox(height: 12),
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 320),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: active.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final c = active[index];
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          title: Text(
                            c.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(c.discountDisplay),
                          trailing: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedCoupon = c;
                                _step = 1;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6F3FCC),
                            ),
                            child: const Text('Select'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (state is UserCouponsError) {
            return Text(
              state.message,
              style: const TextStyle(color: Color(0xFFE53E3E)),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPhoneEntry() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSelectedCouponPreview(),
        const SizedBox(height: 16),
        const Text(
          'Recipient Phone Number',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'e.g. +919876543210',
            prefixIcon: const Icon(Icons.phone_iphone),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF6F3FCC)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Gift Message (Optional)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _messageController,
          maxLines: 3,
          maxLength: 200,
          decoration: InputDecoration(
            hintText: 'Add a personal message...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF6F3FCC)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _sendingOtp
                    ? null
                    : () async {
                        setState(() => _sendingOtp = true);
                        try {
                          final auth = getIt<AuthRemoteDataSource>();
                          final me = await auth.getUserProfile();
                          final phone = me.phoneNumber;
                          if (phone.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Your phone number is not set'),
                                backgroundColor: Color(0xFFE53E3E),
                              ),
                            );
                            return;
                          }
                          final ds = getIt<OtpAuthRemoteDataSource>();
                          final resp = await ds.sendOtp(
                            SendOtpRequest(phoneNumber: phone),
                          );
                          if (resp.succeeded) {
                            setState(() {
                              _senderPhone = phone;
                              _otpSent = true;
                              _step = 2;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('OTP sent to your phone number'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to send OTP'),
                                backgroundColor: Color(0xFFE53E3E),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to send OTP: $e'),
                              backgroundColor: const Color(0xFFE53E3E),
                            ),
                          );
                        } finally {
                          if (mounted) setState(() => _sendingOtp = false);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F3FCC),
                ),
                child: _sendingOtp
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Next'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOtpVerification() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSelectedCouponPreview(),
        const SizedBox(height: 16),
        const Text(
          'Enter OTP',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: '6-digit code',
            prefixIcon: const Icon(Icons.lock_outline),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF6F3FCC)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _step = 1),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: !_otpSent || _verifyingOtp
                    ? null
                    : () async {
                        final phone = (_senderPhone ?? '').replaceAll(' ', '');
                        final otp = _otpController.text.trim();
                        if (otp.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Enter the OTP'),
                              backgroundColor: Color(0xFFE53E3E),
                            ),
                          );
                          return;
                        }
                        setState(() => _verifyingOtp = true);
                        try {
                          final ds = getIt<OtpAuthRemoteDataSource>();
                          final resp = await ds.verifyOtp(
                            VerifyOtpRequest(phoneNumber: phone, otp: otp),
                          );
                          if (resp.succeeded) {
                            setState(() {
                              _step = 3;
                            });
                          } else {
                            final errors = resp.errors.isNotEmpty
                                ? resp.errors.join(', ')
                                : 'OTP verification failed';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errors),
                                backgroundColor: const Color(0xFFE53E3E),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to verify OTP: $e'),
                              backgroundColor: const Color(0xFFE53E3E),
                            ),
                          );
                        } finally {
                          if (mounted) setState(() => _verifyingOtp = false);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F3FCC),
                ),
                child: _verifyingOtp
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Verify OTP'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConfirmSend(BuildContext blocContext, bool isLoading) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSelectedCouponPreview(),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.phone_iphone, color: Color(0xFF4A5568)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _phoneController.text,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        if (_recipientName != null && _recipientName!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.person_outline, color: Color(0xFF4A5568)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _recipientName!,
                  style: const TextStyle(color: Color(0xFF4A5568)),
                ),
              ),
            ],
          ),
        ],
        if (_messageController.text.trim().isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            '“${_messageController.text.trim()}”',
            style: const TextStyle(color: Color(0xFF4A5568)),
          ),
        ],
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _step = 2),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: isLoading || _submitting
                    ? null
                    : () async {
                        final recipientPhone = _phoneController.text.replaceAll(
                          ' ',
                          '',
                        );
                        final phoneRegex = RegExp(r'^\+?[1-9]\d{9,14}$');
                        if (!phoneRegex.hasMatch(recipientPhone)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Enter a valid recipient phone number',
                              ),
                              backgroundColor: Color(0xFFE53E3E),
                            ),
                          );
                          return;
                        }
                        setState(() => _submitting = true);
                        try {
                          final dio = getIt<Dio>();
                          final resp = await dio.post(
                            '/api/gifting/coupon/by-phone',
                            data: {
                              'userCouponId': _selectedCoupon.id,
                              'recipientPhone': recipientPhone,
                              'message': _messageController.text.trim().isEmpty
                                  ? null
                                  : _messageController.text.trim(),
                            },
                          );
                          if (resp.statusCode == 200 &&
                              (resp.data['success'] == true ||
                                  resp.data['Success'] == true)) {
                            if (mounted) Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Coupon gifted successfully'),
                                backgroundColor: Color(0xFF38A169),
                              ),
                            );
                          } else {
                            final msg =
                                resp.data['message'] ?? 'Failed to gift coupon';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(msg.toString()),
                                backgroundColor: const Color(0xFFE53E3E),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to gift coupon: $e'),
                              backgroundColor: const Color(0xFFE53E3E),
                            ),
                          );
                        } finally {
                          if (mounted) setState(() => _submitting = false);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F3FCC),
                ),
                child: (isLoading || _submitting)
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Send Gift'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectedCouponPreview() {
    final c = _selectedCoupon;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF6F3FCC).withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              c.discountDisplay ?? c.discountDisplay,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.title ?? c.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  c.vendorName ?? c.vendorName,
                  style: const TextStyle(color: Color(0xFF4A5568)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
