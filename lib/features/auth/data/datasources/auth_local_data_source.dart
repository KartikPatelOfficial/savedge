import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:savedge/core/constants/app_constants.dart';
import 'package:savedge/core/error/exceptions.dart';
import 'package:savedge/features/auth/data/models/user_model.dart';

/// Local data source for caching user data
abstract class AuthLocalDataSource {
  /// Gets cached user from local storage
  Future<UserModel?> getCachedUser();

  /// Caches user to local storage
  Future<void> cacheUser(UserModel user);

  /// Clears cached user data
  Future<void> clearUser();

  /// Gets auth token from local storage
  Future<String?> getAuthToken();

  /// Saves auth token to local storage
  Future<void> saveAuthToken(String token);

  /// Clears auth token
  Future<void> clearAuthToken();
}

/// Implementation of local data source using SharedPreferences
@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final userData = _preferences.getString(AppConstants.userDataKey);
      if (userData != null) {
        final Map<String, dynamic> userMap = 
            Map<String, dynamic>.from(json.decode(userData) as Map);
        return UserModel.fromJson(userMap);
      }
      return null;
    } catch (e) {
      throw const CacheException(message: 'Failed to get cached user');
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final userData = json.encode(user.toJson());
      await _preferences.setString(AppConstants.userDataKey, userData);
    } catch (e) {
      throw const CacheException(message: 'Failed to cache user');
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await _preferences.remove(AppConstants.userDataKey);
    } catch (e) {
      throw const CacheException(message: 'Failed to clear user data');
    }
  }

  @override
  Future<String?> getAuthToken() async {
    try {
      return _preferences.getString(AppConstants.authTokenKey);
    } catch (e) {
      throw const CacheException(message: 'Failed to get auth token');
    }
  }

  @override
  Future<void> saveAuthToken(String token) async {
    try {
      await _preferences.setString(AppConstants.authTokenKey, token);
    } catch (e) {
      throw const CacheException(message: 'Failed to save auth token');
    }
  }

  @override
  Future<void> clearAuthToken() async {
    try {
      await _preferences.remove(AppConstants.authTokenKey);
    } catch (e) {
      throw const CacheException(message: 'Failed to clear auth token');
    }
  }
}
