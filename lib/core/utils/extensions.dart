import 'package:flutter/material.dart';

/// Extensions for BuildContext
extension BuildContextExtensions on BuildContext {
  /// Theme extensions
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  /// MediaQuery extensions
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  /// Navigation extensions
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void pushNamedAndClearStack(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  /// SnackBar extensions
  void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showErrorSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.red);
  }

  void showSuccessSnackBar(String message) {
    showSnackBar(message, backgroundColor: Colors.green);
  }
}

/// Extensions for String
extension StringExtensions on String {
  /// Check if string is email
  bool get isEmail {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(this);
  }

  /// Check if string is phone number
  bool get isPhoneNumber {
    final phoneRegex = RegExp(r'^\+?[\d\s-()]+$');
    return phoneRegex.hasMatch(this);
  }

  /// Capitalize first letter
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Upgrade a cleartext `http://` URL to `https://`.
  ///
  /// Some image URLs are persisted with an `http://` scheme (e.g. the
  /// ImageProxy links returned for vendor media). Android 9+ blocks cleartext
  /// traffic by default, so those requests fail before the server's 301 → HTTPS
  /// redirect can fire and images silently fall back to a placeholder.
  /// The host already serves the same path over HTTPS, so rewrite the scheme
  /// up front. Protocol-relative (`//host/…`) URLs are also normalised.
  String get toSecureImageUrl {
    if (startsWith('http://')) return replaceFirst('http://', 'https://');
    if (startsWith('//')) return 'https:$this';
    return this;
  }
}
