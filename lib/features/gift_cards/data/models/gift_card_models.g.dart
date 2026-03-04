// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_card_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GiftCardCategory _$GiftCardCategoryFromJson(Map<String, dynamic> json) =>
    _GiftCardCategory(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isActive: json['isActive'] as bool,
      productCount: (json['productCount'] as num).toInt(),
      parentCategoryId: (json['parentCategoryId'] as num?)?.toInt(),
      subCategories:
          (json['subCategories'] as List<dynamic>?)
              ?.map((e) => GiftCardCategory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GiftCardCategoryToJson(_GiftCardCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'isActive': instance.isActive,
      'productCount': instance.productCount,
      'parentCategoryId': instance.parentCategoryId,
      'subCategories': instance.subCategories,
    };

_GiftCardProduct _$GiftCardProductFromJson(Map<String, dynamic> json) =>
    _GiftCardProduct(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      sku: json['sku'] as String,
      imageUrl: json['imageUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      minPrice: (json['minPrice'] as num).toDouble(),
      maxPrice: (json['maxPrice'] as num).toDouble(),
      isActive: json['isActive'] as bool,
      categoryName: json['categoryName'] as String?,
      brandName: json['brandName'] as String?,
      denominations: json['denominations'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
      offerDescription: json['offerDescription'] as String?,
      formatExpiry: json['formatExpiry'] as String?,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GiftCardProductToJson(_GiftCardProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'sku': instance.sku,
      'imageUrl': instance.imageUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'isActive': instance.isActive,
      'categoryName': instance.categoryName,
      'brandName': instance.brandName,
      'denominations': instance.denominations,
      'currencySymbol': instance.currencySymbol,
      'offerDescription': instance.offerDescription,
      'formatExpiry': instance.formatExpiry,
      'discountPercentage': instance.discountPercentage,
    };

_PaginatedGiftCardProductResponse _$PaginatedGiftCardProductResponseFromJson(
  Map<String, dynamic> json,
) => _PaginatedGiftCardProductResponse(
  items: (json['items'] as List<dynamic>)
      .map((e) => GiftCardProduct.fromJson(e as Map<String, dynamic>))
      .toList(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  hasPreviousPage: json['hasPreviousPage'] as bool,
  hasNextPage: json['hasNextPage'] as bool,
);

Map<String, dynamic> _$PaginatedGiftCardProductResponseToJson(
  _PaginatedGiftCardProductResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'pageNumber': instance.pageNumber,
  'totalPages': instance.totalPages,
  'totalCount': instance.totalCount,
  'hasPreviousPage': instance.hasPreviousPage,
  'hasNextPage': instance.hasNextPage,
};

_GiftCardOrder _$GiftCardOrderFromJson(Map<String, dynamic> json) =>
    _GiftCardOrder(
      id: (json['id'] as num).toInt(),
      userId: json['userId'] as String,
      giftCardProductId: (json['giftCardProductId'] as num).toInt(),
      productName: json['productName'] as String,
      productImageUrl: json['productImageUrl'] as String?,
      requestedAmount: (json['requestedAmount'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      payableAmount: (json['payableAmount'] as num).toDouble(),
      paymentMethod: $enumDecode(
        _$GiftCardPaymentMethodEnumMap,
        json['paymentMethod'],
      ),
      paymentStatus: $enumDecode(
        _$GiftCardPaymentStatusEnumMap,
        json['paymentStatus'],
      ),
      totalPointsUsed: (json['totalPointsUsed'] as num).toDouble(),
      razorpayOrderId: json['razorpayOrderId'] as String?,
      razorpayPaymentId: json['razorpayPaymentId'] as String?,
      status: $enumDecode(_$GiftCardOrderStatusEnumMap, json['status']),
      woohooCardNumber: json['woohooCardNumber'] as String?,
      woohooCardPin: json['woohooCardPin'] as String?,
      woohooActivationCode: json['woohooActivationCode'] as String?,
      woohooActivationUrl: json['woohooActivationUrl'] as String?,
      woohooActivatedAmount: (json['woohooActivatedAmount'] as num?)
          ?.toDouble(),
      woohooCardExpiry: json['woohooCardExpiry'] == null
          ? null
          : DateTime.parse(json['woohooCardExpiry'] as String),
      failureReason: json['failureReason'] as String?,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$GiftCardOrderToJson(_GiftCardOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'giftCardProductId': instance.giftCardProductId,
      'productName': instance.productName,
      'productImageUrl': instance.productImageUrl,
      'requestedAmount': instance.requestedAmount,
      'discountPercentage': instance.discountPercentage,
      'discountAmount': instance.discountAmount,
      'payableAmount': instance.payableAmount,
      'paymentMethod': _$GiftCardPaymentMethodEnumMap[instance.paymentMethod]!,
      'paymentStatus': _$GiftCardPaymentStatusEnumMap[instance.paymentStatus]!,
      'totalPointsUsed': instance.totalPointsUsed,
      'razorpayOrderId': instance.razorpayOrderId,
      'razorpayPaymentId': instance.razorpayPaymentId,
      'status': _$GiftCardOrderStatusEnumMap[instance.status]!,
      'woohooCardNumber': instance.woohooCardNumber,
      'woohooCardPin': instance.woohooCardPin,
      'woohooActivationCode': instance.woohooActivationCode,
      'woohooActivationUrl': instance.woohooActivationUrl,
      'woohooActivatedAmount': instance.woohooActivatedAmount,
      'woohooCardExpiry': instance.woohooCardExpiry?.toIso8601String(),
      'failureReason': instance.failureReason,
      'created': instance.created.toIso8601String(),
    };

const _$GiftCardPaymentMethodEnumMap = {
  GiftCardPaymentMethod.none: 0,
  GiftCardPaymentMethod.points: 1,
  GiftCardPaymentMethod.razorpay: 2,
};

const _$GiftCardPaymentStatusEnumMap = {
  GiftCardPaymentStatus.pending: 1,
  GiftCardPaymentStatus.completed: 2,
  GiftCardPaymentStatus.failed: 3,
  GiftCardPaymentStatus.refunded: 4,
};

const _$GiftCardOrderStatusEnumMap = {
  GiftCardOrderStatus.pending: 1,
  GiftCardOrderStatus.paymentCompleted: 2,
  GiftCardOrderStatus.issuing: 3,
  GiftCardOrderStatus.completed: 4,
  GiftCardOrderStatus.failed: 5,
  GiftCardOrderStatus.cancelled: 6,
  GiftCardOrderStatus.refunded: 7,
};

_PaginatedGiftCardOrderResponse _$PaginatedGiftCardOrderResponseFromJson(
  Map<String, dynamic> json,
) => _PaginatedGiftCardOrderResponse(
  items: (json['items'] as List<dynamic>)
      .map((e) => GiftCardOrder.fromJson(e as Map<String, dynamic>))
      .toList(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  hasPreviousPage: json['hasPreviousPage'] as bool,
  hasNextPage: json['hasNextPage'] as bool,
);

Map<String, dynamic> _$PaginatedGiftCardOrderResponseToJson(
  _PaginatedGiftCardOrderResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'pageNumber': instance.pageNumber,
  'totalPages': instance.totalPages,
  'totalCount': instance.totalCount,
  'hasPreviousPage': instance.hasPreviousPage,
  'hasNextPage': instance.hasNextPage,
};

_CreateGiftCardOrderRequest _$CreateGiftCardOrderRequestFromJson(
  Map<String, dynamic> json,
) => _CreateGiftCardOrderRequest(
  giftCardProductId: (json['giftCardProductId'] as num).toInt(),
  amount: (json['amount'] as num).toDouble(),
  paymentMethod: $enumDecode(
    _$GiftCardPaymentMethodEnumMap,
    json['paymentMethod'],
  ),
);

Map<String, dynamic> _$CreateGiftCardOrderRequestToJson(
  _CreateGiftCardOrderRequest instance,
) => <String, dynamic>{
  'giftCardProductId': instance.giftCardProductId,
  'amount': instance.amount,
  'paymentMethod': _$GiftCardPaymentMethodEnumMap[instance.paymentMethod]!,
};

_GiftCardPriceBreakdown _$GiftCardPriceBreakdownFromJson(
  Map<String, dynamic> json,
) => _GiftCardPriceBreakdown(
  productId: (json['productId'] as num).toInt(),
  productName: json['productName'] as String,
  requestedAmount: (json['requestedAmount'] as num).toDouble(),
  discountPercentage: (json['discountPercentage'] as num).toDouble(),
  discountAmount: (json['discountAmount'] as num).toDouble(),
  payableAmount: (json['payableAmount'] as num).toDouble(),
);

Map<String, dynamic> _$GiftCardPriceBreakdownToJson(
  _GiftCardPriceBreakdown instance,
) => <String, dynamic>{
  'productId': instance.productId,
  'productName': instance.productName,
  'requestedAmount': instance.requestedAmount,
  'discountPercentage': instance.discountPercentage,
  'discountAmount': instance.discountAmount,
  'payableAmount': instance.payableAmount,
};

_CreateGiftCardPaymentOrderRequest _$CreateGiftCardPaymentOrderRequestFromJson(
  Map<String, dynamic> json,
) => _CreateGiftCardPaymentOrderRequest(
  giftCardProductId: (json['giftCardProductId'] as num).toInt(),
  amount: (json['amount'] as num).toDouble(),
);

Map<String, dynamic> _$CreateGiftCardPaymentOrderRequestToJson(
  _CreateGiftCardPaymentOrderRequest instance,
) => <String, dynamic>{
  'giftCardProductId': instance.giftCardProductId,
  'amount': instance.amount,
};

_CreateGiftCardPaymentOrderResponse
_$CreateGiftCardPaymentOrderResponseFromJson(Map<String, dynamic> json) =>
    _CreateGiftCardPaymentOrderResponse(
      razorpayOrderId: json['razorpayOrderId'] as String,
      razorpayAmountInPaise: (json['razorpayAmountInPaise'] as num).toInt(),
      currency: json['currency'] as String,
      razorpayKeyId: json['razorpayKeyId'] as String,
      orderId: (json['orderId'] as num).toInt(),
      productName: json['productName'] as String,
      requestedAmount: (json['requestedAmount'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      discountAmount: (json['discountAmount'] as num).toDouble(),
      payableAmount: (json['payableAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$CreateGiftCardPaymentOrderResponseToJson(
  _CreateGiftCardPaymentOrderResponse instance,
) => <String, dynamic>{
  'razorpayOrderId': instance.razorpayOrderId,
  'razorpayAmountInPaise': instance.razorpayAmountInPaise,
  'currency': instance.currency,
  'razorpayKeyId': instance.razorpayKeyId,
  'orderId': instance.orderId,
  'productName': instance.productName,
  'requestedAmount': instance.requestedAmount,
  'discountPercentage': instance.discountPercentage,
  'discountAmount': instance.discountAmount,
  'payableAmount': instance.payableAmount,
};

_VerifyGiftCardPaymentRequest _$VerifyGiftCardPaymentRequestFromJson(
  Map<String, dynamic> json,
) => _VerifyGiftCardPaymentRequest(
  orderId: (json['orderId'] as num).toInt(),
  razorpayOrderId: json['razorpayOrderId'] as String,
  razorpayPaymentId: json['razorpayPaymentId'] as String,
  razorpaySignature: json['razorpaySignature'] as String,
);

Map<String, dynamic> _$VerifyGiftCardPaymentRequestToJson(
  _VerifyGiftCardPaymentRequest instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'razorpayOrderId': instance.razorpayOrderId,
  'razorpayPaymentId': instance.razorpayPaymentId,
  'razorpaySignature': instance.razorpaySignature,
};
