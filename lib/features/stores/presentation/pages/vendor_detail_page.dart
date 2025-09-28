import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/network/image_cache_manager.dart';
import 'package:savedge/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:savedge/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:savedge/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:savedge/features/home/presentation/widgets/subscription_plans_section.dart';
import 'package:savedge/features/points_payment/presentation/widgets/points_payment_dialog.dart';
import 'package:savedge/features/qr_scanner/presentation/pages/qr_scanner_page.dart';
import 'package:savedge/features/stores/presentation/widgets/vendor_offers_section.dart';
import 'package:savedge/features/user_profile/presentation/bloc/points_bloc.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_event.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_state.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<VendorDetailBloc>()..add(LoadVendorDetail(id)),
        ),
        BlocProvider(
          create: (context) => getIt<PointsBloc>()..add(LoadUserPoints()),
        ),
        BlocProvider(
          create: (context) => getIt<FavoritesBloc>()..add(LoadFavorites()),
        ),
      ],
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

  /// Resolve vendor UID for QR and coupon flows.
  String get _resolvedVendorUid {
    final uid = vendor.vendorUserId.trim();
    if (uid.isNotEmpty) return uid;
    for (final c in vendor.coupons) {
      final u = c.vendorUserId.trim();
      if (u.isNotEmpty) return u;
    }
    return vendor.id.toString();
  }

  /// Get full address string
  String get _fullAddress {
    final addressParts = <String>[];
    if (vendor.address?.isNotEmpty == true) addressParts.add(vendor.address!);
    if (vendor.city?.isNotEmpty == true) addressParts.add(vendor.city!);
    if (vendor.state?.isNotEmpty == true) addressParts.add(vendor.state!);
    if (vendor.pinCode?.isNotEmpty == true) addressParts.add(vendor.pinCode!);
    return addressParts.isNotEmpty
        ? addressParts.join(', ')
        : 'Address not available';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      body: CustomScrollView(
        slivers: [
          // Image Gallery with App Bar
          _buildSliverAppBar(context),
          // Vendor Info
          SliverToBoxAdapter(child: _buildVendorInfo(context)),
          // Offers Section
          SliverToBoxAdapter(
            child: VendorOffersSection(
              vendorId: vendor.id,
              vendorUid: _resolvedVendorUid,
              vendorName: vendor.businessName,
              coupons: vendor.coupons,
            ),
          ),
          // Yearly Subscription
          SliverToBoxAdapter(child: _buildSubscriptionPlansSection()),
          // Bottom spacing
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
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
      expandedHeight: 320,
      pinned: true,
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF1A202C),
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xFF1A202C),
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
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

  Widget _buildVendorInfo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Business name with enhanced styling
          Text(
            vendor.businessName,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A202C),
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),

          // Category badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF6F3FCC).withOpacity(0.2),
              ),
            ),
            child: Text(
              vendor.category,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6F3FCC),
                letterSpacing: 0.5,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Business description section
          if (vendor.description != null &&
              vendor.description!.trim().isNotEmpty) ...[
            _buildDescriptionSection(),
            const SizedBox(height: 24),
          ],

          // Address with improved styling
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: Color(0xFF6F3FCC),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B7280),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _fullAddress,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF374151),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Website link if available
          if (vendor.website != null && vendor.website!.trim().isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  String url = vendor.website!.trim();
                  // Add https:// if not present
                  if (!url.startsWith('http://') && !url.startsWith('https://')) {
                    url = 'https://$url';
                  }
                  launchUrlString(url);
                },
                borderRadius: BorderRadius.circular(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6F3FCC).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.language_rounded,
                        color: Color(0xFF6F3FCC),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Website',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6B7280),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            vendor.website!.trim(),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF374151),
                              height: 1.4,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.open_in_new_rounded,
                      color: Color(0xFF6B7280),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 24),

          // Action buttons row with improved styling
          Row(
            children: [
              Expanded(
                child: BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, favState) {
                    final isFavorite =
                        favState is FavoritesLoaded &&
                        favState.isFavorite(vendor.id);

                    return Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isFavorite
                              ? [
                                  const Color(0xFFEF4444),
                                  const Color(0xFFDC2626),
                                ]
                              : [
                                  const Color(0xFF6F3FCC),
                                  const Color(0xFF9F7AEA),
                                ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color:
                                (isFavorite
                                        ? const Color(0xFFEF4444)
                                        : const Color(0xFF6F3FCC))
                                    .withOpacity(0.25),
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
                            context.read<FavoritesBloc>().add(
                              ToggleFavorite(vendor),
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isFavorite ? 'Favorited' : 'Add to Favorites',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              if (vendor.contactPhone != null &&
                  vendor.contactPhone!.trim().isNotEmpty)
                _buildActionButton(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    final raw = vendor.contactPhone!.trim();
                    final phone = raw.replaceAll(RegExp(r'[^0-9+]'), '');
                    if (phone.isNotEmpty) {
                      launchUrlString('tel:$phone');
                    }
                  },
                  icon: Icons.call_rounded,
                  color: const Color(0xFF10B981),
                  tooltip: 'Call',
                ),
              if (vendor.contactPhone != null &&
                  vendor.contactPhone!.trim().isNotEmpty)
                const SizedBox(width: 12),
              if (_googleMapsUrl != null)
                _buildActionButton(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    launchUrlString(_googleMapsUrl!);
                  },
                  icon: Icons.directions_rounded,
                  color: const Color(0xFFF59E0B),
                  tooltip: 'Directions',
                ),
            ],
          ),

          // Social Media Links
          if (vendor.socialMediaLinks.isNotEmpty) ...[
            const SizedBox(height: 24),
            _buildSocialMediaSection(),
          ],

          // Points Payment Card
          const SizedBox(height: 24),
          _buildPointsPaymentCard(context),
        ],
      ),
    );
  }

  /// Build points payment card
  Widget _buildPointsPaymentCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.35),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative pattern
          Positioned.fill(
            child: CustomPaint(painter: PaymentCardPatternPainter()),
          ),

          // Card content
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pay with Points',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.1,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Use your reward points to pay bills',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Points info row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(55),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withAlpha(86),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available Points',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 4),
                            BlocBuilder<PointsBloc, PointsState>(
                              builder: (context, pointsState) {
                                final pointsText = pointsState is PointsLoaded
                                    ? pointsState.points.balance.toString()
                                    : '--';
                                return Text(
                                  pointsText,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Exchange Rate',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '1 pt = ₹1',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Action button
                Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _openPointsPaymentDialog(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance_wallet_rounded,
                            color: const Color(0xFF6366F1),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Pay Bill with Points',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF6366F1),
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
        ],
      ),
    );
  }

  /// Build action button helper
  Widget _buildActionButton({
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Icon(icon, color: Colors.white, size: 22),
          ),
        ),
      ),
    );
  }

  /// Build business description section
  Widget _buildDescriptionSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6F3FCC).withOpacity(0.05),
            const Color(0xFF9F7AEA).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF6F3FCC).withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.business_rounded,
                  color: Color(0xFF6F3FCC),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'About This Business',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            vendor.description!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4A5568),
              height: 1.6,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  /// Build social media links section
  Widget _buildSocialMediaSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6F3FCC).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.share_rounded,
                  color: Color(0xFF6F3FCC),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Connect With Us',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: vendor.socialMediaLinks
                .where((social) => social.isActive)
                .where((social) => social.platform != 6)
                .map((social) => _buildSocialMediaIcon(social))
                .toList(),
          ),
        ],
      ),
    );
  }

  /// Find a Google Maps URL from vendor social links, if available
  String? get _googleMapsUrl {
    if (vendor.socialMediaLinks.isEmpty) return null;
    for (final s in vendor.socialMediaLinks) {
      if (!s.isActive) continue;
      final url = s.url;
      if (s.platform == 6) return url; // Platform 6 designated for Google Maps
      final lu = url.toLowerCase();
      if (lu.contains('google.com/maps') ||
          lu.contains('goo.gl/maps') ||
          lu.contains('maps.app.goo.gl') ||
          lu.contains('maps.google')) {
        return url;
      }
    }
    return null;
  }

  /// Build individual social media icon
  Widget _buildSocialMediaIcon(VendorSocialMedia social) {
    Image iconData;
    Color backgroundColor;

    // Map platform integers to icons and colors
    switch (social.platform) {
      case 1: // Instagram
        iconData = Image.asset(
          'assets/icons/social_media_platforms/Instagram.png',
        );
        backgroundColor = const Color(0xFFE4405F);
        break;
      case 2: // Facebook
        iconData = Image.asset(
          'assets/icons/social_media_platforms/Facebook.png',
        );
        backgroundColor = const Color(0xFF1877F2);
        break;
      case 3: // Twitter
        iconData = Image.asset('assets/icons/social_media_platforms/X.png');
        backgroundColor = const Color(0xFF000000);
        break;
      case 4: // LinkedIn
        iconData = Image.asset(
          'assets/icons/social_media_platforms/LinkedIn.png',
        );
        backgroundColor = const Color(0xFF0A66C2);
        break;
      case 5: // YouTube
        iconData = Image.asset(
          'assets/icons/social_media_platforms/YouTube.png',
        );
        backgroundColor = const Color(0xFFFF0000);
        break;
      case 6: // Google Maps
        iconData = Image.asset(
          'assets/icons/social_media_platforms/GoogleMaps.png',
        );
        backgroundColor = const Color(0xFF4285F4);
        break;
      case 7: // WhatsApp
        iconData = Image.asset(
          'assets/icons/social_media_platforms/WhatsApp.png',
        );
        backgroundColor = const Color(0xFF25D366);
        break;
      default: // Other
        iconData = Image.asset('assets/icons/social_media_platforms/Link.png');
        backgroundColor = const Color(0xFF6B7280);
        break;
    }

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: backgroundColor.withOpacity(0.2)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchSocialMediaUrl(social.url),
          borderRadius: BorderRadius.circular(16),
          child: Padding(padding: const EdgeInsets.all(8), child: iconData),
        ),
      ),
    );
  }

  /// Launch social media URL
  void _launchSocialMediaUrl(String url) {
    launchUrlString(url);
  }

  /// Start pay-with-points flow: verify vendor via QR, then open payment dialog
  Future<void> _openPointsPaymentDialog(BuildContext context) async {
    HapticFeedback.lightImpact();

    // 1) Verify vendor via QR scanner
    final verified = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => QRScannerPage(
          expectedVendorUid: _resolvedVendorUid,
          expectedVendorName: vendor.businessName,
          verifyOnly: true,
        ),
      ),
    );

    if (verified != true) {
      return; // Cancelled or failed verification
    }

    // 2) On success, open payment dialog
    final pointsState = context.read<PointsBloc>().state;
    final availablePoints = pointsState is PointsLoaded
        ? pointsState.points.balance
        : 0;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) =>
          PointsPaymentDialog(vendor: vendor, availablePoints: availablePoints),
    );
  }
}

