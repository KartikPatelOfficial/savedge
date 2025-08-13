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
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(title: title, onSeeAllTap: onSeeAllTap),
          const SizedBox(height: 20),
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
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        GestureDetector(
          onTap: onSeeAllTap,
          child: Text(
            'See all',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
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
        width: 70,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: category.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: category.color.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Icon(category.icon, color: category.color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              category.title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
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