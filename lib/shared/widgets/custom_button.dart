import 'package:flutter/material.dart';

/// Custom button widget following design system guidelines
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.buttonType = ButtonType.elevated,
    this.icon,
    this.width,
    this.height,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final ButtonType buttonType;
  final IconData? icon;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final Widget child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[Icon(icon), const SizedBox(width: 8)],
              Text(text),
            ],
          );

    final VoidCallback? effectiveOnPressed = (isEnabled && !isLoading)
        ? onPressed
        : null;

    Widget button;
    switch (buttonType) {
      case ButtonType.elevated:
        button = ElevatedButton(onPressed: effectiveOnPressed, child: child);
        break;
      case ButtonType.outlined:
        button = OutlinedButton(onPressed: effectiveOnPressed, child: child);
        break;
      case ButtonType.text:
        button = TextButton(onPressed: effectiveOnPressed, child: child);
        break;
    }

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: button);
    }

    return button;
  }
}

/// Button type enumeration
enum ButtonType { elevated, outlined, text }
