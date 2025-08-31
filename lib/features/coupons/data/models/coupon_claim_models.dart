/// Model for unused coupon data in check response
class UnusedCouponData {
  const UnusedCouponData({
    required this.userCouponId,
    required this.uniqueCode,
    required this.purchasedDate,
    required this.status,
  });

  final int userCouponId;
  final String uniqueCode;
  final String purchasedDate;
  final String status;

  // Map to match expected field names
  int get id => userCouponId;

  factory UnusedCouponData.fromJson(Map<String, dynamic> json) {
    return UnusedCouponData(
      userCouponId: json['userCouponId'] as int,
      uniqueCode: json['uniqueCode'] as String,
      purchasedDate: json['purchasedDate'] as String,
      status: json['status'] as String,
    );
  }
}

/// Model for coupon check request
class CouponCheckRequest {
  const CouponCheckRequest({required this.couponId});

  final int couponId;

  Map<String, dynamic> toJson() => {'couponId': couponId};
}

/// Model for coupon check response
class CouponCheckResponse {
  const CouponCheckResponse({
    required this.couponId,
    required this.title,
    required this.description,
    required this.vendorId,
    required this.vendorUserId,
    required this.vendorName,
    required this.discountType,
    required this.discountValue,
    required this.discountDisplay,
    required this.minCartValue,
    required this.maxDiscountAmount,
    required this.cashPrice,
    required this.validFrom,
    required this.validUntil,
    required this.maxRedemptions,
    required this.status,
    required this.terms,
    required this.createdAt,
    required this.lastModifiedAt,
    required this.isValid,
    required this.canUserRedeem,
    required this.redeemabilityReasons,
    required this.userTotalAcquisitions,
    required this.userUsedRedemptions,
    required this.userUnusedRedemptions,
    required this.userMaxRedemptions,
    this.remainingSubscriptionClaims,
    required this.userLastRedemptionDate,
    required this.userLastAcquisitionDate,
    required this.hasUnusedCoupons,
    required this.unusedCoupons,
  });

  final int couponId;
  final String title;
  final String description;
  final int vendorId;
  final String vendorUserId;
  final String vendorName;
  final int discountType;
  final double discountValue;
  final String discountDisplay;
  final double? minCartValue;
  final double? maxDiscountAmount;
  final double? cashPrice;
  final String validFrom;
  final String validUntil;
  final int? maxRedemptions;
  final int status;
  final String? terms;
  final String createdAt;
  final String lastModifiedAt;
  final bool isValid;
  final bool canUserRedeem;
  final List<String> redeemabilityReasons;
  final int userTotalAcquisitions;
  final int userUsedRedemptions;
  final int userUnusedRedemptions;
  final int? userMaxRedemptions;
  /// Server-computed remaining claims for subscription (if provided)
  final int? remainingSubscriptionClaims;
  final String? userLastRedemptionDate;
  final String? userLastAcquisitionDate;
  final bool hasUnusedCoupons;
  final List<UnusedCouponData> unusedCoupons;

  factory CouponCheckResponse.fromJson(Map<String, dynamic> json) {
    return CouponCheckResponse(
      couponId: json['couponId'] as int,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      vendorId: json['vendorProfileId'] as int,
      vendorUserId: json['vendorUserId'] as String,
      vendorName: json['vendorName'] as String,
      discountType: json['discountType'] as int,
      discountValue: (json['discountValue'] as num).toDouble(),
      discountDisplay: json['discountDisplay'] as String,
      minCartValue: (json['minCartValue'] as num?)?.toDouble(),
      maxDiscountAmount: (json['maxDiscountAmount'] as num?)?.toDouble(),
      cashPrice: (json['cashPrice'] as num?)?.toDouble(),
      validFrom: json['validFrom'] as String,
      validUntil: json['validUntil'] as String,
      maxRedemptions: json['maxRedemptions'] as int?,
      status: json['status'] as int,
      terms: json['terms'] as String?,
      createdAt: json['createdAt'] as String,
      lastModifiedAt: json['lastModifiedAt'] as String,
      isValid: json['isValid'] as bool,
      canUserRedeem: json['canUserRedeem'] as bool,
      redeemabilityReasons: (json['redeemabilityReasons'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userTotalAcquisitions: json['userTotalAcquisitions'] as int,
      userUsedRedemptions: json['userUsedRedemptions'] as int,
      userUnusedRedemptions: json['userUnusedRedemptions'] as int,
      userMaxRedemptions: json['userMaxRedemptions'] as int?,
      remainingSubscriptionClaims: json['remainingSubscriptionClaims'] as int?,
      userLastRedemptionDate: json['userLastRedemptionDate'] as String?,
      userLastAcquisitionDate: json['userLastAcquisitionDate'] as String?,
      hasUnusedCoupons: json['hasUnusedCoupons'] as bool,
      unusedCoupons: (json['unusedCoupons'] as List<dynamic>)
          .map((e) => UnusedCouponData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Model for coupon claim request
class CouponClaimRequest {
  const CouponClaimRequest({required this.couponId});

  final int couponId;

  Map<String, dynamic> toJson() => {'couponId': couponId};
}

/// Model for coupon claim response
class CouponClaimResponse {
  const CouponClaimResponse({
    required this.success,
    required this.message,
    this.claimId,
    this.expiryDate,
  });

  final bool success;
  final String message;
  final String? claimId;
  final String? expiryDate;

  factory CouponClaimResponse.fromJson(Map<String, dynamic> json) {
    return CouponClaimResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      claimId: json['claimId'] as String?,
      expiryDate: json['expiryDate'] as String?,
    );
  }
}
