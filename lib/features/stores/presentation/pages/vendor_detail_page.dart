import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/network/image_cache_manager.dart';
import 'package:savedge/features/home/presentation/widgets/subscription_plans_section.dart';
import 'package:savedge/features/stores/presentation/widgets/vendor_offers_section.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_event.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_state.dart';

class VendorDetailPage extends StatelessWidget {
  const VendorDetailPage({super.key, this.vendor, this.vendorId})
    : assert(
        vendor != null || vendorId != null,
        'Either vendor or vendorId must be provided',
      );

  final Vendor? vendor;
  final int? vendorId;

  @override
  Widget build(BuildContext context) {
    // Always load vendor details from API to get complete data (images, coupons, etc.)
    final int id = vendorId ?? vendor!.id;

    return BlocProvider(
      create: (context) => getIt<VendorDetailBloc>()..add(LoadVendorDetail(id)),
      child: BlocBuilder<VendorDetailBloc, VendorDetailState>(
        builder: (context, state) {
          if (state is VendorDetailLoading) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1A202C),
                elevation: 0,
                scrolledUnderElevation: 0,
                title: const Text(
                  'Loading...',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              body: const Center(
                child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
              ),
            );
          } else if (state is VendorDetailLoaded) {
            return _VendorDetailView(vendor: state.vendor);
          } else if (state is VendorDetailError) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1A202C),
                elevation: 0,
                scrolledUnderElevation: 0,
                title: const Text(
                  'Error',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE53E3E).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Color(0xFFE53E3E),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Failed to load store',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A202C),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.message,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4A5568),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          context.read<VendorDetailBloc>().add(
                            RefreshVendorDetail(id),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6F3FCC),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Try Again',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          // Initial state - should not reach here due to bloc initialization
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
            ),
          );
        },
      ),
    );
  }
}

class _VendorDetailView extends StatelessWidget {
  const _VendorDetailView({required this.vendor});

  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Image Gallery with App Bar
          _buildSliverAppBar(context),
          // Vendor Info
          SliverToBoxAdapter(child: _buildVendorInfo()),
          // Offers Section
          SliverToBoxAdapter(
            child: VendorOffersSection(
              vendorId: vendor.id,
              vendorUid: vendor.firebaseUid ?? vendor.id.toString(),
              vendorName: vendor.businessName,
            ),
          ),
          // Yearly Subscription
          SliverToBoxAdapter(child: _buildSubscriptionPlansSection()),
          // Other Restaurants
          SliverToBoxAdapter(child: _buildOtherRestaurants()),
          // Bottom spacing
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildSubscriptionPlansSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SubscriptionPlansSection(),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    // Get all gallery images or use primary image as fallback
    final galleryImages = vendor.images
        .where(
          (img) => img.imageType == 'gallery' || img.imageType == 'Gallery',
        )
        .toList();

    final imagesToShow = galleryImages.isNotEmpty
        ? galleryImages
        : vendor.images.take(3).toList(); // Show up to 3 images

    // Debug: Print image information
    if (kDebugMode) {
      print('=== Vendor Images Debug ===');
      print('Total images: ${vendor.images.length}');
      print('Gallery images: ${galleryImages.length}');
      print('Images to show: ${imagesToShow.length}');
      for (int i = 0; i < imagesToShow.length; i++) {
        final img = imagesToShow[i];
        print(
          'Image $i: ${img.imageUrl} (Type: ${img.imageType}, Primary: ${img.isPrimary})',
        );
      }
      print('===========================');
    }

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF1A202C),
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Image Carousel
            imagesToShow.isNotEmpty
                ? PageView.builder(
                    itemCount: imagesToShow.length,
                    itemBuilder: (context, index) {
                      final image = imagesToShow[index];
                      return CachedNetworkImage(
                        imageUrl: image.imageUrl,
                        fit: BoxFit.cover,
                        cacheManager: CustomImageCacheManager(),
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: const Color(0xFF6F3FCC),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Loading image...',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 48,
                                    color: Colors.grey[500],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Failed to load image',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Error: $error',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'URL: ${image.imageUrl}',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(
                        Icons.restaurant,
                        size: 80,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
            // Navigation arrows (only show if multiple images)
            if (imagesToShow.length > 1) ...[
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_left, color: Colors.white),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_right, color: Colors.white),
                  ),
                ),
              ),
            ],
            // Modern overlay at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 80,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black54],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVendorInfo() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Restaurant name and rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  vendor.businessName,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A202C),
                  ),
                ),
              ),
              if (vendor.rating != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF38A169),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        vendor.ratingDisplay,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Address with icon
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF6F3FCC),
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  vendor.fullAddress,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A5568),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Category and price row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF6F3FCC).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  vendor.category,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6F3FCC),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (vendor.averagePrice != null) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD69E2E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFD69E2E).withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    vendor.averagePriceDisplay,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFD69E2E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Open status and timing in modern card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: vendor.isCurrentlyOpen
                  ? const Color(0xFF38A169).withOpacity(0.1)
                  : const Color(0xFFE53E3E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: vendor.isCurrentlyOpen
                    ? const Color(0xFF38A169).withOpacity(0.2)
                    : const Color(0xFFE53E3E).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: vendor.isCurrentlyOpen
                        ? const Color(0xFF38A169)
                        : const Color(0xFFE53E3E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    vendor.isCurrentlyOpen
                        ? Icons.access_time_rounded
                        : Icons.schedule_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vendor.isCurrentlyOpen
                            ? 'Open Now'
                            : 'Currently Closed',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: vendor.isCurrentlyOpen
                              ? const Color(0xFF38A169)
                              : const Color(0xFFE53E3E),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        vendor.isCurrentlyOpen
                            ? '${vendor.openingHours ?? "11:00 AM"} to ${vendor.closingHours ?? "3:00 PM"}'
                            : 'Opens at ${vendor.openingHours ?? "11:00 AM"}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4A5568),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Action buttons row
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Add to Favorites',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF38A169),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.call_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFD69E2E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.directions_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOtherRestaurants() {
    // Mock data for other restaurants
    final otherRestaurants = [
      {
        'name': 'Hotel Tulsi',
        'location': 'Sardar Vegetable Market, Sanjay Nagar, Surat, Gujarat',
        'rating': '4.9',
      },
      {
        'name': 'ZERO The restaurant',
        'location':
            'The restaurant, ZERO, VIP Rd, beside NANDINI 3 RESIDENCY, Vesu, Surat, Gujarat',
        'rating': '4.9',
      },
      {
        'name': 'Raada Resto & Cafe',
        'location': 'A-302, Aagam Marg, viviana, Vesu, Surat, Gujarat',
        'rating': '4.9',
      },
    ];

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.explore_outlined,
                  color: Color(0xFF6F3FCC),
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Explore Other Restaurants',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A202C),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...otherRestaurants.asMap().entries.map(
            (entry) => _buildRestaurantItem(
              entry.value['name']!,
              entry.value['location']!,
              entry.value['rating']!,
              isLast: entry.key == otherRestaurants.length - 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantItem(
    String name,
    String location,
    String rating, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF6F3FCC).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.restaurant_rounded,
                  color: Color(0xFF6F3FCC),
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A5568),
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF38A169),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          rating,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6F3FCC).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF6F3FCC),
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (!isLast) const SizedBox(height: 16),
      ],
    );
  }
}
