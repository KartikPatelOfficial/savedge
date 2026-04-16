import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift_card_models.freezed.dart';
part 'gift_card_models.g.dart';

@freezed
abstract class GiftCardCategory with _$GiftCardCategory {
  const factory GiftCardCategory({
    required int id,
    required String name,
    String? description,
    String? imageUrl,
    String? blurHash,
    required bool isActive,
    required int productCount,
    int? parentCategoryId,
    @Default([]) List<GiftCardCategory> subCategories,
  }) = _GiftCardCategory;

  factory GiftCardCategory.fromJson(Map<String, dynamic> json) =>
      _$GiftCardCategoryFromJson(json);
}

@freezed
abstract class GiftCardProduct with _$GiftCardProduct {
  const factory GiftCardProduct({
    required int id,
    required String name,
    String? description,
    required String sku,
    String? imageUrl,
    String? thumbnailUrl,
    String? mobileImageUrl,
    String? smallImageUrl,
    String? blurHash,
    required String priceType,
    required double minPrice,
    required double maxPrice,
    required bool isActive,
    String? categoryName,
    String? brandName,
    String? denominations,
    @Default([]) List<double> parsedDenominations,
    String? currencySymbol,
    String? offerDescription,
    String? formatExpiry,
    String? termsAndConditions,
    String? termsAndConditionsUrl,
    double? discountPercentage,
    String? themesJson,
    @Default([]) List<GiftCardTheme> parsedThemes,
    @Default(3) int redemptionMode,
  }) = _GiftCardProduct;

  factory GiftCardProduct.fromJson(Map<String, dynamic> json) =>
      _$GiftCardProductFromJson(json);
}

@freezed
abstract class GiftCardTheme with _$GiftCardTheme {
  const factory GiftCardTheme({
    required String sku,
    String? name,
    String? price,
    String? image,
  }) = _GiftCardTheme;

  factory GiftCardTheme.fromJson(Map<String, dynamic> json) =>
      _$GiftCardThemeFromJson(json);
}

@freezed
abstract class GiftCardRelatedProduct with _$GiftCardRelatedProduct {
  const factory GiftCardRelatedProduct({
    required int id,
    required int giftCardProductId,
    required String relatedSku,
    required String relatedName,
    String? relatedUrl,
    String? minPrice,
    String? maxPrice,
    String? offerShortDesc,
    String? thumbnailUrl,
    String? mobileImageUrl,
    @Default('INR') String currencyCode,
    @Default(false) bool hasPromo,
  }) = _GiftCardRelatedProduct;

  factory GiftCardRelatedProduct.fromJson(Map<String, dynamic> json) =>
      _$GiftCardRelatedProductFromJson(json);
}

@freezed
abstract class PaginatedGiftCardProductResponse
    with _$PaginatedGiftCardProductResponse {
  const factory PaginatedGiftCardProductResponse({
    required List<GiftCardProduct> items,
    required int pageNumber,
    required int totalPages,
    required int totalCount,
    required bool hasPreviousPage,
    required bool hasNextPage,
  }) = _PaginatedGiftCardProductResponse;

  factory PaginatedGiftCardProductResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PaginatedGiftCardProductResponseFromJson(json);
}

@freezed
abstract class GiftCardOrder with _$GiftCardOrder {
  const factory GiftCardOrder({
    required int id,
    required String userId,
    required int giftCardProductId,
    required String productName,
    String? productImageUrl,
    required double requestedAmount,
    required double discountPercentage,
    required double discountAmount,
    required double payableAmount,
    required GiftCardPaymentMethod paymentMethod,
    required GiftCardPaymentStatus paymentStatus,
    required double totalPointsUsed,
    String? razorpayOrderId,
    String? razorpayPaymentId,
    required GiftCardOrderStatus status,
    String? woohooCardNumber,
    String? woohooCardPin,
    String? woohooActivationCode,
    String? woohooActivationUrl,
    double? woohooActivatedAmount,
    DateTime? woohooCardExpiry,
    String? failureReason,
    String? razorpayRefundId,
    double? refundAmount,
    String? refundStatus,
    DateTime? refundedAt,
    int? pointsRefunded,
    required DateTime created,
  }) = _GiftCardOrder;

  factory GiftCardOrder.fromJson(Map<String, dynamic> json) =>
      _$GiftCardOrderFromJson(json);
}

@freezed
abstract class PaginatedGiftCardOrderResponse
    with _$PaginatedGiftCardOrderResponse {
  const factory PaginatedGiftCardOrderResponse({
    required List<GiftCardOrder> items,
    required int pageNumber,
    required int totalPages,
    required int totalCount,
    required bool hasPreviousPage,
    required bool hasNextPage,
  }) = _PaginatedGiftCardOrderResponse;

  factory PaginatedGiftCardOrderResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PaginatedGiftCardOrderResponseFromJson(json);
}

@freezed
abstract class CreateGiftCardOrderRequest with _$CreateGiftCardOrderRequest {
  const factory CreateGiftCardOrderRequest({
    required int giftCardProductId,
    required double amount,
    required GiftCardPaymentMethod paymentMethod,
    @Default(0) int pointsToUse,
    String? themeSku,
  }) = _CreateGiftCardOrderRequest;

  factory CreateGiftCardOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateGiftCardOrderRequestFromJson(json);
}

