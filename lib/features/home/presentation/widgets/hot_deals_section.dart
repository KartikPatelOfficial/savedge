import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_event.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_state.dart';
import 'package:savedge/features/stores/presentation/pages/vendor_detail_page.dart';

/// Hot deals section widget with real vendor data
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
          getIt<VendorsBloc>()
            ..add(const LoadVendors(pageSize: 5)), // Load only 5 for hot deals
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
            child: BlocBuilder<VendorsBloc, VendorsState>(
              builder: (context, state) {
                if (state is VendorsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
                  );
                } else if (state is VendorsError) {
                  return _buildErrorWidget(state.message);
                } else if (state is VendorsLoaded) {
                  return _buildVendorsList(state.vendors);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVendorsList(List<Vendor> vendors) {
    if (vendors.isEmpty) {
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
      itemCount: vendors.length,
      itemBuilder: (context, index) {
        final vendor = vendors[index];
        return Padding(
          padding: EdgeInsets.only(right: index == vendors.length - 1 ? 0 : 16),
          child: HotDealCard(
            vendor: vendor,
            onTap: () => _navigateToVendorDetail(context, vendor),
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

  void _navigateToVendorDetail(BuildContext context, Vendor vendor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendorDetailPage(vendorId: vendor.id),
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

/// Individual hot deal card widget using vendor data
class HotDealCard extends StatelessWidget {
  const HotDealCard({
    super.key,
    required this.vendor,
    this.width = 280,
    this.onTap,
  });

  final Vendor vendor;
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
              _DealBackground(vendor: vendor),
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
                    _OfferBadge(vendor: vendor),
                    const Spacer(),
                    _DealInfo(vendor: vendor),
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
  const _DealBackground({required this.vendor});

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: vendor.primaryImageUrl != null
            ? DecorationImage(
                image: NetworkImage(vendor.primaryImageUrl!),
                fit: BoxFit.cover,
                onError: (error, stackTrace) {},
              )
            : null,
        gradient: vendor.primaryImageUrl == null
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.brown[300]!.withOpacity(0.8),
                  Colors.brown[600]!.withOpacity(0.8),
                ],
              )
            : null,
      ),
      child: vendor.primaryImageUrl == null
          ? Center(
              child: Icon(
                Icons.restaurant,
                size: 60,
                color: Colors.white.withOpacity(0.3),
              ),
            )
          : null,
    );
  }
}

class _OfferBadge extends StatelessWidget {
  const _OfferBadge({required this.vendor});

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    // Generate dynamic offer based on vendor ID
    final offerPercentage = 20 + (vendor.id % 4) * 10; // 20%, 30%, 40%, or 50%

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
            'Up to $offerPercentage% OFF',
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
  const _DealInfo({required this.vendor});

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          vendor.businessName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
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
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    vendor.ratingDisplay,
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
