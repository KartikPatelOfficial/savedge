import 'package:flutter/material.dart';

import '../../data/models/coupon_gifting_models.dart';
import 'enhanced_coupon_card.dart';

class CouponCategorySection extends StatelessWidget {
  const CouponCategorySection({
    super.key,
    required this.title,
    required this.coupons,
    this.onGiftTap,
    this.showGiftButton = true,
  });

  final String title;
  final List<UserCouponDetailModel> coupons;
  final Function(UserCouponDetailModel)? onGiftTap;
  final bool showGiftButton;

  @override
  Widget build(BuildContext context) {
    if (coupons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF6F3FCC).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${coupons.length}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6F3FCC),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: coupons.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: EnhancedCouponCard(
                coupon: coupons[index],
                onGiftTap: showGiftButton && onGiftTap != null
                    ? () => onGiftTap!(coupons[index])
                    : null,
              ),
            );
          },
        ),
      ],
    );
  }
}