@freezed
abstract class GiftCardPriceBreakdown with _$GiftCardPriceBreakdown {
  const factory GiftCardPriceBreakdown({
    @JsonKey(name: 'giftCardProductId') @Default(0) int productId,
    @Default('') String productName,
    @Default(0) double requestedAmount,
    @Default(0) double discountPercentage,
    @Default(0) double discountAmount,
    @Default(0) double payableAmount,
    @Default(0) int availablePoints,
    @Default(0) double pointsDiscount,
    @Default(0) double finalPayableAmount,
  }) = _GiftCardPriceBreakdown;

  factory GiftCardPriceBreakdown.fromJson(Map<String, dynamic> json) =>
      _$GiftCardPriceBreakdownFromJson(json);
}

@freezed
abstract class CreateGiftCardPaymentOrderRequest
    with _$CreateGiftCardPaymentOrderRequest {
  const factory CreateGiftCardPaymentOrderRequest({
    required int giftCardProductId,
    required double amount,
    @Default(0) int pointsToUse,
    String? themeSku,
  }) = _CreateGiftCardPaymentOrderRequest;

  factory CreateGiftCardPaymentOrderRequest.fromJson(
          Map<String, dynamic> json) =>
      _$CreateGiftCardPaymentOrderRequestFromJson(json);
}

@freezed
abstract class CreateGiftCardPaymentOrderResponse
    with _$CreateGiftCardPaymentOrderResponse {
  const factory CreateGiftCardPaymentOrderResponse({
    @JsonKey(name: 'orderId') @Default('') String razorpayOrderId,
    @JsonKey(name: 'amount') @Default(0) int razorpayAmountInPaise,
    @Default('INR') String currency,
    @Default('') String razorpayKeyId,
    @JsonKey(name: 'giftCardOrderId') @Default(0) int orderId,
    @Default('') String productName,
    @Default(0) double requestedAmount,
    @Default(0) double discountPercentage,
    @Default(0) double discountAmount,
    @Default(0) double payableAmount,
    @Default(0) double pointsDiscount,
    @Default(0) double finalPayableAmount,
  }) = _CreateGiftCardPaymentOrderResponse;

  factory CreateGiftCardPaymentOrderResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreateGiftCardPaymentOrderResponseFromJson(json);
}

@freezed
abstract class VerifyGiftCardPaymentRequest
    with _$VerifyGiftCardPaymentRequest {
  const factory VerifyGiftCardPaymentRequest({
    @JsonKey(name: 'giftCardOrderId') required int orderId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  }) = _VerifyGiftCardPaymentRequest;

  factory VerifyGiftCardPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyGiftCardPaymentRequestFromJson(json);
}

@freezed
abstract class VerifyGiftCardPaymentResponse
    with _$VerifyGiftCardPaymentResponse {
  const factory VerifyGiftCardPaymentResponse({
    @Default(false) bool success,
    @Default('') String message,
  }) = _VerifyGiftCardPaymentResponse;

  factory VerifyGiftCardPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyGiftCardPaymentResponseFromJson(json);
}

enum GiftCardOrderStatus {
  @JsonValue(1)
  pending,
  @JsonValue(2)
  paymentCompleted,
  @JsonValue(3)
  issuing,
  @JsonValue(4)
  completed,
  @JsonValue(5)
  failed,
  @JsonValue(6)
  cancelled,
  @JsonValue(7)
  refunded,
}

enum GiftCardPaymentMethod {
  @JsonValue(0)
  none,
  @JsonValue(1)
  points,
  @JsonValue(2)
  razorpay,
}

enum GiftCardPaymentStatus {
  @JsonValue(1)
  pending,
  @JsonValue(2)
  completed,
  @JsonValue(3)
  failed,
  @JsonValue(4)
  refunded,
}

extension GiftCardOrderStatusExtension on GiftCardOrderStatus {
  String get displayName {
    switch (this) {
      case GiftCardOrderStatus.pending:
        return 'Pending';
      case GiftCardOrderStatus.paymentCompleted:
        return 'Payment Completed';
      case GiftCardOrderStatus.issuing:
        return 'Issuing';
      case GiftCardOrderStatus.completed:
        return 'Completed';
      case GiftCardOrderStatus.failed:
        return 'Failed';
      case GiftCardOrderStatus.cancelled:
        return 'Cancelled';
      case GiftCardOrderStatus.refunded:
        return 'Refunded';
    }
  }

  String get description {
    switch (this) {
      case GiftCardOrderStatus.pending:
        return 'Waiting for payment';
      case GiftCardOrderStatus.paymentCompleted:
        return 'Payment received, issuing gift card';
      case GiftCardOrderStatus.issuing:
        return 'Gift card is being issued';
      case GiftCardOrderStatus.completed:
        return 'Gift card is ready to use';
      case GiftCardOrderStatus.failed:
        return 'Order failed';
      case GiftCardOrderStatus.cancelled:
        return 'Order was cancelled';
      case GiftCardOrderStatus.refunded:
        return 'Order was refunded';
    }
  }
}

extension GiftCardPaymentMethodExtension on GiftCardPaymentMethod {
  String get displayName {
    switch (this) {
      case GiftCardPaymentMethod.none:
        return 'Not Specified';
      case GiftCardPaymentMethod.points:
        return 'Points';
      case GiftCardPaymentMethod.razorpay:
        return 'Online Payment';
    }
  }
}
