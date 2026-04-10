import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import '../../domain/entities/gift_card_entity.dart';
import '../theme/gc_tokens.dart';

class GcTrendingBrandTile extends StatelessWidget {
  const GcTrendingBrandTile({
    super.key,
    required this.product,
    required this.onTap,
  });

  final GiftCardProductEntity product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accent = GcTokens.accentFor(product.id);
    final bg = GcTokens.bgFor(product.id);
    final currency = product.currencySymbol ?? '\u20B9';
    final base = product.minPrice;
    final payable = product.calculatePayable(base);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(GcTokens.rCard),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(GcTokens.rCard),
            border: Border.all(color: const Color(0xFFEFEAFB)),
          ),
          child: Row(
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: product.squareImageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: product.squareImageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => product.blurHash != null
                              ? BlurHash(hash: product.blurHash!)
                              : Container(color: bg),
                          errorWidget: (_, __, ___) => Container(color: bg),
                        )
                      : Center(
                          child: Text(
                            (product.brandName ?? product.name)
                                .substring(0, 1)
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: accent,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.brandName ?? product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: GcTokens.textPrimary,
                      ),
                    ),
                    if (product.offerDescription != null &&
                        product.offerDescription!.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        product.offerDescription!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: GcTokens.textSecondary,
                          height: 1.3,
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        if (product.hasDiscount) ...[
                          Text(
                            '$currency${base.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: GcTokens.textTertiary,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 5),
                        ],
                        Text(
                          '$currency${payable.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: accent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (product.hasDiscount)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7C3AED), Color(0xFF5B21B6)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${product.discountPercentage!.toStringAsFixed(0)}%',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
