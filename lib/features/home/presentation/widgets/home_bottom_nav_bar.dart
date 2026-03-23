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

/// Fluid bottom navigation bar — sliding pill indicator, icon + label
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
    final itemCount = defaultItems.length;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(26),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6F3FCC).withOpacity(0.14),
                blurRadius: 32,
                offset: const Offset(0, 10),
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final totalWidth = constraints.maxWidth;
              final itemWidth = totalWidth / itemCount;
              final indicatorW = itemWidth - 20;
              final indicatorLeft =
                  currentIndex * itemWidth + (itemWidth - indicatorW) / 2;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // ── Fluid sliding indicator ──────────────────────────────
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOutCubic,
                    left: indicatorLeft,
                    top: 10,
                    child: Container(
                      width: indicatorW,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE9FE),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),

                  // ── Nav items ────────────────────────────────────────────
                  Row(
                    children: defaultItems.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return _NavItem(
                        item: item,
                        isSelected: index == currentIndex,
                        onTap: () => onTap?.call(index),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<BottomNavItem> _getDefaultItems() {
    final List<BottomNavItem> navItems = [
      const BottomNavItem(
        icon: Icons.explore_outlined,
        selectedIcon: Icons.explore_rounded,
        label: 'Home',
      ),
    ];

    // Gift Cards hidden until Pine Labs integration is completed
    // if (isEmployee) {
    //   navItems.add(
    //     const BottomNavItem(
    //       icon: Icons.card_giftcard_outlined,
    //       selectedIcon: Icons.card_giftcard_rounded,
    //       label: 'Gift',
    //     ),
    //   );
    // }

    navItems.addAll([
      const BottomNavItem(
        icon: Icons.local_offer_outlined,
        selectedIcon: Icons.local_offer_rounded,
        label: 'Coupons',
      ),
      const BottomNavItem(
        icon: Icons.account_circle_outlined,
        selectedIcon: Icons.account_circle_rounded,
        label: 'Profile',
      ),
    ]);

    return navItems;
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.item,
    required this.isSelected,
    this.onTap,
  });

  final BottomNavItem item;
  final bool isSelected;
  final VoidCallback? onTap;

  static const _activeColor = Color(0xFF6F3FCC);
  static const _inactiveColor = Color(0xFFB8C1CC);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, anim) => ScaleTransition(
                    scale: anim,
                    child: child,
                  ),
                  child: Icon(
                    isSelected
                        ? (item.selectedIcon ?? item.icon)
                        : item.icon,
                    key: ValueKey(isSelected),
                    color: isSelected ? _activeColor : _inactiveColor,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected ? _activeColor : _inactiveColor,
                  letterSpacing: isSelected ? 0.1 : 0,
                ),
                child: Text(item.label, maxLines: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
