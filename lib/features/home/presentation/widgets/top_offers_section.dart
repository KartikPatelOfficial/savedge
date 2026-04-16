import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:savedge/core/constants/categories_constants.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_event.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_state.dart';

/// Top offers section showing top vendors from API
class TopOffersSection extends StatefulWidget {
  const TopOffersSection({
    super.key,
    this.title = 'Top Offers',
    this.onVendorTap,
    this.cityId,
  });

  final String title;
  final Function(Vendor)? onVendorTap;
  final int? cityId;

  @override
  State<TopOffersSection> createState() => _TopOffersSectionState();
}

class _TopOffersSectionState extends State<TopOffersSection> {
  late final VendorsBloc _topOffersBloc;

  @override
  void initState() {
    super.initState();
    // Use a dedicated bloc so regular vendor loads don't overwrite top offers
    // Don't filter by city - show all featured vendors regardless of location
    _topOffersBloc = getIt<VendorsBloc>()..add(const LoadTopOfferVendors());
  }

  @override
  void didUpdateWidget(TopOffersSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.key != widget.key) {
      _topOffersBloc.add(const LoadTopOfferVendors());
    }
  }

  @override
  void dispose() {
    _topOffersBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _topOffersBloc,
      child: TopOffersView(
        title: widget.title,
        onVendorTap: widget.onVendorTap,
      ),
    );
  }
}

/// Top offers view - image background cards with content overlay
class TopOffersView extends StatelessWidget {
  const TopOffersView({super.key, required this.title, this.onVendorTap});

  final String title;
  final Function(Vendor)? onVendorTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A202C),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B35),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'HOT',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // List
          BlocBuilder<VendorsBloc, VendorsState>(
            builder: (context, state) {
              if (state is VendorsLoading) {
                return _buildLoadingList();
              } else if (state is VendorsError) {
                return _buildErrorState(state.message);
              } else if (state is VendorsLoaded) {
                return _buildList(state.vendors);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<Vendor> vendors) {
    if (vendors.isEmpty) return _buildEmptyState();

    return Column(
      children: List.generate(vendors.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 24, right: 24),
          child: _TopVendorCard(
            vendor: vendors[index],
            onTap: () => onVendorTap?.call(vendors[index]),
          ),
        );
      }),
    );
  }

  Widget _buildLoadingList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: List.generate(
          3,
          (i) => _ShimmerCard(delay: Duration(milliseconds: i * 80)),
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFED7D7)),
      ),
      child: const Row(
        children: [
          Text(
            'Could not load offers',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE53E3E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F4FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9D8FD)),
      ),
      child: const Row(
        children: [
          Text('🏪', style: TextStyle(fontSize: 24)),
          SizedBox(width: 12),
          Text(
            'No offers right now - check back soon!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6F3FCC),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Premium offer card with gradient border & embossed effects ─────────────

class _TopVendorCard extends StatelessWidget {
  const _TopVendorCard({required this.vendor, this.onTap});

  final Vendor vendor;
  final VoidCallback? onTap;

  // Premium gradient border color pairs
  static const _accentColors = [
    [Color(0xFF7C3AED), Color(0xFFA78BFA)], // Violet
    [Color(0xFF0EA5E9), Color(0xFF67E8F9)], // Sky
    [Color(0xFFEC4899), Color(0xFFF9A8D4)], // Pink
    [Color(0xFFF59E0B), Color(0xFFFCD34D)], // Amber
    [Color(0xFF10B981), Color(0xFF6EE7B7)], // Emerald
    [Color(0xFFEF4444), Color(0xFFFCA5A5)], // Rose
  ];

  List<Color> get _accent => _accentColors[vendor.id % _accentColors.length];

  String get _locationText {
    final parts = [
      vendor.city,
      vendor.state,
    ].where((s) => s != null && s.isNotEmpty).toList();
    return parts.isNotEmpty ? parts.join(', ') : '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // Gradient border via outer container
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _accent[0].withOpacity(0.5),
              _accent[1].withOpacity(0.3),
              _accent[0].withOpacity(0.15),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: _accent[0].withOpacity(0.12),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(1.5), // Border width
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.5),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // Vendor logo / image
                _buildVendorImage(),
                const SizedBox(width: 16),
                // Vendor info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Category pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _accent[0].withOpacity(0.12),
                              _accent[1].withOpacity(0.08),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          vendor.category,
                          style: TextStyle(
                            color: _accent[0],
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Vendor name with embossed effect
                      Text(
                        vendor.businessName,
                        style: TextStyle(
                          color: const Color(0xFF1A202C),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.3,
                          shadows: [
                            Shadow(
                              color: _accent[0].withOpacity(0.08),
                              blurRadius: 0,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Description text
                      if (vendor.description != null &&
                          vendor.description!.isNotEmpty)
                        Text(
                          vendor.description!,
                          style: TextStyle(
                            color: _accent[0],
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (_locationText.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.place_rounded,
                              size: 13,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(width: 3),
                            Flexible(
                              child: Text(
                                _locationText,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Arrow button
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _accent,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _accent[0].withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVendorImage() {
    final primaryImage = vendor.images.firstWhere(
      (img) => img.isPrimary,
      orElse: () => vendor.images.isNotEmpty
          ? vendor.images[0]
          : VendorImage(
              id: 0,
              imageUrl: '',
              displayOrder: 0,
              isPrimary: false,
              imageType: 'unknown',
              imageTypeName: 'Unknown',
            ),
    );

    return Container(
      width: 82,
      height: 82,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A202C),
            const Color(0xFF2D3748),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: primaryImage.imageUrl.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: primaryImage.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => primaryImage.blurHash != null
                    ? BlurHash(hash: primaryImage.blurHash!)
                    : Container(color: const Color(0xFF1A202C)),
                errorWidget: (_, __, ___) => _buildFallbackIcon(),
              )
            : _buildFallbackIcon(),
      ),
    );
  }

  Widget _buildFallbackIcon() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A202C),
            const Color(0xFF374151),
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              CategoriesConstants.getCategoryIcon(vendor.category),
              width: 32,
              height: 32,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Icon(
                Icons.store_rounded,
                color: _accent[0],
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Shimmer card placeholder ─────────────────────────────────────────────────

class _ShimmerCard extends StatefulWidget {
  const _ShimmerCard({required this.delay});

  final Duration delay;

  @override
  State<_ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<_ShimmerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        final base = Color.lerp(
          const Color(0xFFEDE9FE),
          const Color(0xFFDDD6FE),
          _anim.value,
        )!;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              color: base,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFDDD6FE).withOpacity(0.5),
              ),
            ),
          ),
        );
      },
    );
  }
}
