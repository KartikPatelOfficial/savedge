/// Coupon response model
class CouponResponse {
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

  factory CouponResponse.fromJson(Map<String, dynamic> json) {
    return CouponResponse(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      discountValue: (json['discountValue'] as num).toDouble(),
      discountType: json['discountType'] as String,
      minimumOrderAmount: (json['minimumOrderAmount'] as num).toDouble(),
      maximumDiscountAmount: (json['maximumDiscountAmount'] as num).toDouble(),
      validFrom: DateTime.parse(json['validFrom'] as String),
      validTo: DateTime.parse(json['validTo'] as String),
      isActive: json['isActive'] as bool,
      vendorId: json['vendorId'] as int,
      status: json['status'] as String,
      termsAndConditions: json['termsAndConditions'] as String?,
      usageCount: json['usageCount'] as int? ?? 0,
      maxUsageCount: json['maxUsageCount'] as int?,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'discountValue': discountValue,
      'discountType': discountType,
      'minimumOrderAmount': minimumOrderAmount,
      'maximumDiscountAmount': maximumDiscountAmount,
      'validFrom': validFrom.toIso8601String(),
      'validTo': validTo.toIso8601String(),
      'isActive': isActive,
      'vendorId': vendorId,
      'status': status,
      'termsAndConditions': termsAndConditions,
      'usageCount': usageCount,
      'maxUsageCount': maxUsageCount,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

/// Get coupons response wrapper
class GetCouponsResponse {
  const GetCouponsResponse({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  final List<CouponResponse> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;
  final bool hasNextPage;
  final bool hasPreviousPage;

  factory GetCouponsResponse.fromJson(Map<String, dynamic> json) {
    return GetCouponsResponse(
      items: (json['items'] as List<dynamic>)
          .map((item) => CouponResponse.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      pageNumber: json['pageNumber'] as int,
      pageSize: json['pageSize'] as int,
      hasNextPage: json['hasNextPage'] as bool,
      hasPreviousPage: json['hasPreviousPage'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'totalCount': totalCount,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'hasNextPage': hasNextPage,
      'hasPreviousPage': hasPreviousPage,
    };
  }
}
