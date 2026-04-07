import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/injection/injection.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../bloc/gift_cards_bloc.dart';
import '../widgets/gift_card_category_card.dart';
import '../widgets/gift_card_featured_banner.dart';
import '../widgets/gift_card_product_card.dart';

class GiftCardsPage extends StatelessWidget {
  const GiftCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GiftCardsBloc>()
        ..add(const LoadGiftCardCategories())
        ..add(const LoadHotDeals())
        ..add(const LoadGiftCardProducts()),
      child: const GiftCardsView(),
    );
  }
}

class GiftCardsView extends StatefulWidget {
  const GiftCardsView({super.key});

  @override
  State<GiftCardsView> createState() => _GiftCardsViewState();
}

class _GiftCardsViewState extends State<GiftCardsView> {
  GiftCardCategoryEntity? _selectedCategory;
  final _searchController = TextEditingController();
  bool _searchActive = false;

  // Cached state for single-scroll layout
  List<GiftCardCategoryEntity> _categories = [];
  List<GiftCardProductEntity> _products = [];
  List<GiftCardProductEntity> _featuredProducts = [];
  bool _isLoading = true;
  String? _error;

  // Auto-scroll carousel
  Timer? _autoScrollTimer;
  PageController? _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _autoScrollTimer?.cancel();
    _pageController?.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    if (_featuredProducts.length <= 1) return;
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pageController != null && _pageController!.hasClients) {
        final next =
            ((_pageController!.page?.round() ?? 0) + 1) % _featuredProducts.length;
        _pageController!.animateToPage(
          next,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _selectCategory(GiftCardCategoryEntity? category) {
    setState(() {
      _selectedCategory = category;
      _searchController.clear();
      _searchActive = false;
    });
    context.read<GiftCardsBloc>().add(
      LoadGiftCardProducts(categoryId: category?.id),
    );
  }

  void _searchProducts(String query) {
    context.read<GiftCardsBloc>().add(
      LoadGiftCardProducts(
        categoryId: _selectedCategory?.id,
        searchTerm: query.isEmpty ? null : query,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: BlocListener<GiftCardsBloc, GiftCardsState>(
          listener: (context, state) {
            if (state is GiftCardCategoriesLoaded) {
              setState(() => _categories = state.categories);
            } else if (state is HotDealsLoaded) {
              setState(() {
                _featuredProducts = state.hotDeals;
                _startAutoScroll();
              });
            } else if (state is GiftCardProductsLoaded) {
              setState(() {
                _products = state.products;
                _isLoading = false;
                _error = null;
              });
            } else if (state is GiftCardProductsLoading) {
              setState(() => _isLoading = true);
            } else if (state is GiftCardProductsError) {
              setState(() {
                _error = state.message;
                _isLoading = false;
              });
            }
          },
          child: AnimationLimiter(
            child: CustomScrollView(
              slivers: [
                // 1. Header
                SliverToBoxAdapter(child: _buildHeader(context)),

                // 2. Featured Deals Carousel
                if (_featuredProducts.isNotEmpty)
                  SliverToBoxAdapter(child: _buildFeaturedDeals()),

                // 3. Top Categories
                if (_categories.isNotEmpty)
                  SliverToBoxAdapter(child: _buildTopCategories()),

                // 4. Category Chips
                if (_categories.isNotEmpty)
                  SliverToBoxAdapter(child: _buildCategoryRow(_categories)),

                // 5. Section Heading
                SliverToBoxAdapter(child: _buildSectionHeading()),

                // 6. Products Grid / Loading / Error / Empty
                if (_isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF6F3FCC),
                        strokeWidth: 2.5,
                      ),
                    ),
                  )
                else if (_error != null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildError(_error!),
                  )
                else if (_products.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: _buildEmptyState(),
                  )
                else
                  _buildProductsGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -- Header ----------------------------------------------------------------

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F7FC),
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.of(context).padding.top + 16,
        24,
        16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: title + orders button
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Gift Cards',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF111827),
                        letterSpacing: -0.5,
                        height: 1.1,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Send joy to someone special',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/gift-card-orders'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.receipt_long_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'My Orders',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFEEEEEE), width: 1.5),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchActive = v.isNotEmpty),
              onSubmitted: _searchProducts,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF111827),
              ),
              decoration: InputDecoration(
                hintText: 'Search Amazon, Flipkart, Zomato...',
                hintStyle: const TextStyle(
                  color: Color(0xFFBBC0C9),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 10),
                  child: Icon(
                    Icons.search_rounded,
                    color: _searchActive
                        ? const Color(0xFF6F3FCC)
                        : const Color(0xFFBBC0C9),
                    size: 22,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 0),
                suffixIcon: _searchActive
                    ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _searchProducts('');
                          setState(() => _searchActive = false);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.close_rounded,
                            color: Color(0xFFBBC0C9),
                            size: 20,
                          ),
                        ),
                      )
                    : null,
                suffixIconConstraints: const BoxConstraints(minWidth: 0),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -- Featured Deals Carousel -----------------------------------------------

  Widget _buildFeaturedDeals() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          // Heading row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  'Hot Deals',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => _selectCategory(null),
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7C3AED),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // PageView carousel
          SizedBox(
            height: 190,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _featuredProducts.length,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder: (context, index) {
                final product = _featuredProducts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GiftCardFeaturedBanner(
                    product: product,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/gift-card-detail',
                      arguments: product,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // Dot indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _featuredProducts.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == _currentPage
                      ? const Color(0xFF7C3AED)
                      : const Color(0xFFD1D5DB),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -- Top Categories --------------------------------------------------------

  Widget _buildTopCategories() {
    final sorted = List<GiftCardCategoryEntity>.from(_categories)
      ..sort((a, b) => b.productCount.compareTo(a.productCount));
    final top = sorted.take(6).toList();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  'Top Categories',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => _selectCategory(null),
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7C3AED),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: top.length,
              itemBuilder: (context, index) {
                final cat = top[index];
                return Padding(
                  padding: EdgeInsets.only(right: index < top.length - 1 ? 10 : 0),
                  child: GiftCardCategoryCard(
                    category: cat,
                    isSelected: _selectedCategory?.id == cat.id,
                    onTap: () => _selectCategory(cat),
                    index: index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // -- Category Chips --------------------------------------------------------

  static const List<Color> _catBg = [
    Color(0xFFEDE9FE),
    Color(0xFFFFEDD5),
    Color(0xFFDCFCE7),
    Color(0xFFE0F2FE),
    Color(0xFFFCE7F3),
    Color(0xFFFEF9C3),
  ];

  static const List<Color> _catFg = [
    Color(0xFF7C3AED),
    Color(0xFFEA580C),
    Color(0xFF16A34A),
    Color(0xFF0284C7),
    Color(0xFFDB2777),
    Color(0xFFCA8A04),
  ];

  Widget _buildCategoryRow(List<GiftCardCategoryEntity> categories) {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            final isSelected = _selectedCategory == null;
            return _buildChip(
              label: 'All',
              isSelected: isSelected,
              bg: isSelected ? const Color(0xFF6F3FCC) : Colors.white,
              fg: isSelected ? Colors.white : const Color(0xFF6B7280),
              onTap: () => _selectCategory(null),
            );
          }
          final cat = categories[index - 1];
          final isSelected = _selectedCategory?.id == cat.id;
          final ci = (index - 1) % _catBg.length;
          return _buildChip(
            label: cat.name,
            isSelected: isSelected,
            bg: isSelected ? _catFg[ci] : _catBg[ci],
            fg: isSelected ? Colors.white : _catFg[ci],
            imageUrl: cat.imageUrl,
            onTap: () => _selectCategory(cat),
          );
        },
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required bool isSelected,
    required Color bg,
    required Color fg,
    String? imageUrl,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imageUrl != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 18,
                    height: 18,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -- Section Heading -------------------------------------------------------

  Widget _buildSectionHeading() {
    String title;
    if (_searchActive && _searchController.text.isNotEmpty) {
      title = 'Search Results';
    } else if (_selectedCategory != null) {
      title = _selectedCategory!.name;
    } else {
      title = 'All Gift Cards';
    }

    final count = _products.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        '$title ($count)',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: Color(0xFF111827),
        ),
      ),
    );
  }

  // -- Products Grid ---------------------------------------------------------

  Widget _buildProductsGrid() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = _products[index];
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 2,
              child: SlideAnimation(
                verticalOffset: 30,
                child: FadeInAnimation(
                  child: GiftCardProductCard(
                    product: product,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/gift-card-detail',
                      arguments: product,
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: _products.length,
        ),
      ),
    );
  }

  // -- Error & Empty States --------------------------------------------------

  Widget _buildError(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.wifi_off_rounded,
              size: 36,
              color: Color(0xFFEF4444),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: const TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _selectCategory(_selectedCategory),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF6F3FCC),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFEDE9FE),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.card_giftcard_rounded,
              size: 40,
              color: Color(0xFF7C3AED),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'No gift cards found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Try a different category or search',
            style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }
}
