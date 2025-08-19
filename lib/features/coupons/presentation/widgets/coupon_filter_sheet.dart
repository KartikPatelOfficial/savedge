import 'package:flutter/material.dart';

class CouponFilterSheet extends StatefulWidget {
  const CouponFilterSheet({
    super.key,
    required this.selectedCategory,
    required this.sortBy,
    required this.onFiltersChanged,
  });

  final String selectedCategory;
  final String sortBy;
  final Function(String category, String sortBy) onFiltersChanged;

  @override
  State<CouponFilterSheet> createState() => _CouponFilterSheetState();
}

class _CouponFilterSheetState extends State<CouponFilterSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  late String _selectedCategory;
  late String _selectedSort;
  double _minDiscount = 0;
  double _maxDiscount = 100;
  bool _showExpiringSoon = false;
  bool _showGiftedOnly = false;

  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'all',
      'title': 'All Coupons',
      'subtitle': 'Show all available coupons',
      'icon': Icons.dashboard_rounded,
      'color': const Color(0xFF6F3FCC),
    },
    {
      'id': 'active',
      'title': 'Active',
      'subtitle': 'Ready to use coupons',
      'icon': Icons.local_offer_rounded,
      'color': const Color(0xFF10B981),
    },
    {
      'id': 'used',
      'title': 'Used',
      'subtitle': 'Already redeemed coupons',
      'icon': Icons.check_circle_rounded,
      'color': const Color(0xFFF59E0B),
    },
    {
      'id': 'gifts',
      'title': 'Gifts',
      'subtitle': 'Received as gifts',
      'icon': Icons.card_giftcard_rounded,
      'color': const Color(0xFFEF4444),
    },
    {
      'id': 'expiring',
      'title': 'Expiring Soon',
      'subtitle': 'Expires within 7 days',
      'icon': Icons.schedule_rounded,
      'color': const Color(0xFFFF6B35),
    },
  ];

  final List<Map<String, dynamic>> _sortOptions = [
    {
      'id': 'newest',
      'title': 'Newest First',
      'subtitle': 'Recently acquired coupons',
      'icon': Icons.fiber_new_rounded,
    },
    {
      'id': 'expiry',
      'title': 'Expiry Date',
      'subtitle': 'Expiring soonest first',
      'icon': Icons.schedule_rounded,
    },
    {
      'id': 'value',
      'title': 'Discount Value',
      'subtitle': 'Highest discount first',
      'icon': Icons.trending_up_rounded,
    },
    {
      'id': 'vendor',
      'title': 'Vendor Name',
      'subtitle': 'Alphabetical order',
      'icon': Icons.sort_by_alpha_rounded,
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory;
    _selectedSort = widget.sortBy;
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, (1 - _animation.value) * 400),
          child: Container(
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
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCategoriesSection(),
                        const SizedBox(height: 32),
                        _buildSortSection(),
                        const SizedBox(height: 32),
                        _buildDiscountRangeSection(),
                        const SizedBox(height: 32),
                        _buildAdvancedFilters(),
                        const SizedBox(height: 32),
                        _buildActionButtons(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              color: const Color(0xFF6F3FCC).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Color(0xFF6F3FCC),
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filter & Sort',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Find exactly what you\'re looking for',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close_rounded,
              color: Color(0xFF64748B),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...(_categories.map((category) {
          final isSelected = _selectedCategory == category['id'];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: isSelected
                  ? const Color(0xFF6F3FCC).withOpacity(0.1)
                  : Colors.grey[50],
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  setState(() => _selectedCategory = category['id']);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF6F3FCC)
                          : Colors.grey[200]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (category['color'] as Color)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          category['icon'] as IconData,
                          color: isSelected ? Colors.white : Colors.grey[600],
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category['title'] as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? const Color(0xFF6F3FCC)
                                    : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              category['subtitle'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: Color(0xFF6F3FCC),
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList()),
      ],
    );
  }

  Widget _buildSortSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sort By',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...(_sortOptions.map((option) {
          final isSelected = _selectedSort == option['id'];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              color: isSelected
                  ? const Color(0xFF6F3FCC).withOpacity(0.1)
                  : Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() => _selectedSort = option['id']);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        option['icon'] as IconData,
                        color: isSelected
                            ? const Color(0xFF6F3FCC)
                            : Colors.grey[600],
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option['title'] as String,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? const Color(0xFF6F3FCC)
                                    : Colors.black87,
                              ),
                            ),
                            Text(
                              option['subtitle'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Radio<String>(
                        value: option['id'],
                        groupValue: _selectedSort,
                        onChanged: (value) {
                          setState(() => _selectedSort = value!);
                        },
                        activeColor: const Color(0xFF6F3FCC),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList()),
      ],
    );
  }

  Widget _buildDiscountRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Discount Range',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_minDiscount.toInt()}%',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6F3FCC),
                    ),
                  ),
                  Text(
                    '${_maxDiscount.toInt()}%',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6F3FCC),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RangeSlider(
                values: RangeValues(_minDiscount, _maxDiscount),
                min: 0,
                max: 100,
                divisions: 20,
                activeColor: const Color(0xFF6F3FCC),
                inactiveColor: Colors.grey[300],
                onChanged: (values) {
                  setState(() {
                    _minDiscount = values.start;
                    _maxDiscount = values.end;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdvancedFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Advanced Filters',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildFilterToggle(
          title: 'Expiring Soon',
          subtitle: 'Show coupons expiring within 7 days',
          icon: Icons.schedule_rounded,
          value: _showExpiringSoon,
          onChanged: (value) => setState(() => _showExpiringSoon = value),
        ),
        const SizedBox(height: 12),
        _buildFilterToggle(
          title: 'Gifted Coupons Only',
          subtitle: 'Show only received gift coupons',
          icon: Icons.card_giftcard_rounded,
          value: _showGiftedOnly,
          onChanged: (value) => setState(() => _showGiftedOnly = value),
        ),
      ],
    );
  }

  Widget _buildFilterToggle({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: value ? const Color(0xFF6F3FCC).withOpacity(0.1) : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? const Color(0xFF6F3FCC) : Colors.grey[200]!,
          width: value ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: value ? const Color(0xFF6F3FCC) : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: value ? Colors.white : Colors.grey[600],
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: value ? const Color(0xFF6F3FCC) : Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF6F3FCC),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedCategory = 'all';
                _selectedSort = 'newest';
                _minDiscount = 0;
                _maxDiscount = 100;
                _showExpiringSoon = false;
                _showGiftedOnly = false;
              });
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Color(0xFF6F3FCC), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Reset',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6F3FCC),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              widget.onFiltersChanged(_selectedCategory, _selectedSort);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6F3FCC),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Apply Filters',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}