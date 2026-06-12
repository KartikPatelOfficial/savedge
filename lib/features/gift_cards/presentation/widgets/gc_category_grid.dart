import 'package:flutter/material.dart';

import 'package:savedge/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:savedge/features/gift_cards/presentation/theme/gc_tokens.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gc_category_icons.dart';

/// Category selector for the gift-card page.
///
/// A 3-column grid of tiles — an "All" tile, the first few categories, then a
/// "More" tile that opens the full list in a dialog. Each tile pairs a
/// thin-stroke Lucide icon with the category name. Selection is single-value:
/// tapping the active tile (or "All") clears the filter via `onSelect(null)`, so
/// exactly one tile is ever active. The active tile is shown with a violet tint
/// and border; the rest are white with a hairline border and a faint shadow.
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

  /// How many category tiles show inline before collapsing into "More".
  /// 7 keeps the grid a clean 3×3: the "All" tile + 7 categories + the "More"
  /// tile = 9 cells. The rest live in the "More" sheet.
  static const int _inlineCount = 7;

  /// Columns in the grid and the gap between tiles.
  static const int _columns = 3;
  static const double _gap = 10;

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
        ...categories.where((c) => c.id != selected!.id).take(_inlineCount - 1),
      ];
    }
    final hasMore = categories.length > visible.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 2, 16, 4),
      child: LayoutBuilder(
        builder: (context, c) {
          final tileWidth =
              ((c.maxWidth - _gap * (_columns - 1)) / _columns).floorToDouble();
          return Wrap(
            spacing: _gap,
            runSpacing: _gap,
            children: [
              GcCategoryTile(
                width: tileWidth,
                label: 'All',
                icon: GcCategoryIcon.all,
                selected: selectedId == null,
                onTap: () => onSelect(null),
              ),
              for (final cat in visible)
                GcCategoryTile(
                  width: tileWidth,
                  label: cat.name,
                  icon: GcCategoryIcon.forName(cat.name),
                  selected: cat.id == selectedId,
                  onTap: () => onSelect(cat.id == selectedId ? null : cat),
                ),
              if (hasMore)
                GcCategoryTile(
                  width: tileWidth,
                  label: 'More',
                  icon: GcCategoryIcon.more,
                  selected: false,
                  onTap: () => _GcCategorySheet.show(
                    context,
                    categories: categories,
                    selectedId: selectedId,
                    onSelect: onSelect,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// A single grid tile: a thin-stroke icon above a (max two-line) centered
/// label. Stacking vertically gives the label the full tile width, so longer
/// category names wrap cleanly instead of truncating in the narrow 3-column
/// grid. Unselected tiles are white with a hairline border and a faint shadow;
/// the active tile gets a soft violet tint and a violet border.
class GcCategoryTile extends StatelessWidget {
  const GcCategoryTile({
    super.key,
    required this.width,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final double width;
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          width: width,
          constraints: const BoxConstraints(minHeight: 84),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? GcTokens.primary.withValues(alpha: 0.08)
                : Colors.white,
            borderRadius: BorderRadius.circular(GcTokens.rCard),
            border: Border.all(
              color: selected ? GcTokens.primary : const Color(0xFFEFEAFB),
              width: selected ? 1.5 : 1,
            ),
            boxShadow: selected ? null : GcTokens.tinyShadow,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 23, color: GcTokens.primary),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.18,
                  fontWeight: FontWeight.w700,
                  color: GcTokens.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "More" dialog: the full category list as the same grid tiles, on a plain
/// rounded white surface that matches the page — no elevation/shadow/gradient.
class _GcCategorySheet extends StatelessWidget {
  const _GcCategorySheet({
    required this.categories,
    required this.selectedId,
    required this.onSelect,
  });

  final List<GiftCardCategoryEntity> categories;
  final int? selectedId;
  final ValueChanged<GiftCardCategoryEntity?> onSelect;

  static const int _columns = 3;
  static const double _gap = 10;

  static Future<void> show(
    BuildContext context, {
    required List<GiftCardCategoryEntity> categories,
    required int? selectedId,
    required ValueChanged<GiftCardCategoryEntity?> onSelect,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: const Color(0x33101828),
      builder: (_) => _GcCategorySheet(
        categories: categories,
        selectedId: selectedId,
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
                child: LayoutBuilder(
                  builder: (context, c) {
                    final tileWidth =
                        ((c.maxWidth - _gap * (_columns - 1)) / _columns)
                            .floorToDouble();
                    return Wrap(
                      spacing: _gap,
                      runSpacing: _gap,
                      children: [
                        GcCategoryTile(
                          width: tileWidth,
                          label: 'All',
                          icon: GcCategoryIcon.all,
                          selected: selectedId == null,
                          onTap: () => _pick(context, null),
                        ),
                        for (final cat in categories)
                          GcCategoryTile(
                            width: tileWidth,
                            label: cat.name,
                            icon: GcCategoryIcon.forName(cat.name),
                            selected: cat.id == selectedId,
                            onTap: () =>
                                _pick(context, cat.id == selectedId ? null : cat),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
