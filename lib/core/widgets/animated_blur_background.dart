import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

/// A global animated blurred background that creates a beautiful aurora/glassmorphic effect
class AnimatedBlurBackground extends StatefulWidget {
  const AnimatedBlurBackground({super.key});

  @override
  State<AnimatedBlurBackground> createState() => _AnimatedBlurBackgroundState();
}

class _AnimatedBlurBackgroundState extends State<AnimatedBlurBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 20-second loop for a very slow, ambient drift
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        
        final val = _controller.value * 2 * pi;

        return Stack(
          children: [
            // Clean neutral base
            Container(color: const Color(0xFFF6F8FB)),
            
            // Orb 1: Primary Purple
            Positioned(
              left: width * 0.1 + sin(val) * width * 0.2,
              top: height * 0.1 + cos(val) * height * 0.1,
              child: Container(
                width: width * 0.8,
                height: width * 0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6F3FCC).withOpacity(0.3),
                ),
              ),
            ),
            
            // Orb 2: Teal / Emerald accent
            Positioned(
              right: -width * 0.2 + cos(val * 0.8) * width * 0.2,
              bottom: height * 0.2 + sin(val * 0.8) * height * 0.1,
              child: Container(
                width: width * 0.7,
                height: width * 0.8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF10B981).withOpacity(0.2),
                ),
              ),
            ),
            
            // Orb 3: Blue accent
            Positioned(
              left: -width * 0.1 + sin(val * 1.2) * width * 0.3,
              bottom: -height * 0.1 + cos(val * 1.2) * height * 0.2,
              child: Container(
                width: width * 0.9,
                height: width * 0.9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF3B82F6).withOpacity(0.2),
                ),
              ),
            ),
            
            // The heavy blur layer that melts the orbs together
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                child: Container(
                  color: Colors.white.withOpacity(0.6), // Whitewash overlay for standard brightness
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
