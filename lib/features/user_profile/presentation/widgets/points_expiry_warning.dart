import 'package:flutter/material.dart';
import '../../../../shared/domain/entities/points.dart';

/// Warning widget for points that are expiring soon
class PointsExpiryWarning extends StatelessWidget {
  final Points points;

  const PointsExpiryWarning({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    if (!points.isExpiringSoon) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        color: Colors.orange[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.orange[300]!),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange[700],
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Points Expiring Soon!',
                      style: TextStyle(
                        color: Colors.orange[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getWarningMessage(),
                      style: TextStyle(color: Colors.orange[800], fontSize: 13),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  _showExpiryDetails(context);
                },
                icon: Icon(Icons.info_outline, color: Colors.orange[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getWarningMessage() {
    final days = points.daysUntilExpiry;
    if (days == 0) {
      return '${points.balance} points expire today. Use them now!';
    } else if (days == 1) {
      return '${points.balance} points expire tomorrow. Don\'t miss out!';
    } else {
      return '${points.balance} points expire in $days days. Use them soon!';
    }
  }

  void _showExpiryDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.schedule, color: Colors.orange[700]),
            const SizedBox(width: 8),
            const Text('Points Expiry'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your points are set to expire soon. Here are the details:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Current Balance', '${points.balance} points'),
            _buildInfoRow('Expiry Date', _formatExpiryDate()),
            _buildInfoRow('Days Remaining', '${points.daysUntilExpiry} days'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '💡 Tip',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Use your points to redeem coupons or upgrade your subscription to avoid losing them.',
                    style: TextStyle(color: Colors.blue[800], fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to coupons or subscription page
              Navigator.pushNamed(context, '/coupons');
            },
            child: const Text('Browse Coupons'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  String _formatExpiryDate() {
    if (points.expirationDate == null) return 'No expiry';

    final date = points.expirationDate!;
    return '${date.day}/${date.month}/${date.year}';
  }
}
