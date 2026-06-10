import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/gc_tokens.dart';

/// Shimmer building blocks used by the gift card surface.
class GcSkeleton extends StatelessWidget {
  const GcSkeleton({
    super.key,
    required this.width,
    required this.height,
    this.radius = 12,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFEDEAF5),
      highlightColor: const Color(0xFFF8F6FD),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class GcHeroSkeleton extends StatelessWidget {
  const GcHeroSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GcSkeleton(
        width: double.infinity,
        height: 160,
        radius: GcTokens.rHero,
      ),
    );
  }
}

class GcCategoryGridSkeleton extends StatelessWidget {
  const GcCategoryGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (_, __) => const GcSkeleton(
        width: double.infinity,
        height: double.infinity,
        radius: 18,
      ),
    );
  }
}

class GcProductGridSkeleton extends StatelessWidget {
  const GcProductGridSkeleton({super.key, this.count = 6});
  final int count;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.92,
      ),
      itemBuilder: (_, __) => const GcSkeleton(
        width: double.infinity,
        height: double.infinity,
        radius: GcTokens.rCard,
      ),
    );
  }
}

class GcListSkeleton extends StatelessWidget {
  const GcListSkeleton({super.key, this.count = 4});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        count,
        (_) => const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: GcSkeleton(
            width: double.infinity,
            height: 96,
            radius: GcTokens.rCard,
          ),
        ),
      ),
    );
  }
}
