import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class SecureStorageService {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _tokenExpiresAtKey = 'token_expires_at';
  static const _userIdKey = 'user_id';
  static const _userDataKey = 'user_data';
  static const _selectedCityIdKey = 'selected_city_id';
  static const _selectedCityNameKey = 'selected_city_name';

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Token Management
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
  }) async {
    await Future.wait([
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
      _storage.write(key: _tokenExpiresAtKey, value: expiresAt.toIso8601String()),
    ]);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<DateTime?> getTokenExpiresAt() async {
    final expiresAtString = await _storage.read(key: _tokenExpiresAtKey);
    if (expiresAtString != null) {
      return DateTime.parse(expiresAtString);
    }
    return null;
  }

  Future<bool> hasValidToken() async {
    final accessToken = await getAccessToken();
    final expiresAt = await getTokenExpiresAt();
    
    if (accessToken == null || expiresAt == null) {
      return false;
    }
    
    return DateTime.now().isBefore(expiresAt);
  }

  // User Data Management
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userIdKey, value: userId);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: _userIdKey);
  }

  Future<void> saveUserData(String userData) async {
    await _storage.write(key: _userDataKey, value: userData);
  }

  Future<String?> getUserData() async {
    return await _storage.read(key: _userDataKey);
  }

  // Clear all stored data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final accessToken = await getAccessToken();
    final userId = await getUserId();
    return accessToken != null && userId != null;
  }

  // City Selection Management
  Future<void> saveSelectedCity({
    required int cityId,
    required String cityName,
  }) async {
    await Future.wait([
      _storage.write(key: _selectedCityIdKey, value: cityId.toString()),
      _storage.write(key: _selectedCityNameKey, value: cityName),
    ]);
  }

  Future<int?> getSelectedCityId() async {
    final cityIdString = await _storage.read(key: _selectedCityIdKey);
    if (cityIdString != null) {
      return int.tryParse(cityIdString);
    }
    return null;
  }

  Future<String?> getSelectedCityName() async {
    return await _storage.read(key: _selectedCityNameKey);
  }

  Future<void> clearSelectedCity() async {
    await Future.wait([
      _storage.delete(key: _selectedCityIdKey),
      _storage.delete(key: _selectedCityNameKey),
    ]);
  }

  /// Check if user has selected a city
  Future<bool> hasCitySelected() async {
    final cityId = await getSelectedCityId();
    return cityId != null;
  }

  /// Check if user selected "Other" city (not available region)
  Future<bool> isOtherCitySelected() async {
    final cityId = await getSelectedCityId();
    return cityId == -1; // -1 is the special ID for "Other"
  }
}