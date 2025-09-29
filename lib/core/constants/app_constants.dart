import 'package:flutter/foundation.dart';

/// Application-wide constants
class AppConstants {
  AppConstants._();

  // Environment keys
  static const String _developmentEnv = 'development';
  static const String _stagingEnv = 'staging';
  static const String _productionEnv = 'production';

  // API Endpoints per environment
  static const String _developmentBaseUrl = 'https://10.0.2.2:44447';
  static const String _stagingBaseUrl =
      'https://web-app-20250829054601.salmonhill-0be6c935.centralindia.azurecontainerapps.io';
  static const String _productionBaseUrl =
      'https://savedge-prod.calmmoss-be0e7220.centralindia.azurecontainerapps.io';

  /// Compile-time environment (can be overridden via --dart-define=APP_ENV=staging)
  static const String _environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: kDebugMode ? _developmentEnv : _productionEnv,
  );

  /// Normalized environment value in lowercase
  static String get environment => _environment.toLowerCase();

  /// The active API base URL for the current environment
  static String get baseUrl {
    switch (environment) {
      case _stagingEnv:
        return _stagingBaseUrl;
      case _productionEnv:
        return _productionBaseUrl;
      default:
        return _developmentBaseUrl;
    }
  }

  static const String apiVersion = 'v1';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';

  // App Info
  static const String appName = 'Savedge';
  static const String appVersion = '1.0.0';

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int maxNameLength = 100;

  // UI
  static const double defaultPadding = 20.0;
  static const double smallPadding = 12.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;

  static const double defaultRadius = 12.0;
  static const double smallRadius = 8.0;
  static const double mediumRadius = 12.0;
  static const double largeRadius = 16.0;
  static const double extraLargeRadius = 24.0;

  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 200);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  /// Cache keys
  static const String userCacheKey = 'CACHED_USER';
}
