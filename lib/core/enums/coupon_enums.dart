/// Enum for coupon occasion types
enum CouponOccasionType {
  /// Regular coupon not tied to any occasion
  regular,

  /// Birthday occasion coupon
  birthday,

  /// Anniversary occasion coupon
  anniversary,

  /// New Year occasion coupon
  newYear,
}

/// Extension methods for CouponOccasionType
extension CouponOccasionTypeExtension on CouponOccasionType {
  /// Get display name for the occasion type
  String get displayName {
    switch (this) {
      case CouponOccasionType.regular:
        return 'Regular';
      case CouponOccasionType.birthday:
        return 'Birthday';
      case CouponOccasionType.anniversary:
        return 'Anniversary';
      case CouponOccasionType.newYear:
        return 'New Year';
    }
  }

  /// Get icon emoji for the occasion type
  String get emoji {
    switch (this) {
      case CouponOccasionType.regular:
        return '🎫';
      case CouponOccasionType.birthday:
        return '🎂';
      case CouponOccasionType.anniversary:
        return '💍';
      case CouponOccasionType.newYear:
        return '🎊';
    }
  }

  /// Check if this is an occasion-based coupon
  bool get isOccasionBased => this != CouponOccasionType.regular;
}
