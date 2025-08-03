import 'package:flutter/material.dart';

/// Model class for bottom navigation items
class BottomNavItem {
  const BottomNavItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final IconData? selectedIcon;
  final VoidCallback? onTap;
}

/// Custom bottom navigation bar widget
class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
    this.currentIndex = 0,
    this.onTap,
    this.items = const [],
  });

  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<BottomNavItem> items;

  @override
  Widget build(BuildContext context) {
    final defaultItems = items.isEmpty ? _getDefaultItems() : items;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: defaultItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return _NavBarItem(
                item: item,
                isSelected: index == currentIndex,
                onTap: () => onTap?.call(index),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  List<BottomNavItem> _getDefaultItems() {
    return const [
      BottomNavItem(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: 'Home',
      ),
      BottomNavItem(
        icon: Icons.shopping_cart_outlined,
        selectedIcon: Icons.shopping_cart,
        label: 'Cart',
      ),
      BottomNavItem(
        icon: Icons.card_giftcard_outlined,
        selectedIcon: Icons.card_giftcard,
        label: 'Gift',
      ),
      BottomNavItem(
        icon: Icons.local_offer_outlined,
        selectedIcon: Icons.local_offer,
        label: 'Coupons',
      ),
      BottomNavItem(
        icon: Icons.person_outline,
        selectedIcon: Icons.person,
        label: 'Profile',
      ),
    ];
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({required this.item, required this.isSelected, this.onTap});

  final BottomNavItem item;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? (item.selectedIcon ?? item.icon) : item.icon,
              color: isSelected ? const Color(0xFF6F3FCC) : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? const Color(0xFF6F3FCC) : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