/// Custom painter for payment card decorative pattern
class PaymentCardPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    // Create flowing wave patterns similar to Gemini
    _drawGeminiWaves(canvas, size, paint);

    // Add geometric accents
    _drawGeometricAccents(canvas, size, paint);

    // Add subtle mesh grid
    _drawMeshGrid(canvas, size, paint);
  }

  void _drawGeminiWaves(Canvas canvas, Size size, Paint paint) {
    // Create flowing wave paths with different opacities
    final path1 = Path();
    final path2 = Path();
    final path3 = Path();

    // Wave 1 - Top flowing wave
    path1.moveTo(-20, size.height * 0.3);
    path1.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.1,
      size.width * 0.6,
      size.height * 0.4,
    );
    path1.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.6,
      size.width + 20,
      size.height * 0.2,
    );
    path1.lineTo(size.width + 20, -20);
    path1.lineTo(-20, -20);
    path1.close();

    paint.color = Colors.white.withOpacity(0.08);
    canvas.drawPath(path1, paint);

    // Wave 2 - Middle flowing wave
    path2.moveTo(-20, size.height * 0.7);
    path2.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.5,
      size.width * 0.7,
      size.height * 0.8,
    );
    path2.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.9,
      size.width + 20,
      size.height * 0.6,
    );
    path2.lineTo(size.width + 20, size.height + 20);
    path2.lineTo(-20, size.height + 20);
    path2.close();

    paint.color = Colors.white.withOpacity(0.06);
    canvas.drawPath(path2, paint);

    // Wave 3 - Subtle accent wave
    path3.moveTo(size.width * 0.2, -20);
    path3.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.3,
      size.width * 0.8,
      size.height * 0.15,
    );
    path3.quadraticBezierTo(
      size.width * 1.1,
      size.height * 0.05,
      size.width + 20,
      size.height * 0.4,
    );
    path3.lineTo(size.width + 20, -20);
    path3.close();

    paint.color = Colors.white.withOpacity(0.04);
    canvas.drawPath(path3, paint);
  }

  void _drawGeometricAccents(Canvas canvas, Size size, Paint paint) {
    // Add subtle geometric shapes for Gemini-like accents
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Colors.white.withOpacity(0.1);

    // Flowing lines
    final path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.2);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.1,
      size.width * 0.5,
      size.height * 0.25,
    );
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.4,
      size.width * 0.9,
      size.height * 0.3,
    );
    canvas.drawPath(path, paint);

    // Second flowing line
    final path2 = Path();
    path2.moveTo(size.width * 0.05, size.height * 0.7);
    path2.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.85,
      size.width * 0.45,
      size.height * 0.75,
    );
    path2.quadraticBezierTo(
      size.width * 0.65,
      size.height * 0.65,
      size.width * 0.85,
      size.height * 0.8,
    );
    canvas.drawPath(path2, paint);

    // Add subtle dots along the paths
    paint.style = PaintingStyle.fill;
    paint.color = Colors.white.withOpacity(0.15);

    // Dots along first curve
    _drawDotAlongCurve(canvas, size.width * 0.2, size.height * 0.18, 2, paint);
    _drawDotAlongCurve(
      canvas,
      size.width * 0.6,
      size.height * 0.35,
      1.5,
      paint,
    );
    _drawDotAlongCurve(
      canvas,
      size.width * 0.8,
      size.height * 0.32,
      2.5,
      paint,
    );

    // Dots along second curve
    _drawDotAlongCurve(
      canvas,
      size.width * 0.15,
      size.height * 0.75,
      1.8,
      paint,
    );
    _drawDotAlongCurve(
      canvas,
      size.width * 0.55,
      size.height * 0.72,
      2.2,
      paint,
    );
    _drawDotAlongCurve(
      canvas,
      size.width * 0.75,
      size.height * 0.68,
      1.6,
      paint,
    );
  }

  void _drawDotAlongCurve(
    Canvas canvas,
    double x,
    double y,
    double radius,
    Paint paint,
  ) {
    canvas.drawCircle(Offset(x, y), radius, paint);
  }

  void _drawMeshGrid(Canvas canvas, Size size, Paint paint) {
    // Create a very subtle mesh grid effect
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = Colors.white.withOpacity(0.02);

    // Vertical lines
    for (double x = size.width * 0.2; x < size.width; x += size.width * 0.15) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (
      double y = size.height * 0.25;
      y < size.height;
      y += size.height * 0.2
    ) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
