import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Resolves a gift-card category name to a thin-stroke Lucide icon.
///
/// Categories come from the backend by name (admin-organized), so the mapping is
/// keyword-based with a sensible fallback. Matching is case-insensitive and uses
/// the first keyword that appears in the name.
class GcCategoryIcon {
  GcCategoryIcon._();

  /// Icon for the synthetic "All" tile.
  static const IconData all = LucideIcons.layoutGrid;

  /// Icon for the "More" tile that opens the full category list.
  static const IconData more = LucideIcons.ellipsis;

  /// Fallback when nothing matches.
  static const IconData fallback = LucideIcons.tag;

  /// Ordered keyword → icon rules. First contained keyword wins, so put more
  /// specific terms before broad ones.
  static const List<(List<String>, IconData)> _rules = [
    (['food', 'dining', 'restaurant', 'eat', 'cafe', 'coffee'], LucideIcons.utensils),
    (['grocery', 'supermarket', 'kirana'], LucideIcons.shoppingCart),
    (['entertain', 'ott', 'movie', 'stream', 'cinema'], LucideIcons.clapperboard),
    (['travel', 'hotel', 'flight', 'trip', 'holiday', 'stay'], LucideIcons.plane),
    (['fashion', 'apparel', 'cloth', 'wear', 'footwear', 'shoe'], LucideIcons.shirt),
    (['beauty', 'wellness', 'cosmetic', 'spa', 'salon', 'grooming'], LucideIcons.sparkles),
    (['gaming', 'game', 'esport'], LucideIcons.gamepad2),
    (['health', 'fitness', 'gym', 'medical', 'pharmacy', 'medicine'], LucideIcons.heartPulse),
    (['electronic', 'tech', 'gadget', 'mobile', 'recharge', 'telecom'], LucideIcons.smartphone),
    (['home', 'furniture', 'decor', 'living'], LucideIcons.sofa),
    (['book', 'education', 'learn', 'course', 'stationery'], LucideIcons.bookOpen),
    (['fuel', 'petrol', 'gas'], LucideIcons.fuel),
    (['jewel', 'gold', 'diamond'], LucideIcons.gem),
    (['kid', 'baby', 'toy'], LucideIcons.baby),
    (['shop', 'gift', 'store', 'retail', 'mall'], LucideIcons.shoppingBag),
  ];

  static IconData forName(String name) {
    final n = name.toLowerCase();
    for (final (keywords, icon) in _rules) {
      for (final k in keywords) {
        if (n.contains(k)) return icon;
      }
    }
    return fallback;
  }
}
