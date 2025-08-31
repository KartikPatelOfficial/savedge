import 'package:flutter/material.dart';
import 'package:savedge/core/constants/categories_constants.dart';

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
    this.onSeeAllTap,
    this.onCategoryTap,
  });

  final String title;
  final VoidCallback? onSeeAllTap;
  final Function(String)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: title, onSeeAllTap: onSeeAllTap),
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
      ],
    );
  }
}

class _CategoriesGrid extends StatelessWidget {
  const _CategoriesGrid({this.onCategoryTap});

  final Function(String)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: CategoriesConstants.categories.length,
        itemBuilder: (context, index) {
          final category = CategoriesConstants.categories[index];
          final iconPath = CategoriesConstants.getCategoryIcon(category);

          return CategoryItemWidget(
            category: CategoryItem(
              title: category,
              iconPath: iconPath,
              onTap: () => onCategoryTap?.call(category),
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                category.iconPath,
                width: 48,
                height: 48,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.category_outlined,
                    color: Color(0xFF6F3FCC),
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Category title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              category.title,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
