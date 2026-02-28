import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/network/image_cache_manager.dart';
import 'package:savedge/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:savedge/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:savedge/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:savedge/features/points_payment/presentation/widgets/points_payment_dialog.dart';
import 'package:savedge/features/qr_scanner/presentation/pages/qr_scanner_page.dart';
import 'package:savedge/features/stores/presentation/widgets/vendor_offers_section.dart';
import 'package:savedge/features/user_profile/presentation/bloc/points_bloc.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/core/enums/coupon_enums.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_event.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_state.dart';
import 'package:url_launcher/url_launcher_string.dart';

class VendorDetailPage extends StatefulWidget {
  const VendorDetailPage({super.key, this.vendor, this.vendorId})
    : assert(
        vendor != null || vendorId != null,
        'Either vendor or vendorId must be provided',
      );

  final Vendor? vendor;
  final int? vendorId;

  @override
  State<VendorDetailPage> createState() => _VendorDetailPageState();
}

class _VendorDetailPageState extends State<VendorDetailPage> {
  UserProfileResponse3? _userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final authRepo = getIt<AuthRepository>();
      final profile = await authRepo.getCurrentUserProfile();
      if (mounted) {
        setState(() {
          _userProfile = profile;
        });
      }
    } catch (e) {
      // User might not be authenticated or profile fetch failed
      // This is okay - occasion coupons just won't be shown
    }
  }

  @override
  Widget build(BuildContext context) {
    // Always load vendor details from API to get complete data (images, coupons, etc.)
    final int id = widget.vendorId ?? widget.vendor!.id;

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
            return _VendorDetailView(
              vendor: state.vendor,
              userProfile: _userProfile,
            );
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

class _VendorDetailView extends StatefulWidget {
  const _VendorDetailView({required this.vendor, this.userProfile});

  final Vendor vendor;
  final UserProfileResponse3? userProfile;

  @override
  State<_VendorDetailView> createState() => _VendorDetailViewState();
}

class _VendorDetailViewState extends State<_VendorDetailView> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    final galleryImages = widget.vendor.images
        .where(
          (img) => img.imageType == 'gallery' || img.imageType == 'Gallery',
        )
        .toList();
    final imagesToShow = galleryImages.isNotEmpty
        ? galleryImages
        : widget.vendor.images.take(3).toList();

    // Only start auto-scroll if there are multiple images
    if (imagesToShow.length > 1) {
      _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
        if (_pageController.hasClients) {
          final nextPage = (_currentPage + 1) % imagesToShow.length;
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  /// Resolve vendor UID for QR and coupon flows.
  String get _resolvedVendorUid {
    final uid = widget.vendor.vendorUserId.trim();
    if (uid.isNotEmpty) return uid;
    for (final c in widget.vendor.coupons) {
      final u = c.vendorUserId.trim();
      if (u.isNotEmpty) return u;
    }
    return widget.vendor.id.toString();
  }

  /// Get full address string
  String get _fullAddress {
    final addressParts = <String>[];
    if (widget.vendor.address?.isNotEmpty == true) {
      addressParts.add(widget.vendor.address!);
    }
    if (widget.vendor.city?.isNotEmpty == true) {
      addressParts.add(widget.vendor.city!);
    }
    if (widget.vendor.state?.isNotEmpty == true) {
      addressParts.add(widget.vendor.state!);
    }
    if (widget.vendor.pinCode?.isNotEmpty == true) {
      addressParts.add(widget.vendor.pinCode!);
    }
    return addressParts.isNotEmpty
        ? addressParts.join(', ')
        : 'Address not available';
  }

  @override
  Widget build(BuildContext context) {
    // Debug: Print coupon occasion types
    debugPrint('===== VENDOR COUPONS DEBUG =====');
    for (final coupon in widget.vendor.coupons) {
      debugPrint('Coupon: ${coupon.title}');
      debugPrint('  - occasionType: ${coupon.occasionType}');
      debugPrint('  - isOccasionBased: ${coupon.isOccasionBased}');
      debugPrint('  - daysBeforeOccasion: ${coupon.daysBeforeOccasion}');
      debugPrint('  - daysAfterOccasion: ${coupon.daysAfterOccasion}');
    }
    final regularCoupons = widget.vendor.coupons
        .where((c) => !c.isOccasionBased)
        .toList();
    final occasionCoupons = widget.vendor.coupons
        .where((c) => c.isOccasionBased)
        .toList();
    debugPrint('Regular coupons count: ${regularCoupons.length}');
    debugPrint('Occasion coupons count: ${occasionCoupons.length}');
    debugPrint('================================');

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      body: CustomScrollView(
        slivers: [
          // Image Gallery with App Bar
          _buildSliverAppBar(context),
          // Vendor Info
          SliverToBoxAdapter(child: _buildVendorInfo(context)),
          // Regular Offers Section (excluding occasion-based coupons)
          SliverToBoxAdapter(
            child: VendorOffersSection(
              vendorId: widget.vendor.id,
              vendorUid: _resolvedVendorUid,
              vendorName: widget.vendor.businessName,
              coupons: regularCoupons,
            ),
          ),
          // Occasion-Based Offers Section (only if available)
          SliverToBoxAdapter(
            child: _buildOccasionOffersSection(
              context,
              widget.vendor,
              _resolvedVendorUid,
            ),
          ),
          // Yearly Subscription
          const SliverToBoxAdapter(child: SizedBox.shrink()),
          // Bottom spacing
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    // Get all gallery images or use primary image as fallback
    final galleryImages = widget.vendor.images
        .where(
          (img) => img.imageType == 'gallery' || img.imageType == 'Gallery',
        )
        .toList();

    final imagesToShow = galleryImages.isNotEmpty
        ? galleryImages
        : widget.vendor.images.take(3).toList(); // Show up to 3 images

    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: Colors.white,
      foregroundColor: const Color(0xFF1A202C),
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12, top: 4, bottom: 4),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: IconButton(
                icon: const Padding(
                  padding: EdgeInsets.only(left: 6.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ),
      actions: const [],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            // Image Carousel
            imagesToShow.isNotEmpty
                ? PageView.builder(
                    controller: _pageController,
                    itemCount: imagesToShow.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
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
            // Page indicators (only show if multiple images)
            if (imagesToShow.length > 1)
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imagesToShow.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            // Bottom overlay curve
            Positioned(
              bottom: -1,
              left: 0,
              right: 0,
              height: 24,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFAFBFC),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row with Layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.vendor.businessName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A202C),
                        letterSpacing: -0.5,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6F3FCC).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.vendor.category,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6F3FCC),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Favorite Button inline
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, favState) {
                  final isFavorite =
                      favState is FavoritesLoaded &&
                      favState.isFavorite(widget.vendor.id);
                  return IconButton(
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      context.read<FavoritesBloc>().add(ToggleFavorite(widget.vendor));
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: isFavorite
                          ? const Color(0xFFEF4444).withOpacity(0.1)
                          : const Color(0xFFF3F4F6),
                      padding: const EdgeInsets.all(12),
                    ),
                    icon: Icon(
                      isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: isFavorite ? const Color(0xFFEF4444) : const Color(0xFF6B7280),
                      size: 24,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Quick Action Pills Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: [
                if (widget.vendor.contactPhone != null &&
                    widget.vendor.contactPhone!.trim().isNotEmpty) ...[
                  _buildActionPill(
                    icon: Icons.call_rounded,
                    label: 'Call',
                    color: const Color(0xFF10B981),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      final raw = widget.vendor.contactPhone!.trim();
                      final phone = raw.replaceAll(RegExp(r'[^0-9+]'), '');
                      if (phone.isNotEmpty) launchUrlString('tel:$phone');
                    },
                  ),
                  const SizedBox(width: 8),
                ],
                if (_googleMapsUrl != null) ...[
                  _buildActionPill(
                    icon: Icons.directions_rounded,
                    label: 'Map',
                    color: const Color(0xFFF59E0B),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      launchUrlString(_googleMapsUrl!);
                    },
                  ),
                  const SizedBox(width: 8),
                ],
                if (widget.vendor.website != null &&
                    widget.vendor.website!.trim().isNotEmpty) ...[
                  _buildActionPill(
                    icon: Icons.language_rounded,
                    label: 'Website',
                    color: const Color(0xFF3B82F6),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      String url = widget.vendor.website!.trim();
                      if (!url.startsWith('http')) url = 'https://$url';
                      launchUrlString(url);
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Unified Info Section (Location & About)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5E7EB)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_rounded, color: Color(0xFF6B7280), size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _fullAddress,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF374151),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),

                if (widget.vendor.description != null &&
                    widget.vendor.description!.trim().isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: Color(0xFFE5E7EB), height: 1),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline_rounded, color: Color(0xFF6B7280), size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.vendor.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF4B5563),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Social Media Links
          if (widget.vendor.socialMediaLinks.isNotEmpty) ...[
            const SizedBox(height: 20),
            _buildSocialMediaSection(),
          ],

          // Points Payment Banner
          const SizedBox(height: 20),
          _buildPointsPaymentCard(context),
        ],
      ),
    );
  }

  /// Horizontal points payment banner
  Widget _buildPointsPaymentCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pay with Points',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                BlocBuilder<PointsBloc, PointsState>(
                  builder: (context, pointsState) {
                    final balance = pointsState is PointsLoaded ? pointsState.points.balance : 0;
                    return Text(
                      'Balance: $balance pts',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () => _openPointsPaymentDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text('Pay Bill', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  /// Compact Action Pill helper
  Widget _buildActionPill({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.15)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build social media links section
  Widget _buildSocialMediaSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.share_rounded, color: Color(0xFF6B7280), size: 20),
              const SizedBox(width: 12),
              const Text(
                'Connect With Us',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: widget.vendor.socialMediaLinks
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
    if (widget.vendor.socialMediaLinks.isEmpty) return null;
    for (final s in widget.vendor.socialMediaLinks) {
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

  /// Check if an occasion coupon is currently available for the user
  bool _isOccasionCouponAvailable(
    Coupon coupon,
    DateTime? userDateOfBirth,
    DateTime? userAnniversaryDate,
  ) {
    if (!coupon.isOccasionBased) return false;

    final now = DateTime.now();

    switch (coupon.occasionType) {
      case CouponOccasionType.birthday:
        if (userDateOfBirth == null) return false;
        return _isWithinOccasionWindow(
          now,
          userDateOfBirth,
          coupon.daysBeforeOccasion ?? 0,
          coupon.daysAfterOccasion ?? 0,
        );

      case CouponOccasionType.anniversary:
        if (userAnniversaryDate == null) return false;
        return _isWithinOccasionWindow(
          now,
          userAnniversaryDate,
          coupon.daysBeforeOccasion ?? 0,
          coupon.daysAfterOccasion ?? 0,
        );

      case CouponOccasionType.newYear:
        // Check if current date is within the New Year window
        final currentYearNewYear = DateTime(now.year, 1, 1);
        return _isWithinOccasionWindow(
          now,
          currentYearNewYear,
          coupon.daysBeforeOccasion ?? 0,
          coupon.daysAfterOccasion ?? 0,
        );

      case CouponOccasionType.regular:
        return false;
    }
  }

  /// Check if current date is within the occasion window
  bool _isWithinOccasionWindow(
    DateTime now,
    DateTime occasionDate,
    int daysBefore,
    int daysAfter,
  ) {
    // Adjust occasion date to current year for recurring occasions
    final thisYearOccasion = DateTime(
      now.year,
      occasionDate.month,
      occasionDate.day,
    );

    final windowStart = thisYearOccasion.subtract(Duration(days: daysBefore));
    final windowEnd = thisYearOccasion.add(Duration(days: daysAfter));

    return now.isAfter(windowStart) &&
        now.isBefore(windowEnd.add(const Duration(days: 1)));
  }

  /// Build occasion-based offers section
  Widget _buildOccasionOffersSection(
    BuildContext context,
    Vendor vendor,
    String vendorUid,
  ) {
    // Get user's dates from profile if available
    final userDateOfBirth = widget.userProfile?.dateOfBirth;
    final userAnniversaryDate = widget.userProfile?.anniversaryDate;

    // Get all occasion coupons (both available and unavailable)
    final allOccasionCoupons = vendor.coupons
        .where((c) => c.isOccasionBased && c.isValid)
        .toList();

    // Only show section if there are any occasion coupons
    if (allOccasionCoupons.isEmpty) {
      return const SizedBox.shrink();
    }

    // Build custom occasion section with availability info
    return _buildCustomOccasionSection(
      context,
      allOccasionCoupons,
      vendorUid,
      vendor.businessName,
      userDateOfBirth,
      userAnniversaryDate,
    );
  }

  Widget _buildCustomOccasionSection(
    BuildContext context,
    List<Coupon> occasionCoupons,
    String vendorUid,
    String vendorName,
    DateTime? userDateOfBirth,
    DateTime? userAnniversaryDate,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.celebration,
                    color: Color(0xFF6F3FCC),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Special Occasion Offers 🎉',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Coupon cards
          ...occasionCoupons.asMap().entries.map((entry) {
            final index = entry.key;
            final coupon = entry.value;
            final isAvailable = _isOccasionCouponAvailable(
              coupon,
              userDateOfBirth,
              userAnniversaryDate,
            );

            return _buildOccasionCouponCard(
              context,
              coupon,
              vendorUid,
              vendorName,
              isAvailable,
              userDateOfBirth,
              userAnniversaryDate,
              index,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOccasionCouponCard(
    BuildContext context,
    Coupon coupon,
    String vendorUid,
    String vendorName,
    bool isAvailable,
    DateTime? userDateOfBirth,
    DateTime? userAnniversaryDate,
    int index,
  ) {
    // Calculate availability message
    String availabilityMessage = '';
    if (!isAvailable) {
      availabilityMessage = _getAvailabilityMessage(
        coupon,
        userDateOfBirth,
        userAnniversaryDate,
      );
    }

    return Opacity(
      opacity: isAvailable ? 1.0 : 0.5,
      child: AbsorbPointer(
        absorbing: !isAvailable,
        child: Container(
          margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VendorOfferCard(
                coupon: coupon,
                vendorUid: vendorUid,
                vendorName: vendorName,
                index: index,
              ),
              if (!isAvailable && availabilityMessage.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3CD),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFFFC107),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        size: 16,
                        color: Color(0xFFF57C00),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          availabilityMessage,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFF57C00),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getAvailabilityMessage(
    Coupon coupon,
    DateTime? userDateOfBirth,
    DateTime? userAnniversaryDate,
  ) {
    final now = DateTime.now();

    switch (coupon.occasionType) {
      case CouponOccasionType.birthday:
        if (userDateOfBirth == null) {
          return 'Add your birthday to your profile to use this offer';
        }
        final thisYearBirthday = DateTime(
          now.year,
          userDateOfBirth.month,
          userDateOfBirth.day,
        );
        final daysBefore = coupon.daysBeforeOccasion ?? 0;
        final windowStart = thisYearBirthday.subtract(
          Duration(days: daysBefore),
        );

        if (now.isBefore(windowStart)) {
          final daysUntil = windowStart.difference(now).inDays;
          return 'Available in $daysUntil days ($daysBefore days before your birthday)';
        } else {
          // Already passed this year
          return 'Available $daysBefore days before your birthday';
        }

      case CouponOccasionType.anniversary:
        if (userAnniversaryDate == null) {
          return 'Add your anniversary date to your profile to use this offer';
        }
        final thisYearAnniversary = DateTime(
          now.year,
          userAnniversaryDate.month,
          userAnniversaryDate.day,
        );
        final daysBefore = coupon.daysBeforeOccasion ?? 0;
        final windowStart = thisYearAnniversary.subtract(
          Duration(days: daysBefore),
        );

        if (now.isBefore(windowStart)) {
          final daysUntil = windowStart.difference(now).inDays;
          return 'Available in $daysUntil days ($daysBefore days before your anniversary)';
        } else {
          return 'Available $daysBefore days before your anniversary';
        }

      case CouponOccasionType.newYear:
        final nextYearNewYear = DateTime(now.year + 1, 1, 1);
        final daysBefore = coupon.daysBeforeOccasion ?? 0;
        final windowStart = nextYearNewYear.subtract(
          Duration(days: daysBefore),
        );

        if (now.isBefore(windowStart)) {
          final daysUntil = windowStart.difference(now).inDays;
          return 'Available in $daysUntil days ($daysBefore days before New Year)';
        } else {
          return 'Available $daysBefore days before New Year';
        }

      case CouponOccasionType.regular:
        return '';
    }
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
          expectedVendorName: widget.vendor.businessName,
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
      builder: (BuildContext context) => PointsPaymentDialog(
        vendor: widget.vendor,
        availablePoints: availablePoints,
      ),
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

  void _drawMeshGrid(Canvas canvas, Size size, Paint paint) {
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = Colors.white.withOpacity(0.04);

    const step = 20.0;
    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
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

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}