import 'package:flutter/material.dart';

/// Extension methods for BuildContext
extension ContextExtensions on BuildContext {
  /// Gets the current theme data
  ThemeData get theme => Theme.of(this);

  /// Gets the current color scheme
  ColorScheme get colorScheme => theme.colorScheme;

  /// Gets the current text theme
  TextTheme get textTheme => theme.textTheme;

  /// Gets the media query data
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Gets the screen size
  Size get screenSize => mediaQuery.size;

  /// Gets the screen width
  double get screenWidth => screenSize.width;

  /// Gets the screen height
  double get screenHeight => screenSize.height;

  /// Checks if the device is in portrait mode
  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;

  /// Checks if the device is in landscape mode
  bool get isLandscape => mediaQuery.orientation == Orientation.landscape;

  /// Gets the safe area padding
  EdgeInsets get padding => mediaQuery.padding;

  /// Gets the keyboard height
  double get keyboardHeight => mediaQuery.viewInsets.bottom;

  /// Checks if the keyboard is visible
  bool get isKeyboardVisible => keyboardHeight > 0;

  /// Shows a snackbar with the given message
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  /// Shows an error snackbar
  void showErrorSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }

  /// Shows a success snackbar
  void showSuccessSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  /// Pops the current route
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  /// Pushes a new route
  Future<T?> push<T>(Route<T> route) => Navigator.of(this).push(route);

  /// Pushes a new named route
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed(routeName, arguments: arguments);

  /// Pushes a new route and removes all previous routes
  Future<T?> pushNamedAndClearStack<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
        arguments: arguments,
      );
}
