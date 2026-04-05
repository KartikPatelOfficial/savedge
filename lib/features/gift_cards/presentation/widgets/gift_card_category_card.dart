import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entities/gift_card_entity.dart';

/// Visual category tile for horizontal scroll section.
/// Uses AnimatedContainer for selection transitions.
class GiftCardCategoryCard extends StatelessWidget {
  final GiftCardCategoryEntity category;
  final bool isSelected;
  final VoidCallback onTap;
  final int index;

  static const _palettes = [
    Color(0xFFF3EFFE),
    Color(0xFFFFF0E6),
    Color(0xFFE6F9F0),
    Color(0xFFE6F3FF),
    Color(0xFFFFF3E6),
    Color(0xFFFCE6F0),
  ];

  static const _accentPalettes = [
    Color(0xFF7C3AED),
    Color(0xFFEA580C),
    Color(0xFF059669),
    Color(0xFF2563EB),
    Color(0xFFD97706),
    Color(0xFFDB2777),
  ];

  const GiftCardCategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final palette = _palettes[index % _palettes.length];
    final accent = _accentPalettes[index % _accentPalettes.length];

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: palette,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? accent : const Color(0xFFF0F0F0),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (category.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: category.imageUrl!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Icon(
                      Icons.category_rounded,
                      size: 28,
                      color: accent,
                    ),
                    errorWidget: (_, __, ___) => Icon(
                      Icons.category_rounded,
                      size: 28,
                      color: accent,
                    ),
                  ),
                )
              else
                Icon(Icons.category_rounded, size: 28, color: accent),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF374151),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Text(
                '${category.productCount} cards',
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
