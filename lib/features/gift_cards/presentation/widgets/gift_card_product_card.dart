import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entities/gift_card_entity.dart';

class GiftCardProductCard extends StatelessWidget {
  final GiftCardProductEntity product;
  final VoidCallback onTap;

  const GiftCardProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: product.thumbnailUrl != null ||
                          product.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl:
                              product.thumbnailUrl ?? product.imageUrl ?? '',
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          placeholder: (_, __) => Container(
                            height: 120,
                            color: const Color(0xFFF5F3FF),
                            child: const Center(
                              child: Icon(Icons.card_giftcard,
                                  color: Color(0xFFD1D5DB)),
                            ),
                          ),
                          errorWidget: (_, __, ___) => Container(
                            height: 120,
                            color: const Color(0xFFF5F3FF),
                            child: const Center(
                              child: Icon(Icons.card_giftcard,
                                  color: Color(0xFFD1D5DB)),
                            ),
                          ),
                        )
                      : Container(
                          height: 120,
                          color: const Color(0xFFF5F3FF),
                          child: const Center(
                            child: Icon(Icons.card_giftcard,
                                size: 36, color: Color(0xFFD1D5DB)),
                          ),
                        ),
                ),
                // Discount badge
                if (product.hasDiscount)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF059669),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${product.discountPercentage!.toStringAsFixed(0)}% OFF',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A202C),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${product.currencySymbol ?? '₹'}${product.minPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF6F3FCC),
                          ),
                        ),
                        Text(
                          ' - ${product.currencySymbol ?? '₹'}${product.maxPrice.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
