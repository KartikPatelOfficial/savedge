import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
  final _controller = PageController(viewportFraction: 0.92);
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
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
          height: 210,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            clipBehavior: Clip.none,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _slide(widget.items[i]),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.items.length,
            (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: i == _index ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: i == _index
                    ? GcTokens.primary
                    : GcTokens.primary.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _slide(GiftCardProductEntity p) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GcPaletteExtractor(
        imageUrl: p.imageUrl,
        fallback: GcTokens.accentFor(p.id),
        builder: (context, brand) {
          final tint = Color.lerp(brand, Colors.white, 0.78)!;
          final tintStrong = Color.lerp(brand, Colors.white, 0.55)!;
          final ink = Color.lerp(brand, Colors.black, 0.65)!;
          return GestureDetector(
            onTap: () => widget.onTap(p),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(GcTokens.rHero),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, tint],
                ),
                border: Border.all(color: tintStrong.withValues(alpha: 0.45)),
                boxShadow: [
                  BoxShadow(
                    color: brand.withValues(alpha: 0.20),
                    offset: const Offset(0, 14),
                    blurRadius: 26,
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // Soft brand glow top-right
                  Positioned(
                    right: -60,
                    top: -60,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            brand.withValues(alpha: 0.22),
                            brand.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: brand.withValues(alpha: 0.30),
                                  ),
                                ),
                                child: Text(
                                  'BRAND OF THE WEEK',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w900,
                                    color: ink,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (p.hasDiscount)
                                    Text(
                                      'Flat ${p.discountPercentage!.toStringAsFixed(0)}% off',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        color: ink,
                                        height: 1.0,
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                  const SizedBox(height: 6),
                                  Text(
                                    p.brandName ?? p.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w800,
                                      color: ink.withValues(alpha: 0.65),
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 9,
                                ),
                                decoration: BoxDecoration(
                                  color: ink,
                                  borderRadius:
                                      BorderRadius.circular(GcTokens.rPill),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Explore now',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w900,
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
                        const SizedBox(width: 12),
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: brand.withValues(alpha: 0.18),
                                offset: const Offset(0, 8),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(10),
                          child: p.imageUrl != null && p.imageUrl!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: p.imageUrl!,
                                  fit: BoxFit.contain,
                                  errorWidget: (_, __, ___) =>
                                      Container(color: tint),
                                )
                              : Container(color: tint),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
