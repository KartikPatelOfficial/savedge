import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/stores/presentation/pages/vendor_detail_page.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/presentation/bloc/coupons_bloc.dart';

/// Hot deals section widget with real coupon data
class HotDealsSection extends StatelessWidget {
  const HotDealsSection({
    super.key,
    this.title = 'Hot Deals',
    this.deals = const [],
  });

  final String title;
  final List<HotDeal> deals;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CouponsBloc>()..add(const LoadFeaturedCoupons(pageSize: 5)),
      // Load only 5 featured coupons
      child: HotDealsView(title: title),
    );
  }
}

class HotDealsView extends StatelessWidget {
  const HotDealsView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 240,
            child: BlocBuilder<CouponsBloc, CouponsState>(
              builder: (context, state) {
                if (state is CouponsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
                  );
                } else if (state is CouponsError) {
                  return _buildErrorWidget(state.message);
                } else if (state is CouponsLoaded) {
                  return _buildCouponsList(state.coupons);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponsList(List<Coupon> coupons) {
    if (coupons.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF6F3FCC).withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.local_offer_outlined,
                size: 40,
                color: Color(0xFF6F3FCC),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No deals available',
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

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: coupons.length,
      itemBuilder: (context, index) {
        final coupon = coupons[index];
        return Padding(
          padding: EdgeInsets.only(right: index == coupons.length - 1 ? 0 : 16),
          child: HotDealCard(
            coupon: coupon,
            onTap: () => _navigateToCouponDetail(context, coupon),
          ),
        );
      },
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

/// Model class for hot deal items (now using vendor data)
class HotDeal {
  const HotDeal({
    required this.name,
    required this.rating,
    required this.offer,
    this.imageUrl,
    this.onTap,
  });

  final String name;
  final String rating;
  final String offer;
  final String? imageUrl;
  final VoidCallback? onTap;
}

/// Individual hot deal card widget using coupon data
class HotDealCard extends StatelessWidget {
  const HotDealCard({
    super.key,
    required this.coupon,
    this.width = 280,
    this.onTap,
  });

  final Coupon coupon;
  final double width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background image
              _DealBackground(coupon: coupon),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    stops: const [0.6, 1.0],
                  ),
                ),
              ),
              // Content
              Positioned(
                left: 20,
                right: 20,
                top: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _OfferBadge(coupon: coupon),
                    const Spacer(),
                    _DealInfo(coupon: coupon),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DealBackground extends StatelessWidget {
  const _DealBackground({required this.coupon});

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    // Since Coupon entity doesn't have imageUrl, show gradient background
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple[300]!.withOpacity(0.8),
            Colors.purple[600]!.withOpacity(0.8),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.local_offer,
          size: 60,
          color: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }
}

class _OfferBadge extends StatelessWidget {
  const _OfferBadge({required this.coupon});

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    String discountText;
    if (coupon.discountType.toLowerCase() == 'percentage') {
      discountText = '${coupon.discountValue.toInt()}% OFF';
    } else {
      discountText = '₹${coupon.discountValue.toInt()} OFF';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF6F3FCC),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_offer, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(
            discountText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DealInfo extends StatelessWidget {
  const _DealInfo({required this.coupon});

  final Coupon coupon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          coupon.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        if (coupon.description.isNotEmpty)
          Text(
            coupon.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.shopping_cart, color: Colors.white, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    coupon.minimumAmountDisplay.isEmpty 
                        ? 'No minimum' 
                        : coupon.minimumAmountDisplay,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
