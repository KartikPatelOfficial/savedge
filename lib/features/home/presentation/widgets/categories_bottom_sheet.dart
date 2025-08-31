import 'package:flutter/material.dart';
import 'package:savedge/core/constants/categories_constants.dart';

/// Categories bottom sheet displaying all categories in a grid layout
class CategoriesBottomSheet extends StatelessWidget {
  const CategoriesBottomSheet({super.key, this.onCategoryTap});

  final Function(String)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Title
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'All Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Categories grid
          Flexible(child: _buildCategoriesGrid(context)),
          // Bottom padding for safe area
          SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.85,
      ),
      itemCount: CategoriesConstants.categories.length,
      itemBuilder: (context, index) {
        final category = CategoriesConstants.categories[index];
        final iconPath = CategoriesConstants.getCategoryIcon(category);

        return _buildCategoryCard(
          context: context,
          category: category,
          iconPath: iconPath,
          onTap: () => _onCategoryTap(context, category),
        );
      },
    );
  }

  Widget _buildCategoryCard({
    required BuildContext context,
    required String category,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Category icon from assets
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              iconPath,
              width: 56,
              height: 56,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.category_outlined,
                  color: Color(0xFF6F3FCC),
                  size: 28,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Category title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              category,
              style: const TextStyle(
                fontSize: 12,
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

  void _onCategoryTap(BuildContext context, String category) {
    // Close the bottom sheet first
    Navigator.pop(context);

    // Call the callback if provided
    if (onCategoryTap != null) {
      onCategoryTap!(category);
    } else {
      // Default feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Selected: $category'),
          backgroundColor: const Color(0xFF6F3FCC),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  /// Static method to show the bottom sheet
  static Future<void> show({
    required BuildContext context,
    Function(String)? onCategoryTap,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return CategoriesBottomSheet(onCategoryTap: onCategoryTap);
          },
        );
      },
    );
  }
}
