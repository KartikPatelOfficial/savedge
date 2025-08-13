import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_models.freezed.dart';
part 'payment_models.g.dart';

@freezed
abstract class CreatePaymentOrderRequest with _$CreatePaymentOrderRequest {
  const factory CreatePaymentOrderRequest({
    required int planId,
    required double amount,
    required String currency,
  }) = _CreatePaymentOrderRequest;

  factory CreatePaymentOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentOrderRequestFromJson(json);
}

@freezed
abstract class CreatePaymentOrderResponse with _$CreatePaymentOrderResponse {
  const factory CreatePaymentOrderResponse({
    required String orderId,
    required String razorpayOrderId,
    required double amount,
    required String currency,
    required String key,
    required int transactionId,
  }) = _CreatePaymentOrderResponse;

  factory CreatePaymentOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentOrderResponseFromJson(json);
}

@freezed
abstract class VerifyPaymentRequest with _$VerifyPaymentRequest {
  const factory VerifyPaymentRequest({
    required String razorpayPaymentId,
    required String razorpayOrderId,
    required String razorpaySignature,
    required int transactionId,
  }) = _VerifyPaymentRequest;

  factory VerifyPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyPaymentRequestFromJson(json);
}

@freezed
abstract class PaymentVerificationResponse with _$PaymentVerificationResponse {
  const factory PaymentVerificationResponse({
    required bool success,
    required String message,
    String? subscriptionId,
  }) = _PaymentVerificationResponse;

  factory PaymentVerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentVerificationResponseFromJson(json);
}

@freezed
abstract class PurchaseSubscriptionRequest with _$PurchaseSubscriptionRequest {
  const factory PurchaseSubscriptionRequest({
    required int planId,
    @Default(false) bool autoRenew,
    String? paymentMethod, // 'points' or 'razorpay'
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
