/// Model representing a user's acquired coupon
class UserCouponModel {
  const UserCouponModel({
    required this.id,
    required this.couponId,
    required this.title,
    required this.description,
    required this.discountValue,
    required this.discountType,
    required this.discountDisplay,
    required this.minCartValue,
    required this.maxDiscountAmount,
    required this.vendorId,
    required this.vendorUserId,
    required this.vendorName,
    required this.expiryDate,
    required this.isUsed,
    required this.usedAt,
    required this.claimedAt,
    required this.isGifted,
    this.terms,
    this.imageUrl,
    this.redemptionCode,
  });

  final int id;
  final int couponId;
  final String title;
  final String description;
  final double discountValue;
  final String discountType;
  final String discountDisplay;
  final double minCartValue;
  final double maxDiscountAmount;
  final int vendorId;
  final String vendorUserId;
  final String vendorName;
  final String expiryDate;
  final bool isUsed;
  final String? usedAt;
  final String claimedAt;
  final bool isGifted;
  final String? terms;
  final String? imageUrl;
  final String? redemptionCode;

  /// Check if the coupon is expired
  bool get isExpired {
    try {
      final expiry = DateTime.parse(expiryDate);
      return DateTime.now().isAfter(expiry);
    } catch (e) {
      return false;
    }
  }

  /// Check if the coupon is currently valid (not used and not expired)
  bool get isValid => !isUsed && !isExpired;

  /// Get status text
  String get statusText {
    if (isUsed) return 'Used';
    if (isExpired) return 'Expired';
    return 'Active';
  }

  factory UserCouponModel.fromJson(Map<String, dynamic> json) {
    return UserCouponModel(
      id: json['id'] as int,
      couponId: json['couponId'] as int,
      title: json['title'] as String,
      description: json['description'] as String? ?? json['title'] as String,
      discountValue: (json['discountValue'] as num).toDouble(),
      discountType: json['discountType'] as String,
      discountDisplay: json['discountDisplay'] as String? ?? _generateDiscountDisplay(
        json['discountType'] as String,
        json['discountValue'] as num,
      ),
      minCartValue: (json['minCartValue'] as num?)?.toDouble() ?? 0.0,
      maxDiscountAmount: (json['maxDiscountAmount'] as num?)?.toDouble() ?? 0.0,
      vendorId: json['vendorProfileId'] as int,
      vendorUserId: json['vendorUserId'] as String,
      vendorName: json['vendorName'] as String? ?? 'Vendor ${json['vendorId']}',
      expiryDate: json['expiryDate'] as String,
      isUsed: json['status'] == 'Used' || json['isUsed'] == true,
      usedAt: json['redeemedDate'] as String?,
      claimedAt: json['acquiredDate'] as String,
      isGifted: json['isGifted'] as bool? ?? false,
      terms: json['terms'] as String?,
      imageUrl: json['imageUrl'] as String?,
      redemptionCode: json['uniqueCode'] as String?,
    );
  }

  static String _generateDiscountDisplay(
    String discountType,
    num discountValue,
  ) {
    switch (discountType.toLowerCase()) {
      case 'percentage':
        return '${discountValue.toInt()}% Off';
      case 'fixedamount':
        return '₹${discountValue.toInt()} Off';
      default:
        return '${discountValue.toInt()}% Off';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'couponId': couponId,
      'title': title,
      'description': description,
      'discountValue': discountValue,
      'discountType': discountType,
      'discountDisplay': discountDisplay,
      'minCartValue': minCartValue,
      'maxDiscountAmount': maxDiscountAmount,
      'vendorProfileId': vendorId,
      'vendorUserId': vendorUserId,
      'vendorName': vendorName,
      'expiryDate': expiryDate,
      'isUsed': isUsed,
      'usedAt': usedAt,
      'claimedAt': claimedAt,
      'isGifted': isGifted,
      'terms': terms,
      'imageUrl': imageUrl,
      'redemptionCode': redemptionCode,
    };
  }
}

/// Response model for the /api/user/coupons endpoint
class UserCouponsResponse {
  const UserCouponsResponse({
    required this.success,
    required this.message,
    required this.coupons,
    required this.totalCount,
    required this.activeCount,
    required this.usedCount,
    required this.expiredCount,
  });

  final bool success;
  final String message;
  final List<UserCouponModel> coupons;
  final int totalCount;
  final int activeCount;
  final int usedCount;
  final int expiredCount;

  factory UserCouponsResponse.fromJson(Map<String, dynamic> json) {
    // Handle case where response is a direct array
    if (json.containsKey('data') && json['data'] is List) {
      final couponsList = json['data'] as List<dynamic>;
      final coupons = couponsList
          .map(
            (coupon) =>
                UserCouponModel.fromJson(coupon as Map<String, dynamic>),
          )
          .toList();

      return UserCouponsResponse(
        success: json['success'] as bool? ?? true,
        message: json['message'] as String? ?? '',
        coupons: coupons,
        totalCount: coupons.length,
        activeCount: coupons.where((c) => c.isValid).length,
        usedCount: coupons.where((c) => c.isUsed).length,
        expiredCount: coupons.where((c) => c.isExpired && !c.isUsed).length,
      );
    } else {
      // Handle nested structure (if exists)
      final couponsData = json['data'] as Map<String, dynamic>? ?? {};
      final couponsList = couponsData['coupons'] as List<dynamic>? ?? [];

      return UserCouponsResponse(
        success: json['success'] as bool? ?? true,
        message: json['message'] as String? ?? '',
        coupons: couponsList
            .map(
              (coupon) =>
                  UserCouponModel.fromJson(coupon as Map<String, dynamic>),
            )
            .toList(),
        totalCount: couponsData['totalCount'] as int? ?? 0,
        activeCount: couponsData['activeCount'] as int? ?? 0,
        usedCount: couponsData['usedCount'] as int? ?? 0,
        expiredCount: couponsData['expiredCount'] as int? ?? 0,
      );
    }
  }
}
