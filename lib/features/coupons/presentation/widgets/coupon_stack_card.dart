import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savedge/features/coupons/data/models/coupon_gifting_models.dart';
import 'package:savedge/features/coupons/presentation/widgets/coupon_card.dart';

/// A Tinder-style stacked card widget that groups identical coupons.
/// Swipe left/right to cycle through coupons in the stack.
/// Cards rotate back into the stack with a smooth spring animation.
class CouponStackCard extends StatefulWidget {
  const CouponStackCard({
    super.key,
    required this.coupons,
    required this.onTap,
  });

  final List<UserCouponDetailModel> coupons;
  final void Function(UserCouponDetailModel coupon) onTap;

  @override
  State<CouponStackCard> createState() => _CouponStackCardState();
}

class _CouponStackCardState extends State<CouponStackCard>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  double _dragX = 0;
  double _dragY = 0;
  bool _isDragging = false;

  late AnimationController _returnController;
  late AnimationController _cycleController;

  double _returnStartX = 0;
  double _returnStartY = 0;
  double _swipeOutTargetX = 0;
  bool _isCycling = false;
  int _swipeDirection = 1; // +1 = next, -1 = previous

  static const double _maxRotation = 0.06;
  static const double _swipeThreshold = 80.0;
  // Vertical offset between stacked cards - enough to clearly see edges
  static const double _stackOffset = 14.0;
  // Scale reduction per stack level
  static const double _stackScaleStep = 0.05;

  @override
  void initState() {
    super.initState();

    _returnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _returnController.addListener(_onReturnTick);

    _cycleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _cycleController.addStatusListener(_onCycleStatus);
  }

  void _onReturnTick() {
    final t = Curves.elasticOut.transform(_returnController.value);
    setState(() {
      _dragX = _returnStartX * (1 - t);
      _dragY = _returnStartY * (1 - t);
    });
  }

  void _onCycleStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      final count = widget.coupons.length;
      setState(() {
        _currentIndex = (_currentIndex + _swipeDirection) % count;
        if (_currentIndex < 0) _currentIndex += count;
        _dragX = 0;
        _dragY = 0;
        _isCycling = false;
      });
      _cycleController.reset();
    }
  }

  @override
  void dispose() {
    _returnController.removeListener(_onReturnTick);
    _cycleController.removeStatusListener(_onCycleStatus);
    _returnController.dispose();
    _cycleController.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    if (_isCycling) return;
    _isDragging = true;
    _returnController.stop();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!_isDragging || _isCycling) return;
    setState(() {
      _dragX += details.delta.dx;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (!_isDragging || _isCycling) return;
    _isDragging = false;

    if (_dragX.abs() > _swipeThreshold && widget.coupons.length > 1) {
      HapticFeedback.lightImpact();
      // Swipe right = next (+1), swipe left = previous (-1)
      _swipeDirection = _dragX > 0 ? 1 : -1;
      _swipeOutTargetX = _dragX > 0 ? 500.0 : -500.0;
      _isCycling = true;
      _cycleController.forward();
    } else {
      // Snap back
      _returnStartX = _dragX;
      _returnStartY = _dragY;
      _returnController.reset();
      _returnController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.coupons.length;
    if (count == 0) return const SizedBox.shrink();

    if (count == 1) {
      return CouponCard(
        coupon: widget.coupons[0],
        onTap: () => widget.onTap(widget.coupons[0]),
      );
    }

    final visibleCount = min(3, count);
    final children = <Widget>[];

    // Build from back to front
    for (int i = visibleCount - 1; i >= 0; i--) {
      final couponIndex = (_currentIndex + i) % count;
      final coupon = widget.coupons[couponIndex];

      if (i == 0) {
        children.add(_buildTopCard(coupon));
      } else {
        children.add(_buildBackCard(coupon, i));
      }
    }

    // Card height ~130 + extra room for stacked peek cards
    const double cardHeight = 130;
    final double stackExtra = (visibleCount - 1) * _stackOffset;

    return Column(
      children: [
        SizedBox(
          height: cardHeight + stackExtra + 4,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: children,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: _buildPageIndicator(count),
        ),
      ],
    );
  }

  Widget _buildTopCard(UserCouponDetailModel coupon) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: RepaintBoundary(
        child: GestureDetector(
          onHorizontalDragStart: _onDragStart,
          onHorizontalDragUpdate: _onDragUpdate,
          onHorizontalDragEnd: _onDragEnd,
          child: AnimatedBuilder(
            animation: _cycleController,
            builder: (context, child) {
              double tx = _dragX;
              double ty = _dragY;

              if (_isCycling) {
                final t = Curves.easeInCubic.transform(_cycleController.value);
                tx = _dragX + (_swipeOutTargetX - _dragX) * t;
                ty = _dragY * (1 - t);
              }

              final rotation = (tx / 600) * _maxRotation;

              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.translationValues(tx, ty, 0)
                  ..rotateZ(rotation),
                child: Opacity(
                  opacity: _isCycling
                      ? (1 - _cycleController.value * 0.5).clamp(0.4, 1.0)
                      : 1.0,
                  child: child,
                ),
              );
            },
            child: CouponCard(
              coupon: coupon,
              onTap: () => widget.onTap(coupon),
              enableHero: !_isCycling && !_isDragging,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackCard(UserCouponDetailModel coupon, int stackIndex) {
    final baseOffset = stackIndex * _stackOffset;
    final baseScale = 1.0 - (stackIndex * _stackScaleStep);
    // Horizontal padding grows per level to create a narrowing effect
    final basePadding = stackIndex * 8.0;

    double offset = baseOffset;
    double scale = baseScale;
    double padding = basePadding;

    if (_isCycling) {
      final t = Curves.easeOut.transform(_cycleController.value);
      final targetOffset = (stackIndex - 1) * _stackOffset;
      final targetScale = 1.0 - ((stackIndex - 1) * _stackScaleStep);
      final targetPadding = (stackIndex - 1) * 8.0;
      offset = baseOffset + (targetOffset - baseOffset) * t;
      scale = baseScale + (targetScale - baseScale) * t;
      padding = basePadding + (targetPadding - basePadding) * t;
    }

    return Positioned(
      top: offset,
      left: padding,
      right: padding,
      child: IgnorePointer(
        child: Transform.scale(
          scale: scale,
          alignment: Alignment.topCenter,
          child: Opacity(
            opacity: (1.0 - stackIndex * 0.2).clamp(0.4, 1.0),
            child: CouponCard(
              coupon: coupon,
              onTap: () {},
              enableHero: false,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator(int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF6F3FCC).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.layers_rounded,
                size: 14,
                color: Color(0xFF6F3FCC),
              ),
              const SizedBox(width: 4),
              Text(
                '${_currentIndex + 1} / $count',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6F3FCC),
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.swipe_rounded,
                size: 14,
                color: Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
