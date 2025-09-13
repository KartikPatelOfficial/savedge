import 'package:equatable/equatable.dart';

/// Coupon domain entity
class Coupon extends Equatable {
  const Coupon({
    required this.id,
    required this.title,
    required this.description,
    required this.discountValue,
    required this.discountType,
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
    this.isSpecialOffer = false,
    this.specialOfferStartDate,
    this.specialOfferEndDate,
    this.specialOfferPriority = 0,
    this.specialOfferImageUrl,
  });

  final int id;
  final String title;
  final String description;
  final double discountValue;
  final String discountType;
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
  final bool isSpecialOffer;
  final DateTime? specialOfferStartDate;
  final DateTime? specialOfferEndDate;
  final int specialOfferPriority;
  final String? specialOfferImageUrl;

  /// Check if coupon is currently valid
  bool get isValid {
    final now = DateTime.now();
    return status.toLowerCase() == 'active' &&
        now.isAfter(validFrom) &&
        now.isBefore(validTo);
  }

  /// Get discount display text
  String get discountDisplay {
    switch (discountType.toLowerCase()) {
      case 'percentage':
        return '${discountValue.toInt()}% Off';
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

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    discountValue,
    discountType,
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
    isSpecialOffer,
    specialOfferStartDate,
    specialOfferEndDate,
    specialOfferPriority,
    specialOfferImageUrl,
  ];
}
