import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/coupon_gifting_models.dart';

class EnhancedCouponCard extends StatelessWidget {
  const EnhancedCouponCard({super.key, required this.coupon, this.onGiftTap});

  final UserCouponDetailModel coupon;
  final VoidCallback? onGiftTap;

  @override
  Widget build(BuildContext context) {
    final color = _getCouponColor();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: coupon.isActive
              ? color.withOpacity(0.3)
              : const Color(0xFFE2E8F0),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Coupon Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: coupon.isActive ? color : const Color(0xFF718096),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
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
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        coupon.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (coupon.description != null &&
                    coupon.description!.isNotEmpty) ...[
                  Text(
                    coupon.description!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF4A5568),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                ],
                Row(
                  children: [
                    const Icon(
                      Icons.store_outlined,
                      size: 18,
                      color: Color(0xFF6F3FCC),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        coupon.vendorName,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D3748),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                if (coupon.minCartValue > 0) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6F3FCC).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          size: 16,
                          color: Color(0xFF6F3FCC),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Min order: ₹${coupon.minCartValue.toInt()}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6F3FCC),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expires: ${_getFormattedDate(coupon.expiryDate)}',
                            style: TextStyle(
                              fontSize: 13,
                              color: coupon.isExpired
                                  ? const Color(0xFFE53E3E)
                                  : const Color(0xFF718096),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (coupon.isGifted &&
                              coupon.giftedFromUserId != null) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.card_giftcard,
                                  size: 14,
                                  color: Color(0xFF38A169),
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Gift from colleague',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF38A169),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7FAFC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Text(
                            coupon.uniqueCode,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'monospace',
                              color: Color(0xFF2D3748),
                            ),
                          ),
                        ),
                        if (onGiftTap != null &&
                            coupon.isActive &&
                            !coupon.isGifted) ...[
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: onGiftTap,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6F3FCC).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(
                                    0xFF6F3FCC,
                                  ).withOpacity(0.3),
                                ),
                              ),
                              child: const Icon(
                                Icons.card_giftcard,
                                size: 16,
                                color: Color(0xFF6F3FCC),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
                if (coupon.giftMessage != null &&
                    coupon.giftMessage!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF38A169).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF38A169).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '💝 Gift Message:',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF38A169),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          coupon.giftMessage!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF2D3748),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
      backgroundColor = const Color(0xFFD69E2E);
      textColor = Colors.white;
      statusText = 'Used';
    } else if (coupon.isExpired) {
      backgroundColor = const Color(0xFFE53E3E);
      textColor = Colors.white;
      statusText = 'Expired';
    } else if (coupon.status.toLowerCase() == 'gifted') {
      backgroundColor = const Color(0xFF805AD5);
      textColor = Colors.white;
      statusText = 'Gifted';
    } else {
      backgroundColor = const Color(0xFF38A169);
      textColor = Colors.white;
      statusText = 'Active';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: textColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getCouponColor() {
    if (!coupon.isActive) return Colors.grey;

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

  String _getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}
