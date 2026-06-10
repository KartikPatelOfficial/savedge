import 'dart:async';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/features/stores/presentation/pages/vendor_detail_page.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/presentation/bloc/coupons_bloc.dart';

class HotDealsSection extends StatelessWidget {
  const HotDealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const HotDealsView();
  }
}

class HotDealsView extends StatelessWidget {
  const HotDealsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponsBloc, CouponsState>(
      builder: (context, state) {
        if (state is CouponsLoading) {
          return _wrap(const _HotDealsShimmer());
        } else if (state is CouponsError) {
          return _wrap(_buildErrorWidget(state.message));
        } else if (state is CouponsLoaded) {
          // Collapse the section entirely when there are no deals.
          if (state.coupons.isEmpty) {
            return const SizedBox.shrink();
          }
          return _wrap(_buildCouponsList(context, state.coupons));
        }
        return const SizedBox.shrink();
      },
    );
  }

  /// Wraps content with the section's vertical spacing and fixed height.
  /// Kept here (rather than in the parent) so the whole section, spacing
  /// included, collapses when there are no deals to show.
  Widget _wrap(Widget child) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(height: 280, child: child),
    );
  }

  Widget _buildCouponsList(BuildContext context, List<Coupon> coupons) {
    return StackedDealsCards(
      coupons: coupons,
      onCouponTap: (coupon) => _navigateToCouponDetail(context, coupon),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFE53E3E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Icon(
              Icons.error_outline,
              size: 40,
              color: Color(0xFFE53E3E),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Failed to load deals',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF4A5568),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCouponDetail(BuildContext context, Coupon coupon) {
    // Navigate to vendor detail page to see the coupon
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendorDetailPage(vendorId: coupon.vendorId),
      ),
    );
  }
}

/// Stacked deals cards widget with beautiful animations
class StackedDealsCards extends StatefulWidget {
  const StackedDealsCards({super.key, required this.coupons, this.onCouponTap});

  final List<Coupon> coupons;
  final Function(Coupon)? onCouponTap;

  @override
  State<StackedDealsCards> createState() => _StackedDealsCardsState();
}

