import 'package:flutter/material.dart';
import 'package:savedge/features/coupons/data/models/coupon_gifting_models.dart';

/// Visual types for coupon card display
enum CouponVisualType {
  cashback,
  percentDiscount,
  priceSlash,
}

/// Helper class for determining coupon visual type and associated styling
class CouponTypeHelper {
  /// Determine the visual type of a coupon based on its properties
  static CouponVisualType getCouponType(UserCouponDetailModel coupon) {
    // Check if it's a cashback coupon by looking at title or description
    final titleLower = coupon.title.toLowerCase();
    final descriptionLower = coupon.description?.toLowerCase() ?? '';

    if (titleLower.contains('cashback') ||
        descriptionLower.contains('cashback') ||
        titleLower.contains('cash back')) {
      return CouponVisualType.cashback;
    }

    // Use discountType to determine between percentage and fixed amount
    if (coupon.discountType.toLowerCase() == 'percentage') {
      return CouponVisualType.percentDiscount;
    }

    return CouponVisualType.priceSlash;
  }

  /// Get the color for the coupon sidebar based on type
  static Color getSidebarColor(CouponVisualType type) {
    switch (type) {
      case CouponVisualType.cashback:
        return const Color(0xFF4A90E2); // Blue
      case CouponVisualType.percentDiscount:
        return const Color(0xFFE85D9A); // Pink
      case CouponVisualType.priceSlash:
        return const Color(0xFF4ECDC4); // Green/Teal
    }
  }

  /// Get the sidebar label text based on type
  static String getSidebarLabel(CouponVisualType type) {
    switch (type) {
      case CouponVisualType.cashback:
        return 'CASHBACK';
      case CouponVisualType.percentDiscount:
        return '% DISCOUNT';
      case CouponVisualType.priceSlash:
        return 'PRICE SLASH';
    }
  }

  /// Get background gradient colors for the sidebar
  static List<Color> getSidebarGradient(CouponVisualType type) {
    final baseColor = getSidebarColor(type);
    return [
      baseColor,
      baseColor.withValues(alpha: 0.85),
    ];
  }

  /// Format the main discount display text
  static String getDiscountDisplay(UserCouponDetailModel coupon) {
    final type = getCouponType(coupon);

    switch (type) {
      case CouponVisualType.cashback:
      case CouponVisualType.priceSlash:
        // For cashback and price slash, show the amount
        return '₹${coupon.discountValue.toStringAsFixed(0)}';
      case CouponVisualType.percentDiscount:
        // For percentage, show the percentage
        return '${coupon.discountValue.toStringAsFixed(0)}%';
    }
  }

  /// Get the secondary display text (like "OFF" or "CASHBACK")
  static String getSecondaryText(CouponVisualType type) {
    switch (type) {
      case CouponVisualType.cashback:
        return '';
      case CouponVisualType.percentDiscount:
        return 'DISCOUNT';
      case CouponVisualType.priceSlash:
        return 'OFF';
    }
  }

  /// Calculate days left until expiry
  static int? getDaysUntilExpiry(DateTime expiryDate) {
    final now = DateTime.now();
    final difference = expiryDate.difference(now).inDays;
    return difference >= 0 ? difference : null;
  }

  /// Check if coupon is expiring soon (within 7 days)
  static bool isExpiringSoon(DateTime expiryDate) {
    final daysLeft = getDaysUntilExpiry(expiryDate);
    return daysLeft != null && daysLeft <= 7;
  }

  /// Format expiry warning text
  static String? getExpiryWarningText(DateTime expiryDate) {
    final daysLeft = getDaysUntilExpiry(expiryDate);

    if (daysLeft == null) {
      return null; // Already expired
    }

    if (daysLeft == 0) {
      return 'EXPIRES TODAY';
    } else if (daysLeft == 1) {
      return '1 DAY LEFT';
    } else if (daysLeft <= 7) {
      return '$daysLeft DAYS LEFT';
    }

    return null; // Not expiring soon
  }

  /// Get icon for points display
  static IconData getPointsIcon() {
    return Icons.toll; // Coins icon
  }

  /// Format points display text
  static String formatPoints(int points) {
    if (points >= 1000) {
      final thousands = points / 1000;
      return '${thousands.toStringAsFixed(thousands.truncateToDouble() == thousands ? 0 : 1)}K';
    }
    return points.toString();
  }

  /// Format full points display with commas
  static String formatPointsWithCommas(int points) {
    return points.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
