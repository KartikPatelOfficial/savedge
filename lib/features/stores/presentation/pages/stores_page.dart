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
        create: (context) => getIt<VendorsBloc>()
          ..add(LoadVendors(category: categoryParam)),
        child: StoresView(initialCategory: initialCategory),
      );
    } catch (e) {
      // Handle dependency injection error gracefully
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
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Error: $e',
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Try to refresh the page
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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Apply initial category selection for UI highlighting and behavior
    if (widget.initialCategory.isNotEmpty && widget.initialCategory != 'All') {
      _selectedCategory = widget.initialCategory;
      // Defer firing selection to ensure context is ready
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
    if (_isBottom) {
      context.read<VendorsBloc>().add(const LoadMoreVendors());
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
      backgroundColor: const Color(0xFFFAFBFC),
      body: BlocBuilder<VendorsBloc, VendorsState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // SliverAppBar like profile page
              SliverAppBar(
                expandedHeight: 140,
                backgroundColor: const Color(0xFFFAFBFC),
                pinned: true,
                elevation: 0,
                scrolledUnderElevation: 0,
                surfaceTintColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    'Discover Stores',
                    style: TextStyle(
                      color: Color(0xFF1A202C),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
                ),
                iconTheme: const IconThemeData(color: Color(0xFF1A202C)),
              ),

              // Search Bar
              SliverToBoxAdapter(child: _buildSearchBar()),

              // Quick Categories
              SliverToBoxAdapter(child: _buildQuickCategories()),

              // Vendors List
              if (state is VendorsLoading)
                SliverFillRemaining(child: _buildLoadingWidget())
              else
                if (state is VendorsError)
                  SliverFillRemaining(child: _buildErrorWidget(state.message))
                else
                  if (state is VendorsLoaded)
                    _buildSliverVendorsList(state)
                  else
                    const SliverToBoxAdapter(child: SizedBox.shrink()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 16.0),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF1A202C),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Search stores, cafés, restaurants...',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF6F3FCC),
            size: 20,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.close_rounded,
                color: Color(0xFF718096),
                size: 18,
              ),
              onPressed: () {
                _searchController.clear();
                context.read<VendorsBloc>().add(const SearchVendors(''));
                setState(() {});
              },
            ),
          )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
        ),
        onChanged: (value) {
          context.read<VendorsBloc>().add(SearchVendors(value));
          setState(() {});
        },
      ),
    );
  }

  Widget _buildQuickCategories() {
    // Use first 6 categories from CategoriesConstants instead of hardcoded
    final quickCategories = [
      'All',
      ...CategoriesConstants.categories.take(5),
    ].toList();

    // Ensure the initially selected category chip is visible even if not in top 5
    if (widget.initialCategory.isNotEmpty &&
        widget.initialCategory != 'All' &&
        !quickCategories.contains(widget.initialCategory)) {
      quickCategories.insert(1, widget.initialCategory);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Row(
            children: [
              const Text(
                'Quick Browse',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2563EB),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: _showCategoriesBottomSheet,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6F3FCC),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: Color(0xFF6F3FCC),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: quickCategories.length,
            itemBuilder: (context, index) {
              final category = quickCategories[index];
              final isSelected =
                  _selectedCategory == category ||
                      (category == 'All' && _selectedCategory == null);

              final categoryColors = [
                const Color(0xFF6F3FCC),
                const Color(0xFF10B981),
                const Color(0xFF3B82F6),
                const Color(0xFFEF4444),
                const Color(0xFFF59E0B),
                const Color(0xFF8B5CF6),
              ];

              final color = categoryColors[index % categoryColors.length];

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => _onCategorySelected(category),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? color : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected ? color : const Color(0xFFE8E9EA),
                        width: isSelected ? 2 : 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isSelected) ...[
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          category,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF4A5568),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildVendorsList(VendorsLoaded state) {
    if (state.vendors.isEmpty) {
      return _buildEmptyWidget();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<VendorsBloc>().add(const RefreshVendors());
      },
      color: const Color(0xFF6F3FCC),
      backgroundColor: Colors.white,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        itemCount: state.hasReachedMax
            ? state.vendors.length
            : state.vendors.length + 1,
        itemBuilder: (context, index) {
          if (index >= state.vendors.length) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Color(0xFF6F3FCC),
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Loading more stores...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF718096),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final vendor = state.vendors[index];
          return ModernVendorCard(
            vendor: vendor,
            onTap: () => _navigateToVendorDetail(vendor),
          );
        },
      ),
    );
  }

  Widget _buildSliverVendorsList(VendorsLoaded state) {
    if (state.vendors.isEmpty) {
      return SliverFillRemaining(child: _buildEmptyWidget());
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          if (index >= state.vendors.length) {
            if (!state.hasReachedMax) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Color(0xFF6F3FCC),
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Loading more stores...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF718096),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return null;
          }

          final vendor = state.vendors[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              index == 0 ? 0 : 0,
              20,
              index == state.vendors.length - 1 ? 20 : 16,
            ),
            child: ModernVendorCard(
              vendor: vendor,
              onTap: () => _navigateToVendorDetail(vendor),
            ),
          );
        },
        childCount: state.hasReachedMax
            ? state.vendors.length
            : state.vendors.length + 1,
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Color(0xFF6F3FCC),
                  strokeWidth: 2.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Finding amazing stores for you',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A5568),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '🎯 Get ready for great deals!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
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
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFECACA), width: 1),
              ),
              child: const Icon(
                Icons.sentiment_dissatisfied_rounded,
                color: Color(0xFFDC2626),
                size: 36,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    context.read<VendorsBloc>().add(const LoadVendors());
                  },
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
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh_rounded, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Try Again',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    context.read<VendorsBloc>().add(const RefreshVendors());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F3FCC),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Reload Stores',
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
    final hasSearchQuery = _searchController.text.isNotEmpty;
    final hasSelectedCategory = _selectedCategory != null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
              ),
              child: const Icon(
                Icons.search_off_rounded,
                color: Color(0xFF6B7280),
                size: 36,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              hasSearchQuery || hasSelectedCategory
                  ? 'No matching stores found'
                  : 'No stores available',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hasSearchQuery || hasSelectedCategory
                  ? 'Try adjusting your search or browse different categories'
                  : 'Check back later for new stores and exciting offers',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 32),
            if (hasSearchQuery || hasSelectedCategory)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (hasSearchQuery)
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
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.clear_rounded, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Clear Search',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  if (hasSearchQuery && hasSelectedCategory)
                    const SizedBox(width: 12),
                  if (hasSelectedCategory)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedCategory = null;
                        });
                        context.read<VendorsBloc>().add(
                          const FilterVendorsByCategory(null),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6F3FCC),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.apps_rounded, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Show All',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
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

