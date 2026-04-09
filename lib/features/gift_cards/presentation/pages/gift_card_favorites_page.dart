import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/injection/injection.dart';

import '../../data/services/gift_card_favorites_service.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../bloc/gift_cards_bloc.dart';
import '../theme/gc_tokens.dart';
import '../widgets/gc_empty_state.dart';
import '../widgets/gc_palette_extractor.dart';
import '../widgets/gc_skeleton.dart';

class GiftCardFavoritesPage extends StatelessWidget {
  const GiftCardFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<GiftCardsBloc>()..add(const LoadGiftCardProducts()),
      child: const _FavoritesView(),
    );
  }
}

class _FavoritesView extends StatefulWidget {
  const _FavoritesView();

  @override
  State<_FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<_FavoritesView> {
  final GiftCardFavoritesService _favorites =
      getIt<GiftCardFavoritesService>();

  @override
  void initState() {
    super.initState();
    _favorites.addListener(_onChanged);
  }

  @override
  void dispose() {
    _favorites.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<GiftCardsBloc, GiftCardsState>(
        buildWhen: (_, s) =>
            s is GiftCardProductsLoaded ||
            s is GiftCardProductsLoading ||
            s is GiftCardProductsError,
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              ..._buildContent(state),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 150,
      backgroundColor: Colors.transparent,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: const IconThemeData(color: GcTokens.textPrimary),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: GcTokens.textPrimary,
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
                        'Your saved gift cards',
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
                      fontWeight:
                          t > 0.5 ? FontWeight.w800 : FontWeight.w700,
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

  List<Widget> _buildContent(GiftCardsState state) {
    if (state is GiftCardProductsLoading) {
      return const [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 12),
            child: GcListSkeleton(),
          ),
        ),
      ];
    }
    if (state is GiftCardProductsError) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: GcEmptyState(
            icon: Icons.error_outline_rounded,
            title: 'Could not load favorites',
            message: state.message,
            actionLabel: 'Retry',
            onAction: () => context
                .read<GiftCardsBloc>()
                .add(const LoadGiftCardProducts()),
          ),
        ),
      ];
    }
    if (state is GiftCardProductsLoaded) {
      final favs = state.products
          .where((p) => _favorites.isFavorite(p.id))
          .toList();
      if (favs.isEmpty) {
        return _buildEmptySlivers();
      }
      return _buildBodySlivers(favs);
    }
    return const [];
  }

  List<Widget> _buildEmptySlivers() {
    return [
      SliverToBoxAdapter(
        child: Column(
          children: [
            const SizedBox(height: 12),
            _buildHero(0),
            const SizedBox(height: 12),
        Center(
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: Colors.redAccent.withValues(alpha: 0.06),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.redAccent.withValues(alpha: 0.20),
              ),
            ),
            child: const Icon(
              Icons.favorite_border_rounded,
              size: 44,
              color: Colors.redAccent,
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Center(
          child: Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: GcTokens.textPrimary,
            ),
          ),
        ),
        const SizedBox(height: 6),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            'Tap the heart on any gift card to save it here for quick access.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: GcTokens.textTertiary,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 22),
        Center(
          child: ElevatedButton.icon(
            onPressed: () => Navigator.pushReplacementNamed(
              context,
              '/gift-cards',
            ),
            icon: const Icon(
              Icons.search_rounded,
              size: 16,
              color: Colors.redAccent,
            ),
            label: const Text(
              'Browse gift cards',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: GcTokens.textPrimary,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: GcTokens.textPrimary,
              elevation: 0,
              shadowColor: Colors.redAccent.withValues(alpha: 0.18),
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 14,
              ),
              side: BorderSide(
                color: Colors.redAccent.withValues(alpha: 0.35),
                width: 1.4,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GcTokens.rPill),
              ),
            ),
          ),
        ),
          ],
        ),
      ),
    ];
  }

  List<Widget> _buildBodySlivers(List<GiftCardProductEntity> favs) {
    final discounted = favs.where((p) => p.hasDiscount).length;
    return [
        SliverToBoxAdapter(
          child: _buildHero(favs.length, discounted: discounted),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 8),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                const Text(
                  'YOUR LIST',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: GcTokens.textTertiary,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Divider(color: Color(0xFFEFEAFB), height: 1),
                ),
              ],
            ),
          ),
        ),
        SliverList.separated(
          itemCount: favs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) => _FavoriteTile(
            product: favs[i],
            favorites: _favorites,
            onTap: () => Navigator.pushNamed(
              context,
              '/gift-card-detail',
              arguments: favs[i],
            ),
          ),
        ),
    ];
  }

  Widget _buildHero(int count, {int discounted = 0}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
      child: AspectRatio(
        aspectRatio: 2.05,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Colors.redAccent.withValues(alpha: 0.18),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.redAccent.withValues(alpha: 0.10),
                offset: const Offset(0, 14),
                blurRadius: 28,
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Soft red glow top-right
              Positioned(
                right: -70,
                top: -70,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.redAccent.withValues(alpha: 0.22),
                        Colors.redAccent.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              // Soft pink glow bottom-left
              Positioned(
                left: -60,
                bottom: -80,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFFF8A8A).withValues(alpha: 0.18),
                        const Color(0xFFFF8A8A).withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              // Hearts pattern overlay (faint)
              Positioned.fill(
                child: CustomPaint(painter: _HeartsPatternPainter()),
              ),
              // Big heart icon top-right
              Positioned(
                right: 22,
                top: 22,
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.redAccent.withValues(alpha: 0.30),
                    ),
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.redAccent,
                    size: 24,
                  ),
                ),
              ),
              // Value block bottom-left
              Positioned(
                left: 22,
                bottom: 18,
                right: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WISHLIST',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.6,
                        color: Colors.redAccent.withValues(alpha: 0.95),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          count.toString(),
                          style: const TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.w900,
                            color: GcTokens.textPrimary,
                            height: 1.0,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            count == 1 ? 'card saved' : 'cards saved',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: GcTokens.textTertiary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (discounted > 0) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF059669)
                              .withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$discounted ON SALE',
                          style: const TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF059669),
                            letterSpacing: 0.8,
                          ),
                        ),
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
}

