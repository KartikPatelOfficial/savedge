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
        create: (context) =>
            getIt<VendorsBloc>()..add(LoadVendors(category: categoryParam)),
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
  bool _isLoadingMore = false;

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
    if (_isBottom && !_isLoadingMore) {
      final currentState = context.read<VendorsBloc>().state;
      if (currentState is VendorsLoaded && !currentState.hasReachedMax) {
        setState(() {
          _isLoadingMore = true;
        });
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
      backgroundColor: const Color(0xFFFAFBFC),
      body: BlocConsumer<VendorsBloc, VendorsState>(
        listener: (context, state) {
          // Reset loading flag when state changes
          if (state is VendorsLoaded || state is VendorsError) {
            if (_isLoadingMore) {
              setState(() {
                _isLoadingMore = false;
              });
            }
          }
        },
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
                leadingWidth: 56,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate the collapse progress
                    final expandedHeight = 140.0;
                    final minHeight =
                        kToolbarHeight + MediaQuery.of(context).padding.top;
                    final currentHeight = constraints.maxHeight;
                    final deltaHeight = expandedHeight - minHeight;
                    final t = ((currentHeight - minHeight) / deltaHeight).clamp(
                      0.0,
                      1.0,
                    );

                    // Interpolate left padding: expanded (20px) to collapsed (72px)
                    final leftPadding =
                        20.0 + (52.0 * (1 - t)); // 20 + 52 = 72 when collapsed

                    return FlexibleSpaceBar(
                      title: const Text(
                        'Discover Stores',
                        style: TextStyle(
                          color: Color(0xFF1A202C),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                      titlePadding: EdgeInsets.only(
                        left: leftPadding,
                        bottom: 16,
                        right: 20,
                      ),
                      centerTitle: false,
                    );
                  },
                ),
                iconTheme: const IconThemeData(color: Color(0xFF1A202C)),
              ),

              // Combined Search and Browse Section
              SliverToBoxAdapter(child: _buildSearchAndBrowseSection()),

              // Vendors List
              if (state is VendorsLoading)
                SliverFillRemaining(child: _buildLoadingWidget())
              else if (state is VendorsError)
                SliverFillRemaining(child: _buildErrorWidget(state.message))
              else if (state is VendorsLoaded)
                _buildSliverVendorsList(state)
              else
                const SliverToBoxAdapter(child: SizedBox.shrink()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchAndBrowseSection() {
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

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar without card styling
          Row(
            children: [
              Expanded(
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
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onChanged: (value) {
                    context.read<VendorsBloc>().add(SearchVendors(value));
                    setState(() {});
                  },
                ),
              ),
              if (_searchController.text.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      context.read<VendorsBloc>().add(const SearchVendors(''));
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Color(0xFF718096),
                        size: 16,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 20),

          // Categories without card container
          Row(
            children: [
              const Text(
                'Browse by category',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A5568),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: _showCategoriesBottomSheet,
                child: const Row(
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

          const SizedBox(height: 12),

          // Categories as inline chips
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: quickCategories.asMap().entries.map((entry) {
              final index = entry.key;
              final category = entry.value;
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

              return GestureDetector(
                onTap: () => _onCategorySelected(category),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? color : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? color : const Color(0xFFE2E8F0),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isSelected) ...[
                        const Icon(
                          Icons.check_circle,
                          size: 14,
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
              );
            }).toList(),
          ),
        ],
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
              index == 0 ? 20 : 0,
              20,
              index == state.vendors.length - 1 ? 40 : 16,
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

  bool get _hasAddress =>
      vendor.address != null && vendor.address!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final imageUrl = vendor.images.isNotEmpty
        ? vendor.images[0].imageUrl
        : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: _buildVibrantCard(imageUrl),
        ),
      ),
    );
  }

  Widget _buildVibrantCard(String? imageUrl) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),

        color: Colors.white,
      ),
      child: Stack(
        children: [
          // Background Pattern
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF6F3FCC).withOpacity(0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Main Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Vendor Image with Gradient Border
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.blueGrey),
                      ),
                      child: Container(
                        width: 74,
                        height: 74,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(17),
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
                    ),
                    const SizedBox(width: 16),
                    // Vendor Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Business Name
                          Text(
                            vendor.businessName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A202C),
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          // Category Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF6F3FCC).withOpacity(0.1),
                                  const Color(0xFF9F7AEA).withOpacity(0.1),
                                ],
                              ),
                            ),
                            child: Text(
                              vendor.category,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6F3FCC),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          // Location if available
                          if (_hasAddress) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF10B981,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Icon(
                                    Icons.location_on,
                                    size: 12,
                                    color: Color(0xFF10B981),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    vendor.address!,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Arrow with Vibrant Background
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6F3FCC), Color(0xFF9F7AEA)],
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                // Description
                if (vendor.description != null &&
                    vendor.description!.trim().isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      vendor.description!,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                        height: 1.4,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
                // Bottom Action Bar
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Coupons Available
                    if (vendor.coupons.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF10B981).withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.local_offer_rounded,
                              size: 14,
                              color: Color(0xFF10B981),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${vendor.coupons.length} offer${vendor.coupons.length == 1 ? '' : 's'}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF10B981),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    // View Store Button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF6F3FCC).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'View Store',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6F3FCC),
                          fontWeight: FontWeight.w700,
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
    );
  }

  Widget _buildPlaceholderImage() {
    final categoryIcon = CategoriesConstants.getCategoryIcon(vendor.category);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6F3FCC).withOpacity(0.1),
            const Color(0xFF9F7AEA).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: categoryIcon.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  categoryIcon,
                  fit: BoxFit.contain,
                  width: 48,
                  height: 48,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6F3FCC).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.storefront_rounded,
                      color: Color(0xFF6F3FCC),
                      size: 28,
                    ),
                  ),
                ),
              )
            : Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.storefront_rounded,
                  color: Color(0xFF6F3FCC),
                  size: 28,
                ),
              ),
      ),
    );
  }
}
