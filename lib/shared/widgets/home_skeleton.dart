import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Skeleton loading screen that mimics the home page layout.
/// Shown while the user profile or city data is loading.
class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Shimmer.fromColors(
            baseColor: const Color(0xFFEDEAF5),
            highlightColor: const Color(0xFFF8F6FD),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App bar skeleton
                _buildAppBarSkeleton(),
                const SizedBox(height: 20),
                // Hot deals card skeleton
                _buildHotDealsSkeleton(),
                const SizedBox(height: 24),
                // Categories section skeleton
                _buildCategoriesSkeleton(),
                const SizedBox(height: 24),
                // Subscription carousel skeleton
                _buildBannerSkeleton(),
                const SizedBox(height: 24),
                // Top offers section skeleton
                _buildTopOffersSkeleton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarSkeleton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
      child: Row(
        children: [
          // Menu button
          _box(44, 44, radius: 16),
          const SizedBox(width: 16),
          // City selector
          Expanded(child: _box(44, double.infinity, radius: 12)),
          const SizedBox(width: 16),
          // Notification button
          _box(44, 44, radius: 12),
          const SizedBox(width: 12),
          // Favorite button
          _box(44, 44, radius: 12),
        ],
      ),
    );
  }

  Widget _buildHotDealsSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _box(200, double.infinity, radius: 20),
          const SizedBox(height: 14),
          // Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _box(8, 24, radius: 4),
              const SizedBox(width: 6),
              _box(8, 8, radius: 4),
              const SizedBox(width: 6),
              _box(8, 8, radius: 4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _box(18, 140, radius: 6),
              _box(14, 50, radius: 6),
            ],
          ),
          const SizedBox(height: 16),
          // Category chips row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              children: List.generate(
                5,
                (_) => Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: _box(70, 70, radius: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: _box(120, double.infinity, radius: 16),
    );
  }

  Widget _buildTopOffersSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _box(18, 100, radius: 6),
              _box(14, 50, radius: 6),
            ],
          ),
          const SizedBox(height: 16),
          // Vendor cards
          ...List.generate(
            3,
            (_) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  _box(80, 80, radius: 14),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _box(14, double.infinity, radius: 4),
                        const SizedBox(height: 8),
                        _box(12, 120, radius: 4),
                        const SizedBox(height: 8),
                        _box(10, 80, radius: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _box(double height, double width, {double radius = 8}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
