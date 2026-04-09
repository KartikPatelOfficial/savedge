import 'package:flutter/material.dart';

import '../theme/gc_tokens.dart';

enum GcQuickFilter {
  onSale,
  under500,
  from500to2000,
  above2000,
  bigSaver,
}

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _chip(GcQuickFilter.onSale, 'On sale'),
          const SizedBox(width: 8),
          _chip(GcQuickFilter.under500, 'Under \u20B9500'),
          const SizedBox(width: 8),
          _chip(GcQuickFilter.from500to2000, '\u20B9500 – \u20B92000'),
          const SizedBox(width: 8),
          _chip(GcQuickFilter.above2000, 'Above \u20B92000'),
          const SizedBox(width: 8),
          _chip(GcQuickFilter.bigSaver, 'Big savers'),
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
