import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../../data/services/gift_card_favorites_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entities/gift_card_entity.dart';
import '../bloc/gift_cards_bloc.dart';
import '../theme/gc_tokens.dart';
import '../widgets/gc_category_grid.dart';
import '../widgets/gc_empty_state.dart';
import '../widgets/gc_hero_carousel.dart';
import '../widgets/gc_quick_filter_chips.dart';
import '../widgets/gc_search_bar.dart';
import '../widgets/gc_section_header.dart';
import '../widgets/gc_skeleton.dart';
import '../widgets/gc_palette_extractor.dart';
import '../widgets/gc_trending_brand_tile.dart';
import '../widgets/gift_card_product_card.dart';

class GiftCardsPage extends StatelessWidget {
  const GiftCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GiftCardsBloc>()
        ..add(const LoadGiftCardCategories())
        ..add(const LoadHotDeals())
        ..add(const LoadGiftCardProducts())
        ..add(const LoadGiftCardOrders(pageSize: 10)),
      child: const _GiftCardsView(),
    );
  }
}

class _GiftCardsView extends StatefulWidget {
  const _GiftCardsView();

  @override
  State<_GiftCardsView> createState() => _GiftCardsViewState();
}

class _GiftCardsViewState extends State<_GiftCardsView> {
  final _searchController = TextEditingController();
  final _favorites = getIt<GiftCardFavoritesService>();

  List<GiftCardCategoryEntity> _categories = [];
  List<GiftCardProductEntity> _products = [];
  List<GiftCardProductEntity> _hotDeals = [];
  List<GiftCardOrderEntity> _myOrders = [];

  GiftCardCategoryEntity? _selectedCategory;
  GcQuickFilter? _quickFilter;

  bool _loadingCategories = true;
  bool _loadingProducts = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ── Filtering / sorting ───────────────────────────────────────────────

  List<GiftCardProductEntity> get _filteredProducts {
    Iterable<GiftCardProductEntity> list = _products;

    if (_quickFilter != null) {
      switch (_quickFilter!) {
        case GcQuickFilter.onSale:
          list = list.where((p) => p.hasDiscount);
          break;
        case GcQuickFilter.under500:
          list = list.where((p) => p.minPrice < 500);
          break;
        case GcQuickFilter.from500to2000:
          list = list.where(
            (p) => p.minPrice >= 500 && p.minPrice <= 2000,
          );
          break;
        case GcQuickFilter.above2000:
          list = list.where((p) => p.minPrice > 2000);
          break;
        case GcQuickFilter.bigSaver:
          list = list.where((p) => (p.discountPercentage ?? 0) >= 10);
          break;
      }
    }

    return list.toList();
  }

  void _onSearchSubmitted(String value) {
    context
        .read<GiftCardsBloc>()
        .add(LoadGiftCardProducts(
          searchTerm: value.trim().isEmpty ? null : value.trim(),
          categoryId: _selectedCategory?.id,
        ));
  }

  void _onCategorySelected(GiftCardCategoryEntity? category) {
    setState(() => _selectedCategory = category);
    context
        .read<GiftCardsBloc>()
        .add(LoadGiftCardProducts(categoryId: category?.id));
  }

