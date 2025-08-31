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

/// Categories section widget with grid layout
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    this.title = 'Our Categories',
    this.onCategoryTap,
  });

  final String title;
  final Function(String)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
          const SizedBox(height: 20),
          _CategoriesGrid(onCategoryTap: onCategoryTap),
        ],
      ),
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
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A202C),
          ),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: const Text(
            'See all',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6F3FCC),
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
      height: 100,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        scrollDirection: Axis.horizontal,
        itemCount: displayCategories.length,
        itemBuilder: (context, index) {
          final category = displayCategories[index];
          final iconPath = CategoriesConstants.getCategoryIcon(category);

          return Container(
            width: 76,
            margin: EdgeInsets.only(
              right: index == displayCategories.length - 1 ? 0 : 16,
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

/// Individual category item widget
class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({super.key, required this.category});

  final CategoryItem category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: category.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Category icon from assets
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                category.iconPath,
                width: 64,
                height: 64,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.category_outlined,
                    color: Color(0xFF6F3FCC),
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Category title
          Text(
            category.title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D3748),
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
