import 'package:flutter/material.dart';

/// Model class for category items
class CategoryItem {
  const CategoryItem({
    required this.title,
    required this.icon,
    required this.color,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
}

/// Categories section widget with grid layout
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    this.title = 'Our Categories',
    this.categories = const [],
    this.onSeeAllTap,
  });

  final String title;
  final List<CategoryItem> categories;
  final VoidCallback? onSeeAllTap;

  @override
  Widget build(BuildContext context) {
    final defaultCategories = categories.isEmpty
        ? _getDefaultCategories()
        : categories;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: title, onSeeAllTap: onSeeAllTap),
          const SizedBox(height: 24),
          _CategoriesGrid(categories: defaultCategories),
        ],
      ),
    );
  }

  List<CategoryItem> _getDefaultCategories() {
    return [
      const CategoryItem(
        title: 'Restaurant',
        icon: Icons.restaurant,
        color: Color(0xFFFF6B7A),
      ),
      const CategoryItem(
        title: 'Saloon',
        icon: Icons.content_cut,
        color: Color(0xFF4CAF50),
      ),
      const CategoryItem(
        title: 'Theater',
        icon: Icons.movie,
        color: Color(0xFF2196F3),
      ),
      const CategoryItem(
        title: 'Fast Food',
        icon: Icons.fastfood,
        color: Color(0xFFFF9800),
      ),
    ];
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
  const _CategoriesGrid({required this.categories});

  final List<CategoryItem> categories;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories
          .map((category) => CategoryItemWidget(category: category))
          .toList(),
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
      child: SizedBox(
        width: 76,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(category.icon, color: category.color, size: 32),
            ),
            const SizedBox(height: 12),
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
      ),
    );
  }
}