class ModernVendorCard extends StatelessWidget {
  const ModernVendorCard({super.key, required this.vendor, this.onTap});

  final Vendor vendor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = vendor.images.isNotEmpty
        ? vendor.images[0].imageUrl
        : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8E9EA), width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Vendor Image with playful design
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: imageUrl != null
                            ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholderImage(),
                        )
                            : _buildPlaceholderImage(),
                      ),
                    ),
                    // Playful indicator dot
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                // Vendor Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              vendor.businessName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A202C),
                                letterSpacing: -0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (vendor.address != null) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              size: 14,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                vendor.address!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                      Row(
                        children: [
                          // Category badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6F3FCC).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF6F3FCC).withOpacity(0.2),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              vendor.category,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6F3FCC),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                          // Fun arrow indicator
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFE8E9EA),
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                              color: Color(0xFF6F3FCC),
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
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    final categoryIcon = CategoriesConstants.getCategoryIcon(vendor.category);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: categoryIcon.isNotEmpty
          ? ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          categoryIcon,
          fit: BoxFit.contain,
          width: 40,
          height: 40,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(
            Icons.storefront_rounded,
            color: Color(0xFF6F3FCC),
            size: 32,
          ),
        ),
      )
          : const Icon(
        Icons.storefront_rounded,
        color: Color(0xFF6F3FCC),
        size: 32,
      ),
    );
  }
}
