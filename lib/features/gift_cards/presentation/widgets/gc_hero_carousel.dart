import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import '../../domain/entities/gift_card_entity.dart';
import '../theme/gc_tokens.dart';
import 'gc_palette_extractor.dart';

class GcHeroCarousel extends StatefulWidget {
  const GcHeroCarousel({
    super.key,
    required this.items,
    required this.onTap,
  });

  final List<GiftCardProductEntity> items;
  final ValueChanged<GiftCardProductEntity> onTap;

  @override
  State<GcHeroCarousel> createState() => _GcHeroCarouselState();
}

class _GcHeroCarouselState extends State<GcHeroCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.82);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    if (widget.items.length <= 1) return;
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_controller.hasClients) return;
      final next = (_index + 1) % widget.items.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  void _pauseAutoScroll() => _timer?.cancel();

  void _resumeAutoScroll() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) _startAutoScroll();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        SizedBox(
          height: 236,
          child: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification) {
                _pauseAutoScroll();
              } else if (notification is ScrollEndNotification) {
                _resumeAutoScroll();
              }
              return false;
            },
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.items.length,
              clipBehavior: Clip.none,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _HeroCard(
                  product: widget.items[i],
                  onTap: () => widget.onTap(widget.items[i]),
                ),
              ),
            ),
          ),
        ),
        if (widget.items.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.items.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _index ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: i == _index
                        ? GcTokens.primary
                        : GcTokens.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Premium showcase card with dynamic brand colors extracted from
/// the product image — matches the home page gift cards showcase style.
class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.product, required this.onTap});

  final GiftCardProductEntity product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fallbackAccent = GcTokens.accentFor(product.id);
    final paletteFallback = GcPaletteColors(
      primary: fallbackAccent,
      secondary: Color.lerp(fallbackAccent, Colors.white, 0.24)!,
    );
    final paletteImageUrl = product.heroImageUrl ?? product.squareImageUrl;

    return FutureBuilder<GcPaletteColors>(
      future: GcPaletteExtractor.resolvePair(paletteImageUrl, paletteFallback),
      builder: (context, snapshot) {
        final pair = snapshot.data ?? paletteFallback;
        final primary = pair.primary;
        final hsl = HSLColor.fromColor(primary);
        final deep = hsl
            .withLightness((hsl.lightness * 0.52).clamp(0.28, 0.40))
            .toColor();
        final midTone = hsl
            .withLightness((hsl.lightness * 0.78).clamp(0.38, 0.56))
            .toColor();
        final highlight = hsl
            .withLightness((hsl.lightness * 1.08).clamp(0.58, 0.72))
            .toColor();
        final accentLine = hsl
            .withLightness((hsl.lightness * 1.18).clamp(0.68, 0.82))
            .toColor();
        final currency = product.currencySymbol ?? '\u20B9';
        final base = product.minPrice;
        final payable = product.calculatePayable(base);

        return LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 300;
            final imageWidth = isCompact ? 104.0 : 124.0;
            final imageHeight = isCompact ? 148.0 : 170.0;
            final titleSize = isCompact ? 18.0 : 20.0;
            final bodySize = isCompact ? 11.0 : 12.0;
            final priceSize = isCompact ? 18.0 : 20.0;
            final overlineSize = isCompact ? 9.5 : 10.5;
            final subtitleLines = isCompact ? 1 : 2;

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [deep, midTone, highlight],
                      stops: const [0.0, 0.58, 1.0],
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.20),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      ..._buildBackgroundWatermarks(
                        isCompact: isCompact,
                        primaryTint: Colors.white,
                        accentTint: accentLine,
                      ),
                      // Top-right glow
                      Positioned(
                        right: -26,
                        top: -34,
                        child: Container(
                          width: 168,
                          height: 168,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0.18),
                                Colors.white.withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Bottom-left glow
                      Positioned(
                        left: -46,
                        bottom: -74,
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                highlight.withValues(alpha: 0.22),
                                primary.withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Logo watermark
                      Positioned(
                        left: isCompact ? -28 : -36,
                        bottom: isCompact ? -36 : -48,
                        child: IgnorePointer(
                          child: Transform.rotate(
                            angle: -0.04,
                            child: Image.asset(
                              'assets/images/logo_transparant.png',
                              width: isCompact ? 148 : 168,
                              fit: BoxFit.contain,
                              color: Colors.white.withValues(alpha: 0.12),
                              colorBlendMode: BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    product.hasDiscount
                                        ? 'CURATED SAVINGS'
                                        : 'DIGITAL GIFTING',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: overlineSize,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.6,
                                      color: Colors.white.withValues(
                                        alpha: 0.70,
                                      ),
                                    ),
                                  ),
                                ),
                                if (product.hasDiscount)
                                  Text(
                                    '${product.discountPercentage!.toStringAsFixed(0)}% OFF',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.8,
                                      color: Color.lerp(
                                        primary,
                                        Colors.white,
                                        0.72,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 42,
                                height: 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  color: accentLine,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.brandName ?? product.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: titleSize,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                            height: 1.05,
                                            letterSpacing: -0.5,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          _subtitle,
                                          maxLines: subtitleLines,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: bodySize,
                                            height: 1.3,
                                            color: Colors.white.withValues(
                                              alpha: 0.78,
                                            ),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          product.hasDiscount
                                              ? 'You pay'
                                              : 'Starts at',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white.withValues(
                                              alpha: 0.72,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Wrap(
                                          spacing: 6,
                                          runSpacing: 4,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            if (product.hasDiscount)
                                              Text(
                                                '$currency${base.toStringAsFixed(0)}',
                                                style: TextStyle(
                                                  fontSize: 10.5,
                                                  color: Colors.white
                                                      .withValues(alpha: 0.56),
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor: Colors.white
                                                      .withValues(alpha: 0.52),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            Text(
                                              '$currency${payable.toStringAsFixed(0)}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: priceSize,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                                letterSpacing: -0.3,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: isCompact ? 8 : 10),
                                  // Product image
                                  Transform.translate(
                                    offset: const Offset(0, 2),
                                    child: Transform.rotate(
                                      angle: -0.04,
                                      child: Container(
                                        width: imageWidth,
                                        height: imageHeight,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.white,
                                              Color.lerp(
                                                primary,
                                                Colors.white,
                                                0.88,
                                              )!,
                                            ],
                                          ),
                                          border: Border.all(
                                            color: Colors.white.withValues(
                                              alpha: 0.62,
                                            ),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: _buildImage(
                                          product.squareImageUrl ??
                                              product.heroImageUrl,
                                          Color.lerp(
                                            primary,
                                            Colors.white,
                                            0.80,
                                          )!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
          },
        );
      },
    );
  }

  String get _subtitle {
    final offer = product.offerDescription?.trim();
    if (offer != null && offer.isNotEmpty) return offer;

    final description = product.description?.trim();
    if (description != null && description.isNotEmpty) return description;

    final category = product.categoryName?.trim();
    if (category != null && category.isNotEmpty) {
      return '$category experiences, dining and more in one card.';
    }

    return 'Flexible gifting with instant checkout and easy redemption.';
  }

  List<Widget> _buildBackgroundWatermarks({
    required bool isCompact,
    required Color primaryTint,
    required Color accentTint,
  }) {
    final softTint = primaryTint.withValues(alpha: isCompact ? 0.08 : 0.10);
    final accentSoftTint = accentTint.withValues(
      alpha: isCompact ? 0.12 : 0.14,
    );

    return [
      Positioned(
        right: isCompact ? 24 : 28,
        top: isCompact ? 18 : 20,
        child: IgnorePointer(
          child: Transform.rotate(
            angle: 0.18,
            child: Icon(
              Icons.redeem_rounded,
              size: isCompact ? 24 : 30,
              color: softTint,
            ),
          ),
        ),
      ),
      Positioned(
        left: isCompact ? 18 : 24,
        top: isCompact ? 82 : 92,
        child: IgnorePointer(
          child: Transform.rotate(
            angle: -0.22,
            child: Icon(
              Icons.local_offer_rounded,
              size: isCompact ? 18 : 22,
              color: softTint,
            ),
          ),
        ),
      ),
      Positioned(
        right: isCompact ? 96 : 114,
        bottom: isCompact ? 26 : 30,
        child: IgnorePointer(
          child: Transform.rotate(
            angle: -0.16,
            child: Icon(
              Icons.auto_awesome_rounded,
              size: isCompact ? 18 : 22,
              color: accentSoftTint,
            ),
          ),
        ),
      ),
      Positioned(
        left: isCompact ? 92 : 108,
        bottom: isCompact ? 28 : 26,
        child: IgnorePointer(
          child: Transform.rotate(
            angle: -0.10,
            child: Text(
              '\u2726',
              style: TextStyle(
                fontSize: isCompact ? 20 : 26,
                fontWeight: FontWeight.w800,
                color: primaryTint.withValues(alpha: 0.14),
              ),
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildImage(String? url, Color fallbackColor) {
    if (url != null && url.trim().isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.contain,
          memCacheWidth: 560,
          placeholder: (_, _) => product.blurHash != null
              ? BlurHash(hash: product.blurHash!)
              : Container(color: fallbackColor),
          errorWidget: (_, _, _) => _imageFallback(),
        ),
      );
    }
    return _imageFallback();
  }

  Widget _imageFallback() {
    final label = (product.brandName ?? product.name).trim();
    final initial = label.isEmpty ? '?' : label[0].toUpperCase();
    final accent = GcTokens.accentFor(product.id);
    return Center(
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.15),
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
    );
  }
}
