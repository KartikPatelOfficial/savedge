import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  });

  final String title;
  final Function(Vendor)? onVendorTap;

  @override
  State<TopOffersSection> createState() => _TopOffersSectionState();
}

class _TopOffersSectionState extends State<TopOffersSection> {
  bool _dispatched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final existingBloc = context.read<VendorsBloc?>();
    if (existingBloc != null && !_dispatched) {
      existingBloc.add(const LoadTopOfferVendors());
      _dispatched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vendorsBloc = context.read<VendorsBloc?>();
    if (vendorsBloc == null) {
      return BlocProvider(
        create: (context) =>
            getIt<VendorsBloc>()..add(const LoadTopOfferVendors()),
        child: TopOffersView(
          title: widget.title,
          onVendorTap: widget.onVendorTap,
        ),
      );
    }
    return TopOffersView(title: widget.title, onVendorTap: widget.onVendorTap);
  }
}

/// Top offers view — image background cards with content overlay
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
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF6F3FCC), Color(0xFF9F6BFF)],
                  ).createShader(bounds),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
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
    final items = vendors.take(5).toList();

    return Column(
      children: List.generate(items.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 24, right: 24),
          child: _TopVendorCard(
            vendor: items[index],
            onTap: () => onVendorTap?.call(items[index]),
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
            'No offers right now — check back soon!',
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

// ─── Image background card ──────────────────────────────────────────────────

class _TopVendorCard extends StatelessWidget {
  const _TopVendorCard({required this.vendor, this.onTap});

  final Vendor vendor;
  final VoidCallback? onTap;

  static const _gradients = [
    [Color(0xFF6F3FCC), Color(0xFF9F7AEA)],
    [Color(0xFF38B2AC), Color(0xFF4FD1C7)],
    [Color(0xFFED8936), Color(0xFFF56500)],
    [Color(0xFFE53E3E), Color(0xFFF56565)],
    [Color(0xFF3182CE), Color(0xFF63B3ED)],
    [Color(0xFF38A169), Color(0xFF68D391)],
  ];

  String get _locationText {
    final parts = [
      vendor.city,
      vendor.state,
    ].where((s) => s != null && s.isNotEmpty).toList();
    return parts.isNotEmpty ? parts.join(', ') : '';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              _buildBackgroundImage(),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Left content
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Category badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6F3FCC),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              vendor.category,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Vendor name
                          Text(
                            vendor.businessName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          // Description or location
                          Text(
                            vendor.description ?? _locationText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 1,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // Location badge
                          if (_locationText.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.place_outlined,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      _locationText,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Right content - Category icon and arrow
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Category icon
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              CategoriesConstants.getCategoryIcon(
                                vendor.category,
                              ),
                              width: 48,
                              height: 48,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.store,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Arrow indicator
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
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

  Widget _buildBackgroundImage() {
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

    if (primaryImage.imageUrl.isNotEmpty) {
      return Positioned.fill(
        child: Image.network(
          primaryImage.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildDefaultBackground(),
        ),
      );
    } else {
      return _buildDefaultBackground();
    }
  }

  Widget _buildDefaultBackground() {
    final colors = _gradients[vendor.id % _gradients.length];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
        ],
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
            height: 200,
            decoration: BoxDecoration(
              color: base,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      },
    );
  }
}
