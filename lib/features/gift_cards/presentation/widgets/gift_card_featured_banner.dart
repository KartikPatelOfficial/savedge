import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entities/gift_card_entity.dart';

/// Carousel banner card for discounted gift card products.
/// Used in a PageView on the browse page.
class GiftCardFeaturedBanner extends StatelessWidget {
  final GiftCardProductEntity product;
  final VoidCallback onTap;

  static const _palettes = [
    Color(0xFFF3EFFE),
    Color(0xFFFFF0E6),
    Color(0xFFE6F9F0),
    Color(0xFFE6F3FF),
    Color(0xFFFFF3E6),
    Color(0xFFFCE6F0),
  ];

  static const _accentPalettes = [
    Color(0xFF7C3AED),
    Color(0xFFEA580C),
    Color(0xFF059669),
    Color(0xFF2563EB),
    Color(0xFFD97706),
    Color(0xFFDB2777),
  ];

  const GiftCardFeaturedBanner({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = _palettes[product.id % _palettes.length];
    final accent = _accentPalettes[product.id % _accentPalettes.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: palette,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF0F0F0), width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            // Left side — text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.brandName ?? product.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: accent,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  if (product.hasDiscount)
                    Text(
                      '${product.discountPercentage!.toStringAsFixed(0)}% OFF',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: accent,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    'Save on ${product.name}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Shop Now',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Right side — product image
            SizedBox(
              width: 120,
              child: Container(
                decoration: BoxDecoration(
                  color: palette,
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: product.imageUrl != null || product.thumbnailUrl != null
                    ? CachedNetworkImage(
                        imageUrl:
                            product.imageUrl ?? product.thumbnailUrl ?? '',
                        fit: BoxFit.contain,
                        placeholder: (_, __) => Center(
                          child: Icon(Icons.card_giftcard_rounded,
                              size: 40, color: accent.withAlpha(80)),
                        ),
                        errorWidget: (_, __, ___) => Center(
                          child: Icon(Icons.card_giftcard_rounded,
                              size: 40, color: accent.withAlpha(80)),
                        ),
                      )
                    : Center(
                        child: Icon(Icons.card_giftcard_rounded,
                            size: 40, color: accent.withAlpha(80)),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
