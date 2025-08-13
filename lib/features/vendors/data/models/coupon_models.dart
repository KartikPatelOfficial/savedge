/// Coupon response model
class CouponResponse {
  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      discountValue: (json['discountValue'] as num).toDouble(),
      discountType: _mapDiscountTypeFromInt(json['discountType'] as int),
      minimumOrderAmount: (json['minCartValue'] as num?)?.toDouble() ?? 0.0,
      maximumDiscountAmount:
          (json['maxDiscountAmount'] as num?)?.toDouble() ?? 0.0,
      validFrom: DateTime.parse(json['validFrom'] as String),
      validTo: DateTime.parse(json['validUntil'] as String),
      isActive: json['isActive'] as bool,
      vendorId: json['vendorId'] as int,
      status: _mapStatusFromInt(json['status'] as int),
      termsAndConditions: json['termsAndConditions'] as String?,
      usageCount: json['currentRedemptions'] as int? ?? 0,
      maxUsageCount: json['maxRedemptions'] as int?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      vendorName: json['vendorName'] as String?,
      discountTypeDisplay: json['discountTypeDisplay'] as String?,
      discountDisplay: json['discountDisplay'] as String?,
      statusDisplay: json['statusDisplay'] as String?,
      imageUrl: json['imageUrl'] as String?,
      pointsCost: json['pointsCost'] as int?,
      isOnePerUser: json['isOnePerUser'] as bool? ?? false,
      isValid: json['isValid'] as bool? ?? true,
      isExpired: json['isExpired'] as bool? ?? false,
    );
  }
  const CouponResponse({
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
    this.createdAt,
    this.updatedAt,
    this.vendorName,
    this.discountTypeDisplay,
    this.discountDisplay,
    this.statusDisplay,
    this.imageUrl,
    this.pointsCost,
    this.isOnePerUser = false,
    this.isValid = true,
    this.isExpired = false,
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? vendorName;
  final String? discountTypeDisplay;
  final String? discountDisplay;
  final String? statusDisplay;
  final String? imageUrl;
  final int? pointsCost;
  final bool isOnePerUser;
  final bool isValid;
  final bool isExpired;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'discountValue': discountValue,
      'discountType': discountType,
      'minCartValue': minimumOrderAmount,
      'maxDiscountAmount': maximumDiscountAmount,
      'validFrom': validFrom.toIso8601String(),
      'validUntil': validTo.toIso8601String(),
      'isActive': isActive,
      'vendorId': vendorId,
      'status': status,
      'termsAndConditions': termsAndConditions,
      'currentRedemptions': usageCount,
      'maxRedemptions': maxUsageCount,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'vendorName': vendorName,
      'discountTypeDisplay': discountTypeDisplay,
      'discountDisplay': discountDisplay,
      'statusDisplay': statusDisplay,
      'imageUrl': imageUrl,
      'pointsCost': pointsCost,
      'isOnePerUser': isOnePerUser,
      'isValid': isValid,
      'isExpired': isExpired,
    };
  }

  /// Maps integer discount type from API to string representation
  /// 1 = Percentage, 2 = FixedAmount
  static String _mapDiscountTypeFromInt(int discountType) {
    switch (discountType) {
      case 1:
        return 'percentage';
      case 2:
        return 'fixedamount';
      default:
        return 'percentage'; // Default fallback
    }
  }

  /// Maps integer status from API to string representation
  /// 1 = Active, 2 = Inactive, 3 = Expired
  static String _mapStatusFromInt(int status) {
    switch (status) {
      case 1:
        return 'active';
      case 2:
        return 'inactive';
      case 3:
        return 'expired';
      default:
        return 'active'; // Default fallback
    }
  }
}

/// Get coupons response wrapper
class GetCouponsResponse {
  factory GetCouponsResponse.fromJson(Map<String, dynamic> json) {
    return GetCouponsResponse(
      items: (json['items'] as List<dynamic>)
          .map((item) => CouponResponse.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      pageNumber: json['pageNumber'] as int,
      pageSize: json['pageSize'] as int? ?? 10,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
      totalPages: json['totalPages'] as int?,
    );
  }
  const GetCouponsResponse({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.hasNextPage,
    required this.hasPreviousPage,
    this.totalPages,
  });

  final List<CouponResponse> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int? totalPages;

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'totalCount': totalCount,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'hasNextPage': hasNextPage,
      'hasPreviousPage': hasPreviousPage,
      'totalPages': totalPages,
    };
  }
}
