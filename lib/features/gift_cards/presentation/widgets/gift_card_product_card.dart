import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entities/gift_card_entity.dart';

/// Bold, colorful gift card grid tile.
/// - Tall image at top in a vibrant pastel container
/// - Brand name in large bold text below
/// - Price pill at the bottom left
/// - Discount badge tucked in top-right
class GiftCardProductCard extends StatelessWidget {
  final GiftCardProductEntity product;
  final VoidCallback onTap;

  // Palette rotated by product id for visual variety
  static const _palettes = [
    Color(0xFFF3EFFE), // soft lavender
    Color(0xFFFFF0E6), // soft peach
    Color(0xFFE6F9F0), // soft mint
    Color(0xFFE6F3FF), // soft sky
    Color(0xFFFFF3E6), // soft amber
    Color(0xFFFCE6F0), // soft rose
  ];

  static const _accentPalettes = [
    Color(0xFF7C3AED),
    Color(0xFFEA580C),
    Color(0xFF059669),
    Color(0xFF2563EB),
    Color(0xFFD97706),
    Color(0xFFDB2777),
  ];

  const GiftCardProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = _palettes[product.id % _palettes.length];
    final accent = _accentPalettes[product.id % _accentPalettes.length];
    final priceText = product.priceType == 'SLAB'
        ? '${product.currencySymbol ?? '₹'}${product.minPrice.toStringAsFixed(0)}'
        : '${product.currencySymbol ?? '₹'}${product.minPrice.toStringAsFixed(0)}+';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF0F0F0), width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Image section ===
            Stack(
              children: [
                Container(
                  height: 130,
                  color: palette,
                  child: product.thumbnailUrl != null || product.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: product.thumbnailUrl ?? product.imageUrl ?? '',
                          width: double.infinity,
                          height: 130,
                          fit: BoxFit.cover,
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

                // Discount badge
                if (product.hasDiscount)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${product.discountPercentage!.toStringAsFixed(0)}% OFF',
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // === Info section ===
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category name
                    if (product.categoryName != null)
                      Text(
                        product.categoryName!,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF9CA3AF),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    // Brand name
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Savings callout
                    if (product.hasDiscount)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Row(
                          children: [
                            Text(
                              '${product.currencySymbol ?? '₹'}${product.minPrice.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF9CA3AF),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${product.currencySymbol ?? '₹'}${product.calculatePayable(product.minPrice).toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: accent,
                              ),
                            ),
                          ],
                        ),
                      ),

                    const Spacer(),

                    // Price tag row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: palette,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            priceText,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: accent,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(Icons.arrow_forward_rounded,
                                  color: Colors.white, size: 12),
                            ],
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
