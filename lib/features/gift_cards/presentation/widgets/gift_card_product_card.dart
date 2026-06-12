import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:savedge/features/gift_cards/data/services/gift_card_favorites_service.dart';
import 'package:savedge/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:savedge/features/gift_cards/presentation/theme/gc_tokens.dart';

/// Product card used on the listing grid and the "Save X%" sections.
///
/// A clean white card: a full-width brand banner on top (with a heart toggle and
/// an optional discount badge), then the brand name, the payable price in violet,
/// and a violet arrow button. The heart is bound to [GiftCardFavoritesService].
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
    final currency = product.currencySymbol ?? '₹';
    final base = product.minPrice;
    final payable = product.calculatePayable(base);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(GcTokens.rCard),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(GcTokens.rCard),
            border: Border.all(color: const Color(0xFFEFEAFB)),
            boxShadow: GcTokens.tinyShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(GcTokens.rCard),
                      ),
                      child: _ProductImage(product: product),
                    ),
                    if (product.hasDiscount)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(7, 4, 8, 4),
                          decoration: BoxDecoration(
                            color: GcTokens.brandLime,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: GcTokens.tinyShadow,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                LucideIcons.percent,
                                size: 11,
                                color: GcTokens.brandBlack,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                '${product.discountPercentage!.toStringAsFixed(0)}% OFF',
                                style: const TextStyle(
                                  color: GcTokens.brandBlack,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _FavoriteButton(
                        product: product,
                        favorites: favorites,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 10, 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.brandName ?? product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.18,
                        fontWeight: FontWeight.w800,
                        color: GcTokens.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (product.hasDiscount)
                                Text(
                                  '$currency${base.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 10.5,
                                    color: GcTokens.textTertiary,
                                    decoration: TextDecoration.lineThrough,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              Text(
                                '$currency${payable.toStringAsFixed(0)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  color: GcTokens.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        _ArrowButton(onTap: onTap),
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
  }
}

/// Violet rounded-square "open" affordance shown at the card's bottom-right.
class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'View',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: GcTokens.primary,
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Icon(
            LucideIcons.arrowRight,
            size: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// White circular heart toggle bound to [GiftCardFavoritesService].
class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.product, required this.favorites});

  final GiftCardProductEntity product;
  final GiftCardFavoritesService favorites;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: favorites,
      builder: (_, _) {
        final fav = favorites.isFavorite(product.id);
        return Material(
          color: Colors.white,
          shape: const CircleBorder(),
          elevation: 1,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => favorites.toggle(product.id),
            child: SizedBox(
              width: 32,
              height: 32,
              child: Icon(
                fav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                size: 17,
                color: fav ? Colors.redAccent : GcTokens.textTertiary,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product});

  final GiftCardProductEntity product;

  // Prefer the ~square mobile image so the whole card art stays visible.
  String? get _bestUrl => product.squareImageUrl;
  bool get _hasUrl => _bestUrl != null && _bestUrl!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GcTokens.surfaceMuted,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      child: !_hasUrl
          ? _fallback()
          : CachedNetworkImage(
              imageUrl: _bestUrl!,
              // Contain so the entire brand artwork is shown, never cropped.
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              memCacheWidth: 600,
              placeholder: (_, _) => product.blurHash != null
                  ? BlurHash(hash: product.blurHash!)
                  : _fallback(),
              errorWidget: (_, _, _) => _fallback(),
            ),
    );
  }

  Widget _fallback() {
    final label = (product.brandName ?? product.name).trim();
    final initial = label.isEmpty ? '?' : label[0].toUpperCase();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: GcTokens.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(
              initial,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: GcTokens.primary,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              label.isEmpty ? 'Gift card' : label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: GcTokens.primary,
              ),
            ),
          ),
        ],
    );
  }
}
