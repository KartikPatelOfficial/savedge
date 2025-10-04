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
    this.isEmployee = false,
  });

  final int currentIndex;
  final ValueChanged<int>? onTap;
  final List<BottomNavItem> items;
  final bool isEmployee;

  @override
  Widget build(BuildContext context) {
    final defaultItems = items.isEmpty ? _getDefaultItems() : items;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
    final List<BottomNavItem> navItems = [
      const BottomNavItem(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: 'Home',
      ),
    ];

    // Only show Gift tab for employees
    if (isEmployee) {
      navItems.add(
        const BottomNavItem(
          icon: Icons.card_giftcard_outlined,
          selectedIcon: Icons.card_giftcard,
          label: 'Gift',
        ),
      );
    }

    navItems.addAll([
      const BottomNavItem(
        icon: Icons.local_offer_outlined,
        selectedIcon: Icons.local_offer,
        label: 'Coupons',
      ),
      const BottomNavItem(
        icon: Icons.person_outline,
        selectedIcon: Icons.person,
        label: 'Profile',
      ),
    ]);

    return navItems;
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF6F3FCC).withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isSelected ? (item.selectedIcon ?? item.icon) : item.icon,
                color: isSelected
                    ? const Color(0xFF6F3FCC)
                    : const Color(0xFF718096),
                size: 24,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? const Color(0xFF6F3FCC)
                    : const Color(0xFF718096),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
