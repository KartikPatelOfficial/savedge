import 'package:flutter/material.dart';
import 'package:savedge/features/coupons/presentation/widgets/filter_chips_widget.dart';

/// Persistent header delegate for status filter chips
/// Makes the filter chips sticky at the top when scrolling
class StatusFilterDelegate extends SliverPersistentHeaderDelegate {
  StatusFilterDelegate({
    required this.filters,
    required this.selectedFilter,
    required this.onFilterSelected,
    this.isScrolled = false,
  });

  final List<String> filters;
  final String selectedFilter;
  final Function(String) onFilterSelected;
  final bool isScrolled;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: FilterChipsWidget(
        filters: filters,
        selectedFilter: selectedFilter,
        onFilterSelected: onFilterSelected,
      ),
    );
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(covariant StatusFilterDelegate oldDelegate) {
    return oldDelegate.selectedFilter != selectedFilter ||
        oldDelegate.isScrolled != isScrolled;
  }
}

/// Persistent header delegate for category filter chips
/// Makes the category filter chips sticky below the status filters
class CategoryFilterDelegate extends SliverPersistentHeaderDelegate {
  CategoryFilterDelegate({
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    this.isScrolled = false,
  });

  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final bool isScrolled;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: CategoryFilterChips(
        categories: categories,
        selectedCategory: selectedCategory,
        onCategorySelected: onCategorySelected,
      ),
    );
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(covariant CategoryFilterDelegate oldDelegate) {
    return oldDelegate.selectedCategory != selectedCategory ||
        oldDelegate.isScrolled != isScrolled;
  }
}
