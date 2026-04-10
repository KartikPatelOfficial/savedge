import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:savedge/core/injection/injection.dart';

import '../../../stores/presentation/pages/vendor_detail_page.dart';
import '../../domain/entities/favorite_vendor.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FavoritesBloc>()..add(LoadFavorites()),
      child: const _FavoritesView(),
    );
  }
}

class _FavoritesView extends StatelessWidget {
  const _FavoritesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              _buildSliverAppBar(context),
              if (state is FavoritesLoading)
                const SliverToBoxAdapter(child: _FavoritesSkeleton())
              else if (state is FavoritesLoaded)
                ..._buildLoadedContent(context, state)
              else if (state is FavoritesError)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _ErrorBody(
                    message: state.message,
                    onRetry: () =>
                        context.read<FavoritesBloc>().add(LoadFavorites()),
                  ),
                )
              else
                const SliverToBoxAdapter(child: _FavoritesSkeleton()),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150,
      backgroundColor: Colors.transparent,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: const IconThemeData(color: Color(0xFF1A202C)),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: Color(0xFF1A202C),
        ),
      ),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          const expandedHeight = 150.0;
          final minHeight =
              kToolbarHeight + MediaQuery.of(context).padding.top;
          final t = ((constraints.maxHeight - minHeight) /
                  (expandedHeight - minHeight))
              .clamp(0.0, 1.0);
          final leftPadding = 20.0 + (52.0 * (1 - t));

          return Container(
            decoration: BoxDecoration(
              color: Color.lerp(Colors.white, Colors.transparent, t),
            ),
            child: Stack(
              children: [
                if (t > 0.05)
                  Positioned(
                    bottom: 52,
                    left: 20,
                    child: Opacity(
                      opacity: t.clamp(0.0, 1.0),
                      child: const Text(
                        'Your saved stores',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                  ),
                FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                    left: leftPadding,
                    bottom: 16,
                    right: 20,
                  ),
                  centerTitle: false,
                  title: Text(
                    'Favorites',
                    style: TextStyle(
                      color: const Color(0xFF1A202C),
                      fontSize: t > 0.5 ? 24 : 20,
                      fontWeight: t > 0.5 ? FontWeight.w800 : FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildLoadedContent(
      BuildContext context, FavoritesLoaded state) {
    if (state.favorites.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: _EmptyBody(
            onExplore: () => Navigator.pop(context),
          ),
        ),
      ];
    }

    return [
      // Stats hero banner
      SliverToBoxAdapter(
        child: _HeroBanner(count: state.favorites.length),
      ),

      // Section divider
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 8),
        sliver: SliverToBoxAdapter(
          child: Row(
            children: [
              const Text(
                'YOUR STORES',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: Color(0xFF9CA3AF),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  height: 1,
                  color: const Color(0xFFEFEAFB),
                ),
              ),
            ],
          ),
        ),
      ),

      // Vendor grid — 2 columns of vertical cards
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 14,
            childAspectRatio: 0.72,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final fav = state.favorites[index];
              return _FavoriteVendorCard(
                favorite: fav,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        VendorDetailPage(vendorId: fav.vendorId),
                  ),
                ),
                onRemove: () {
                  HapticFeedback.lightImpact();
                  context
                      .read<FavoritesBloc>()
                      .add(RemoveFromFavorites(fav.vendorId));
                },
              );
            },
            childCount: state.favorites.length,
          ),
        ),
      ),
    ];
  }
}

// ─── Hero Banner ────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
      child: AspectRatio(
        aspectRatio: 2.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFFFCFBFF),
            border: Border.all(
              color: const Color(0xFF6F3FCC).withValues(alpha: 0.10),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6F3FCC).withValues(alpha: 0.10),
                offset: const Offset(0, 12),
                blurRadius: 32,
                spreadRadius: -6,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Aurora blob — top-left, emerald
              Positioned(
                left: -50,
                top: -60,
                child: Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF10B981).withValues(alpha: 0.40),
                        const Color(0xFF10B981).withValues(alpha: 0.10),
                        const Color(0xFF10B981).withValues(alpha: 0.0),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
              ),
              // Aurora blob — center-right, purple
              Positioned(
                right: -40,
                top: -30,
                child: Container(
                  width: 210,
                  height: 210,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF9F7AEA).withValues(alpha: 0.38),
                        const Color(0xFF6F3FCC).withValues(alpha: 0.08),
                        const Color(0xFF6F3FCC).withValues(alpha: 0.0),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
              // Aurora blob — bottom-center, amber/warm
              Positioned(
                left: 50,
                bottom: -65,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFF59E0B).withValues(alpha: 0.30),
                        const Color(0xFFF59E0B).withValues(alpha: 0.06),
                        const Color(0xFFF59E0B).withValues(alpha: 0.0),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),
              // Aurora blob — bottom-right, blue
              Positioned(
                right: 10,
                bottom: -35,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF3B82F6).withValues(alpha: 0.25),
                        const Color(0xFF3B82F6).withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top: small label
                    Text(
                      'Saved collection',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1A202C).withValues(alpha: 0.4),
                        letterSpacing: 0.3,
                      ),
                    ),
                    // Bottom: big count + description
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Count in a frosted pill
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6F3FCC).withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF6F3FCC).withValues(alpha: 0.12),
                            ),
                          ),
                          child: Text(
                            count.toString(),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1A202C),
                              height: 1.0,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  count == 1
                                      ? 'store in your'
                                      : 'stores in your',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF1A202C)
                                        .withValues(alpha: 0.4),
                                    height: 1.3,
                                  ),
                                ),
                                const Text(
                                  'favorites',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1A202C),
                                    height: 1.2,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
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
}

