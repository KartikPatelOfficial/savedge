import 'package:flutter/material.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';

/// Widget to display subscription status information
class SubscriptionStatusCard extends StatelessWidget {
  const SubscriptionStatusCard({
    super.key,
    required this.activeSubscription,
    this.onManageSubscriptionTap,
    this.onUpgradeTap,
  });

  final SubscriptionInfo? activeSubscription;
  final VoidCallback? onManageSubscriptionTap;
  final VoidCallback? onUpgradeTap;

  @override
  Widget build(BuildContext context) {
    if (activeSubscription == null) {
      return _buildNoSubscriptionCard(context);
    }

    return _buildActiveSubscriptionCard(context);
  }

  Widget _buildNoSubscriptionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6F3FCC), Color(0xFF9C27B0)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6F3FCC).withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.workspace_premium,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get Premium',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Unlock exclusive coupons and benefits',
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onUpgradeTap,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'View Plans',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSubscriptionCard(BuildContext context) {
    final subscription = activeSubscription!;
    final now = DateTime.now();
    final daysRemaining = subscription.endDate.difference(now).inDays;
    final isExpiring = daysRemaining <= 15 && daysRemaining > 0;
    final hasExpired = !subscription.isActive || daysRemaining <= 0;

    // Calculate subscription duration in months
    final duration =
        subscription.endDate.difference(subscription.startDate).inDays ~/ 30;
    final durationText = duration >= 12
        ? '${duration ~/ 12} Year${duration ~/ 12 > 1 ? 's' : ''}'
        : '$duration Month${duration > 1 ? 's' : ''}';

    Color statusColor;
    Color backgroundColor;
    String statusText;

    if (hasExpired) {
      statusColor = const Color(0xFFE53E3E);
      backgroundColor = const Color(0xFFE53E3E).withOpacity(0.1);
      statusText = 'Expired';
    } else if (isExpiring) {
      statusColor = const Color(0xFFD69E2E);
      backgroundColor = const Color(0xFFD69E2E).withOpacity(0.1);
      statusText = 'Expiring Soon';
    } else {
      statusColor = const Color(0xFF38A169);
      backgroundColor = const Color(0xFF38A169).withOpacity(0.1);
      statusText = 'Active';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with subscription info and status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF6F3FCC),
                      const Color(0xFF6F3FCC).withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.workspace_premium,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription.planName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${subscription.price.toStringAsFixed(0)}/$durationText',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      statusText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Benefits/Features Grid
          Row(
            children: [
              Expanded(
                child: _buildFeatureItem(
                  icon: Icons.access_time_rounded,
                  label: hasExpired ? 'Expired' : 'Expires In',
                  value: hasExpired
                      ? 'Renew Now'
                      : daysRemaining == 0
                      ? 'Today'
                      : daysRemaining == 1
                      ? '1 Day'
                      : '$daysRemaining Days',
                  color: statusColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildFeatureItem(
                  icon: Icons.autorenew_rounded,
                  label: 'Auto Renew',
                  value: subscription.autoRenew ? 'Enabled' : 'Disabled',
                  color: subscription.autoRenew
                      ? const Color(0xFF38A169)
                      : const Color(0xFF718096),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildFeatureItem(
                  icon: Icons.event_available_rounded,
                  label: 'Valid Until',
                  value: _formatDate(subscription.endDate),
                  color: const Color(0xFF6F3FCC),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildFeatureItem(
                  icon: Icons.star_rounded,
                  label: 'Access Level',
                  value: 'Premium',
                  color: const Color(0xFFD69E2E),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Action buttons
          Row(
            children: [
              if (hasExpired) ...[
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onUpgradeTap,
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('Renew Now'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6F3FCC),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                    ),
                  ),
                ),
              ] else ...[
                if (isExpiring) ...[
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onUpgradeTap,
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: const Text('Renew'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD69E2E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),

          // Expiring warning
          if (isExpiring && !hasExpired) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFD69E2E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFD69E2E).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Color(0xFFD69E2E),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Your subscription expires in $daysRemaining ${daysRemaining == 1 ? 'day' : 'days'}. Renew to continue enjoying premium benefits.',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFD69E2E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF718096),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A202C),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }
}

/// Extension methods for SubscriptionInfo
extension SubscriptionInfoExtensions on SubscriptionInfo {
  /// Check if subscription is expiring within specified days
  bool isExpiringWithin(int days) {
    final now = DateTime.now();
    final daysRemaining = endDate.difference(now).inDays;
    return daysRemaining <= days && daysRemaining > 0;
  }

  /// Check if subscription is currently active (not expired)
  bool get isCurrentlyActive {
    final now = DateTime.now();
    return isActive && endDate.isAfter(now);
  }

  /// Get formatted price display
  String get priceDisplay => '₹${price.toStringAsFixed(0)}';

  /// Get remaining days
  int get daysRemaining {
    final now = DateTime.now();
    return endDate.difference(now).inDays;
  }
}
