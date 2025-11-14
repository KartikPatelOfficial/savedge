import 'package:equatable/equatable.dart';
import 'package:savedge/core/enums/coupon_enums.dart';

/// Coupon domain entity
class Coupon extends Equatable {
  const Coupon({
    required this.id,
    required this.title,
    required this.description,
    required this.discountValue,
    required this.discountType,
    this.freeItemDescription,
    required this.minimumOrderAmount,
    required this.maximumDiscountAmount,
    required this.validFrom,
    required this.validTo,
    required this.vendorId,
    required this.vendorUserId,
    required this.status,
    this.cashPrice,
    this.termsAndConditions,
    this.maxRedemptions,
    this.totalClaimed = 0,
    this.remainingClaims,
    this.isSpecialOffer = false,
    this.specialOfferStartDate,
    this.specialOfferEndDate,
    this.specialOfferPriority = 0,
    this.specialOfferImageUrl,
    this.occasionType = CouponOccasionType.regular,
    this.daysBeforeOccasion,
    this.daysAfterOccasion,
  });

  final int id;
  final String title;
  final String description;
  final double discountValue;
  final String discountType;
  final String? freeItemDescription;
  final double minimumOrderAmount;
  final double maximumDiscountAmount;
  final DateTime validFrom;
  final DateTime validTo;
  final int vendorId;
  final String vendorUserId;
  final String status;
  final double? cashPrice;
  final String? termsAndConditions;
  final int? maxRedemptions;
  final int totalClaimed;
  final int? remainingClaims;
  final bool isSpecialOffer;
  final DateTime? specialOfferStartDate;
  final DateTime? specialOfferEndDate;
  final int specialOfferPriority;
  final String? specialOfferImageUrl;
  final CouponOccasionType occasionType;
  final int? daysBeforeOccasion;
  final int? daysAfterOccasion;

  /// Check if coupon is currently valid
  bool get isValid {
    final now = DateTime.now();
    return status.toLowerCase() == 'active' &&
        (now.isAfter(validFrom) || now.isAtSameMomentAs(validFrom)) &&
        now.isBefore(validTo);
  }

  /// Get discount display text
  String get discountDisplay {
    switch (discountType.toLowerCase()) {
      case 'percentage':
        return '${discountValue.toInt()}% Off';
      case 'freeitem':
        return 'Free ${freeItemDescription ?? 'Item'}';
      case 'fixedamount':
        return '₹${discountValue.toInt()} Off';
      default:
        return '${discountValue.toInt()}% Off';
    }
  }

  /// Get minimum amount display
  String get minimumAmountDisplay {
    if (minimumOrderAmount <= 0) return '';
    return 'on orders above ₹${minimumOrderAmount.toInt()}';
  }

  /// Check if special offer is currently active
  bool get isSpecialOfferActive {
    if (!isSpecialOffer) return false;
    if (specialOfferStartDate == null || specialOfferEndDate == null) return false;
    final now = DateTime.now();
    return now.isAfter(specialOfferStartDate!) && now.isBefore(specialOfferEndDate!);
  }

  /// Check if this is an occasion-based coupon
  bool get isOccasionBased => occasionType != CouponOccasionType.regular;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    discountValue,
    discountType,
    freeItemDescription,
    minimumOrderAmount,
    maximumDiscountAmount,
    validFrom,
    validTo,
    vendorId,
    vendorUserId,
    status,
    cashPrice,
    termsAndConditions,
    maxRedemptions,
    totalClaimed,
    remainingClaims,
    isSpecialOffer,
    specialOfferStartDate,
    specialOfferEndDate,
    specialOfferPriority,
    specialOfferImageUrl,
    occasionType,
    daysBeforeOccasion,
    daysAfterOccasion,
  ];
}
