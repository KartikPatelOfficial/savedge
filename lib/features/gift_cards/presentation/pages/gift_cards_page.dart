import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../../data/services/gift_card_favorites_service.dart';
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
import '../widgets/gc_sort_filter_sheet.dart';
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
        ..add(const LoadGiftCardProducts()),
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

  GiftCardCategoryEntity? _selectedCategory;
  GcQuickFilter? _quickFilter;
  GcSort _sort = GcSort.relevance;
  double _minDiscount = 0;

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
        case GcQuickFilter.topBrands:
          list = list.where((p) => p.hasDiscount);
          break;
        case GcQuickFilter.save20:
          list = list.where(
            (p) => (p.discountPercentage ?? 0) >= 20,
          );
          break;
        case GcQuickFilter.save30:
          list = list.where(
            (p) => (p.discountPercentage ?? 0) >= 30,
          );
          break;
        case GcQuickFilter.trending:
          list = list.where((p) => p.hasDiscount);
          break;
      }
    }

    if (_minDiscount > 0) {
      list = list.where(
        (p) => (p.discountPercentage ?? 0) >= _minDiscount,
      );
    }

    final out = list.toList();
    switch (_sort) {
      case GcSort.relevance:
        break;
      case GcSort.discountDesc:
        out.sort((a, b) =>
            (b.discountPercentage ?? 0).compareTo(a.discountPercentage ?? 0));
        break;
      case GcSort.priceAsc:
        out.sort((a, b) => a.minPrice.compareTo(b.minPrice));
        break;
    }
    return out;
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

  Future<void> _openSortSheet() async {
    final result = await GcSortFilterSheet.show(
      context,
      sort: _sort,
      minDiscount: _minDiscount,
    );
    if (result != null) {
      setState(() {
        _sort = result.sort;
        _minDiscount = result.minDiscount;
      });
    }
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
                    const SliverToBoxAdapter(
                      child: GcSectionHeader(
                        title: 'Newly added brands',
                        subtitle: 'Fresh on SavEdge',
                      ),
                    ),
                    SliverToBoxAdapter(child: _buildNewlyAdded()),
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
      pinned: true,
      backgroundColor: GcTokens.background,
      surfaceTintColor: GcTokens.background,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarHeight: 64,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            size: 18, color: GcTokens.textPrimary),
      ),
      titleSpacing: 0,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gift Vouchers',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: GcTokens.textPrimary,
            ),
          ),
          Text(
            'Save on every brand you love',
            style: TextStyle(
              fontSize: 11,
              color: GcTokens.textTertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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
                      onTap: () {},
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
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/gift-card-orders'),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFEFEAFB)),
              ),
              child: const Icon(
                Icons.receipt_long_rounded,
                size: 18,
                color: GcTokens.textPrimary,
              ),
            ),
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

  Widget _buildNewlyAdded() {
    if (_loadingProducts) {
      return const SizedBox(
        height: 130,
        child: GcListSkeleton(count: 1),
      );
    }
    if (_products.isEmpty) return const SizedBox.shrink();
    final items = _products.take(8).toList();
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final p = items[i];
          return SizedBox(
            width: 150,
            child: GiftCardProductCard(
              product: p,
              favorites: _favorites,
              onTap: () => _openDetail(p),
            ),
          );
        },
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
              _minDiscount = 0;
              _sort = GcSort.relevance;
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
          color: const Color(0xFF1A1124),
          borderRadius: BorderRadius.circular(GcTokens.rPill),
          elevation: 8,
          shadowColor: Colors.black54,
          child: InkWell(
            borderRadius: BorderRadius.circular(GcTokens.rPill),
            onTap: _openSortSheet,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.swap_vert_rounded,
                      size: 18, color: Colors.white),
                  const SizedBox(width: 6),
                  Text(
                    _sort == GcSort.relevance
                        ? 'Relevance'
                        : (_sort == GcSort.discountDesc
                            ? 'Discount'
                            : 'Price'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    width: 1,
                    height: 14,
                    color: Colors.white24,
                  ),
                  const Icon(Icons.tune_rounded,
                      size: 18, color: Colors.white),
                  const SizedBox(width: 6),
                  const Text(
                    'Filters',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
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
