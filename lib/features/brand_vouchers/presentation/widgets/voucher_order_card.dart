import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entities/brand_voucher_entity.dart';

class VoucherOrderCard extends StatelessWidget {
  final VoucherOrderEntity order;
  final VoidCallback onTap;

  const VoucherOrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with brand info and status
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: order.brandImageUrl,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 40,
                        height: 40,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, size: 20, color: Colors.grey),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 40,
                        height: 40,
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image, size: 20, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.brandName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A202C),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Order #${order.id}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Order details
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildInfoColumn(
                        'Voucher Value',
                        '₹${order.voucherAmount.toStringAsFixed(0)}',
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 32,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: _buildInfoColumn(
                        'Points Used',
                        '${order.totalPointsUsed.toStringAsFixed(0)}',
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 32,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: _buildInfoColumn(
                        'Order Date',
                        _formatDate(order.created),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Status description or voucher details
              if (order.isCompleted && order.hasVoucherDetails) ...[
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF86EFAC)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 16,
                        color: Color(0xFF059669),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Voucher ready! Tap to view details',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                        color: Color(0xFF059669),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      _getStatusIcon(),
                      size: 14,
                      color: _getStatusColor(),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        order.status.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              
              if (order.isRejected && order.rejectionReason != null) ...[
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Reason: ${order.rejectionReason}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFFEF4444),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        order.status.displayName,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: _getStatusColor(),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (order.status) {
      case VoucherOrderStatusEntity.pending:
        return const Color(0xFFFF9800);
      case VoucherOrderStatusEntity.processing:
        return const Color(0xFF2196F3);
      case VoucherOrderStatusEntity.fulfilled:
        return const Color(0xFF059669);
      case VoucherOrderStatusEntity.rejected:
        return const Color(0xFFEF4444);
      case VoucherOrderStatusEntity.cancelled:
        return const Color(0xFF6B7280);
    }
  }

  IconData _getStatusIcon() {
    switch (order.status) {
      case VoucherOrderStatusEntity.pending:
        return Icons.access_time_rounded;
      case VoucherOrderStatusEntity.processing:
        return Icons.refresh_rounded;
      case VoucherOrderStatusEntity.fulfilled:
        return Icons.check_circle_rounded;
      case VoucherOrderStatusEntity.rejected:
        return Icons.cancel_rounded;
      case VoucherOrderStatusEntity.cancelled:
        return Icons.block_rounded;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}';
    }
  }
}