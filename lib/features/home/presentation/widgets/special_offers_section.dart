import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/presentation/bloc/coupons_bloc.dart';

/// Model class for special offers (legacy support)
class SpecialOffer {
  const SpecialOffer({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.color,
    required this.icon,
    this.imageUrl,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String buttonText;
  final Color color;
  final IconData icon;
  final String? imageUrl;
  final VoidCallback? onTap;
}

/// Special offers section widget with real coupons data
class SpecialOffersSection extends StatelessWidget {
  const SpecialOffersSection({super.key, this.offers = const []});

  final List<SpecialOffer> offers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CouponsBloc>()..add(const LoadFeaturedCoupons()),
      child: const SpecialOffersView(),
    );
  }
}

class SpecialOffersView extends StatelessWidget {
  const SpecialOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      height: 200,
      child: BlocBuilder<CouponsBloc, CouponsState>(
        builder: (context, state) {
          if (state is CouponsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CouponsError) {
            return _buildErrorWidget(state.message);
          } else if (state is CouponsLoaded) {
            return _buildCouponsPageView(state.coupons);
          }
          return _buildEmptyState();
        },
      ),
    );
  }

  Widget _buildCouponsPageView(List<Coupon> coupons) {
    if (coupons.isEmpty) {
      return _buildEmptyState();
    }

    return PageView.builder(
      padEnds: false,
      itemCount: coupons.length,
      itemBuilder: (context, index) {
        final coupon = coupons[index];
        return Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 16 : 8,
            right: index == coupons.length - 1 ? 16 : 8,
          ),
          child: CouponOfferCard(coupon: coupon),
        );
      },
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text(
            'Failed to load offers',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_offer_outlined, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text(
            'No special offers available',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

/// Coupon offer card widget using real coupon data
class CouponOfferCard extends StatelessWidget {
  const CouponOfferCard({super.key, required this.coupon});

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    // Generate colors based on coupon type and vendor
    final colors = _getCouponColors();

    return GestureDetector(
      onTap: () => _onCouponTap(context),
      child: Container(
        decoration: BoxDecoration(
          color: colors.backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Background pattern/decoration
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: 40,
              bottom: -30,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: _CouponContent(coupon: coupon, colors: colors),
                  ),
                  Expanded(flex: 2, child: _CouponImage(coupon: coupon)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  CouponColors _getCouponColors() {
    // Determine colors based on discount type
    switch (coupon.discountType.toLowerCase()) {
      case 'percentage':
        return const CouponColors(
          backgroundColor: Color(0xFF6F3FCC),
          accentColor: Color(0xFF9C4DFF),
        );
      case 'fixedamount':
        return const CouponColors(
          backgroundColor: Color(0xFF4CAF50),
          accentColor: Color(0xFF66BB6A),
        );
      default:
        return const CouponColors(
          backgroundColor: Color(0xFFFF6B7A),
          accentColor: Color(0xFFFF8A95),
        );
    }
  }

  void _onCouponTap(BuildContext context) {
    // TODO: Navigate to coupon details or vendor page
    debugPrint('Coupon tapped: ${coupon.title}');
  }
}

class CouponColors {
  const CouponColors({
    required this.backgroundColor,
    required this.accentColor,
  });

  final Color backgroundColor;
  final Color accentColor;
}

class _CouponContent extends StatelessWidget {
  const _CouponContent({required this.coupon, required this.colors});

  final Coupon coupon;
  final CouponColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          coupon.discountDisplay,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          coupon.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Get Coupon',
            style: TextStyle(
              color: colors.backgroundColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _CouponImage extends StatelessWidget {
  const _CouponImage({required this.coupon});

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: _PlaceholderImage(),
    );
  }
}

/// Individual special offer card widget
class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({super.key, required this.offer});

  final SpecialOffer offer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: offer.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: offer.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // Background pattern/decoration
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: 40,
              bottom: -30,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(flex: 3, child: _OfferContent(offer: offer)),
                  Expanded(flex: 2, child: _OfferImage(offer: offer)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OfferContent extends StatelessWidget {
  const _OfferContent({required this.offer});

  final SpecialOffer offer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          offer.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          offer.subtitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            offer.buttonText,
            style: TextStyle(
              color: offer.color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _OfferImage extends StatelessWidget {
  const _OfferImage({required this.offer});

  final SpecialOffer offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: offer.imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                offer.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _PlaceholderImage(),
              ),
            )
          : _PlaceholderImage(),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(Icons.fastfood, size: 40, color: Colors.white),
      ),
    );
  }
}