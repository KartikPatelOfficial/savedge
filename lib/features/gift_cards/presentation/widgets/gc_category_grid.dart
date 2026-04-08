import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/gift_card_entity.dart';
import '../theme/gc_tokens.dart';

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

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();
    final items = categories.take(6).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: items.length,
        itemBuilder: (_, i) {
          final c = items[i];
          final selected = c.id == selectedId;
          final bg = GcTokens.categoryBgFor(i);
          final accent = GcTokens.categoryAccentFor(i);
          return GestureDetector(
            onTap: () => onSelect(selected ? null : c),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selected ? accent : Colors.transparent,
                  width: selected ? 2 : 0,
                ),
              ),
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: GcTokens.tinyShadow,
                        ),
                        child: ClipOval(
                          child: c.imageUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: c.imageUrl!,
                                  fit: BoxFit.cover,
                                  errorWidget: (_, __, ___) => Icon(
                                    Icons.card_giftcard_rounded,
                                    color: accent,
                                  ),
                                )
                              : Icon(
                                  Icons.card_giftcard_rounded,
                                  color: accent,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          c.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: GcTokens.textPrimary,
                            height: 1.15,
                          ),
                        ),
                      ),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(
                          Icons.arrow_outward_rounded,
                          size: 14,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
