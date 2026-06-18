import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import 'package:savedge/features/gift_cards/data/services/gift_card_favorites_service.dart';
import 'package:savedge/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:savedge/features/gift_cards/presentation/theme/gc_tokens.dart';

/// Clean, image-forward gift card tile for the 2-column grid.
///
/// Deliberately restrained: the real brand artwork fills a rounded frame, with a
/// small heart and (when relevant) a flat discount tag over it, then the brand
/// name and price as plain text below — no gradients, gloss, or glow. The
/// artwork itself differentiates each card.
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

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEBECEF)),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _ProductImage(product: product),
                  if (product.hasDiscount)
                    Positioned(
                      top: 9,
                      left: 9,
                      child: _DiscountTag(pct: product.discountPercentage!),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _Heart(product: product, favorites: favorites),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.brandName ?? product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.25,
              fontWeight: FontWeight.w700,
              color: GcTokens.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 4),
          _PriceLine(
            currency: currency,
            base: base,
            payable: payable,
            hasDiscount: product.hasDiscount,
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.product});

  final GiftCardProductEntity product;

  @override
  Widget build(BuildContext context) {
    final url = product.squareImageUrl;
    if (url == null) return _Fallback(product: product);
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      memCacheWidth: 420,
      placeholder: (_, _) => product.blurHash != null
          ? BlurHash(hash: product.blurHash!)
          : const ColoredBox(color: Color(0xFFF5F6F8)),
      errorWidget: (_, _, _) => _Fallback(product: product),
    );
  }
}

/// Neutral brand-initial placeholder when there is no usable artwork.
class _Fallback extends StatelessWidget {
  const _Fallback({required this.product});

  final GiftCardProductEntity product;

  @override
  Widget build(BuildContext context) {
    final label = (product.brandName ?? product.name).trim();
    final initial = label.isEmpty ? '?' : label.characters.first.toUpperCase();
    return Container(
      color: const Color(0xFFF1F2F5),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w800,
          color: Color(0xFFB6BCC8),
        ),
      ),
    );
  }
}

/// Flat, high-contrast discount tag — no icon, gradient, or shadow.
class _DiscountTag extends StatelessWidget {
  const _DiscountTag({required this.pct});

  final double pct;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: GcTokens.brandBlack,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        '${pct.toStringAsFixed(0)}% OFF',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _PriceLine extends StatelessWidget {
  const _PriceLine({
    required this.currency,
    required this.base,
    required this.payable,
    required this.hasDiscount,
  });

  final String currency;
  final double base;
  final double payable;
  final bool hasDiscount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            '$currency${payable.toStringAsFixed(0)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w800,
              color: GcTokens.textPrimary,
            ),
          ),
        ),
        if (hasDiscount) ...[
          const SizedBox(width: 6),
          Text(
            '$currency${base.toStringAsFixed(0)}',
            maxLines: 1,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: GcTokens.textTertiary,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }
}

/// Small white heart toggle bound to [GiftCardFavoritesService].
class _Heart extends StatelessWidget {
  const _Heart({required this.product, required this.favorites});

  final GiftCardProductEntity product;
  final GiftCardFavoritesService favorites;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: favorites,
      builder: (_, _) {
        final fav = favorites.isFavorite(product.id);
        return GestureDetector(
          onTap: () => favorites.toggle(product.id),
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              fav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              size: 16,
              color: fav ? Colors.redAccent : const Color(0xFF8A93A3),
            ),
          ),
        );
      },
    );
  }
}
