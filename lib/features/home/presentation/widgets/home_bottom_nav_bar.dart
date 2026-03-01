import 'dart:ui';

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

/// Custom bottom navigation bar widget with modern floating aesthetic
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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95), // Increased opacity
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.1),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6F3FCC).withOpacity(0.15),
                    // Brand color shadow
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
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
        ),
      ),
    );
  }

  List<BottomNavItem> _getDefaultItems() {
    final List<BottomNavItem> navItems = [
      const BottomNavItem(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home_rounded,
        label: 'Home',
      ),
    ];

    // Only show Gift tab for employees
    if (isEmployee) {
      navItems.add(
        const BottomNavItem(
          icon: Icons.card_giftcard_outlined,
          selectedIcon: Icons.card_giftcard_rounded,
          label: 'Gift',
        ),
      );
    }

    navItems.addAll([
      const BottomNavItem(
        icon: Icons.local_offer_outlined,
        selectedIcon: Icons.local_offer_rounded,
        label: 'Coupons',
      ),
      const BottomNavItem(
        icon: Icons.person_outline,
        selectedIcon: Icons.person_rounded,
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF6F3FCC) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF6F3FCC).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? (item.selectedIcon ?? item.icon) : item.icon,
              color: isSelected ? Colors.white : const Color(0xFFA0AEC0),
              size: 24,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: isSelected ? null : 0,
                child: Padding(
                  padding: EdgeInsets.only(left: isSelected ? 8 : 0),
                  child: Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
