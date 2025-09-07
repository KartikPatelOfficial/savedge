import 'package:hive_flutter/hive_flutter.dart';

import '../models/favorite_vendor_model.dart';

abstract class FavoritesLocalDataSource {
  Future<List<FavoriteVendorModel>> getFavorites();

  Future<void> addFavorite(FavoriteVendorModel vendor);

  Future<void> removeFavorite(int vendorId);

  Future<bool> isFavorite(int vendorId);

  Future<void> clearAllFavorites();
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const String _boxName = 'favorites';
  
  /// Get or open the favorites box
  Box<FavoriteVendorModel> _getBox() {
    return Hive.box<FavoriteVendorModel>(_boxName);
  }
  
  /// Initialize the box - should be called during app startup
  static Future<void> initializeBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<FavoriteVendorModel>(_boxName);
    }
  }

  @override
  Future<List<FavoriteVendorModel>> getFavorites() async {
    final box = _getBox();
    final favorites = box.values.toList();
    // Sort by added date, most recent first
    favorites.sort((a, b) => b.addedAt.compareTo(a.addedAt));
    return favorites;
  }

  @override
  Future<void> addFavorite(FavoriteVendorModel vendor) async {
    final box = _getBox();
    // Use vendorId as key for easy retrieval
    // According to Hive docs, put operations are synchronous by default
    box.put(vendor.vendorId.toString(), vendor);
  }

  @override
  Future<void> removeFavorite(int vendorId) async {
    final box = _getBox();
    // Delete returns bool indicating if key was found
    box.delete(vendorId.toString());
  }

  @override
  Future<bool> isFavorite(int vendorId) async {
    final box = _getBox();
    return box.containsKey(vendorId.toString());
  }

  @override
  Future<void> clearAllFavorites() async {
    final box = _getBox();
    // Clear all entries from the box
    box.clear();
  }
}
