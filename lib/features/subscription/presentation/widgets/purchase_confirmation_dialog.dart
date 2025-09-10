import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/subscription.dart';
import '../bloc/subscription_bloc.dart';
import '../pages/payment_flow_page.dart';

/// Bottom sheet dialog for confirming subscription purchase
class PurchaseConfirmationDialog extends StatelessWidget {
  final SubscriptionPlan plan;
  final VoidCallback onPurchaseWithCurrency;
  final VoidCallback onPurchaseWithPoints;

  const PurchaseConfirmationDialog({
    super.key,
    required this.plan,
    required this.onPurchaseWithCurrency,
    required this.onPurchaseWithPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle Bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Title
          const Text(
            'Choose Payment Method',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          // Plan Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      plan.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹${plan.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Payment Options
          const Text(
            'Select Payment Method:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 16),

          // Currency Payment Option (Razorpay)
          BlocBuilder<SubscriptionBloc, SubscriptionState>(
            builder: (context, state) {
              final isLoading =
                  state is SubscriptionLoaded && state.isPurchasing;

              return _buildPaymentOption(
                icon: Icons.payment,
                title: 'Pay with Money',
                subtitle:
                    '₹${plan.price.toStringAsFixed(0)} via secure payment (Razorpay)',
                color: Colors.blue,
                onTap: isLoading ? null : () => _navigateToPaymentFlow(context),
                isLoading: isLoading,
              );
            },
          ),

          const SizedBox(height: 12),

          // Points Payment Option
          BlocBuilder<SubscriptionBloc, SubscriptionState>(
            builder: (context, state) {
              final isLoading =
                  state is SubscriptionLoaded && state.isPurchasing;
              final pointsRequired = plan.price.ceil();

              return _buildPaymentOption(
                icon: Icons.account_balance_wallet,
                title: 'Pay with Points',
                subtitle: '$pointsRequired points required',
                color: Colors.orange,
                onTap: isLoading ? null : onPurchaseWithPoints,
                isLoading: isLoading,
              );
            },
          ),

          const SizedBox(height: 24),

          // Terms and Cancel
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),

          // Terms Text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'By purchasing, you agree to our Terms of Service and Privacy Policy. Subscription will auto-renew unless cancelled.',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),
              if (isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToPaymentFlow(BuildContext context) {
    Navigator.of(context).pop(); // Close bottom sheet

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PaymentFlowPage(
          plan: plan,
          autoRenew: false, // Can be made configurable
        ),
      ),
    );
  }
}
