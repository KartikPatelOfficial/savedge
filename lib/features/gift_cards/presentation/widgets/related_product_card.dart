import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// Compact card for related products in a horizontal scroll
/// on the gift card detail page.
class RelatedProductCard extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String? minPrice;
  final String? maxPrice;
  final String? offerShortDesc;
  final String currencySymbol;
  final int index;

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

  const RelatedProductCard({
    super.key,
    required this.name,
    this.imageUrl,
    this.minPrice,
    this.maxPrice,
    this.offerShortDesc,
    required this.currencySymbol,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final palette = _palettes[index % _palettes.length];
    final accent = _accentPalettes[index % _accentPalettes.length];

    final hasRange =
        minPrice != null && maxPrice != null && minPrice != maxPrice;
    final priceText = hasRange
        ? '$currencySymbol$minPrice - $currencySymbol$maxPrice'
        : '$currencySymbol${minPrice ?? '0'}';

    return SizedBox(
      width: 140,
      height: 170,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF0F0F0), width: 1.5),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Container(
              height: 90,
              width: double.infinity,
              color: palette,
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Center(
                        child: Icon(Icons.card_giftcard_rounded,
                            size: 32, color: accent.withAlpha(80)),
                      ),
                      errorWidget: (_, __, ___) => Center(
                        child: Icon(Icons.card_giftcard_rounded,
                            size: 32, color: accent.withAlpha(80)),
                      ),
                    )
                  : Center(
                      child: Icon(Icons.card_giftcard_rounded,
                          size: 32, color: accent.withAlpha(80)),
                    ),
            ),

            // Info section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      priceText,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: accent,
                      ),
                    ),
                    if (offerShortDesc != null) ...[
                      Text(
                        offerShortDesc!,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9CA3AF),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
