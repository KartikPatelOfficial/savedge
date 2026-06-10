import 'package:flutter/material.dart';

/// Local design tokens for the points wallet surface. Pure constants — no
/// MaterialApp.theme overrides — following the same pattern as GcTokens so
/// the rest of the app's styling is unaffected.
class WalletTokens {
  WalletTokens._();

  // Brand
  static const Color primary = Color(0xFF6F3FCC);
  static const Color primarySoft = Color(0xFFF3EFFE);
  static const Color secondary = Color(0xFF9F7AEA);

  // Premium ink hero (shared language with the gift-card surface)
  static const Color ink = Color(0xFF14161D);
  static const Color inkDeep = Color(0xFF0A0B0F);
  static const Color onInk = Colors.white;
  static const Color onInkMuted = Color(0xB3FFFFFF); // white 70%
  static const Color onInkFaint = Color(0x66FFFFFF); // white 40%

  // Canvas & surfaces
  static const Color canvas = Color(0xFFF7F8FB);
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFEDF2F7);

  // Text
  static const Color textPrimary = Color(0xFF1A202C);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textTertiary = Color(0xFF718096);

  // Semantics — green strictly for credits, red for debits/expiry
  static const Color credit = Color(0xFF059669);
  static const Color creditSoft = Color(0xFFE6F9F0);
  static const Color debit = Color(0xFFDC2626);
  static const Color debitSoft = Color(0xFFFDEAEA);

  // Meal points bucket (amber, distinct from SavEdge violet)
  static const Color meal = Color(0xFFEA580C);
  static const Color mealSoft = Color(0xFFFFF4EC);
  static const Color mealBorder = Color(0xFFFFE0CC);

  // Expiry / warning
  static const Color warn = Color(0xFFB45309);
  static const Color warnSoft = Color(0xFFFFF7E8);
  static const Color warnBorder = Color(0xFFFDE9C8);

  // Radii
  static const double rHero = 24;
  static const double rCard = 18;
  static const double rTile = 14;
  static const double rChip = 999;
  static const double rSheet = 28;

  // Spacing scale (4-pt grid)
  static const double s1 = 4;
  static const double s2 = 8;
  static const double s3 = 12;
  static const double s4 = 16;
  static const double s5 = 20;
  static const double s6 = 24;
  static const double s8 = 32;

  // Page gutter
  static const EdgeInsets gutter = EdgeInsets.symmetric(horizontal: 20);

  // Shadows
  static const List<BoxShadow> heroShadow = [
    BoxShadow(
      color: Color(0x33140E2E),
      offset: Offset(0, 16),
      blurRadius: 32,
      spreadRadius: -8,
    ),
  ];

  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Color(0x0A101828), offset: Offset(0, 4), blurRadius: 12),
  ];

  // Type — system font, tightened numerals for the fintech feel
  static const TextStyle balance = TextStyle(
    fontSize: 48,
    height: 1.05,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.5,
    color: onInk,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle eyebrow = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 2,
    color: onInkMuted,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: textPrimary,
  );

  static const TextStyle statValue = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.4,
    color: textPrimary,
    fontFeatures: [FontFeature.tabularFigures()],
  );

  static const TextStyle statLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: textTertiary,
  );

  /// 1,234 / 12,345 — thin-space-free comma grouping for point amounts.
  static String fmt(int n) {
    final digits = n.abs().toString();
    final buf = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buf.write(',');
      buf.write(digits[i]);
    }
    return n < 0 ? '-$buf' : buf.toString();
  }
}
