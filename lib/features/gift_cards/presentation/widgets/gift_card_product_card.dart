import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import '../../data/services/gift_card_favorites_service.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../theme/gc_tokens.dart';
import 'gc_palette_extractor.dart';

/// Premium-looking product card used on the listing grid and the
/// "Save X%" sections. Shows brand image, name, strikethrough+payable price,
/// discount badge, and a heart toggle bound to [GiftCardFavoritesService].
class GiftCardProductCard extends StatelessWidget {
  const GiftCardProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.favorites,
  });

  final GiftCardProductEntity product;
  final VoidCallback onTap;
  final GiftCardFavoritesService favorites;

  @override
  Widget build(BuildContext context) {
    final accent = GcTokens.accentFor(product.id);
    final currency = product.currencySymbol ?? '\u20B9';
    final base = product.minPrice;
    final payable = product.calculatePayable(base);

    return GcPaletteExtractor(
      imageUrl: product.squareImageUrl,
      fallback: accent,
      builder: (context, brand) {
        // Soft pastel tint of the brand color filling the entire image area.
        final tint = Color.lerp(brand, Colors.white, 0.82)!;
        final borderTint = brand.withValues(alpha: 0.22);

        return Material(
          color: tint,
          borderRadius: BorderRadius.circular(GcTokens.rCard),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(GcTokens.rCard),
            child: Container(
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(GcTokens.rCard),
                border: Border.all(color: borderTint),
                boxShadow: GcTokens.tinyShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Full-bleed gift-card art (base image), rounded to match
                        // the card's top corners. Center-cropped so the brand —
                        // which sits centered on the artwork — is always kept.
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(GcTokens.rCard),
                          ),
                          child: _ProductImage(
                            product: product,
                            accent: brand == accent ? accent : brand,
                          ),
                        ),
                        if (product.hasDiscount)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF7C3AED),
                                    Color(0xFF9F7AEA),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Save ${product.discountPercentage!.toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: AnimatedBuilder(
                            animation: favorites,
                            builder: (_, __) {
                              final fav = favorites.isFavorite(product.id);
                              return Material(
                                color: Colors.white,
                                shape: const CircleBorder(),
                                elevation: 1,
                                child: InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: () => favorites.toggle(product.id),
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: Icon(
                                      fav
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_border_rounded,
                                      size: 16,
                                      color: fav
                                          ? Colors.redAccent
                                          : GcTokens.textTertiary,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    color: brand.withValues(alpha: 0.18),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.brandName ?? product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: GcTokens.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (product.hasDiscount) ...[
                              Text(
                                '$currency${base.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: GcTokens.textTertiary,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                            ],
                            Text(
                              '$currency${payable.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w900,
                                color: brand == accent ? accent : brand,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product, required this.accent});

  final GiftCardProductEntity product;
  final Color accent;

  String? get _bestUrl => product.squareImageUrl;
  bool get _hasUrl => _bestUrl != null && _bestUrl!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (!_hasUrl) return _fallback();
    return CachedNetworkImage(
      imageUrl: _bestUrl!,
      // Mobile (square) variant, contained so the whole card is always visible and
      // never cropped. Full-bleed area (no inner padding) keeps it from looking shrunk.
      fit: BoxFit.contain,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      memCacheWidth: 600,
      placeholder: (_, __) => product.blurHash != null
          ? BlurHash(hash: product.blurHash!)
          : _fallback(),
      errorWidget: (_, __, ___) => _fallback(),
    );
  }

  Widget _fallback() {
    final label = (product.brandName ?? product.name).trim();
    final initial = label.isEmpty ? '?' : label[0].toUpperCase();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: accent,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label.isEmpty ? 'Gift card' : label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: accent,
            ),
          ),
        ],
      ),
    );
  }
}
