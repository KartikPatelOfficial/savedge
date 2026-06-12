import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/enums/coupon_enums.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/network/image_cache_manager.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/core/themes/app_theme.dart';
import 'package:savedge/core/widgets/login_prompt.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:savedge/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:savedge/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:savedge/features/points_payment/presentation/pages/points_payment_page.dart';
import 'package:savedge/features/qr_scanner/presentation/pages/qr_scanner_page.dart';
import 'package:savedge/features/stores/presentation/widgets/vendor_offers_section.dart';
import 'package:savedge/features/user_profile/presentation/bloc/points_bloc.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_event.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_state.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Page-local design tokens. Brand values come from [AppTheme].
abstract class _T {
  static const Color brand = AppTheme.primaryColor;
  static const Color ink = Color(0xFF17181C);
  static const Color inkMid = Color(0xFF54575E);
  static const Color inkLow = Color(0xFF9A9CA3);
  static const Color canvas = Color(0xFFF6F6F8);
  static const Color card = Colors.white;
  static const Color hairline = Color(0xFFEBEBEE);

  static const double margin = 20;

  /// Full-bleed gallery height and how far the info card rides over it.
  static const double heroHeight = 300;
  static const double cardOverlap = 52;
}

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
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthAndLoadProfile();
  }

  Future<void> _checkAuthAndLoadProfile() async {
    final secureStorage = getIt<SecureStorageService>();
    final isAuth = await secureStorage.isAuthenticated();
    if (mounted) {
      setState(() => _isAuthenticated = isAuth);
    }
    if (!isAuth) return;

    try {
      final authRepo = getIt<AuthRepository>();
      final profile = await authRepo.getCurrentUserProfile();
      if (mounted) {
        setState(() => _userProfile = profile);
      }
    } catch (_) {
      // Profile fetch failed — occasion coupons simply won't unlock.
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
          create: (context) {
            final bloc = getIt<PointsBloc>();
            if (_isAuthenticated) bloc.add(LoadUserPoints());
            return bloc;
          },
        ),
        BlocProvider(
          create: (context) {
            final bloc = getIt<FavoritesBloc>();
            if (_isAuthenticated) bloc.add(LoadFavorites());
            return bloc;
          },
        ),
      ],
      child: BlocBuilder<VendorDetailBloc, VendorDetailState>(
        builder: (context, state) {
          if (state is VendorDetailLoaded) {
            return _VendorDetailView(
              vendor: state.vendor,
              userProfile: _userProfile,
              isAuthenticated: _isAuthenticated,
            );
          }
          if (state is VendorDetailError) {
            return _ErrorView(
              message: state.message,
              onRetry: () => context.read<VendorDetailBloc>().add(
                RefreshVendorDetail(id),
              ),
            );
          }
          return const _SkeletonView();
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Loaded view
// ---------------------------------------------------------------------------

class _VendorDetailView extends StatefulWidget {
  const _VendorDetailView({
    required this.vendor,
    this.userProfile,
    this.isAuthenticated = true,
  });

  final Vendor vendor;
  final UserProfileResponse3? userProfile;
  final bool isAuthenticated;

  @override
  State<_VendorDetailView> createState() => _VendorDetailViewState();
}

class _VendorDetailViewState extends State<_VendorDetailView> {
  final ScrollController _scrollController = ScrollController();

  /// Top bar turns solid white once the hero is mostly gone.
  bool _barSolid = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final solid = _scrollController.offset > _T.heroHeight - 120;
    if (solid != _barSolid) {
      setState(() => _barSolid = solid);
    }
  }

  /// Everything except the logo, gallery shots first, stable order.
  List<VendorImage> get _displayImages {
    var images = widget.vendor.images
        .where((img) => img.imageType.toLowerCase() != 'logo')
        .toList();

    // Vendor media frequently arrives with every image mis-typed as 'logo'
    // (the API returns numeric type 1 for all of them), which would leave the
    // carousel empty. When the type filter yields nothing, fall back to the
    // reliable signal: the primary image is the logo, everything else is a
    // gallery shot. This is a no-op for correctly-typed vendors.
    if (images.isEmpty) {
      images = widget.vendor.images.where((img) => !img.isPrimary).toList();
    }

    images.sort((a, b) {
      final aGallery = a.imageType.toLowerCase() == 'gallery' ? 0 : 1;
      final bGallery = b.imageType.toLowerCase() == 'gallery' ? 0 : 1;
      if (aGallery != bGallery) return aGallery - bGallery;
      return a.displayOrder.compareTo(b.displayOrder);
    });
    return images;
  }

  String? get _logoUrl {
    final images = widget.vendor.images;
    // Prefer the primary logo so it stays consistent with _displayImages,
    // which treats the primary image as the logo when types are unreliable.
    for (final img in images) {
      if (img.imageType.toLowerCase() == 'logo' && img.isPrimary) {
        return img.imageUrl;
      }
    }
    for (final img in images) {
      if (img.imageType.toLowerCase() == 'logo') return img.imageUrl;
    }
    for (final img in images) {
      if (img.isPrimary) return img.imageUrl;
    }
    return null;
  }

  void _openPhotoViewer(int initialIndex) {
    final images = _displayImages;
    if (images.isEmpty) return;
    HapticFeedback.selectionClick();
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black,
        pageBuilder: (context, animation, _) => FadeTransition(
          opacity: animation,
          child: _PhotoViewerPage(
            images: images,
            initialIndex: initialIndex,
            storeName: widget.vendor.businessName,
          ),
        ),
      ),
    );
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

  String get _fullAddress {
    final parts = <String>[
      if (widget.vendor.address?.isNotEmpty == true) widget.vendor.address!,
      if (widget.vendor.city?.isNotEmpty == true) widget.vendor.city!,
      if (widget.vendor.state?.isNotEmpty == true) widget.vendor.state!,
      if (widget.vendor.pinCode?.isNotEmpty == true) widget.vendor.pinCode!,
    ];
    return parts.join(', ');
  }

  /// Find a Google Maps URL from vendor social links, if available.
  String? get _googleMapsUrl {
    for (final s in widget.vendor.socialMediaLinks) {
      if (!s.isActive) continue;
      if (s.platform == 6) return s.url; // Platform 6 is Google Maps
      final lu = s.url.toLowerCase();
      if (lu.contains('google.com/maps') ||
          lu.contains('goo.gl/maps') ||
          lu.contains('maps.app.goo.gl') ||
          lu.contains('maps.google')) {
        return s.url;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final regularCoupons = widget.vendor.coupons
        .where((c) => !c.isOccasionBased)
        .toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _barSolid ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: _T.canvas,
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(child: _buildHeroAndCard(context)),
                if (widget.isAuthenticated)
                  SliverToBoxAdapter(child: _buildWalletStrip(context)),
                SliverToBoxAdapter(child: _buildAboutSection()),
                const SliverToBoxAdapter(child: SizedBox(height: 28)),
                SliverToBoxAdapter(
                  child: VendorOffersSection(
                    vendorId: widget.vendor.id,
                    vendorUid: _resolvedVendorUid,
                    vendorName: widget.vendor.businessName,
                    coupons: regularCoupons,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildOccasionOffersSection(context),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 48)),
              ],
            ),
            _buildTopBar(context),
          ],
        ),
      ),
    );
  }

  // -- Floating top bar --------------------------------------------------------

  Widget _buildTopBar(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _barSolid ? _T.card : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _barSolid ? _T.hairline : Colors.transparent,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              const SizedBox(width: 12),
              _RoundIconButton(
                icon: Icons.arrow_back_rounded,
                semanticLabel: 'Back',
                flat: _barSolid,
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AnimatedOpacity(
                  opacity: _barSolid ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    widget.vendor.businessName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: _T.ink,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, favState) {
                  final isFavorite = widget.isAuthenticated &&
                      favState is FavoritesLoaded &&
                      favState.isFavorite(widget.vendor.id);
                  return _RoundIconButton(
                    icon: isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    iconColor: isFavorite ? const Color(0xFFE0245E) : _T.ink,
                    semanticLabel: isFavorite
                        ? 'Remove from favorites'
                        : 'Add to favorites',
                    flat: _barSolid,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      if (!widget.isAuthenticated) {
                        LoginPrompt.show(
                          context,
                          message: 'Sign in to save your favorite stores.',
                        );
                        return;
                      }
                      context
                          .read<FavoritesBloc>()
                          .add(ToggleFavorite(widget.vendor));
                    },
                  );
                },
              ),
              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }

  // -- Hero + overlapping identity card ----------------------------------------

  Widget _buildHeroAndCard(BuildContext context) {
    return Stack(
      children: [
        _HeroGallery(images: _displayImages, onImageTap: _openPhotoViewer),
        Padding(
          padding: const EdgeInsets.only(
            top: _T.heroHeight - _T.cardOverlap,
            left: _T.margin,
            right: _T.margin,
          ),
          child: _buildIdentityCard(),
        ),
      ],
    );
  }

  Widget _buildIdentityCard() {
    final offerCount = widget.vendor.coupons.where((c) => c.isValid).length;
    final city = widget.vendor.city?.trim() ?? '';
    final metaLine = [
      widget.vendor.category,
      if (city.isNotEmpty) city,
    ].join('  ·  ');
    // Only show the address line when there's an actual street address —
    // city/state alone would just repeat the meta line above it.
    final hasStreetAddress = widget.vendor.address?.trim().isNotEmpty == true;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 380),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, 16 * (1 - t)),
          child: child,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: _T.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _T.hairline),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  // Top padding clears the half of the logo that sits
                  // inside the card.
                  padding: const EdgeInsets.fromLTRB(18, 40, 18, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.vendor.businessName,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                          color: _T.ink,
                          letterSpacing: -0.5,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        metaLine,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _T.inkMid,
                        ),
                      ),
                      if (offerCount > 0) ...[
                        const SizedBox(height: 10),
                        _LiveOffersTag(count: offerCount),
                      ],
                      if (hasStreetAddress) ...[
                        const SizedBox(height: 14),
                        _AddressLine(
                          address: _fullAddress,
                          onTap: _googleMapsUrl != null
                              ? () {
                                  HapticFeedback.lightImpact();
                                  launchUrlString(_googleMapsUrl!);
                                }
                              : null,
                        ),
                      ],
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const Divider(color: _T.hairline, height: 1),
                _buildActionRow(),
              ],
            ),
          ),
          // Store logo straddling the card's top edge.
          Positioned(
            top: -28,
            left: 18,
            child: _StoreLogo(
              logoUrl: _logoUrl,
              businessName: widget.vendor.businessName,
            ),
          ),
        ],
      ),
    );
  }

  /// Zomato-style action row: equal cells split by vertical hairlines.
  Widget _buildActionRow() {
    final phone = widget.vendor.contactPhone?.trim() ?? '';
    final website = widget.vendor.website?.trim() ?? '';

    final actions = <Widget>[
      if (phone.isNotEmpty)
        _ActionCell(
          icon: Icons.call_outlined,
          label: 'Call',
          onTap: () {
            HapticFeedback.lightImpact();
            final cleaned = phone.replaceAll(RegExp(r'[^0-9+]'), '');
            if (cleaned.isNotEmpty) launchUrlString('tel:$cleaned');
          },
        ),
      if (_googleMapsUrl != null)
        _ActionCell(
          icon: Icons.near_me_outlined,
          label: 'Directions',
          onTap: () {
            HapticFeedback.lightImpact();
            launchUrlString(_googleMapsUrl!);
          },
        ),
      if (website.isNotEmpty)
        _ActionCell(
          icon: Icons.language_outlined,
          label: 'Website',
          onTap: () {
            HapticFeedback.lightImpact();
            final url =
                website.startsWith('http') ? website : 'https://$website';
            launchUrlString(url);
          },
        ),
    ];

    if (actions.isEmpty) return const SizedBox(height: 4);

    final cells = <Widget>[];
    for (var i = 0; i < actions.length; i++) {
      if (i > 0) {
        cells.add(Container(width: 1, height: 26, color: _T.hairline));
      }
      cells.add(Expanded(child: actions[i]));
    }

    return Row(children: cells);
  }

  // -- Wallet strip --------------------------------------------------------------

  Widget _buildWalletStrip(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(_T.margin, 16, _T.margin, 0),
      child: Material(
        color: _T.ink,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: () => _openPointsPaymentPage(context),
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 14, 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pay your bill with points',
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      BlocBuilder<PointsBloc, PointsState>(
                        builder: (context, pointsState) {
                          final balance = pointsState is PointsLoaded
                              ? pointsState.points.balance
                              : 0;
                          return Text(
                            '$balance pts in your wallet',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.65),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: _T.brand,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -- About -----------------------------------------------------------------

  Widget _buildAboutSection() {
    final description = widget.vendor.description?.trim() ?? '';
    final socials = widget.vendor.socialMediaLinks
        .where((s) => s.isActive && s.platform != 6)
        .toList();

    if (description.isEmpty && socials.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(_T.margin, 28, _T.margin, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (description.isNotEmpty) ...[
            const Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _T.ink,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            _ExpandableText(text: description),
          ],
          if (socials.isNotEmpty) ...[
            SizedBox(height: description.isNotEmpty ? 24 : 0),
            _SocialLinks(
              businessName: widget.vendor.businessName,
              socials: socials,
            ),
          ],
        ],
      ),
    );
  }

  // -- Occasion offers ---------------------------------------------------------

  /// Check if an occasion coupon is currently available for the user.
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

  /// Check if current date is within the occasion window.
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

  Widget _buildOccasionOffersSection(BuildContext context) {
    final userDateOfBirth = widget.userProfile?.dateOfBirth;
    final userAnniversaryDate = widget.userProfile?.anniversaryDate;

    final occasionCoupons = widget.vendor.coupons
        .where((c) => c.isOccasionBased && c.isValid)
        .toList();

    if (occasionCoupons.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Clean typographic header — mirrors the Special Offers section so
          // the two lists read as siblings.
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'On your occasions',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: _T.ink,
                letterSpacing: -0.4,
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Unlocked around your birthday & anniversary',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _T.inkLow,
              ),
            ),
          ),
          const SizedBox(height: 18),
          ...occasionCoupons.asMap().entries.map((entry) {
            final coupon = entry.value;
            final isAvailable = _isOccasionCouponAvailable(
              coupon,
              userDateOfBirth,
              userAnniversaryDate,
            );
            return _buildOccasionCouponCard(
              coupon: coupon,
              isAvailable: isAvailable,
              availabilityMessage: isAvailable
                  ? ''
                  : _getAvailabilityMessage(
                      coupon,
                      userDateOfBirth,
                      userAnniversaryDate,
                    ),
              index: entry.key,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildOccasionCouponCard({
    required Coupon coupon,
    required bool isAvailable,
    required String availabilityMessage,
    required int index,
  }) {
    return Opacity(
      opacity: isAvailable ? 1.0 : 0.55,
      child: AbsorbPointer(
        absorbing: !isAvailable,
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VendorOfferCard(
                coupon: coupon,
                vendorUid: _resolvedVendorUid,
                vendorName: widget.vendor.businessName,
                index: index,
              ),
              if (!isAvailable && availabilityMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.schedule_rounded,
                        size: 15,
                        color: _T.inkLow,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          availabilityMessage,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: _T.inkLow,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
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

  /// Start pay-with-points flow: verify vendor via QR, then open payment page.
  Future<void> _openPointsPaymentPage(BuildContext context) async {
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

    if (verified != true) return;
    if (!context.mounted) return;

    // 2) On success, open the points payment page
    final pointsState = context.read<PointsBloc>().state;
    final availablePoints = pointsState is PointsLoaded
        ? pointsState.points.balance
        : 0;

    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => PointsPaymentPage(
          vendor: widget.vendor,
          availablePoints: availablePoints,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Hero gallery
// ---------------------------------------------------------------------------

class _HeroGallery extends StatefulWidget {
  const _HeroGallery({required this.images, required this.onImageTap});

  final List<VendorImage> images;
  final ValueChanged<int> onImageTap;

  @override
  State<_HeroGallery> createState() => _HeroGalleryState();
}

class _HeroGalleryState extends State<_HeroGallery> {
  final PageController _controller = PageController();
  int _page = 0;
  Timer? _autoScrollTimer;
  bool _autoScrollStarted = false;

  static const Duration _autoScrollInterval = Duration(seconds: 4);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // MediaQuery isn't available in initState; start the carousel here once.
    if (!_autoScrollStarted) {
      _autoScrollStarted = true;
      _maybeStartAutoScroll();
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _maybeStartAutoScroll() {
    _autoScrollTimer?.cancel();
    if (widget.images.length <= 1) return;
    // Honor the OS "reduce motion" setting.
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return;

    _autoScrollTimer = Timer.periodic(_autoScrollInterval, (_) {
      if (!mounted || !_controller.hasClients) return;
      final next = (_page + 1) % widget.images.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOut,
      );
    });
  }

  /// Stop auto-advancing once the user takes over, then resume after a beat.
  void _onUserInteraction() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer(const Duration(seconds: 6), _maybeStartAutoScroll);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _T.heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (widget.images.isEmpty)
            const _HeroFallback()
          else
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification &&
                    notification.dragDetails != null) {
                  _onUserInteraction();
                }
                return false;
              },
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.images.length,
                onPageChanged: (index) => setState(() => _page = index),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => widget.onImageTap(index),
                  child: CachedNetworkImage(
                    imageUrl: widget.images[index].imageUrl,
                    fit: BoxFit.cover,
                    cacheManager: CustomImageCacheManager(),
                    placeholder: (context, url) =>
                        const ColoredBox(color: Color(0xFFE8E8EC)),
                    errorWidget: (context, url, error) =>
                        const _HeroFallback(),
                  ),
                ),
              ),
            ),
          // Soft scrim under the status bar only — photography stays clean.
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 110,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0x59000000), Color(0x00000000)],
                  ),
                ),
              ),
            ),
          ),
          if (widget.images.isNotEmpty)
            Positioned(
              right: 14,
              bottom: _T.cardOverlap + 14,
              child: Semantics(
                button: true,
                label: 'View photos fullscreen',
                child: GestureDetector(
                  onTap: () => widget.onImageTap(_page),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.fullscreen_rounded,
                          size: 15,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.images.length == 1
                              ? 'View'
                              : '${_page + 1} / ${widget.images.length}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Fullscreen photo viewer
// ---------------------------------------------------------------------------

/// Black-canvas viewer: swipe between photos, pinch to zoom, nothing cropped.
class _PhotoViewerPage extends StatefulWidget {
  const _PhotoViewerPage({
    required this.images,
    required this.initialIndex,
    required this.storeName,
  });

  final List<VendorImage> images;
  final int initialIndex;
  final String storeName;

  @override
  State<_PhotoViewerPage> createState() => _PhotoViewerPageState();
}

class _PhotoViewerPageState extends State<_PhotoViewerPage> {
  late final PageController _controller;
  late int _page;

  /// Swiping is disabled while a photo is zoomed in, so pan gestures
  /// move the photo instead of changing pages.
  bool _zoomed = false;

  @override
  void initState() {
    super.initState();
    _page = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              physics: _zoomed
                  ? const NeverScrollableScrollPhysics()
                  : const PageScrollPhysics(),
              itemCount: widget.images.length,
              onPageChanged: (index) => setState(() => _page = index),
              itemBuilder: (context, index) => _ZoomableImage(
                imageUrl: widget.images[index].imageUrl,
                onZoomChanged: (zoomed) {
                  if (zoomed != _zoomed) setState(() => _zoomed = zoomed);
                },
              ),
            ),
            // Top chrome: close button + counter.
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      tooltip: 'Close',
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.images.length > 1
                            ? '${_page + 1} of ${widget.images.length}'
                            : widget.storeName,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Balances the close button so the title stays centered.
                    const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ZoomableImage extends StatefulWidget {
  const _ZoomableImage({required this.imageUrl, required this.onZoomChanged});

  final String imageUrl;
  final ValueChanged<bool> onZoomChanged;

  @override
  State<_ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<_ZoomableImage> {
  final TransformationController _transform = TransformationController();

  /// Panning is only enabled while zoomed in. At scale 1 the parent
  /// [PageView] must own horizontal drags so swiping between photos works —
  /// otherwise [InteractiveViewer] swallows the gesture.
  bool _zoomed = false;

  @override
  void dispose() {
    _transform.dispose();
    super.dispose();
  }

  void _setZoomed(bool zoomed) {
    if (zoomed != _zoomed) {
      setState(() => _zoomed = zoomed);
    }
    widget.onZoomChanged(zoomed);
  }

  void _onInteractionEnd(ScaleEndDetails details) {
    _setZoomed(_transform.value.getMaxScaleOnAxis() > 1.01);
  }

  void _onDoubleTap() {
    final zoomed = _transform.value.getMaxScaleOnAxis() > 1.01;
    if (zoomed) {
      _transform.value = Matrix4.identity();
      _setZoomed(false);
    } else {
      _transform.value = Matrix4.identity()..scaleByDouble(2.2, 2.2, 1, 1);
      _setZoomed(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _onDoubleTap,
      child: InteractiveViewer(
        transformationController: _transform,
        minScale: 1,
        maxScale: 5,
        panEnabled: _zoomed,
        onInteractionEnd: _onInteractionEnd,
        child: Center(
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.contain,
            cacheManager: CustomImageCacheManager(),
            placeholder: (context, url) => const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                color: Colors.white38,
                strokeWidth: 2.5,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.broken_image_outlined,
              color: Colors.white38,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}

/// Decorative stand-in when a store has no photos: deep brand field with a
/// quiet oversized storefront mark, so the page never opens on a grey void.
class _HeroFallback extends StatelessWidget {
  const _HeroFallback();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3B2667), Color(0xFF6F3FCC)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            bottom: -20,
            child: Icon(
              Icons.storefront_rounded,
              size: 220,
              color: Colors.white.withValues(alpha: 0.10),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Identity card pieces
// ---------------------------------------------------------------------------

/// Circular store logo with a white ring; falls back to a monogram so the
/// card composition holds even when no logo was uploaded.
class _StoreLogo extends StatelessWidget {
  const _StoreLogo({required this.logoUrl, required this.businessName});

  final String? logoUrl;
  final String businessName;

  static const double _size = 56;

  @override
  Widget build(BuildContext context) {
    final monogram = businessName.isNotEmpty
        ? businessName.characters.first.toUpperCase()
        : '?';

    return Container(
      width: _size + 8,
      height: _size + 8,
      decoration: BoxDecoration(
        color: _T.card,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: ClipOval(
        child: logoUrl != null
            ? CachedNetworkImage(
                imageUrl: logoUrl!,
                fit: BoxFit.cover,
                cacheManager: CustomImageCacheManager(),
                placeholder: (context, url) =>
                    const ColoredBox(color: Color(0xFFF0F0F3)),
                errorWidget: (context, url, error) =>
                    _Monogram(letter: monogram),
              )
            : _Monogram(letter: monogram),
      ),
    );
  }
}

class _Monogram extends StatelessWidget {
  const _Monogram({required this.letter});

  final String letter;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _T.brand.withValues(alpha: 0.10),
      child: Center(
        child: Text(
          letter,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: _T.brand,
          ),
        ),
      ),
    );
  }
}

class _LiveOffersTag extends StatelessWidget {
  const _LiveOffersTag({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _T.brand.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: _T.brand,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            count == 1 ? '1 offer live' : '$count offers live',
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: _T.brand,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressLine extends StatelessWidget {
  const _AddressLine({required this.address, this.onTap});

  final String address;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final line = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(Icons.place_outlined, size: 16, color: _T.inkLow),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: _T.inkMid,
              height: 1.4,
            ),
          ),
        ),
      ],
    );

    if (onTap == null) return line;

    return Semantics(
      button: true,
      label: 'Open address in maps',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: line,
      ),
    );
  }
}

class _ActionCell extends StatelessWidget {
  const _ActionCell({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: _T.brand),
            const SizedBox(width: 7),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: _T.ink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared chrome
// ---------------------------------------------------------------------------

/// White circular button with a soft shadow — readable over photos and on
/// solid backgrounds alike. `flat` drops the shadow once the bar is solid.
class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.onTap,
    required this.semanticLabel,
    this.iconColor = _T.ink,
    this.flat = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String semanticLabel;
  final Color iconColor;
  final bool flat;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: _T.card,
          shape: BoxShape.circle,
          boxShadow: flat
              ? const []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: Icon(icon, size: 20, color: iconColor),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// About pieces
// ---------------------------------------------------------------------------

/// Description clamped to 3 lines with an inline "more" toggle.
class _ExpandableText extends StatefulWidget {
  const _ExpandableText({required this.text});

  final String text;

  static const int collapsedLines = 3;

  @override
  State<_ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<_ExpandableText> {
  bool _expanded = false;

  static const TextStyle _bodyStyle = TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.w400,
    color: _T.inkMid,
    height: 1.55,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(text: widget.text, style: _bodyStyle),
          maxLines: _ExpandableText.collapsedLines,
          textDirection: TextDirection.ltr,
          textScaler: MediaQuery.textScalerOf(context),
        )..layout(maxWidth: constraints.maxWidth);
        final overflows = painter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: Text(
                widget.text,
                style: _bodyStyle,
                maxLines:
                    _expanded ? null : _ExpandableText.collapsedLines,
                overflow: _expanded ? null : TextOverflow.ellipsis,
              ),
            ),
            if (overflows)
              InkWell(
                onTap: () => setState(() => _expanded = !_expanded),
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    _expanded ? 'Show less' : 'Read more',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _T.brand,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Platform identity: (asset name, display label, brand accent colour).
class _SocialMeta {
  const _SocialMeta(this.asset, this.label, this.color);
  final String asset;
  final String label;
  final Color color;

  static const Map<int, _SocialMeta> byPlatform = {
    1: _SocialMeta('Instagram', 'Instagram', Color(0xFFE1306C)),
    2: _SocialMeta('Facebook', 'Facebook', Color(0xFF1877F2)),
    3: _SocialMeta('X', 'X', Color(0xFF0F1419)),
    4: _SocialMeta('LinkedIn', 'LinkedIn', Color(0xFF0A66C2)),
    5: _SocialMeta('YouTube', 'YouTube', Color(0xFFFF0000)),
    6: _SocialMeta('GoogleMaps', 'Maps', Color(0xFF1A73E8)),
    7: _SocialMeta('WhatsApp', 'WhatsApp', Color(0xFF25D366)),
  };
}

/// "Find us on" — a tight row of icon-only buttons, each tinted with its
/// platform's own brand colour. Compact: one overline + a single row of marks.
class _SocialLinks extends StatelessWidget {
  const _SocialLinks({required this.businessName, required this.socials});

  final String businessName;
  final List<VendorSocialMedia> socials;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Connect with us',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: _T.ink,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final social in socials) _SocialIcon(social: social),
          ],
        ),
      ],
    );
  }
}

/// A single icon-only platform button — brand-tinted circle holding the logo.
class _SocialIcon extends StatelessWidget {
  const _SocialIcon({required this.social});

  final VendorSocialMedia social;

  @override
  Widget build(BuildContext context) {
    final meta = _SocialMeta.byPlatform[social.platform];
    final asset = meta?.asset ?? 'Link';
    final label = meta?.label ?? social.platformName;
    final accent = meta?.color ?? _T.brand;

    return Semantics(
      button: true,
      label: 'Open $label',
      child: Material(
        color: accent.withValues(alpha: 0.10),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            HapticFeedback.lightImpact();
            launchUrlString(social.url);
          },
          child: SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: Image.asset(
                'assets/icons/social_media_platforms/$asset.png',
                width: 22,
                height: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Skeleton + error
// ---------------------------------------------------------------------------

class _SkeletonView extends StatelessWidget {
  const _SkeletonView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _T.canvas,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Shimmer.fromColors(
              baseColor: const Color(0xFFE7E7EB),
              highlightColor: const Color(0xFFF6F6F8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: _T.heroHeight - _T.cardOverlap,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: _T.margin,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 190,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          height: 76,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        const SizedBox(height: 28),
                        const _Bone(width: 120, height: 18),
                        const SizedBox(height: 12),
                        const _Bone(width: double.infinity, height: 13),
                        const SizedBox(height: 7),
                        const _Bone(width: 240, height: 13),
                        const SizedBox(height: 28),
                        const _Bone(width: 180, height: 20),
                        const SizedBox(height: 16),
                        const _Bone(
                          width: double.infinity,
                          height: 130,
                          radius: 16,
                        ),
                        const SizedBox(height: 14),
                        const _Bone(
                          width: double.infinity,
                          height: 130,
                          radius: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 7),
              child: _RoundIconButton(
                icon: Icons.arrow_back_rounded,
                semanticLabel: 'Back',
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bone extends StatelessWidget {
  const _Bone({this.width, required this.height, this.radius = 7});

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _T.canvas,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 7),
              child: _RoundIconButton(
                icon: Icons.arrow_back_rounded,
                semanticLabel: 'Back',
                flat: true,
                onTap: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(36, 0, 36, 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          color: _T.brand.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.storefront_outlined,
                          size: 40,
                          color: _T.brand,
                        ),
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        "This store isn't loading",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: _T.ink,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: _T.inkMid,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 26),
                      FilledButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          onRetry();
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: _T.ink,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(160, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        child: const Text('Try again'),
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
}
