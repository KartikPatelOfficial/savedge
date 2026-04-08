import 'package:flutter/material.dart';

/// Local design tokens for the gift card surface. Pure constants — no
/// MaterialApp.theme overrides — so the rest of the app's styling is unaffected.
class GcTokens {
  GcTokens._();

  // Brand colors (kept consistent with the existing pages)
  static const Color primary = Color(0xFF6F3FCC);
  static const Color primaryDark = Color(0xFF5B21B6);
  static const Color secondary = Color(0xFF9F7AEA);
  static const Color success = Color(0xFF059669);
  static const Color warning = Color(0xFFD97706);
  static const Color danger = Color(0xFFEF4444);
  static const Color textPrimary = Color(0xFF1A202C);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textTertiary = Color(0xFF718096);
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFEDF2F7);
  static const Color background = Colors.white;
  static const Color surfaceMuted = Color(0xFFF7F8FB);
  static const Color surface = Colors.white;

  // Radii
  static const double rCard = 16;
  static const double rHero = 24;
  static const double rSheet = 28;
  static const double rPill = 999;

  // Shadows
  static const List<BoxShadow> softShadow = [
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 8),
      blurRadius: 24,
    ),
  ];

  static const List<BoxShadow> tinyShadow = [
    BoxShadow(
      color: Color(0x12000000),
      offset: Offset(0, 4),
      blurRadius: 12,
    ),
  ];

  // Gradient for primary CTAs and hero overlays
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6F3FCC), Color(0xFF9F7AEA)],
  );

  static const LinearGradient darkOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x00000000), Color(0xCC000000)],
  );

  // Pastel category palettes (bg + accent pairs) — match the reference designs.
  static const List<Color> categoryBgs = [
    Color(0xFFFFE8EE), // pink (Beauty)
    Color(0xFFFFEFD2), // amber (Fashion)
    Color(0xFFFFE7C9), // peach (Home)
    Color(0xFFE0EEFF), // sky (Travel)
    Color(0xFFD8F4E5), // mint (Health)
    Color(0xFFE8FBE0), // green (Electronics)
  ];
  static const List<Color> categoryAccents = [
    Color(0xFFE83E8C),
    Color(0xFFF59E0B),
    Color(0xFFF97316),
    Color(0xFF3B82F6),
    Color(0xFF10B981),
    Color(0xFF84CC16),
  ];

  // Per-product accent rotation (kept compatible with existing detail page)
  static const List<Color> productAccents = [
    Color(0xFF7C3AED),
    Color(0xFFEA580C),
    Color(0xFF059669),
    Color(0xFF2563EB),
    Color(0xFFD97706),
    Color(0xFFDB2777),
  ];
  static const List<Color> productBgs = [
    Color(0xFFF3EFFE),
    Color(0xFFFFF0E6),
    Color(0xFFE6F9F0),
    Color(0xFFE6F3FF),
    Color(0xFFFFF3E6),
    Color(0xFFFCE6F0),
  ];

  static Color accentFor(int id) =>
      productAccents[id.abs() % productAccents.length];
  static Color bgFor(int id) => productBgs[id.abs() % productBgs.length];
  static Color categoryBgFor(int index) =>
      categoryBgs[index.abs() % categoryBgs.length];
  static Color categoryAccentFor(int index) =>
      categoryAccents[index.abs() % categoryAccents.length];
}