// ─── Vendor Card (vertical, glowing) ────────────────────────

class _FavoriteVendorCard extends StatelessWidget {
  const _FavoriteVendorCard({
    required this.favorite,
    required this.onTap,
    required this.onRemove,
  });

  final FavoriteVendor favorite;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  static const _accents = [
    Color(0xFF6F3FCC), // purple
    Color(0xFFFF6B6B), // red
    Color(0xFF10B981), // emerald
    Color(0xFF3B82F6), // blue
    Color(0xFFEC407A), // pink
    Color(0xFFF59E0B), // amber
    Color(0xFF00BCD4), // cyan
    Color(0xFFAB47BC), // violet
  ];

  Color get _accent => _accents[favorite.vendorId.abs() % _accents.length];

  @override
  Widget build(BuildContext context) {
    final accent = _accent;
    final hasImage = favorite.imageUrl != null && favorite.imageUrl!.isNotEmpty;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFEFEAFB)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                offset: Offset(0, 4),
                blurRadius: 12,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Image area with glow orb ──
              Expanded(
                child: Stack(
                  children: [
                    // Tinted background
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.lerp(accent, Colors.white, 0.82)!,
                              Color.lerp(accent, Colors.white, 0.92)!,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Actual image
                    if (hasImage)
                      Positioned.fill(
                        child: CachedNetworkImage(
                          imageUrl: favorite.imageUrl!,
                          fit: BoxFit.cover,
                          memCacheWidth: 400,
                          placeholder: (_, __) =>
                              favorite.blurHash != null
                                  ? BlurHash(hash: favorite.blurHash!)
                                  : const SizedBox.shrink(),
                          errorWidget: (_, __, ___) =>
                              _InitialsFallback(
                                name: favorite.businessName,
                                color: accent,
                              ),
                        ),
                      )
                    else
                      Positioned.fill(
                        child: _InitialsFallback(
                          name: favorite.businessName,
                          color: accent,
                        ),
                      ),
                    // Heart button (top-right, floating)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => _confirmAndRemove(context),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.10),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.favorite_rounded,
                            size: 16,
                            color: Color(0xFFEF4444),
                          ),
                        ),
                      ),
                    ),
                    // Category pill (bottom-left, overlapping)
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Text(
                          favorite.category,
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: accent,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ── Info area ──
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favorite.businessName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    if (favorite.city != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 12,
                            color: Color(0xFFB0B7C3),
                          ),
                          const SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              favorite.city!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFB0B7C3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmAndRemove(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => _RemoveDialog(name: favorite.businessName),
    );
    if (result == true) onRemove();
  }
}

// ─── Initials Fallback ──────────────────────────────────────

class _InitialsFallback extends StatelessWidget {
  const _InitialsFallback({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final label = name.trim();
    final parts = label.split(RegExp(r'\s+'));
    final initials = parts.length >= 2
        ? '${parts.first[0]}${parts.last[0]}'.toUpperCase()
        : (label.isNotEmpty ? label[0].toUpperCase() : '?');

    return Container(
      color: Color.lerp(color, Colors.white, 0.88),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: color,
        ),
      ),
    );
  }
}

// ─── Remove Confirmation Dialog ─────────────────────────────

class _RemoveDialog extends StatelessWidget {
  const _RemoveDialog({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                color: Color(0xFFEF4444),
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Remove from Favorites?',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Are you sure you want to remove $name?',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF9CA3AF),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEF4444),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Remove',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Empty State ────────────────────────────────────────────

class _EmptyBody extends StatelessWidget {
  const _EmptyBody({required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withValues(alpha: 0.06),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF6F3FCC).withValues(alpha: 0.16),
              ),
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              size: 44,
              color: Color(0xFF6F3FCC),
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap the heart on any store to\nsave it here for quick access.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF9CA3AF),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 28),
          ElevatedButton.icon(
            onPressed: onExplore,
            icon: const Icon(Icons.explore_rounded, size: 16),
            label: const Text(
              'Explore stores',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6F3FCC),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Error State ────────────────────────────────────────────

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.wifi_off_rounded,
              size: 36,
              color: Color(0xFFEF4444),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF9CA3AF),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text(
              'Try again',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF6F3FCC),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              side: const BorderSide(color: Color(0xFF6F3FCC)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Loading Skeleton ───────────────────────────────────────

class _FavoritesSkeleton extends StatelessWidget {
  const _FavoritesSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        children: [
          // Hero banner skeleton
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          const SizedBox(height: 24),
          // Card skeletons
          for (int i = 0; i < 4; i++) ...[
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