class _StackedDealsCardsState extends State<StackedDealsCards>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<Offset>> _slideAnimations;

  // Auto-scroll fields
  Timer? _autoScrollTimer;
  bool _isUserInteracting = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);

    // Initialize animation controllers
    _animationControllers = List.generate(
      widget.coupons.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 300 + (index * 100)),
        vsync: this,
      ),
    );

    // Initialize scale animations
    _scaleAnimations = _animationControllers
        .map(
          (controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: controller, curve: Curves.elasticOut),
          ),
        )
        .toList();

    // Initialize slide animations
    _slideAnimations = _animationControllers
        .map(
          (controller) =>
              Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
              ),
        )
        .toList();

    // Start animations
    _startAnimations();

    // Start auto-scroll after a delay to let animations complete
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _startAutoScroll();
      }
    });
  }

  @override
  void didUpdateWidget(covariant StackedDealsCards oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reinitialize animations if coupons length changes (e.g., after load)
    if (oldWidget.coupons.length != widget.coupons.length) {
      for (final controller in _animationControllers) {
        controller.dispose();
      }

      _animationControllers = List.generate(
        widget.coupons.length,
        (index) => AnimationController(
          duration: Duration(milliseconds: 300 + (index * 100)),
          vsync: this,
        ),
      );

      _scaleAnimations = _animationControllers
          .map(
            (controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: controller, curve: Curves.elasticOut),
            ),
          )
          .toList();

      _slideAnimations = _animationControllers
          .map(
            (controller) =>
                Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: controller,
                    curve: Curves.easeOutBack,
                  ),
                ),
          )
          .toList();

      if (_currentIndex >= widget.coupons.length) {
        _currentIndex = widget.coupons.isEmpty ? 0 : widget.coupons.length - 1;
      }
      _startAnimations();
    }
  }

  void _startAnimations() {
    for (int i = 0; i < _animationControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          _animationControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Auto-scroll methods
  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => _scrollToNextPage(),
    );
  }

  void _scrollToNextPage() {
    if (_isUserInteracting || !mounted || widget.coupons.isEmpty) return;
    final nextPage = (_currentIndex + 1) % widget.coupons.length;
    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _pauseAutoScroll() {
    _isUserInteracting = true;
    _autoScrollTimer?.cancel();
  }

  void _resumeAutoScroll() {
    _isUserInteracting = false;
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && !_isUserInteracting) {
        _startAutoScroll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.coupons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // Main stacked cards
        SizedBox(
          height: 240,
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
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.coupons.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _animationControllers[index],
                  builder: (context, child) {
                    return SlideTransition(
                      position: _slideAnimations[index],
                      child: ScaleTransition(
                        scale: _scaleAnimations[index],
                        child: _buildStackCard(widget.coupons[index], index),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Page indicators
        _buildPageIndicators(),
      ],
    );
  }

  Widget _buildStackCard(Coupon coupon, int index) {
    final isCenter = index == _currentIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      margin: EdgeInsets.symmetric(
        vertical: isCenter ? 0 : 10,
        horizontal: 6,
      ),
      child: Transform.scale(
        scale: isCenter ? 1.0 : 0.88,
        child: GestureDetector(
          onTap: () => widget.onCouponTap?.call(coupon),
          child: coupon.isSpecialOffer && coupon.specialOfferImageUrl != null
              ? _buildSpecialOfferImage(coupon)
              : _buildCouponTicket(coupon, index),
        ),
      ),
    );
  }

  Widget _buildSpecialOfferImage(Coupon coupon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: CachedNetworkImage(
        imageUrl: coupon.specialOfferImageUrl!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholder: (context, url) => coupon.specialOfferBlurHash != null
            ? BlurHash(hash: coupon.specialOfferBlurHash!)
            : Container(color: Colors.grey[300]),
        errorWidget: (context, url, error) =>
            _buildCouponTicket(coupon, _currentIndex),
      ),
    );
  }

  Widget _buildCouponTicket(Coupon coupon, int index) {
    final palette = _dealPalettes[index % _dealPalettes.length];
    final daysLeft = coupon.validTo.difference(DateTime.now()).inDays;
    String? expText;
    if (daysLeft >= 0 && daysLeft <= 30) {
      if (daysLeft == 0) {
        expText = 'Ends today';
      } else if (daysLeft == 1) {
        expText = '1 day left';
      } else {
        expText = '$daysLeft days left';
      }
    }
    final minText = coupon.minimumAmountDisplay.isEmpty
        ? 'No minimum order'
        : coupon.minimumAmountDisplay;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: palette.gradient,
          stops: const [0.0, 0.55, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: palette.gradient[1].withOpacity(0.45),
            blurRadius: 22,
            offset: const Offset(0, 10),
            spreadRadius: -4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Soft top-right glow
            Positioned(
              top: -60,
              right: -50,
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.white.withOpacity(0.20),
                      Colors.white.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
            // Big Savedge logo watermark — half cut at the bottom-left,
            // masked to a soft white tint so it reads as a watermark.
            Positioned(
              left: -70,
              bottom: -55,
              child: IgnorePointer(
                child: Transform.rotate(
                  angle: -0.10,
                  child: Image.asset(
                    'assets/images/logo_transparant.png',
                    width: 220,
                    height: 220,
                    fit: BoxFit.contain,
                    color: Colors.white.withOpacity(0.10),
                    colorBlendMode: BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            // Sparkle / dot pattern
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _SparklesPainter()),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: category badge (left) + title & subtitle (right)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategoryBadge(palette),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              coupon.title,
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                                height: 1.15,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                            if (coupon.description.isNotEmpty) ...[
                              const SizedBox(height: 3),
                              Text(
                                coupon.description,
                                textAlign: TextAlign.right,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.85),
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Center: hero discount seal
                  Expanded(
                    child: Center(
                      child: _buildDiscountSeal(coupon, palette),
                    ),
                  ),
                  // Bottom row: minimum (left) + countdown + CTA (right)
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white.withOpacity(0.9),
                        size: 13,
                      ),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          minText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.95),
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (expText != null) ...[
                        _buildCountdownLabel(expText),
                        const SizedBox(width: 8),
                      ],
                      _buildGrabCta(palette),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(_DealPalette palette) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: palette.accent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: palette.accent.withOpacity(0.45),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(palette.icon, color: palette.accentInk, size: 12),
          const SizedBox(width: 4),
          Text(
            palette.label,
            style: TextStyle(
              color: palette.accentInk,
              fontSize: 9.5,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownLabel(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.access_time_rounded,
          color: Colors.white.withOpacity(0.85),
          size: 12,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.white.withOpacity(0.95),
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildGrabCta(_DealPalette palette) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 7, 8, 7),
      decoration: BoxDecoration(
        color: palette.accent,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: palette.accent.withOpacity(0.55),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Grab',
            style: TextStyle(
              color: palette.accentInk,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: palette.accentInk,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_forward_rounded,
              color: palette.accent,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }

  /// Hero centerpiece — a stamped circular seal with the discount value.
  /// Outer dashed ring + inner accent-colored disc, slightly tilted for
  /// hand-stamped character.
  Widget _buildDiscountSeal(Coupon coupon, _DealPalette palette) {
    final type = coupon.discountType.toLowerCase();
    final ink = palette.accentInk;

    Widget innerContent;
    if (type == 'freeitem') {
      innerContent = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.card_giftcard_rounded, color: ink, size: 26),
          const SizedBox(height: 1),
          Text(
            'FREE',
            style: TextStyle(
              color: ink,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              height: 1,
            ),
          ),
          Text(
            'GIFT',
            style: TextStyle(
              color: ink.withOpacity(0.7),
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.5,
              height: 1.4,
            ),
          ),
        ],
      );
    } else {
      final isPercent = type == 'percentage';
      final value = coupon.discountValue.toInt().toString();

      innerContent = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'FLAT',
            style: TextStyle(
              color: ink.withOpacity(0.7),
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isPercent)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, right: 1),
                    child: Text(
                      '₹',
                      style: TextStyle(
                        color: ink,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        height: 1,
                      ),
                    ),
                  ),
                Text(
                  value,
                  style: TextStyle(
                    color: ink,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    height: 0.92,
                    letterSpacing: -1.5,
                  ),
                ),
                if (isPercent)
                  Padding(
                    padding: const EdgeInsets.only(top: 6, left: 1),
                    child: Text(
                      '%',
                      style: TextStyle(
                        color: ink,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 1),
          Text(
            'OFF',
            style: TextStyle(
              color: ink.withOpacity(0.7),
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
              height: 1,
            ),
          ),
        ],
      );
    }

    return Transform.rotate(
      angle: -0.10,
      child: SizedBox(
        width: 116,
        height: 116,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer dashed ring — stamp-style perforation
            CustomPaint(
              size: const Size(116, 116),
              painter: _DashedCirclePainter(
                color: Colors.white.withOpacity(0.7),
                strokeWidth: 1.6,
                dashLengthDeg: 6,
                gapLengthDeg: 4,
              ),
            ),
            // Inner solid accent disc
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color.lerp(palette.accent, Colors.white, 0.08)!,
                    palette.accent,
                  ],
                  stops: const [0, 1],
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.45),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: palette.accent.withOpacity(0.6),
                    blurRadius: 26,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Center(child: innerContent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.coupons.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == _currentIndex ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: index == _currentIndex
                ? const Color(0xFF6F3FCC)
                : const Color(0xFF6F3FCC).withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

// ─── Shimmer placeholder for hot deals loading ──────────────────────────

class _HotDealsShimmer extends StatefulWidget {
  const _HotDealsShimmer();

  @override
  State<_HotDealsShimmer> createState() => _HotDealsShimmerState();
}

class _HotDealsShimmerState extends State<_HotDealsShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // Main card shimmer
              Container(
                height: 220,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment(-1.0 + 2.0 * _ctrl.value, 0),
                    end: Alignment(-1.0 + 2.0 * _ctrl.value + 1, 0),
                    colors: const [
                      Color(0xFFF0ECF8),
                      Color(0xFFE8E0F5),
                      Color(0xFFF0ECF8),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              // Dots shimmer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) => Container(
                  width: i == 0 ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E0F5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                )),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Coupon ticket design helpers ───────────────────────────────────────

class _DealPalette {
  const _DealPalette({
    required this.gradient,
    required this.accent,
    required this.accentInk,
    required this.icon,
    required this.label,
  });

  final List<Color> gradient;
  final Color accent;
  final Color accentInk;
  final IconData icon;
  final String label;
}

const List<_DealPalette> _dealPalettes = [
  _DealPalette(
    gradient: [Color(0xFF4C1D95), Color(0xFF7C3AED), Color(0xFFEC4899)],
    accent: Color(0xFFFCD34D),
    accentInk: Color(0xFF3B0764),
    icon: Icons.local_fire_department_rounded,
    label: 'HOT DEAL',
  ),
  _DealPalette(
    gradient: [Color(0xFF064E3B), Color(0xFF10B981), Color(0xFFA3E635)],
    accent: Color(0xFFFEF9C3),
    accentInk: Color(0xFF064E3B),
    icon: Icons.bolt_rounded,
    label: 'FRESH PICK',
  ),
  _DealPalette(
    gradient: [Color(0xFF7C2D12), Color(0xFFEA580C), Color(0xFFFACC15)],
    accent: Color(0xFFFFFBEB),
    accentInk: Color(0xFF7C2D12),
    icon: Icons.flash_on_rounded,
    label: 'FLASH SALE',
  ),
  _DealPalette(
    gradient: [Color(0xFF0C4A6E), Color(0xFF0EA5E9), Color(0xFF22D3EE)],
    accent: Color(0xFFFEF08A),
    accentInk: Color(0xFF0C4A6E),
    icon: Icons.diamond_rounded,
    label: 'PREMIUM',
  ),
  _DealPalette(
    gradient: [Color(0xFF881337), Color(0xFFE11D48), Color(0xFFFB923C)],
    accent: Color(0xFFFFF7ED),
    accentInk: Color(0xFF881337),
    icon: Icons.favorite_rounded,
    label: 'TOP PICK',
  ),
];

/// Subtle decorative dots and "+" sparkles to break up the gradient.
/// Dashed circle around the centerpiece seal — gives it a postage-stamp
/// "perforated" feel without notching the card itself.
class _DashedCirclePainter extends CustomPainter {
  _DashedCirclePainter({
    required this.color,
    this.strokeWidth = 1.5,
    this.dashLengthDeg = 6,
    this.gapLengthDeg = 4,
  });

  final Color color;
  final double strokeWidth;
  final double dashLengthDeg;
  final double gapLengthDeg;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final stepDeg = dashLengthDeg + gapLengthDeg;
    final segments = (360 / stepDeg).floor();
    final actualStepDeg = 360.0 / segments;
    final dashRad = dashLengthDeg * math.pi / 180;
    final stepRad = actualStepDeg * math.pi / 180;

    for (var i = 0; i < segments; i++) {
      canvas.drawArc(rect, i * stepRad, dashRad, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCirclePainter old) =>
      old.color != color ||
      old.strokeWidth != strokeWidth ||
      old.dashLengthDeg != dashLengthDeg ||
      old.gapLengthDeg != gapLengthDeg;
}

class _SparklesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dot = Paint()..color = Colors.white.withOpacity(0.16);
    final ring = Paint()
      ..color = Colors.white.withOpacity(0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final sparkle = Paint()
      ..color = Colors.white.withOpacity(0.22)
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    final dots = <(Offset, double)>[
      (Offset(size.width * 0.18, size.height * 0.22), 2.5),
      (Offset(size.width * 0.72, size.height * 0.14), 1.8),
      (Offset(size.width * 0.88, size.height * 0.58), 3.0),
      (Offset(size.width * 0.52, size.height * 0.82), 2.2),
      (Offset(size.width * 0.28, size.height * 0.7), 2.6),
      (Offset(size.width * 0.94, size.height * 0.86), 1.6),
    ];
    for (final d in dots) {
      canvas.drawCircle(d.$1, d.$2, dot);
    }

    canvas.drawCircle(
      Offset(size.width * 0.62, size.height * 0.32),
      6,
      ring,
    );
    canvas.drawCircle(
      Offset(size.width * 0.08, size.height * 0.55),
      4,
      ring,
    );

    void drawSparkle(Offset center, double s) {
      canvas.drawLine(
        Offset(center.dx - s, center.dy),
        Offset(center.dx + s, center.dy),
        sparkle,
      );
      canvas.drawLine(
        Offset(center.dx, center.dy - s),
        Offset(center.dx, center.dy + s),
        sparkle,
      );
    }

    drawSparkle(Offset(size.width * 0.42, size.height * 0.18), 4);
    drawSparkle(Offset(size.width * 0.86, size.height * 0.4), 5);
    drawSparkle(Offset(size.width * 0.6, size.height * 0.62), 3);
  }

  @override
  bool shouldRepaint(covariant _SparklesPainter oldDelegate) => false;
}
