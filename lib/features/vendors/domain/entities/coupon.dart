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
  ];
}
