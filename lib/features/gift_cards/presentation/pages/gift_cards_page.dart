import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/core/widgets/login_prompt.dart';
import 'package:savedge/features/gift_cards/data/services/gift_card_favorites_service.dart';
import 'package:savedge/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:savedge/features/gift_cards/presentation/bloc/gift_cards_bloc.dart';
import 'package:savedge/features/gift_cards/presentation/theme/gc_tokens.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_category_grid.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_empty_state.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_hero_carousel.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_palette_extractor.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_quick_filter_chips.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_search_bar.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_section_header.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_skeleton.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_trending_brand_tile.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gift_card_product_card.dart';

class GiftCardsPage extends StatelessWidget {
  const GiftCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GiftCardsBloc>()
        ..add(const LoadGiftCardCategories())
        ..add(const LoadHotDeals())
        ..add(const LoadGiftCardProducts())
        ..add(
          const LoadGiftCardOrders(
            status: GiftCardOrderStatusEntity.completed,
            pageSize: 10,
          ),
        ),
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
  Timer? _searchDebounce;

  List<GiftCardCategoryEntity> _categories = [];
  List<GiftCardProductEntity> _products = [];
  List<GiftCardProductEntity> _hotDeals = [];
  List<GiftCardOrderEntity> _myOrders = [];

  GiftCardCategoryEntity? _selectedCategory;
  GcQuickFilter? _quickFilter;
  String? _activeSearchTerm;

  bool _loadingCategories = true;
  bool _loadingProducts = true;

  // Pagination, mirrored from GiftCardProductsLoaded.
  int _totalCount = 0;
  bool _hasNextPage = false;
  bool _isLoadingMore = false;

  String get _searchTerm => _searchController.text.trim();
  bool get _isSearchMode => _searchTerm.isNotEmpty;

  /// Count shown as "X vouchers available". With no client-side quick filter we
  /// show the backend's catalog total; with a filter active we can only count
  /// the loaded products it actually matched.
  int get _availableCount =>
      _quickFilter != null ? _filteredProducts.length : _totalCount;

