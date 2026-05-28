import 'dart:io';

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
  static const String _stagingBaseUrl = 'https://staging.api.savedge.in';
  static const String _productionBaseUrl = 'https://api.savedge.in';

  /// Compile-time environment (can be overridden via --dart-define=APP_ENV=staging)
  static const String _environment = String.fromEnvironment(
    'APP_ENV',
    defaultValue: kDebugMode ? _developmentEnv : _productionEnv,
  );

  /// Normalized environment value in lowercase
  static String get environment => _environment.toLowerCase();

  /// The active API base URL for the current environment
  /// On iOS in development, uses staging URL since localhost isn't accessible
  static String get baseUrl {
    switch (environment) {
      case _stagingEnv:
        return _stagingBaseUrl;
      case _productionEnv:
        return _productionBaseUrl;
      default:
        return Platform.isIOS ? _stagingBaseUrl : _developmentBaseUrl;
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

  // MSG91 OTP Widget configuration (per env)
  // The widgetId and msg91WidgetAuthToken are client-side identifiers issued by MSG91.
  // They are not the SERVER auth key (which lives only on the backend) and are safe
  // to ship in the app, though they should still be rotated if leaked.
  static const String _devWidgetId = String.fromEnvironment(
    'MSG91_WIDGET_ID_DEV',
    defaultValue: '',
  );
  static const String _devMsg91AuthToken = String.fromEnvironment(
    'MSG91_AUTH_TOKEN_DEV',
    defaultValue: '',
  );
  static const String _stagingWidgetId = String.fromEnvironment(
    'MSG91_WIDGET_ID_STAGING',
    defaultValue: '',
  );
  static const String _stagingMsg91AuthToken = String.fromEnvironment(
    'MSG91_AUTH_TOKEN_STAGING',
    defaultValue: '',
  );
  static const String _prodWidgetId = String.fromEnvironment(
    'MSG91_WIDGET_ID_PROD',
    defaultValue: '',
  );
  static const String _prodMsg91AuthToken = String.fromEnvironment(
    'MSG91_AUTH_TOKEN_PROD',
    defaultValue: '',
  );

  static String get msg91WidgetId {
    switch (environment) {
      case _stagingEnv:
        return _stagingWidgetId;
      case _productionEnv:
        return _prodWidgetId;
      default:
        return _devWidgetId;
    }
  }

  static String get msg91WidgetAuthToken {
    switch (environment) {
      case _stagingEnv:
        return _stagingMsg91AuthToken;
      case _productionEnv:
        return _prodMsg91AuthToken;
      default:
        return _devMsg91AuthToken;
    }
  }

  // Bypass phones must match the backend's Msg91:BypassNumbers config.
  // For these phones, the app skips the MSG91 SDK and uses a sentinel access token
  // that the backend recognizes.
  static const List<String> bypassPhoneNumbers = <String>['+918155063892'];
  static const String bypassOtp = '123456';
  static const String bypassTokenPrefix = 'BYPASS:';
}
