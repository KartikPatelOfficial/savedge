import 'package:flutter/material.dart';
import 'package:savedge/features/coupons/data/models/coupon_gifting_models.dart';

class CouponFilterSheet extends StatefulWidget {
  const CouponFilterSheet({
    super.key,
    required this.selectedStatus,
    required this.selectedCategories,
    required this.couponsData,
    required this.onFiltersChanged,
  });

  final String selectedStatus;
  final List<String> selectedCategories;
  final UserCouponsResponseModel couponsData;
  final Function(String status, List<String> categories) onFiltersChanged;

  @override
  State<CouponFilterSheet> createState() => _CouponFilterSheetState();
}

class _CouponFilterSheetState extends State<CouponFilterSheet> {
  late String _selectedStatus;
  late Set<String> _selectedCategories;
  late List<Map<String, dynamic>> _categoryOptions;

  // Status filter options
  final List<Map<String, dynamic>> _statusOptions = [
    {
      'id': 'All',
      'title': 'All',
      'icon': Icons.dashboard_rounded,
      'color': const Color(0xFF6F3FCC),
    },
    {
      'id': 'Active',
      'title': 'Active',
      'icon': Icons.local_offer_rounded,
      'color': const Color(0xFF10B981),
    },
    {
      'id': 'Used',
      'title': 'Used',
      'icon': Icons.check_circle_rounded,
      'color': const Color(0xFFF59E0B),
    },
    {
      'id': 'Expired',
      'title': 'Expired',
      'icon': Icons.schedule_rounded,
      'color': const Color(0xFFEF4444),
    },
  ];

  // Map of category IDs to icons
  final Map<String, IconData> _categoryIconMap = {
    'Fast food': Icons.fastfood_rounded,
    'Restaurant': Icons.restaurant_rounded,
    'Salon': Icons.content_cut_rounded,
    'Gym': Icons.fitness_center_rounded,
    'Hotels': Icons.hotel_rounded,
    'Clothing store': Icons.checkroom_rounded,
    'Grocery': Icons.shopping_cart_rounded,
    'Cafe': Icons.local_cafe_rounded,
  };

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.selectedStatus;
    _selectedCategories = widget.selectedCategories.toSet();
    _categoryOptions = _extractCategories();
  }

  // Extract unique categories from loaded coupons
  List<Map<String, dynamic>> _extractCategories() {
    final Set<String> categories = {};

    // Get all coupons
    final allCoupons = [
      ...widget.couponsData.purchasedCoupons,
      ...widget.couponsData.giftedReceivedCoupons,
      ...widget.couponsData.usedCoupons,
      ...widget.couponsData.expiredCoupons,
    ];

    // Extract unique categories
    for (final coupon in allCoupons) {
      if (coupon.vendorCategory.isNotEmpty) {
        categories.add(coupon.vendorCategory);
      }
    }

    // Build category options list
    final List<Map<String, dynamic>> options = [
      {
        'id': 'All',
        'title': 'All Categories',
        'icon': Icons.grid_view_rounded,
      },
    ];

    // Add found categories with icons
    for (final category in categories) {
      options.add({
        'id': category,
        'title': category,
        'icon': _categoryIconMap[category] ?? Icons.local_offer_rounded,
      });
    }

    return options;
  }

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
          _buildHeader(),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusSection(),
                  const SizedBox(height: 24),
                  _buildCategorySection(),
                  const SizedBox(height: 24),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Color(0xFF6F3FCC),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          const Text(
            'Filter Coupons',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A202C),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close_rounded, size: 24),
            color: const Color(0xFF6B7280),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _statusOptions.map((status) {
            final isSelected = _selectedStatus == status['id'];
            return GestureDetector(
              onTap: () {
                setState(() => _selectedStatus = status['id']);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (status['color'] as Color).withValues(alpha: 0.1)
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? (status['color'] as Color)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      status['icon'] as IconData,
                      size: 18,
                      color: isSelected
                          ? (status['color'] as Color)
                          : const Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      status['title'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? (status['color'] as Color)
                            : const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _categoryOptions.map((category) {
            final categoryId = category['id'] as String;
            final isAll = categoryId == 'All';
            final isSelected = isAll
                ? _selectedCategories.isEmpty
                : _selectedCategories.contains(categoryId);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isAll) {
                    // Selecting "All" clears all other selections
                    _selectedCategories.clear();
                  } else {
                    // Toggle this category
                    if (_selectedCategories.contains(categoryId)) {
                      _selectedCategories.remove(categoryId);
                      // If no categories selected, default to "All"
                      if (_selectedCategories.isEmpty) {
                        // Do nothing, empty set means "All"
                      }
                    } else {
                      _selectedCategories.add(categoryId);
                    }
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF6F3FCC).withValues(alpha: 0.1)
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF6F3FCC)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      category['icon'] as IconData,
                      size: 18,
                      color: isSelected
                          ? const Color(0xFF6F3FCC)
                          : const Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      category['title'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? const Color(0xFF6F3FCC)
                            : const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedStatus = 'All';
                _selectedCategories.clear();
              });
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Color(0xFF6F3FCC), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Clear All',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6F3FCC),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              widget.onFiltersChanged(
                _selectedStatus,
                _selectedCategories.toList(),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color(0xFF6F3FCC),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Apply Filters',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
