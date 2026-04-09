import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

/// A global animated blurred background — soft coloured aurora glows on white.
///
/// On start and on each page change it smoothly drifts the orbs to a new
/// position over ~3 seconds, then holds still until the next trigger.
/// Orb positions are preserved between animations so transitions are seamless.
class AnimatedBlurBackground extends StatefulWidget {
  const AnimatedBlurBackground({super.key});

  static final ValueNotifier<int> _trigger = ValueNotifier<int>(0);

  /// Call to kick off a brief drift animation (e.g. on tab change).
  static void triggerAnimation() => _trigger.value++;

  @override
  State<AnimatedBlurBackground> createState() => _AnimatedBlurBackgroundState();
}

class _AnimatedBlurBackgroundState extends State<AnimatedBlurBackground>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _controller;

  double _startPhase = 0;
  double _endPhase = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addStatusListener(_onStatus);

    _controller.forward();

    AnimatedBlurBackground._trigger.addListener(_onTrigger);
  }

  void _onStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _startPhase = _endPhase;
    }
  }

  void _onTrigger() {
    if (!mounted) return;
    _startPhase = _lerpPhase(_controller.value);
    _endPhase = _startPhase + 0.35 + Random().nextDouble() * 0.25;
    _controller.reset();
    _controller.forward();
  }

  double _lerpPhase(double t) {
    final curved = Curves.easeInOut.transform(t);
    return _startPhase + (_endPhase - _startPhase) * curved;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AnimatedBlurBackground._trigger.removeListener(_onTrigger);
    _controller.removeStatusListener(_onStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final phase = _lerpPhase(_controller.value) * 2 * pi;

          return ColoredBox(
            color: Colors.white,
            child: Stack(
              children: [
                // Orb 1 — Deep purple (top-left, dominant)
                Positioned(
                  left: w * 0.1 + sin(phase) * w * 0.2,
                  top: h * 0.08 + cos(phase) * h * 0.1,
                  child: _GlowOrb(
                    size: w * 0.85,
                    color: const Color(0xFF5B21B6),
                    opacity: 0.40,
                  ),
                ),

                // Orb 2 — Emerald green (right-center)
                Positioned(
                  right: -w * 0.15 + cos(phase * 0.8) * w * 0.2,
                  bottom: h * 0.18 + sin(phase * 0.8) * h * 0.1,
                  child: _GlowOrb(
                    size: w * 0.75,
                    color: const Color(0xFF10B981),
                    opacity: 0.30,
                  ),
                ),

                // Orb 3 — Lime green (bottom-left)
                Positioned(
                  left: -w * 0.08 + sin(phase * 1.2) * w * 0.25,
                  bottom: -h * 0.08 + cos(phase * 1.2) * h * 0.18,
                  child: _GlowOrb(
                    size: w * 0.8,
                    color: const Color(0xFF8FE13D),
                    opacity: 0.22,
                  ),
                ),

                // Orb 4 — Blue (top-right)
                Positioned(
                  right: w * 0.02 + cos(phase * 0.6) * w * 0.15,
                  top: h * 0.01 + sin(phase * 0.6) * h * 0.08,
                  child: _GlowOrb(
                    size: w * 0.6,
                    color: const Color(0xFF3B82F6),
                    opacity: 0.25,
                  ),
                ),

                // Orb 5 — Red accent (center-bottom, subtle warmth)
                Positioned(
                  left: w * 0.25 + sin(phase * 0.9) * w * 0.1,
                  bottom: h * 0.05 + cos(phase * 0.9) * h * 0.06,
                  child: _GlowOrb(
                    size: w * 0.5,
                    color: const Color(0xFFEF4444),
                    opacity: 0.18,
                  ),
                ),

                // Blur to blend orbs into smooth aurora
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                    child: const SizedBox.expand(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// A radial-gradient orb that fades from colour at the centre to transparent
/// at the edges, producing a soft glow on white.
class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.size,
    required this.color,
    required this.opacity,
  });

  final double size;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: opacity),
              color.withValues(alpha: opacity * 0.4),
              color.withValues(alpha: 0),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }
}
