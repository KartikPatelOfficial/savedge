import 'package:flutter/material.dart';

import '../../domain/entities/gift_card_entity.dart';
import '../theme/gc_tokens.dart';

/// Category selector for the gift-card page.
///
/// A flat, wrapping chip set — an "All" chip, the first few categories, then a
/// "More" chip that opens the full list in a dialog. Selection is single-value:
/// tapping the active chip (or "All") clears the filter via `onSelect(null)`, so
/// exactly one chip is ever active. Selection is shown with the category's accent
/// (tint + border + dot), never a filled bar — and no elevation/shadow/gradient.
class GcCategoryGrid extends StatelessWidget {
  const GcCategoryGrid({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });

  final List<GiftCardCategoryEntity> categories;
  final int? selectedId;
  final ValueChanged<GiftCardCategoryEntity?> onSelect;

  /// How many category chips show inline before collapsing into "More".
  static const int _inlineCount = 5;

  Color _accentOf(GiftCardCategoryEntity c) {
    final idx = categories.indexWhere((x) => x.id == c.id);
    return GcTokens.categoryAccentFor(idx < 0 ? 0 : idx);
  }

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    // Keep the active category visible even when it lives past the inline cut-off.
    GiftCardCategoryEntity? selected;
    for (final c in categories) {
      if (c.id == selectedId) {
        selected = c;
        break;
      }
    }

    var visible = categories.take(_inlineCount).toList();
    if (selected != null && !visible.any((c) => c.id == selected!.id)) {
      visible = [
        selected,
        ...categories
            .where((c) => c.id != selected!.id)
            .take(_inlineCount - 1),
      ];
    }
    final hasMore = categories.length > visible.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          GcCategoryChip(
            label: 'All',
            accent: GcTokens.primary,
            leadingIcon: Icons.grid_view_rounded,
            selected: selectedId == null,
            onTap: () => onSelect(null),
          ),
          for (final c in visible)
            GcCategoryChip(
              label: c.name,
              accent: _accentOf(c),
              selected: c.id == selectedId,
              onTap: () => onSelect(c.id == selectedId ? null : c),
            ),
          if (hasMore)
            GcCategoryChip(
              label: 'More',
              accent: GcTokens.textTertiary,
              leadingIcon: Icons.more_horiz_rounded,
              selected: false,
              onTap: () => _GcCategorySheet.show(
                context,
                categories: categories,
                selectedId: selectedId,
                accentOf: _accentOf,
                onSelect: onSelect,
              ),
            ),
        ],
      ),
    );
  }
}

/// Flat selectable pill. Unselected: white with a hairline border and an accent
/// dot. Selected: a soft accent tint with an accent border. No shadow.
class GcCategoryChip extends StatelessWidget {
  const GcCategoryChip({
    super.key,
    required this.label,
    required this.accent,
    required this.selected,
    required this.onTap,
    this.leadingIcon,
  });

  final String label;
  final Color accent;
  final bool selected;
  final VoidCallback onTap;

  /// Optional icon instead of the default colour dot (used by "All" / "More").
  final IconData? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final borderColor = selected ? accent : const Color(0xFFEFEAFB);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? accent.withValues(alpha: 0.10) : Colors.white,
          borderRadius: BorderRadius.circular(GcTokens.rPill),
          border: Border.all(
            color: borderColor,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leadingIcon != null)
              Icon(leadingIcon, size: 15, color: accent)
            else
              _Dot(color: accent),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: GcTokens.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

/// "More" dialog: the full category list as the same flat chips, on a plain
/// rounded white surface that matches the page — no elevation/shadow/gradient.
class _GcCategorySheet extends StatelessWidget {
  const _GcCategorySheet({
    required this.categories,
    required this.selectedId,
    required this.accentOf,
    required this.onSelect,
  });

  final List<GiftCardCategoryEntity> categories;
  final int? selectedId;
  final Color Function(GiftCardCategoryEntity) accentOf;
  final ValueChanged<GiftCardCategoryEntity?> onSelect;

  static Future<void> show(
    BuildContext context, {
    required List<GiftCardCategoryEntity> categories,
    required int? selectedId,
    required Color Function(GiftCardCategoryEntity) accentOf,
    required ValueChanged<GiftCardCategoryEntity?> onSelect,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: const Color(0x33101828),
      builder: (_) => _GcCategorySheet(
        categories: categories,
        selectedId: selectedId,
        accentOf: accentOf,
        onSelect: onSelect,
      ),
    );
  }

  void _pick(BuildContext context, GiftCardCategoryEntity? c) {
    onSelect(c);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.7;
    return Dialog(
      elevation: 0,
      backgroundColor: GcTokens.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(GcTokens.rHero),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 12, 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Browse categories',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: GcTokens.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Pick a category to filter vouchers.',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: GcTokens.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                    color: GcTokens.textTertiary,
                    splashRadius: 20,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: GcTokens.divider),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 22),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: [
                    GcCategoryChip(
                      label: 'All',
                      accent: GcTokens.primary,
                      leadingIcon: Icons.grid_view_rounded,
                      selected: selectedId == null,
                      onTap: () => _pick(context, null),
                    ),
                    for (final c in categories)
                      GcCategoryChip(
                        label: c.name,
                        accent: accentOf(c),
                        selected: c.id == selectedId,
                        onTap: () => _pick(context, c.id == selectedId ? null : c),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