  void _openDetail(GiftCardProductEntity p) {
    Navigator.pushNamed(context, '/gift-card-detail', arguments: p);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GcTokens.background,
      body: SafeArea(
        bottom: false,
        child: MultiBlocListener(
          listeners: [
            BlocListener<GiftCardsBloc, GiftCardsState>(
              listenWhen: (_, s) =>
                  s is GiftCardCategoriesLoaded ||
                  s is GiftCardCategoriesError,
              listener: (_, s) {
                if (s is GiftCardCategoriesLoaded) {
                  setState(() {
                    _categories = s.categories;
                    _loadingCategories = false;
                  });
                } else if (s is GiftCardCategoriesError) {
                  setState(() => _loadingCategories = false);
                }
              },
            ),
            BlocListener<GiftCardsBloc, GiftCardsState>(
              listenWhen: (_, s) => s is HotDealsLoaded,
              listener: (_, s) {
                if (s is HotDealsLoaded) {
                  setState(() => _hotDeals = s.hotDeals);
                }
              },
            ),
            BlocListener<GiftCardsBloc, GiftCardsState>(
              listenWhen: (_, s) => s is GiftCardOrdersLoaded,
              listener: (_, s) {
                if (s is GiftCardOrdersLoaded) {
                  setState(() => _myOrders = s.orders);
                }
              },
            ),
            BlocListener<GiftCardsBloc, GiftCardsState>(
              listenWhen: (_, s) =>
                  s is GiftCardProductsLoaded ||
                  s is GiftCardProductsLoading ||
                  s is GiftCardProductsError,
              listener: (_, s) {
                if (s is GiftCardProductsLoading) {
                  setState(() => _loadingProducts = true);
                } else if (s is GiftCardProductsLoaded) {
                  setState(() {
                    _products = s.products;
                    _loadingProducts = false;
                  });
                } else if (s is GiftCardProductsError) {
                  setState(() => _loadingProducts = false);
                }
              },
            ),
          ],
          child: Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<GiftCardsBloc>()
                      .add(const LoadGiftCardCategories());
                  context.read<GiftCardsBloc>().add(const LoadHotDeals());
                  context
                      .read<GiftCardsBloc>()
                      .add(LoadGiftCardProducts(
                        categoryId: _selectedCategory?.id,
                        searchTerm: _searchController.text.trim().isEmpty
                            ? null
                            : _searchController.text.trim(),
                      ));
                },
                color: GcTokens.primary,
                child: CustomScrollView(
                  slivers: [
                    _buildAppBar(),
                    SliverToBoxAdapter(child: _buildSearchBar()),
                    SliverToBoxAdapter(child: const SizedBox(height: 18)),
                    SliverToBoxAdapter(child: _buildHero()),
                    const SliverToBoxAdapter(
                      child: GcSectionHeader(
                        title: 'Deal by category',
                        subtitle: 'Pick a category to start saving',
                      ),
                    ),
                    SliverToBoxAdapter(child: _buildCategoryGrid()),
                    if (_myOrders.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: GcSectionHeader(
                          title: 'My cards',
                          subtitle: 'Your latest gift card purchases',
                          actionLabel: 'View all',
                          onAction: () => Navigator.pushNamed(
                            context,
                            '/gift-card-orders',
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(child: _buildMyCards()),
                    ],
                    SliverToBoxAdapter(child: const SizedBox(height: 18)),
                    SliverToBoxAdapter(child: _buildQuickFilters()),
                    SliverToBoxAdapter(
                      child: GcSectionHeader(
                        title: _selectedCategory != null
                            ? _selectedCategory!.name
                            : 'Save big on top brands',
                        subtitle: '${_filteredProducts.length} vouchers available',
                      ),
                    ),
                    _buildProductGridSliver(),
                    SliverToBoxAdapter(
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(18, 22, 18, 8),
                        child: Text(
                          'Trending now',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: GcTokens.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    _buildTrendingSliver(),
                    const SliverToBoxAdapter(child: SizedBox(height: 110)),
                  ],
                ),
              ),
              _buildFloatingFilterPill(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Sections ───────────────────────────────────────────────────────────

  Widget _buildAppBar() {
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
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            size: 18, color: GcTokens.textPrimary),
      ),
      titleSpacing: 0,
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
                        'Save on every brand you love',
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
                    'Gift Vouchers',
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: AnimatedBuilder(
            animation: _favorites,
            builder: (_, __) {
              final count = _favorites.count;
              return Stack(
                children: [
                  Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 0,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/gift-card-favorites',
                      ),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: const Color(0xFFEFEAFB)),
                        ),
                        child: const Icon(
                          Icons.favorite_border_rounded,
                          size: 18,
                          color: GcTokens.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  if (count > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GcSearchBar(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        onSubmitted: _onSearchSubmitted,
      ),
    );
  }

  Widget _buildHero() {
    if (_hotDeals.isEmpty) {
      return const GcHeroSkeleton();
    }
    return GcHeroCarousel(items: _hotDeals.take(5).toList(), onTap: _openDetail);
  }

  Widget _buildCategoryGrid() {
    if (_loadingCategories) return const GcCategoryGridSkeleton();
    if (_categories.isEmpty) return const SizedBox.shrink();
    return GcCategoryGrid(
      categories: _categories,
      selectedId: _selectedCategory?.id,
      onSelect: _onCategorySelected,
    );
  }

  Widget _buildMyCards() {
    final items = _myOrders.take(5).toList();
    return SizedBox(
      height: 116,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => _MyCardTile(
          order: items[i],
          onTap: () {
            if (items[i].hasCardDetails) {
              Navigator.pushNamed(
                context,
                '/gift-card-view',
                arguments: items[i],
              );
            } else {
              Navigator.pushNamed(context, '/gift-card-orders');
            }
          },
        ),
      ),
    );
  }

  Widget _buildQuickFilters() {
    return GcQuickFilterChips(
      selected: _quickFilter,
      onChanged: (v) => setState(() => _quickFilter = v),
    );
  }

  Widget _buildProductGridSliver() {
    if (_loadingProducts) {
      return const SliverToBoxAdapter(child: GcProductGridSkeleton());
    }
    final items = _filteredProducts;
    if (items.isEmpty) {
      return SliverToBoxAdapter(
        child: GcEmptyState(
          icon: Icons.search_off_rounded,
          title: 'No vouchers found',
          message: 'Try a different category, search term, or filter.',
          actionLabel: 'Reset filters',
          onAction: () {
            setState(() {
              _quickFilter = null;
              _selectedCategory = null;
              _searchController.clear();
            });
            context
                .read<GiftCardsBloc>()
                .add(const LoadGiftCardProducts());
          },
        ),
      );
    }
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.92,
        ),
        delegate: SliverChildBuilderDelegate(
          (_, i) {
            final p = items[i];
            return GiftCardProductCard(
              product: p,
              favorites: _favorites,
              onTap: () => _openDetail(p),
            );
          },
          childCount: items.length,
        ),
      ),
    );
  }

  Widget _buildTrendingSliver() {
    if (_loadingProducts) {
      return const SliverToBoxAdapter(child: GcListSkeleton());
    }
    final trending = _filteredProducts
        .where((p) => p.hasDiscount)
        .toList()
      ..sort((a, b) =>
          (b.discountPercentage ?? 0).compareTo(a.discountPercentage ?? 0));
    if (trending.isEmpty) return const SliverToBoxAdapter();
    final items = trending.take(5).toList();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final p = items[i];
          return GcTrendingBrandTile(product: p, onTap: () => _openDetail(p));
        },
      ),
    );
  }

  Widget _buildFloatingFilterPill() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 22,
      child: Center(
        child: Material(
          color: GcTokens.brandBlack,
          borderRadius: BorderRadius.circular(GcTokens.rPill),
          elevation: 10,
          shadowColor: Colors.black.withValues(alpha: 0.4),
          child: InkWell(
            borderRadius: BorderRadius.circular(GcTokens.rPill),
            onTap: () =>
                Navigator.pushNamed(context, '/gift-card-orders'),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 14,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    size: 17,
                    color: GcTokens.brandLime,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'My cards',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: GcTokens.brandLime,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Light, voucher-style "my card" tile shown in the horizontal rail.
/// Different from the hero (which is a full brand card) and different from
/// the orders-list ticket (which is a full-width perforated pass).
class _MyCardTile extends StatelessWidget {
  const _MyCardTile({required this.order, required this.onTap});

  final GiftCardOrderEntity order;
  final VoidCallback onTap;

  Color get _statusColor {
    switch (order.status) {
      case GiftCardOrderStatusEntity.completed:
        return GcTokens.success;
      case GiftCardOrderStatusEntity.failed:
      case GiftCardOrderStatusEntity.cancelled:
        return GcTokens.danger;
      case GiftCardOrderStatusEntity.refunded:
        return Colors.blueGrey;
      default:
        return GcTokens.warning;
    }
  }

  String get _statusLabel {
    switch (order.status) {
      case GiftCardOrderStatusEntity.completed:
        return 'ACTIVE';
      case GiftCardOrderStatusEntity.failed:
        return 'FAILED';
      case GiftCardOrderStatusEntity.cancelled:
        return 'CANCELLED';
      case GiftCardOrderStatusEntity.refunded:
        return 'REFUNDED';
      case GiftCardOrderStatusEntity.pending:
        return 'PENDING';
      case GiftCardOrderStatusEntity.paymentCompleted:
        return 'PROCESSING';
      case GiftCardOrderStatusEntity.issuing:
        return 'ISSUING';
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasImg =
        order.productImageUrl != null && order.productImageUrl!.isNotEmpty;

    return GcPaletteExtractor(
      imageUrl: order.productImageUrl,
      fallback: GcTokens.accentFor(order.giftCardProductId),
      builder: (context, brand) {
        final tintWell = Color.lerp(brand, Colors.white, 0.85)!;
        final ink = Color.lerp(brand, Colors.black, 0.55)!;
        return GestureDetector(
          onTap: onTap,
          child: Container(
            width: 256,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: brand.withValues(alpha: 0.20),
              ),
              boxShadow: [
                BoxShadow(
                  color: brand.withValues(alpha: 0.10),
                  offset: const Offset(0, 8),
                  blurRadius: 16,
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Brand image well
                Container(
                  width: 88,
                  decoration: BoxDecoration(
                    color: tintWell,
                    border: Border(
                      right: BorderSide(
                        color: brand.withValues(alpha: 0.18),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: hasImg
                      ? CachedNetworkImage(
                          imageUrl: order.productImageUrl!,
                          fit: BoxFit.contain,
                          errorWidget: (_, __, ___) =>
                              Icon(Icons.card_giftcard_rounded, color: ink),
                        )
                      : Icon(Icons.card_giftcard_rounded, color: ink),
                ),
                // Info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w900,
                            color: GcTokens.textPrimary,
                            height: 1.2,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                '\u20B9',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: ink,
                                ),
                              ),
                            ),
                            const SizedBox(width: 1),
                            Text(
                              (order.woohooActivatedAmount ??
                                      order.requestedAmount)
                                  .toStringAsFixed(0),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: ink,
                                height: 1.0,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    _statusColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: _statusColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _statusLabel,
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w900,
                                      color: _statusColor,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '#${order.id}',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w900,
                                color: GcTokens.textTertiary
                                    .withValues(alpha: 0.85),
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
        );
      },
    );
  }
}
