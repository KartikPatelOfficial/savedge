import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/gift_card_entity.dart';

class GiftCardOrderCard extends StatelessWidget {
  final GiftCardOrderEntity order;

  const GiftCardOrderCard({super.key, required this.order});

  Color _statusColor() {
    switch (order.status) {
      case GiftCardOrderStatusEntity.completed:
        return const Color(0xFF059669);
      case GiftCardOrderStatusEntity.failed:
        return const Color(0xFFDC2626);
      case GiftCardOrderStatusEntity.cancelled:
        return const Color(0xFF6B7280);
      case GiftCardOrderStatusEntity.refunded:
        return const Color(0xFFA855F7);
      case GiftCardOrderStatusEntity.issuing:
        return const Color(0xFF7C3AED);
      case GiftCardOrderStatusEntity.paymentCompleted:
        return const Color(0xFF2563EB);
      case GiftCardOrderStatusEntity.pending:
        return const Color(0xFFD97706);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // Product image placeholder
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F3FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.card_giftcard,
                      color: Color(0xFF7C3AED), size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.productName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A202C),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Order #${order.id} · ${_formatDate(order.created)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    order.status.displayName,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _statusColor(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Amount row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              border: Border(
                top: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAmountColumn(
                    'Card Value', '₹${order.requestedAmount.toStringAsFixed(0)}'),
                if (order.discountAmount > 0)
                  _buildAmountColumn(
                    'Saved',
                    '₹${order.discountAmount.toStringAsFixed(0)}',
                    color: const Color(0xFF059669),
                  ),
                _buildAmountColumn(
                  'Paid',
                  order.paymentMethod == GiftCardPaymentMethodEntity.points
                      ? '${order.payableAmount.toStringAsFixed(0)} pts'
                      : '₹${order.payableAmount.toStringAsFixed(0)}',
                  color: const Color(0xFF6F3FCC),
                  isBold: true,
                ),
              ],
            ),
          ),

          // Card details (if completed)
          if (order.isCompleted && order.hasCardDetails)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(14)),
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gift Card Details',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF059669),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (order.woohooCardNumber != null)
                    _buildDetailRow(
                        'Card Number', order.woohooCardNumber!, context),
                  if (order.woohooCardPin != null)
                    _buildDetailRow(
                        'PIN', order.woohooCardPin!, context),
                  if (order.woohooActivationCode != null)
                    _buildDetailRow('Activation Code',
                        order.woohooActivationCode!, context),
                  if (order.woohooCardExpiry != null)
                    _buildDetailRow(
                        'Expires', _formatDate(order.woohooCardExpiry!), context,
                        copyable: false),
                ],
              ),
            ),

          // Failure reason
          if (order.isFailed && order.failureReason != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(14)),
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: Text(
                order.failureReason!,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFFDC2626),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAmountColumn(String label, String value,
      {Color? color, bool isBold = false}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: color ?? const Color(0xFF1A202C),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, BuildContext context,
      {bool copyable = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
          ),
          if (copyable)
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$label copied'),
                    duration: const Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Icon(Icons.copy_rounded,
                  size: 16, color: Colors.grey[400]),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
