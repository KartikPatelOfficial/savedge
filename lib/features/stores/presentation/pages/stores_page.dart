import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/constants/categories_constants.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/home/presentation/widgets/categories_bottom_sheet.dart';
import 'package:savedge/features/stores/presentation/pages/vendor_detail_page.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_bloc.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_event.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_state.dart';

// First 5 categories shown in the quick row
const int _quickCategoryCount = 5;

class StoresPage extends StatelessWidget {
  const StoresPage({super.key, this.initialCategory = 'All'});

  final String initialCategory;

  @override
  Widget build(BuildContext context) {
    try {
      final String? categoryParam =
          (initialCategory.isEmpty || initialCategory == 'All')
          ? null
          : initialCategory;

      return BlocProvider(
        create: (context) =>
            getIt<VendorsBloc>()..add(LoadVendors(category: categoryParam)),
        child: StoresView(initialCategory: initialCategory),
      );
    } catch (e) {
      return Scaffold(
        appBar: AppBar(title: const Text('Stores')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Failed to load stores',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Error: $e',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) =>
                          StoresPage(initialCategory: initialCategory),
                    ),
                  );
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class StoresView extends StatefulWidget {
  const StoresView({super.key, this.initialCategory = 'All'});

  final String initialCategory;

  @override
  State<StoresView> createState() => _StoresViewState();
}

class _StoresViewState extends State<StoresView> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _selectedCategory;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    if (widget.initialCategory.isNotEmpty && widget.initialCategory != 'All') {
      _selectedCategory = widget.initialCategory;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onCategorySelected(widget.initialCategory);
      });
    } else {
      _selectedCategory = null;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !_isLoadingMore) {
      final currentState = context.read<VendorsBloc>().state;
      if (currentState is VendorsLoaded && !currentState.hasReachedMax) {
        setState(() => _isLoadingMore = true);
        context.read<VendorsBloc>().add(const LoadMoreVendors());
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: BlocConsumer<VendorsBloc, VendorsState>(
        listener: (context, state) {
          if (state is VendorsLoaded || state is VendorsError) {
            if (_isLoadingMore) setState(() => _isLoadingMore = false);
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildSliverHeader(),
              SliverToBoxAdapter(child: _buildSearchBar()),
              SliverToBoxAdapter(child: _buildCategorySection()),
              // Popular Picks — owns its own VendorsBloc, hides when empty
              SliverToBoxAdapter(
                child: _PopularPicksSection(
                  selectedCategory: _selectedCategory,
                  onVendorTap: _navigateToVendorDetail,
                ),
              ),
              if (state is VendorsLoading)
                SliverFillRemaining(child: _buildLoadingWidget())
              else if (state is VendorsError)
                SliverFillRemaining(child: _buildErrorWidget(state.message))
              else if (state is VendorsLoaded) ...[
                SliverToBoxAdapter(
                  child: _buildSectionLabel(
                    'All Stores',
                    count: state.vendors.length,
                  ),
                ),
                if (state.vendors.isEmpty)
                  SliverFillRemaining(child: _buildEmptyWidget())
                else
                  _buildVendorGrid(state),
              ] else
                const SliverToBoxAdapter(child: SizedBox.shrink()),
              const SliverToBoxAdapter(child: SizedBox(height: 48)),
            ],
          );
        },
      ),
    );
  }

  // ─── Header ────────────────────────────────────────────

  SliverAppBar _buildSliverHeader() {
    return SliverAppBar(
      expandedHeight: 150,
      backgroundColor: const Color(0xFFF7F8FA),
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: const IconThemeData(color: Color(0xFF1A202C)),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final expandedHeight = 150.0;
          final minHeight = kToolbarHeight + MediaQuery.of(context).padding.top;
          final t =
              ((constraints.maxHeight - minHeight) /
                      (expandedHeight - minHeight))
                  .clamp(0.0, 1.0);
          final leftPadding = 20.0 + (52.0 * (1 - t));

          return Stack(
            children: [
              if (t > 0.05)
                Positioned(
                  bottom: 52,
                  left: 20,
                  child: Opacity(
                    opacity: t.clamp(0.0, 1.0),
                    child: const Text(
                      'Find the best local deals',
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
                  'Discover Stores',
                  style: TextStyle(
                    color: const Color(0xFF1A202C),
                    fontSize: t > 0.5 ? 24 : 20,
                    fontWeight: t > 0.5 ? FontWeight.w800 : FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ─── Search bar ────────────────────────────────────────
  // Flat tinted field — no border, no shadow, unified look

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFEDF0F4),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(
              Icons.search_rounded,
              size: 20,
              color: Color(0xFFADB5C0),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _searchController,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF1A202C),
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Search stores, cafés, restaurants...',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  context.read<VendorsBloc>().add(SearchVendors(value));
                  setState(() {});
                },
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              child: _searchController.text.isNotEmpty
                  ? GestureDetector(
                      key: const ValueKey('clear'),
                      onTap: () {
                        _searchController.clear();
                        context.read<VendorsBloc>().add(
                          const SearchVendors(''),
                        );
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC8CDD4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Categories ────────────────────────────────────────
  // 5 categories + All shown as circles with asset icons

  Widget _buildCategorySection() {
    // Build the list: All + first 5 categories
    // If initialCategory is outside first 5, include it as the 5th slot
    final base = CategoriesConstants.categories
        .take(_quickCategoryCount)
        .toList();
    if (widget.initialCategory.isNotEmpty &&
        widget.initialCategory != 'All' &&
        !base.contains(widget.initialCategory)) {
      base
        ..removeLast()
        ..add(widget.initialCategory);
    }
    final displayCategories = ['All', ...base];

    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A202C),
                    letterSpacing: -0.3,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _showCategoriesBottomSheet,
                  child: const Row(
                    children: [
                      Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6F3FCC),
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: Color(0xFF6F3FCC),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Circle icon row — fixed items, no ListView (no scroll)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: displayCategories.map((category) {
                final isSelected =
                    _selectedCategory == category ||
                    (category == 'All' && _selectedCategory == null);
                final label = category == 'All' ? 'All' : _shortLabel(category);
                final iconPath = category == 'All'
                    ? null
                    : CategoriesConstants.getCategoryIcon(category);

                return GestureDetector(
                  onTap: () => _onCategorySelected(category),
                  child: SizedBox(
                    width: 56,
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: isSelected && category == 'All'
                                ? const Color(0xFF6F3FCC)
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF6F3FCC)
                                  : const Color(0xFFE2E8F0),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: category == 'All'
                              ? Icon(
                                  Icons.storefront_outlined,
                                  size: 22,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF6F3FCC),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(28),
                                  child: Image.asset(
                                    iconPath!,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, _, _) => Icon(
                                      Icons.storefront_outlined,
                                      size: 20,
                                      color: isSelected
                                          ? const Color(0xFF6F3FCC)
                                          : const Color(0xFF9CA3AF),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFF6F3FCC)
                                : const Color(0xFF718096),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _shortLabel(String category) {
    // Shorten long category names so they fit under the circle
    const overrides = {
      'Tours and travels': 'Tours',
      'Resort and Gateways': 'Resort',
      'Service centre': 'Service',
      'Financial services': 'Finance',
      'Belt and accessories': 'Belts',
      'Kitchen utensils': 'Kitchen',
      'Health and wellness': 'Health',
      'salads and more': 'Salads',
      'indoor games': 'Games',
      'Clothing store': 'Clothing',
    };
    return overrides[category] ?? category.split(' ').first;
  }

  // ─── Section label ─────────────────────────────────────

  Widget _buildSectionLabel(String title, {required int count}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A202C),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFEDF2F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$count',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF718096),
              ),
            ),
          ),
          if (_selectedCategory != null) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                setState(() => _selectedCategory = null);
                context.read<VendorsBloc>().add(
                  const FilterVendorsByCategory(null),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.07),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF6F3FCC).withOpacity(0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedCategory!,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6F3FCC),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.close_rounded,
                      size: 11,
                      color: Color(0xFF6F3FCC),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ─── Grid ──────────────────────────────────────────────

  Widget _buildVendorGrid(VendorsLoaded state) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 0.74,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index >= state.vendors.length) {
              if (!state.hasReachedMax) {
                return const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Color(0xFF6F3FCC),
                      strokeWidth: 2,
                    ),
                  ),
                );
              }
              return null;
            }
            final vendor = state.vendors[index];
            return ModernVendorCard(
              vendor: vendor,
              onTap: () => _navigateToVendorDetail(vendor),
            );
          },
          childCount: state.hasReachedMax
              ? state.vendors.length
              : state.vendors.length + 1,
        ),
      ),
    );
  }

  // ─── States ────────────────────────────────────────────

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withOpacity(0.08),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: Color(0xFF6F3FCC),
                  strokeWidth: 2.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Finding stores for you',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A5568),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Great deals on the way',
            style: TextStyle(fontSize: 13, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFECACA)),
              ),
              child: const Icon(
                Icons.sentiment_dissatisfied_rounded,
                color: Color(0xFFE53E3E),
                size: 34,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () =>
                      context.read<VendorsBloc>().add(const LoadVendors()),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF6F3FCC),
                    side: const BorderSide(color: Color(0xFF6F3FCC)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Try Again',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () =>
                      context.read<VendorsBloc>().add(const RefreshVendors()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F3FCC),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Reload',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    final hasFilter =
        _searchController.text.isNotEmpty || _selectedCategory != null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(
                Icons.search_off_rounded,
                color: Color(0xFF9CA3AF),
                size: 34,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              hasFilter ? 'No stores found' : 'No stores available',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hasFilter
                  ? 'Try a different search or category'
                  : 'Check back later for stores and offers',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            if (hasFilter)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_searchController.text.isNotEmpty)
                    OutlinedButton(
                      onPressed: () {
                        _searchController.clear();
                        context.read<VendorsBloc>().add(
                          const SearchVendors(''),
                        );
                        setState(() {});
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF6F3FCC),
                        side: const BorderSide(color: Color(0xFF6F3FCC)),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Clear Search',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  if (_searchController.text.isNotEmpty &&
                      _selectedCategory != null)
                    const SizedBox(width: 12),
                  if (_selectedCategory != null)
                    ElevatedButton(
                      onPressed: () {
                        setState(() => _selectedCategory = null);
                        context.read<VendorsBloc>().add(
                          const FilterVendorsByCategory(null),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6F3FCC),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Show All',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _navigateToVendorDetail(Vendor vendor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendorDetailPage(vendorId: vendor.id),
      ),
    );
  }

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category == 'All' ? null : category;
    });
    context.read<VendorsBloc>().add(FilterVendorsByCategory(_selectedCategory));
  }

  void _showCategoriesBottomSheet() {
    CategoriesBottomSheet.show(
      context: context,
      onCategoryTap: (category) {
        _onCategorySelected(category);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────
// Popular Picks — owns its own VendorsBloc using LoadTopOfferVendors
// Filters by selectedCategory and hides itself when the result is empty
// ─────────────────────────────────────────────────────────

class _PopularPicksSection extends StatefulWidget {
  const _PopularPicksSection({
    required this.selectedCategory,
    required this.onVendorTap,
  });

  final String? selectedCategory;
  final void Function(Vendor) onVendorTap;

  @override
  State<_PopularPicksSection> createState() => _PopularPicksSectionState();
}

class _PopularPicksSectionState extends State<_PopularPicksSection> {
  late final VendorsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<VendorsBloc>()..add(const LoadTopOfferVendors());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<VendorsBloc, VendorsState>(
        builder: (context, state) {
          if (state is! VendorsLoaded) return const SizedBox.shrink();

          // Filter by selected category when active; otherwise show all top offers
          final vendors = widget.selectedCategory != null
              ? state.vendors
                    .where((v) => v.category == widget.selectedCategory)
                    .toList()
              : state.vendors;

          if (vendors.isEmpty) return const SizedBox.shrink();

          return Padding(
            padding: const EdgeInsets.only(top: 28, bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      const Text(
                        'Popular Picks',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A202C),
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '🔥 Hot',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFE65100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  height: 216,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: vendors.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return _FeaturedStoreCard(
                        vendor: vendors[index],
                        onTap: () => widget.onVendorTap(vendors[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Featured portrait card — horizontal scroll
// ─────────────────────────────────────────────────────────

class _FeaturedStoreCard extends StatefulWidget {
  const _FeaturedStoreCard({required this.vendor, this.onTap});

  final Vendor vendor;
  final VoidCallback? onTap;

  @override
  State<_FeaturedStoreCard> createState() => _FeaturedStoreCardState();
}

class _FeaturedStoreCardState extends State<_FeaturedStoreCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.vendor.images.isNotEmpty
        ? widget.vendor.images[0].imageUrl
        : null;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 130),
        child: Container(
          width: 148,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFEDF0F4), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
                child: SizedBox(
                  width: 148,
                  height: 142,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      imageUrl != null
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _buildPlaceholder(),
                            )
                          : _buildPlaceholder(),
                    ],
                  ),
                ),
              ),
              // Info
              Padding(
                padding: const EdgeInsets.fromLTRB(11, 10, 11, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.vendor.businessName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                        letterSpacing: -0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.vendor.category,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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

  Widget _buildPlaceholder() {
    final iconPath = CategoriesConstants.getCategoryIcon(
      widget.vendor.category,
    );
    if (iconPath.isNotEmpty) {
      return Image.asset(
        iconPath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _defaultPlaceholder(),
      );
    }
    return _defaultPlaceholder();
  }

  Widget _defaultPlaceholder() => Container(
    color: const Color(0xFFF7F8FA),
    child: const Center(
      child: Icon(Icons.storefront_rounded, color: Color(0xFF6F3FCC), size: 40),
    ),
  );
}

// ─────────────────────────────────────────────────────────
// Grid vendor card
// ─────────────────────────────────────────────────────────

class ModernVendorCard extends StatefulWidget {
  const ModernVendorCard({super.key, required this.vendor, this.onTap});

  final Vendor vendor;
  final VoidCallback? onTap;

  bool get _hasAddress =>
      vendor.address != null && vendor.address!.trim().isNotEmpty;

  @override
  State<ModernVendorCard> createState() => _ModernVendorCardState();
}

class _ModernVendorCardState extends State<ModernVendorCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.vendor.images.isNotEmpty
        ? widget.vendor.images[0].imageUrl
        : null;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 130),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFEDF0F4), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      imageUrl != null
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  _buildPlaceholderImage(),
                            )
                          : _buildPlaceholderImage(),
                      if (widget.vendor.coupons.isNotEmpty)
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF38A169),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.local_offer_rounded,
                                  size: 10,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  '${widget.vendor.coupons.length}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(11, 10, 11, 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.vendor.businessName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A202C),
                        letterSpacing: -0.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          widget._hasAddress
                              ? Icons.location_on_rounded
                              : Icons.category_rounded,
                          size: 11,
                          color: const Color(0xFFB0BAC8),
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            widget._hasAddress
                                ? widget.vendor.address!
                                : widget.vendor.category,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFFB0BAC8),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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

  Widget _buildPlaceholderImage() {
    final iconPath = CategoriesConstants.getCategoryIcon(
      widget.vendor.category,
    );
    if (iconPath.isNotEmpty) {
      return Image.asset(
        iconPath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _defaultPlaceholder(),
      );
    }
    return _defaultPlaceholder();
  }

  Widget _defaultPlaceholder() => Container(
    color: const Color(0xFFF7F8FA),
    child: const Center(
      child: Icon(Icons.storefront_rounded, color: Color(0xFF6F3FCC), size: 36),
    ),
  );
}
