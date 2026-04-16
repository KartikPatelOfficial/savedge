import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import 'package:savedge/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:savedge/features/gift_cards/presentation/bloc/gift_cards_bloc.dart';
import 'package:savedge/features/gift_cards/presentation/pages/gift_card_detail_page.dart';
import 'package:savedge/features/gift_cards/presentation/pages/gift_cards_page.dart';
import 'package:savedge/features/gift_cards/presentation/theme/gc_tokens.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_palette_extractor.dart';

/// Premium gift cards showcase section for the home page.
/// Displays admin-enabled "hot deal" gift cards in a horizontal
/// PageView carousel with dynamic brand colors extracted from images.
class GiftCardsShowcaseSection extends StatelessWidget {
  const GiftCardsShowcaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftCardsBloc, GiftCardsState>(
      buildWhen: (prev, curr) =>
          curr is HotDealsLoaded || curr is GiftCardsInitial,
      builder: (context, state) {
        if (state is HotDealsLoaded && state.hotDeals.isNotEmpty) {
          return _ShowcaseView(hotDeals: state.hotDeals);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _ShowcaseView extends StatefulWidget {
  const _ShowcaseView({required this.hotDeals});

  final List<GiftCardProductEntity> hotDeals;

  @override
  State<_ShowcaseView> createState() => _ShowcaseViewState();
}

class _ShowcaseViewState extends State<_ShowcaseView> {
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
    if (widget.hotDeals.length <= 1) return;
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_controller.hasClients) return;
      final next = (_index + 1) % widget.hotDeals.length;
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

  void _openDetail(GiftCardProductEntity product) {
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GiftCardDetailPage(product: product)),
    );
  }

  void _openAllGiftCards() {
    HapticFeedback.lightImpact();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GiftCardsPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header — gradient title matching Top Offers style
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Text(
                      'Gift Cards',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A202C),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: GcTokens.brandLime,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'DEALS',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: GcTokens.brandBlack,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _openAllGiftCards,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: GcTokens.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: GcTokens.primary,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: GcTokens.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Card carousel
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
              clipBehavior: Clip.none,
              itemCount: widget.hotDeals.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: _ShowcaseCard(
                  product: widget.hotDeals[i],
                  onTap: () => _openDetail(widget.hotDeals[i]),
                ),
              ),
            ),
          ),
        ),

        // Page indicators
        if (widget.hotDeals.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.hotDeals.length,
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

        const SizedBox(height: 8),
      ],
    );
  }
}

/// A premium gift card with dynamic brand colors extracted from the product
/// image. Uses [GcPaletteExtractor] to tint the card background, glow, and
/// accents based on the actual brand image palette.
class _ShowcaseCard extends StatelessWidget {
  const _ShowcaseCard({required this.product, required this.onTap});

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
                                  Transform.translate(
                                    offset: const Offset(0, 2),
                                    child: Transform.rotate(
                                      angle: -0.04,
                                      child: Container(
                                        width: imageWidth,
                                        height: imageHeight,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
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
                                          fit: BoxFit.contain,
                                          radius: 18,
                                          memCacheWidth: 560,
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
    if (offer != null && offer.isNotEmpty) {
      return offer;
    }

    final description = product.description?.trim();
    if (description != null && description.isNotEmpty) {
      return description;
    }

    final category = product.categoryName?.trim();
    if (category != null && category.isNotEmpty) {
      return '$category experiences, dining and more in one card.';
    }

    return 'Flexible gifting with instant checkout and easy redemption.';
  }

  String _supportingPriceText(String currency) {
    if (product.hasDiscount) {
      return 'Worth $currency${product.minPrice.toStringAsFixed(0)}';
    }

    if (product.maxPrice > product.minPrice) {
      return 'Up to $currency${product.maxPrice.toStringAsFixed(0)}';
    }

    return 'Ready to send instantly';
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
              '✦',
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

  Widget _buildImage(
    String? url,
    Color fallbackColor, {
    BoxFit fit = BoxFit.contain,
    double radius = 14,
    int memCacheWidth = 400,
  }) {
    if (url != null && url.trim().isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: url,
          fit: fit,
          memCacheWidth: memCacheWidth,
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
