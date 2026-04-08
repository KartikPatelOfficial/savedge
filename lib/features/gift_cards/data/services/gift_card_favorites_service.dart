import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Frontend-only wishlist for gift card products. Persists to
/// [SharedPreferences] and exposes a [ChangeNotifier] so widgets can rebuild
/// reactively without touching the existing GiftCardsBloc (which has many
/// discrete states rather than a single loaded state we could copyWith).
class GiftCardFavoritesService extends ChangeNotifier {
  GiftCardFavoritesService(this._prefs) {
    _load();
  }

  static const _key = 'gift_card_favorite_ids';

  final SharedPreferences _prefs;
  final Set<int> _ids = <int>{};

  Set<int> get ids => Set.unmodifiable(_ids);
  int get count => _ids.length;

  void _load() {
    final raw = _prefs.getStringList(_key) ?? const <String>[];
    _ids
      ..clear()
      ..addAll(raw.map(int.tryParse).whereType<int>());
  }

  bool isFavorite(int productId) => _ids.contains(productId);

  Future<void> toggle(int productId) async {
    if (!_ids.add(productId)) {
      _ids.remove(productId);
    }
    await _prefs.setStringList(
      _key,
      _ids.map((e) => e.toString()).toList(growable: false),
    );
    notifyListeners();
  }
}
