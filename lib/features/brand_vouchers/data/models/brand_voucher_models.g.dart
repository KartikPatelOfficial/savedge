// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_voucher_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrandVoucher _$BrandVoucherFromJson(Map<String, dynamic> json) =>
    _BrandVoucher(
      id: (json['id'] as num).toInt(),
      brandName: json['brandName'] as String,
      brandDescription: json['brandDescription'] as String,
      brandImageUrl: json['brandImageUrl'] as String,
      brandWebsiteUrl: json['brandWebsiteUrl'] as String,
      minimumAmount: (json['minimumAmount'] as num).toDouble(),
      maximumAmount: (json['maximumAmount'] as num).toDouble(),
      processingFeePercentage: (json['processingFeePercentage'] as num)
          .toDouble(),
      isActive: json['isActive'] as bool,
      terms: json['terms'] as String?,
      instructions: json['instructions'] as String?,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$BrandVoucherToJson(_BrandVoucher instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brandName': instance.brandName,
      'brandDescription': instance.brandDescription,
      'brandImageUrl': instance.brandImageUrl,
      'brandWebsiteUrl': instance.brandWebsiteUrl,
      'minimumAmount': instance.minimumAmount,
      'maximumAmount': instance.maximumAmount,
      'processingFeePercentage': instance.processingFeePercentage,
      'isActive': instance.isActive,
      'terms': instance.terms,
      'instructions': instance.instructions,
      'created': instance.created.toIso8601String(),
    };

_VoucherOrder _$VoucherOrderFromJson(Map<String, dynamic> json) =>
    _VoucherOrder(
      id: (json['id'] as num).toInt(),
      userId: json['userId'] as String,
      brandVoucherId: (json['brandVoucherId'] as num).toInt(),
      brandName: json['brandName'] as String,
      brandImageUrl: json['brandImageUrl'] as String,
      voucherAmount: (json['voucherAmount'] as num).toDouble(),
      processingFee: (json['processingFee'] as num).toDouble(),
      totalPointsUsed: (json['totalPointsUsed'] as num).toDouble(),
      status: $enumDecode(_$VoucherOrderStatusEnumMap, json['status']),
      voucherCode: json['voucherCode'] as String?,
      voucherPin: json['voucherPin'] as String?,
      fulfilledAt: json['fulfilledAt'] == null
          ? null
          : DateTime.parse(json['fulfilledAt'] as String),
      fulfilledBy: json['fulfilledBy'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      notes: json['notes'] as String?,
      created: DateTime.parse(json['created'] as String),
      paymentMethod: $enumDecode(
        _$VoucherPaymentMethodEnumMap,
        json['paymentMethod'],
      ),
      paymentGatewayOrderId: json['paymentGatewayOrderId'] as String?,
      paymentGatewayTransactionId:
          json['paymentGatewayTransactionId'] as String?,
      paymentGatewaySignature: json['paymentGatewaySignature'] as String?,
      amountPaid: (json['amountPaid'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VoucherOrderToJson(_VoucherOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'brandVoucherId': instance.brandVoucherId,
      'brandName': instance.brandName,
      'brandImageUrl': instance.brandImageUrl,
      'voucherAmount': instance.voucherAmount,
      'processingFee': instance.processingFee,
      'totalPointsUsed': instance.totalPointsUsed,
      'status': _$VoucherOrderStatusEnumMap[instance.status]!,
      'voucherCode': instance.voucherCode,
      'voucherPin': instance.voucherPin,
      'fulfilledAt': instance.fulfilledAt?.toIso8601String(),
      'fulfilledBy': instance.fulfilledBy,
      'rejectionReason': instance.rejectionReason,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'notes': instance.notes,
      'created': instance.created.toIso8601String(),
      'paymentMethod': _$VoucherPaymentMethodEnumMap[instance.paymentMethod]!,
      'paymentGatewayOrderId': instance.paymentGatewayOrderId,
      'paymentGatewayTransactionId': instance.paymentGatewayTransactionId,
      'paymentGatewaySignature': instance.paymentGatewaySignature,
      'amountPaid': instance.amountPaid,
    };

const _$VoucherOrderStatusEnumMap = {
  VoucherOrderStatus.pending: 1,
  VoucherOrderStatus.processing: 2,
  VoucherOrderStatus.fulfilled: 3,
  VoucherOrderStatus.rejected: 4,
  VoucherOrderStatus.cancelled: 5,
};

const _$VoucherPaymentMethodEnumMap = {
  VoucherPaymentMethod.none: 0,
  VoucherPaymentMethod.points: 1,
  VoucherPaymentMethod.online: 2,
};

_CreateVoucherOrderRequest _$CreateVoucherOrderRequestFromJson(
  Map<String, dynamic> json,
) => _CreateVoucherOrderRequest(
  userId: json['userId'] as String,
  brandVoucherId: (json['brandVoucherId'] as num).toInt(),
  voucherAmount: (json['voucherAmount'] as num).toDouble(),
  paymentMethod:
      $enumDecodeNullable(
        _$VoucherPaymentMethodEnumMap,
        json['paymentMethod'],
      ) ??
      VoucherPaymentMethod.points,
);

Map<String, dynamic> _$CreateVoucherOrderRequestToJson(
  _CreateVoucherOrderRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'brandVoucherId': instance.brandVoucherId,
  'voucherAmount': instance.voucherAmount,
  'paymentMethod': _$VoucherPaymentMethodEnumMap[instance.paymentMethod]!,
};

_PaginatedBrandVoucherResponse _$PaginatedBrandVoucherResponseFromJson(
  Map<String, dynamic> json,
) => _PaginatedBrandVoucherResponse(
  items: (json['items'] as List<dynamic>)
      .map((e) => BrandVoucher.fromJson(e as Map<String, dynamic>))
      .toList(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  hasPreviousPage: json['hasPreviousPage'] as bool,
  hasNextPage: json['hasNextPage'] as bool,
);

Map<String, dynamic> _$PaginatedBrandVoucherResponseToJson(
  _PaginatedBrandVoucherResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'pageNumber': instance.pageNumber,
  'totalPages': instance.totalPages,
  'totalCount': instance.totalCount,
  'hasPreviousPage': instance.hasPreviousPage,
  'hasNextPage': instance.hasNextPage,
};

_PaginatedVoucherOrderResponse _$PaginatedVoucherOrderResponseFromJson(
  Map<String, dynamic> json,
) => _PaginatedVoucherOrderResponse(
  items: (json['items'] as List<dynamic>)
      .map((e) => VoucherOrder.fromJson(e as Map<String, dynamic>))
      .toList(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  hasPreviousPage: json['hasPreviousPage'] as bool,
  hasNextPage: json['hasNextPage'] as bool,
);

Map<String, dynamic> _$PaginatedVoucherOrderResponseToJson(
  _PaginatedVoucherOrderResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'pageNumber': instance.pageNumber,
  'totalPages': instance.totalPages,
  'totalCount': instance.totalCount,
  'hasPreviousPage': instance.hasPreviousPage,
  'hasNextPage': instance.hasNextPage,
};

_CreateVoucherPaymentOrderRequest _$CreateVoucherPaymentOrderRequestFromJson(
  Map<String, dynamic> json,
) => _CreateVoucherPaymentOrderRequest(
  brandVoucherId: (json['brandVoucherId'] as num).toInt(),
  voucherAmount: (json['voucherAmount'] as num).toDouble(),
);

Map<String, dynamic> _$CreateVoucherPaymentOrderRequestToJson(
  _CreateVoucherPaymentOrderRequest instance,
) => <String, dynamic>{
  'brandVoucherId': instance.brandVoucherId,
  'voucherAmount': instance.voucherAmount,
};

_CreateVoucherPaymentOrderResponse _$CreateVoucherPaymentOrderResponseFromJson(
  Map<String, dynamic> json,
) => _CreateVoucherPaymentOrderResponse(
  orderId: json['orderId'] as String,
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String,
  receipt: json['receipt'] as String,
  voucherOrderId: (json['voucherOrderId'] as num).toInt(),
  brandName: json['brandName'] as String,
  voucherAmount: (json['voucherAmount'] as num).toDouble(),
  processingFee: (json['processingFee'] as num).toDouble(),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  redirectUrl: json['redirectUrl'] as String,
);

Map<String, dynamic> _$CreateVoucherPaymentOrderResponseToJson(
  _CreateVoucherPaymentOrderResponse instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'amount': instance.amount,
  'currency': instance.currency,
  'receipt': instance.receipt,
  'voucherOrderId': instance.voucherOrderId,
  'brandName': instance.brandName,
  'voucherAmount': instance.voucherAmount,
  'processingFee': instance.processingFee,
  'totalAmount': instance.totalAmount,
  'redirectUrl': instance.redirectUrl,
};

_VoucherPaymentStatusResponse _$VoucherPaymentStatusResponseFromJson(
  Map<String, dynamic> json,
) => _VoucherPaymentStatusResponse(
  voucherOrderId: (json['voucherOrderId'] as num).toInt(),
  status: json['status'] as String,
  paymentOrderId: json['paymentOrderId'] as String?,
  paymentTransactionId: json['paymentTransactionId'] as String?,
  brandName: json['brandName'] as String,
  voucherAmount: (json['voucherAmount'] as num).toDouble(),
  totalAmount: (json['totalAmount'] as num).toDouble(),
  failureReason: json['failureReason'] as String?,
);

Map<String, dynamic> _$VoucherPaymentStatusResponseToJson(
  _VoucherPaymentStatusResponse instance,
) => <String, dynamic>{
  'voucherOrderId': instance.voucherOrderId,
  'status': instance.status,
  'paymentOrderId': instance.paymentOrderId,
  'paymentTransactionId': instance.paymentTransactionId,
  'brandName': instance.brandName,
  'voucherAmount': instance.voucherAmount,
  'totalAmount': instance.totalAmount,
  'failureReason': instance.failureReason,
};
