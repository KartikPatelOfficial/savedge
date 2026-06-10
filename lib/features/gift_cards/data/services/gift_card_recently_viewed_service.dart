import 'package:shared_preferences/shared_preferences.dart';

/// Frontend-only "recently viewed" tracker for gift card products.
/// FIFO capped at [_maxItems], persisted to [SharedPreferences].
class GiftCardRecentlyViewedService {
  GiftCardRecentlyViewedService(this._prefs);

  static const _key = 'gift_card_recently_viewed_ids';
  static const _maxItems = 10;

  final SharedPreferences _prefs;

  List<int> getIds() {
    final raw = _prefs.getStringList(_key) ?? const <String>[];
    return raw.map(int.tryParse).whereType<int>().toList(growable: false);
  }

  Future<void> record(int productId) async {
    final current = getIds().toList();
    current.remove(productId);
    current.insert(0, productId);
    if (current.length > _maxItems) {
      current.removeRange(_maxItems, current.length);
    }
    await _prefs.setStringList(
      _key,
      current.map((e) => e.toString()).toList(growable: false),
    );
  }
}
