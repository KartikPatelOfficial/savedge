import 'package:flutter/material.dart';

/// CustomClipper that creates semicircle notches on left and right sides
/// of a card, producing a coupon/ticket shape.
class GiftCardOrderShapeClipper extends CustomClipper<Path> {
  /// Vertical position of the notch as a ratio (0.0 = top, 1.0 = bottom).
  /// Defaults to 0.42 (42% from top).
  final double notchRatio;

  GiftCardOrderShapeClipper({this.notchRatio = 0.42});

  static const double _notchRadius = 10.0;
  static const double _cornerRadius = 16.0;

  @override
  Path getClip(Size size) {
    final roundedRect = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(_cornerRadius),
        ),
      );

    final yPos = size.height * notchRatio;

    final leftNotch = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(0, yPos),
        radius: _notchRadius,
      ));

    final rightNotch = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width, yPos),
        radius: _notchRadius,
      ));

    final notches = Path.combine(PathOperation.union, leftNotch, rightNotch);

    return Path.combine(PathOperation.difference, roundedRect, notches);
  }

  @override
  bool shouldReclip(covariant GiftCardOrderShapeClipper oldClipper) => false;
}

/// Painter that draws a horizontal dashed line between the two notch points.
/// Designed to be used together with [GiftCardOrderShapeClipper].
class HorizontalDashedLinePainter extends CustomPainter {
  /// Vertical position ratio matching [GiftCardOrderShapeClipper.notchRatio].
  final double yRatio;

  /// Color of the dashed line.
  final Color color;

  HorizontalDashedLinePainter({
    required this.yRatio,
    this.color = const Color(0xFFE5E7EB),
  });

  static const double _dashWidth = 4.0;
  static const double _dashSpace = 4.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final y = size.height * yRatio;
    final startX = 12.0; // notch radius + 2
    final endX = size.width - 12.0;

    double currentX = startX;
    while (currentX < endX) {
      final dashEnd = (currentX + _dashWidth).clamp(startX, endX);
      canvas.drawLine(Offset(currentX, y), Offset(dashEnd, y), paint);
      currentX += _dashWidth + _dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant HorizontalDashedLinePainter oldDelegate) =>
      oldDelegate.yRatio != yRatio || oldDelegate.color != color;
}
