import 'package:flutter/material.dart';

import '../theme/gc_tokens.dart';

enum GcQuickFilter { topBrands, save20, save30, trending }

class GcQuickFilterChips extends StatelessWidget {
  const GcQuickFilterChips({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final GcQuickFilter? selected;
  final ValueChanged<GcQuickFilter?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _chip(GcQuickFilter.topBrands, 'Top Brands'),
          const SizedBox(width: 8),
          _chip(GcQuickFilter.save20, 'Save 20%+'),
          const SizedBox(width: 8),
          _chip(GcQuickFilter.save30, 'Save 30%+'),
          const SizedBox(width: 8),
          _chip(GcQuickFilter.trending, 'Trending'),
        ],
      ),
    );
  }

  Widget _chip(GcQuickFilter v, String label) {
    final isSelected = selected == v;
    return GestureDetector(
      onTap: () => onChanged(isSelected ? null : v),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? GcTokens.primary : Colors.white,
          borderRadius: BorderRadius.circular(GcTokens.rPill),
          border: Border.all(
            color: isSelected ? GcTokens.primary : const Color(0xFFEFEAFB),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: GcTokens.primary.withValues(alpha: 0.30),
                    offset: const Offset(0, 6),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.white : GcTokens.textPrimary,
          ),
        ),
      ),
    );
  }
}