  @override
  void dispose() {
    _searchDebounce?.cancel();
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
          list = list.where((p) => p.minPrice >= 500 && p.minPrice <= 2000);
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

  void _loadProducts({String? searchTerm}) {
    final normalizedSearchTerm = searchTerm?.trim();
    final hasSearch =
        normalizedSearchTerm != null && normalizedSearchTerm.isNotEmpty;
    context.read<GiftCardsBloc>().add(
      LoadGiftCardProducts(
        searchTerm: hasSearch ? normalizedSearchTerm : null,
        categoryId: hasSearch ? null : _selectedCategory?.id,
      ),
    );
  }

  void _onSearchSubmitted(String value) {
    final term = value.trim();
    _searchDebounce?.cancel();
    FocusScope.of(context).unfocus();

    if (term.isEmpty) {
      _clearSearch();
      return;
    }

    setState(() {
      _activeSearchTerm = term;
      _selectedCategory = null;
      _quickFilter = null;
      _products = [];
      _loadingProducts = true;
    });
    _loadProducts(searchTerm: term);
  }

  void _onSearchChanged(String value) {
    final term = value.trim();
    _searchDebounce?.cancel();

    if (term.isEmpty) {
      setState(() {
        _activeSearchTerm = null;
        _quickFilter = null;
        _loadingProducts = true;
      });
      _loadProducts();
      return;
    }

    setState(() {
      _activeSearchTerm = term;
      _selectedCategory = null;
      _quickFilter = null;
      _products = [];
      _loadingProducts = true;
    });

    _searchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _loadProducts(searchTerm: term);
    });
  }

  void _clearSearch() {
    _searchDebounce?.cancel();
    final hadSearch =
        _searchController.text.trim().isNotEmpty ||
        (_activeSearchTerm?.isNotEmpty ?? false);
    setState(() {
      _searchController.clear();
      _activeSearchTerm = null;
      _quickFilter = null;
      _loadingProducts = true;
    });
    if (hadSearch) {
      _loadProducts();
    }
  }

  void _onCategorySelected(GiftCardCategoryEntity? category) {
    setState(() => _selectedCategory = category);
    _loadProducts(searchTerm: _activeSearchTerm);
  }

  void _openDetail(GiftCardProductEntity p) {
    Navigator.pushNamed(context, '/gift-card-detail', arguments: p);
  }

  /// Fetches the next page once the user scrolls within ~600px of the end.
  /// The bloc guards against duplicate/overlapping fetches, and we also gate on
  /// the mirrored flags here to avoid spamming events while one is in flight.
  bool _onScrollNotification(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;
    if (_hasNextPage &&
        !_isLoadingMore &&
        !_loadingProducts &&
        notification.metrics.extentAfter < 600) {
      context.read<GiftCardsBloc>().add(const LoadMoreGiftCardProducts());
    }
    return false;
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
                  s is GiftCardCategoriesLoaded || s is GiftCardCategoriesError,
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
                    _totalCount = s.totalCount;
                    _hasNextPage = s.hasNextPage;
                    _isLoadingMore = s.isLoadingMore;
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
              NotificationListener<ScrollNotification>(
                onNotification: _onScrollNotification,
                child: RefreshIndicator(
                  onRefresh: () async {
                    final searchTerm = _searchTerm;
                    setState(() {
                      _activeSearchTerm = searchTerm.isEmpty
                          ? null
                          : searchTerm;
                      if (searchTerm.isNotEmpty) {
                        _selectedCategory = null;
                      }
                    });
                    context.read<GiftCardsBloc>().add(
                      const LoadGiftCardCategories(),
                    );
                    context.read<GiftCardsBloc>().add(const LoadHotDeals());
                    _loadProducts(searchTerm: searchTerm);
                  },
                  color: GcTokens.primary,
                  child: CustomScrollView(
                    slivers: [
                      _buildAppBar(),
                      SliverToBoxAdapter(child: _buildSearchBar()),
                      if (_isSearchMode) ...[
                        SliverToBoxAdapter(child: _buildSearchHeader()),
                        if (!_loadingProducts && _products.isNotEmpty)
                          SliverToBoxAdapter(child: _buildQuickFilters()),
                        _buildProductResultsSliver(asList: true),
                        _buildLoadMoreIndicator(),
                      ] else ...[
                        SliverToBoxAdapter(child: const SizedBox(height: 18)),
                        SliverToBoxAdapter(child: _buildHero()),
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
                        // Hidden entirely until the backend has user-visible
                        // categories (e.g. before the admin organizes the catalog).
                        if (_loadingCategories || _categories.isNotEmpty) ...[
                          const SliverToBoxAdapter(
                            child: GcSectionHeader(
                              title: 'Deal by category',
                              subtitle: 'Pick a category to start saving',
                            ),
                          ),
                          SliverToBoxAdapter(child: _buildCategoryGrid()),
                        ],
                        SliverToBoxAdapter(child: const SizedBox(height: 18)),
                        SliverToBoxAdapter(child: _buildQuickFilters()),
                        SliverToBoxAdapter(
                          child: GcSectionHeader(
                            title: _selectedCategory != null
                                ? _selectedCategory!.name
                                : 'Save big on top brands',
                            subtitle: '$_availableCount vouchers available',
                          ),
                        ),
                        _buildProductResultsSliver(),
                        _buildLoadMoreIndicator(),
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
                        SliverToBoxAdapter(child: _buildBrandWatermark()),
                      ],
                      const SliverToBoxAdapter(child: SizedBox(height: 120)),
                    ],
                  ),
                ),
              ),
              if (!_isSearchMode) _buildFloatingFilterPill(),
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
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: GcTokens.textPrimary,
        ),
      ),
      titleSpacing: 0,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          const expandedHeight = 150.0;
          final minHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
          final t =
              ((constraints.maxHeight - minHeight) /
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: AnimatedBuilder(
            animation: _favorites,
            builder: (_, _) {
              final count = _favorites.count;
              return Stack(
                children: [
                  Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    elevation: 0,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () =>
                          Navigator.pushNamed(context, '/gift-card-favorites'),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFEFEAFB)),
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
        onChanged: _onSearchChanged,
        onSubmitted: _onSearchSubmitted,
      ),
    );
  }

  Widget _buildSearchHeader() {
    final count = _availableCount;
    final query = _searchTerm;
    final countLabel = count == 1 ? '1 voucher' : '$count vouchers';

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _loadingProducts ? 'Searching brands' : 'Results for',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                        color: GcTokens.textTertiary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      query,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 26,
                        height: 1.05,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.4,
                        color: GcTokens.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              if (_loadingProducts)
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  child: const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      color: GcTokens.primary,
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: GcTokens.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(GcTokens.rPill),
                    border: Border.all(
                      color: GcTokens.primary.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Text(
                    countLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: GcTokens.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  _loadingProducts
                      ? 'Checking all available gift voucher brands'
                      : 'Tap a voucher to view denominations and savings.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                    color: GcTokens.textTertiary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              TextButton.icon(
                onPressed: _clearSearch,
                style: TextButton.styleFrom(
                  foregroundColor: GcTokens.textPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                icon: const Icon(Icons.close_rounded, size: 16),
                label: const Text(
                  'Clear',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          if (!_loadingProducts && _products.isNotEmpty) ...[
            const SizedBox(height: 14),
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    GcTokens.primary.withValues(alpha: 0.20),
                    GcTokens.divider,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSearchEmptyState() {
    final query = _searchTerm;
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 42, 28, 24),
      child: Column(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: GcTokens.surfaceMuted,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: const Color(0xFFEFEAFB)),
            ),
            child: const Icon(
              Icons.search_off_rounded,
              size: 38,
              color: GcTokens.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'No voucher found for "$query"',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: GcTokens.textPrimary,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try a shorter brand name or clear search to browse every voucher.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.45,
              fontWeight: FontWeight.w600,
              color: GcTokens.textTertiary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: _clearSearch,
                style: OutlinedButton.styleFrom(
                  foregroundColor: GcTokens.textPrimary,
                  side: const BorderSide(color: Color(0xFFEFEAFB)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(GcTokens.rPill),
                  ),
                ),
                child: const Text(
                  'Browse all',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    if (_hotDeals.isEmpty) {
      return const GcHeroSkeleton();
    }
    return GcHeroCarousel(
      items: _hotDeals.take(5).toList(),
      onTap: _openDetail,
    );
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
        separatorBuilder: (_, _) => const SizedBox(width: 12),
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

  Widget _buildProductResultsSliver({bool asList = false}) {
    if (_loadingProducts) {
      return const SliverToBoxAdapter(child: GcProductGridSkeleton());
    }
    final items = _filteredProducts;
    if (items.isEmpty) {
      return SliverToBoxAdapter(
        child: asList
            ? _buildSearchEmptyState()
            : GcEmptyState(
                icon: Icons.search_off_rounded,
                title: 'No vouchers found',
                message: 'Try a different category, search term, or filter.',
                actionLabel: 'Reset filters',
                onAction: _resetFilters,
              ),
      );
    }
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 20,
          childAspectRatio: 0.72,
        ),
        delegate: SliverChildBuilderDelegate((_, i) {
          final p = items[i];
          return GiftCardProductCard(
            product: p,
            favorites: _favorites,
            onTap: () => _openDetail(p),
          );
        }, childCount: items.length),
      ),
    );
  }

  /// Bottom-of-list spinner shown while the next page is being appended. A
  /// quick filter being active suppresses it (the filter is client-side and
  /// the spinner would be misleading), but scrolling still pulls more pages.
  Widget _buildLoadMoreIndicator() {
    if (!_isLoadingMore) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 22),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: GcTokens.primary,
            ),
          ),
        ),
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      _quickFilter = null;
      _selectedCategory = null;
      _searchController.clear();
      _activeSearchTerm = null;
    });
    context.read<GiftCardsBloc>().add(const LoadGiftCardProducts());
  }

  Widget _buildTrendingSliver() {
    if (_loadingProducts) {
      return const SliverToBoxAdapter(child: GcListSkeleton());
    }
    final trending = _filteredProducts.where((p) => p.hasDiscount).toList()
      ..sort(
        (a, b) =>
            (b.discountPercentage ?? 0).compareTo(a.discountPercentage ?? 0),
      );
    if (trending.isEmpty) return const SliverToBoxAdapter();
    final items = trending.take(5).toList();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList.separated(
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final p = items[i];
          return GcTrendingBrandTile(product: p, onTap: () => _openDetail(p));
        },
      ),
    );
  }

  /// Brand logo + tagline that close the scroll. The logo is shown softly
  /// (reduced opacity) as a watermark, and the extra height lets the list
  /// over-scroll more.
  Widget _buildBrandWatermark() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (rect) => LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                GcTokens.textTertiary.withValues(alpha: 0.55),
                GcTokens.textTertiary.withValues(alpha: 0.35),
              ],
            ).createShader(rect),
            blendMode: BlendMode.srcIn,
            child: Image.asset(
              'assets/images/logo_transparant.png',
              width: 100,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Save on every brand you love',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
              color: GcTokens.textTertiary.withValues(alpha: 0.45),
            ),
          ),
        ],
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
            onTap: () async {
              final isAuth = await getIt<SecureStorageService>()
                  .isAuthenticated();
              if (!isAuth) {
                if (!mounted) return;
                LoginPrompt.show(
                  context,
                  message: 'Sign in to view your gift cards.',
                );
                return;
              }
              if (!mounted) return;
              Navigator.pushNamed(context, '/gift-card-orders');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
              border: Border.all(color: brand.withValues(alpha: 0.20)),
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
                      right: BorderSide(color: brand.withValues(alpha: 0.18)),
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: hasImg
                      ? CachedNetworkImage(
                          imageUrl: order.productImageUrl!,
                          fit: BoxFit.contain,
                          errorWidget: (_, _, _) =>
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
                                color: _statusColor.withValues(alpha: 0.12),
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
                                color: GcTokens.textTertiary.withValues(
                                  alpha: 0.85,
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
        );
      },
    );
  }
}