/// Rich, full-width tile for a favorite gift card.
class _FavoriteTile extends StatelessWidget {
  const _FavoriteTile({
    required this.product,
    required this.favorites,
    required this.onTap,
  });

  final GiftCardProductEntity product;
  final GiftCardFavoritesService favorites;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hasImg = product.imageUrl != null && product.imageUrl!.isNotEmpty;
    final base = product.minPrice;
    final payable = product.calculatePayable(base);
    final currency = product.currencySymbol ?? '\u20B9';

    return GcPaletteExtractor(
      imageUrl: product.imageUrl,
      fallback: GcTokens.accentFor(product.id),
      builder: (context, brand) {
        final tintWell = Color.lerp(brand, Colors.white, 0.85)!;
        final ink = Color.lerp(brand, Colors.black, 0.55)!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(18),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: brand.withValues(alpha: 0.20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: brand.withValues(alpha: 0.10),
                      offset: const Offset(0, 10),
                      blurRadius: 20,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    // Brand image well
                    Container(
                      width: 110,
                      decoration: BoxDecoration(
                        color: tintWell,
                        border: Border(
                          right: BorderSide(
                            color: brand.withValues(alpha: 0.18),
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: hasImg
                          ? CachedNetworkImage(
                              imageUrl: product.imageUrl!,
                              fit: BoxFit.contain,
                              errorWidget: (_, __, ___) => Icon(
                                Icons.card_giftcard_rounded,
                                color: ink,
                                size: 32,
                              ),
                            )
                          : Icon(
                              Icons.card_giftcard_rounded,
                              color: ink,
                              size: 32,
                            ),
                    ),
                    // Info
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    product.brandName ?? product.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w900,
                                      color: GcTokens.textPrimary,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => favorites.toggle(product.id),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent
                                          .withValues(alpha: 0.10),
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.favorite_rounded,
                                      size: 16,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (product.offerDescription != null &&
                                product.offerDescription!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  product.offerDescription!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: ink.withValues(alpha: 0.65),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (product.hasDiscount) ...[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      '$currency${base.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: GcTokens.textTertiary,
                                        decoration:
                                            TextDecoration.lineThrough,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                ],
                                Text(
                                  '$currency${payable.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: ink,
                                    height: 1.0,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                                const Spacer(),
                                if (product.hasDiscount)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF059669)
                                          .withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'SAVE ${product.discountPercentage!.toStringAsFixed(0)}%',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF059669),
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeartsPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.redAccent.withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;
    const spacing = 32.0;
    const radius = 3.0;
    for (var y = -spacing; y < size.height + spacing; y += spacing) {
      for (var x = -spacing; x < size.width + spacing; x += spacing) {
        final offsetX = (y / spacing).floor().isEven ? spacing / 2 : 0.0;
        canvas.drawCircle(Offset(x + offsetX, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
