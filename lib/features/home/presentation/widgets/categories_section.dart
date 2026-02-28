import 'package:flutter/material.dart';
import 'package:savedge/core/constants/categories_constants.dart';
import 'package:savedge/features/home/presentation/widgets/categories_bottom_sheet.dart';

/// Model class for category items
class CategoryItem {
  const CategoryItem({required this.title, required this.iconPath, this.onTap});

  final String title;
  final String iconPath;
  final VoidCallback? onTap;
}

/// Modern Categories section widget with grid layout
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    this.title = 'Explore Categories',
    this.onCategoryTap,
  });

  final String title;
  final Function(String)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: _SectionHeader(
            title: title,
            onSeeAllTap: () {
              CategoriesBottomSheet.show(
                context: context,
                onCategoryTap: onCategoryTap,
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        _CategoriesGrid(onCategoryTap: onCategoryTap),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.onSeeAllTap});

  final String title;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A202C),
            letterSpacing: -0.5,
          ),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'See All',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6F3FCC),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoriesGrid extends StatelessWidget {
  const _CategoriesGrid({this.onCategoryTap});

  final Function(String)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    // Show only first 6 categories
    final displayCategories = CategoriesConstants.categories.take(6).toList();

    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        scrollDirection: Axis.horizontal,
        itemCount: displayCategories.length,
        itemBuilder: (context, index) {
          final category = displayCategories[index];
          final iconPath = CategoriesConstants.getCategoryIcon(category);

          return Container(
            width: 76,
            margin: EdgeInsets.only(
              right: index == displayCategories.length - 1 ? 0 : 20,
            ),
            child: CategoryItemWidget(
              category: CategoryItem(
                title: category,
                iconPath: iconPath,
                onTap: () => onCategoryTap?.call(category),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Premium individual category item widget
class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({super.key, required this.category});

  final CategoryItem category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: category.onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Category icon with squircle shape and shadow
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: const Color(0xFF6F3FCC).withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                category.iconPath,
                width: 48,
                height: 48,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.category_rounded,
                    color: Color(0xFF6F3FCC),
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Category title
          Text(
            category.title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A5568),
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
