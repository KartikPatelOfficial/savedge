import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:savedge/features/gift_cards/presentation/theme/gc_tokens.dart';

enum GcQuickFilter {
  onSale,
  under500,
  from500to2000,
  above2000,
  bigSaver,
}

/// Horizontal row of price/sale filter pills. Each pill pairs a thin-stroke
/// Lucide icon with a label. Unselected pills are white with a hairline border
/// and a faint shadow; the active pill is filled violet.
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
          _chip(GcQuickFilter.onSale, 'On sale', LucideIcons.tag),
          const SizedBox(width: 8),
          _chip(GcQuickFilter.under500, 'Under ₹500', LucideIcons.wallet),
          const SizedBox(width: 8),
          _chip(
            GcQuickFilter.from500to2000,
            '₹500 – ₹2000',
            LucideIcons.badgeIndianRupee,
          ),
          const SizedBox(width: 8),
          _chip(
            GcQuickFilter.above2000,
            'Above ₹2000',
            LucideIcons.layoutGrid,
          ),
          const SizedBox(width: 8),
          _chip(GcQuickFilter.bigSaver, 'Big savers', LucideIcons.sparkles),
        ],
      ),
    );
  }

  Widget _chip(GcQuickFilter v, String label, IconData icon) {
    final isSelected = selected == v;
    return GestureDetector(
      onTap: () => onChanged(isSelected ? null : v),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
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
              : GcTokens.tinyShadow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: isSelected ? Colors.white : GcTokens.primary,
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: isSelected ? Colors.white : GcTokens.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
