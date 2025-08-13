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
    required this.isActive,
    required this.vendorId,
    required this.status,
    this.termsAndConditions,
    this.usageCount = 0,
    this.maxUsageCount,
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
  final bool isActive;
  final int vendorId;
  final String status;
  final String? termsAndConditions;
  final int usageCount;
  final int? maxUsageCount;

  /// Check if coupon is currently valid
  bool get isValid {
    final now = DateTime.now();
    return isActive &&
        now.isAfter(validFrom) &&
        now.isBefore(validTo) &&
        (maxUsageCount == null || usageCount < maxUsageCount!);
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
    isActive,
    vendorId,
    status,
    termsAndConditions,
    usageCount,
    maxUsageCount,
  ];
}
