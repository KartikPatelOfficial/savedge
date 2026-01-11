import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_models.freezed.dart';
part 'payment_models.g.dart';

@freezed
abstract class CreatePaymentOrderRequest with _$CreatePaymentOrderRequest {
  const factory CreatePaymentOrderRequest({
    required int planId,
    @Default(false) bool autoRenew,
  }) = _CreatePaymentOrderRequest;

  factory CreatePaymentOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentOrderRequestFromJson(json);
}

@freezed
abstract class CreatePaymentOrderResponse with _$CreatePaymentOrderResponse {
  const factory CreatePaymentOrderResponse({
    required String orderId,
    required int amount,
    required String currency,
    required String receipt,
    required int transactionId,
    required String redirectUrl, // PineLabs payment page URL
    PlanDetailsDto? planDetails,
  }) = _CreatePaymentOrderResponse;

  factory CreatePaymentOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentOrderResponseFromJson(json);
}

@freezed
abstract class PlanDetailsDto with _$PlanDetailsDto {
  const factory PlanDetailsDto({
    required int id,
    required String name,
    String? description,
    required double price,
    required int durationMonths,
    String? features,
    String? imageUrl,
  }) = _PlanDetailsDto;

  factory PlanDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$PlanDetailsDtoFromJson(json);
}

@freezed
abstract class PaymentStatusResponse with _$PaymentStatusResponse {
  const factory PaymentStatusResponse({
    required int transactionId,
    required String status,
    required double amount,
    String? paymentReference,
    String? paymentOrderId,
    required DateTime createdAt,
    String? failureReason,
    String? planName,
  }) = _PaymentStatusResponse;

  factory PaymentStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentStatusResponseFromJson(json);
}

@freezed
abstract class PurchaseSubscriptionRequest with _$PurchaseSubscriptionRequest {
  const factory PurchaseSubscriptionRequest({
    required int planId,
    @Default(false) bool autoRenew,
    String? paymentMethod, // 'points' or 'pinelabs'
  }) = _PurchaseSubscriptionRequest;

  factory PurchaseSubscriptionRequest.fromJson(Map<String, dynamic> json) =>
      _$PurchaseSubscriptionRequestFromJson(json);
}

@freezed
abstract class PurchaseSubscriptionResponse
    with _$PurchaseSubscriptionResponse {
  const factory PurchaseSubscriptionResponse({
    required bool success,
    required String message,
    String? subscriptionId,
    DateTime? startDate,
    DateTime? endDate,
  }) = _PurchaseSubscriptionResponse;

  factory PurchaseSubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$PurchaseSubscriptionResponseFromJson(json);
}
