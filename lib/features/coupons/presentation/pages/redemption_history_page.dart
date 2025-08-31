import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/coupons/data/models/user_coupon_model.dart';
import 'package:savedge/features/coupons/presentation/bloc/user_coupons_bloc.dart';
import 'package:savedge/features/coupons/presentation/bloc/user_coupons_event.dart';
import 'package:savedge/features/coupons/presentation/bloc/user_coupons_state.dart';
import 'package:savedge/features/coupons/presentation/pages/redeemed_coupon_page.dart';

class RedemptionHistoryPage extends StatelessWidget {
  const RedemptionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserCouponsBloc>()..add(const LoadUserCoupons()),
      child: const _RedemptionHistoryView(),
    );
  }
}

class _RedemptionHistoryView extends StatelessWidget {
  const _RedemptionHistoryView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Redemption History',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).textTheme.bodyLarge?.color,
      ),
      body: BlocBuilder<UserCouponsBloc, UserCouponsState>(
        builder: (context, state) {
          if (state is UserCouponsInitial || state is UserCouponsLoading) {
            return const _LoadingView();
          } else if (state is UserCouponsLoaded) {
            return _LoadedView(state: state);
          } else if (state is UserCouponsError) {
            return _ErrorView(message: state.message);
          }
          return const _LoadingView();
        },
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading history',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<UserCouponsBloc>().add(const LoadUserCoupons());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({required this.state});

  final UserCouponsLoaded state;

  @override
  Widget build(BuildContext context) {
    final redeemedCoupons = state.coupons.where((coupon) => coupon.isUsed).toList();

    if (redeemedCoupons.isEmpty) {
      return const _EmptyHistoryView();
    }

    return Column(
      children: [
        _HistoryStatsCard(
          totalRedeemed: redeemedCoupons.length,
          totalSavings: _calculateTotalSavings(redeemedCoupons),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: redeemedCoupons.length,
            itemBuilder: (context, index) {
              final coupon = redeemedCoupons[index];
              return _RedemptionHistoryCard(
                coupon: coupon,
                isLast: index == redeemedCoupons.length - 1,
              );
            },
          ),
        ),
      ],
    );
  }

  double _calculateTotalSavings(List<UserCouponModel> coupons) {
    return coupons.fold(0.0, (sum, coupon) => sum + coupon.discountValue);
  }
}

class _EmptyHistoryView extends StatelessWidget {
  const _EmptyHistoryView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            'No Redemptions Yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              'Start exploring coupons and redeem them to see your history here',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryStatsCard extends StatelessWidget {
  const _HistoryStatsCard({
    required this.totalRedeemed,
    required this.totalSavings,
  });

  final int totalRedeemed;
  final double totalSavings;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Redeemed',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  totalRedeemed.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Savings',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${totalSavings.toInt()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RedemptionHistoryCard extends StatelessWidget {
  const _RedemptionHistoryCard({
    required this.coupon,
    required this.isLast,
  });

  final UserCouponModel coupon;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToRedeemedCoupon(context),
      child: Container(
        margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coupon.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      coupon.vendorName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Text(
                  coupon.discountDisplay,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[700],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 6),
              Text(
                'Redeemed on ${_formatDate(coupon.usedAt)}',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          if (coupon.redemptionCode != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.qr_code,
                    size: 20,
                    color: Colors.grey[700],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Redemption Code',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          coupon.redemptionCode!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontFamily: 'Courier',
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _copyCode(context, coupon.redemptionCode!),
                    icon: Icon(
                      Icons.copy,
                      size: 20,
                      color: Colors.grey[600],
                    ),
                    tooltip: 'Copy code',
                  ),
                ],
              ),
            ),
          ],
        ],
        ),
      ),
    );
  }

  void _navigateToRedeemedCoupon(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RedeemedCouponPage(userCoupon: coupon),
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return 'Unknown';
    }
  }

  void _copyCode(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Code copied to clipboard'),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}