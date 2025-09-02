import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/network/image_cache_manager.dart';
import 'package:savedge/features/home/presentation/widgets/subscription_plans_section.dart';
import 'package:savedge/features/stores/presentation/widgets/vendor_offers_section.dart';
import 'package:savedge/features/stores/presentation/widgets/payment_options_bottom_sheet.dart';
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
              body: SafeArea(
                child: Column(
                  children: [
                    // Minimal header
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                borderRadius: BorderRadius.circular(14),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Color(0xFF1A202C),
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            'Loading store...',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Loading content
                    Expanded(
                      child: Center(
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
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF6F3FCC),
                                  strokeWidth: 3,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            const Text(
                              'Loading store details...',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A202C),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Getting the best offers for you',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is VendorDetailLoaded) {
            return _VendorDetailView(vendor: state.vendor);
          } else if (state is VendorDetailError) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: Column(
                  children: [
                    // Header with back button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F9FA),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => Navigator.pop(context),
                                borderRadius: BorderRadius.circular(14),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Color(0xFF1A202C),
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            'Store Error',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Error content
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFEF4444,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                    color: const Color(
                                      0xFFEF4444,
                                    ).withOpacity(0.2),
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.store_mall_directory_outlined,
                                  size: 48,
                                  color: const Color(
                                    0xFFEF4444,
                                  ).withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Store not found',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A202C),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6B7280),
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Container(
                                width: double.infinity,
                                height: 52,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6F3FCC),
                                      Color(0xFF9F7AEA),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF6F3FCC,
                                      ).withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      context.read<VendorDetailBloc>().add(
                                        RefreshVendorDetail(id),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: const Center(
                                      child: Text(
                                        'Try Again',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // Initial state
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF6F3FCC),
                      strokeWidth: 3,
                    ),
                  ),
                ),
              ),
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
      body: Stack(
        children: [
          CustomScrollView(
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
              // Bottom spacing
              const SliverToBoxAdapter(child: SizedBox(height: 140)),
            ],
          ),
          // Floating Payment Options Button
          Positioned(
            bottom: 24,
            left: 20,
            right: 20,
            child: _buildPaymentOptionsButton(context),
          ),
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

  Widget _buildPaymentOptionsButton(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF6F3FCC), Color(0xFF9F7AEA)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6F3FCC).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showPaymentOptions(context),
          borderRadius: BorderRadius.circular(16),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_menu,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Start Ordering',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PaymentOptionsBottomSheet(
        vendor: vendor,
      ),
    );
  }
}
