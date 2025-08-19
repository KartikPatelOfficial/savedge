import 'package:flutter/material.dart';
import '../../../../shared/domain/entities/subscription.dart';

/// Card widget displaying a subscription plan with purchase option
class SubscriptionPlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final bool isCurrentPlan;
  final bool canPurchase;
  final VoidCallback onPurchase;
  final bool isLoading;

  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.isCurrentPlan,
    required this.canPurchase,
    required this.onPurchase,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPopular =
        plan.name.toLowerCase().contains('premium') ||
        plan.name.toLowerCase().contains('pro');

    return Stack(
      children: [
        Card(
          elevation: isCurrentPlan ? 8 : 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isCurrentPlan
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Plan Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (plan.description != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              plan.description!,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (isCurrentPlan)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Current',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 16),

                // Price Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${plan.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '/ ${plan.durationText}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ),
                  ],
                ),

                // Monthly Price
                if (plan.durationMonths > 1) ...[
                  const SizedBox(height: 4),
                  Text(
                    '₹${plan.monthlyPrice.toStringAsFixed(0)} per month',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],

                const SizedBox(height: 20),

                // Features
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFeatureRow(
                      Icons.account_balance_wallet,
                      '${plan.bonusPoints} bonus points',
                    ),
                    _buildFeatureRow(
                      Icons.confirmation_number,
                      plan.hasUnlimitedCoupons
                          ? 'Unlimited coupons'
                          : '${plan.maxCoupons} coupons',
                    ),
                    if (plan.featuresList.isNotEmpty)
                      ...plan.featuresList.map(
                        (feature) =>
                            _buildFeatureRow(Icons.check_circle, feature),
                      ),
                  ],
                ),

                const SizedBox(height: 20),

                // Purchase Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (!canPurchase || isCurrentPlan || isLoading)
                        ? null
                        : onPurchase,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: isCurrentPlan
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : Text(
                            _getButtonText(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Popular Badge
        if (isPopular && !isCurrentPlan)
          Positioned(
            top: -2,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'POPULAR',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  String _getButtonText() {
    if (isCurrentPlan) {
      return 'Current Plan';
    } else if (!canPurchase) {
      return 'Already Subscribed';
    } else {
      return 'Choose Plan';
    }
  }
}
