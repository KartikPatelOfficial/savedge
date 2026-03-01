import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

/// Top offers view — compact ranked vertical list
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
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('🔥', style: TextStyle(fontSize: 10)),
                      SizedBox(width: 2),
                      Text(
                        'HOT',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: List.generate(items.length, (index) {
          return _AnimatedOfferCard(
            vendor: items[index],
            rank: index + 1,
            onTap: () => onVendorTap?.call(items[index]),
            delay: Duration(milliseconds: index * 70),
          );
        }),
      ),
    );
  }

  Widget _buildLoadingList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: List.generate(
          4,
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
          Text('😕', style: TextStyle(fontSize: 24)),
          SizedBox(width: 12),
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

// ─── Animated card wrapper ────────────────────────────────────────────────────

class _AnimatedOfferCard extends StatefulWidget {
  const _AnimatedOfferCard({
    required this.vendor,
    required this.rank,
    required this.onTap,
    required this.delay,
  });

  final Vendor vendor;
  final int rank;
  final VoidCallback onTap;
  final Duration delay;

  @override
  State<_AnimatedOfferCard> createState() => _AnimatedOfferCardState();
}

class _AnimatedOfferCardState extends State<_AnimatedOfferCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _opacity = CurvedAnimation(
      parent: _ctrl,
      curve: Curves.easeOut,
    ).drive(Tween(begin: 0.0, end: 1.0));
    _slide = CurvedAnimation(
      parent: _ctrl,
      curve: Curves.easeOutCubic,
    ).drive(Tween(begin: const Offset(0, 0.2), end: Offset.zero));
    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTapDown: (_) => setState(() => _pressed = true),
            onTapUp: (_) {
              setState(() => _pressed = false);
              widget.onTap();
            },
            onTapCancel: () => setState(() => _pressed = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              decoration: BoxDecoration(
                color: _pressed
                    ? const Color(0xFFF3EEFF)
                    : const Color(0xFFFAF8FF),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: _pressed
                      ? const Color(0xFFCDB4F7)
                      : const Color(0xFFEDE8FA),
                  width: 1.2,
                ),
              ),
              child: _VendorCardContent(
                vendor: widget.vendor,
                rank: widget.rank,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Card content ─────────────────────────────────────────────────────────────

class _VendorCardContent extends StatelessWidget {
  const _VendorCardContent({required this.vendor, required this.rank});

  final Vendor vendor;
  final int rank;

  static const _colors = [
    Color(0xFF6F3FCC),
    Color(0xFF0694A2),
    Color(0xFFDD6B20),
    Color(0xFFC53030),
    Color(0xFF2F855A),
    Color(0xFF2C5282),
    Color(0xFF744210),
    Color(0xFF553C9A),
  ];

  Color get _accentColor => _colors[vendor.id % _colors.length];

  String get _rankLabel {
    switch (rank) {
      case 1:
        return '🥇';
      case 2:
        return '🥈';
      case 3:
        return '🥉';
      default:
        return '$rank';
    }
  }

  String get _locationText {
    final parts = [
      vendor.city,
      vendor.state,
    ].where((s) => s != null && s.isNotEmpty).toList();
    return parts.isNotEmpty ? parts.join(', ') : '';
  }

  int get _activeCoupons => vendor.coupons.where((c) => c.isValid).length;

  @override
  Widget build(BuildContext context) {
    final location = _locationText;
    final couponCount = _activeCoupons;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail with rank overlay
          Stack(
            clipBehavior: Clip.none,
            children: [
              _buildThumbnail(),
              Positioned(
                top: -4,
                left: -4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFEDE8FA),
                      width: 1,
                    ),
                  ),
                  child: rank <= 3
                      ? Text(_rankLabel, style: const TextStyle(fontSize: 12))
                      : Text(
                          _rankLabel,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey[500],
                          ),
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          // Info block
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + arrow
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        vendor.businessName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A202C),
                          letterSpacing: -0.2,
                          height: 1.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: _accentColor,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Category + location row
                Row(
                  children: [
                    _Chip(
                      label: vendor.category,
                      color: _accentColor,
                      filled: true,
                    ),
                    if (location.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.place_outlined,
                        size: 12,
                        color: Color(0xFF9CA3AF),
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          location,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                // Description snippet (if available)
                if (vendor.description != null &&
                    vendor.description!.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Text(
                    vendor.description!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                      height: 1.4,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    final image = vendor.images.firstWhere(
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
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDE8FA), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: image.imageUrl.isNotEmpty
            ? Image.network(
                image.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _gradientFallback(),
                loadingBuilder: (_, child, progress) =>
                    progress == null ? child : _gradientFallback(),
              )
            : _gradientFallback(),
      ),
    );
  }

  Widget _gradientFallback() {
    return Container(
      color: _accentColor.withOpacity(0.12),
      child: Center(
        child: Text(
          vendor.businessName.isNotEmpty
              ? vendor.businessName[0].toUpperCase()
              : '?',
          style: TextStyle(
            color: _accentColor,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

// ─── Reusable chip ────────────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.color, this.filled = false});

  final String label;
  final Color color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: filled ? color.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        border: filled
            ? null
            : Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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
        final light = base.withOpacity(0.5);
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF8FF),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFEDE8FA), width: 1.2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: base,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 160,
                        decoration: BoxDecoration(
                          color: base,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 11,
                        width: 100,
                        decoration: BoxDecoration(
                          color: light,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 11,
                        width: 130,
                        decoration: BoxDecoration(
                          color: light,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
