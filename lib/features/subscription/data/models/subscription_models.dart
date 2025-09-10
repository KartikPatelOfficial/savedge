import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/entities/subscription.dart';

part 'subscription_models.freezed.dart';
part 'subscription_models.g.dart';

/// Data model for subscription plan
@freezed
abstract class SubscriptionPlanModel with _$SubscriptionPlanModel {
  const factory SubscriptionPlanModel({
    required int id,
    required String name,
    String? description,
    required double price,
    @JsonKey(name: 'durationMonths') required int durationMonths,
    String? features,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @Default(true) bool isActive,
  }) = _SubscriptionPlanModel;

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanModelFromJson(json);
}

/// Extension to convert to domain entity
extension SubscriptionPlanModelX on SubscriptionPlanModel {
  SubscriptionPlan toDomain() {
    return SubscriptionPlan(
      id: id,
      name: name,
      description: description,
      price: price,
      durationMonths: durationMonths,
      features: features,
      imageUrl: imageUrl,
      isActive: isActive,
    );
  }
}

/// Data model for user subscription
@freezed
abstract class UserSubscriptionModel with _$UserSubscriptionModel {
  const factory UserSubscriptionModel({
    @JsonKey(name: 'planId') required int planId,
    @JsonKey(name: 'planName') required String planName,
    @JsonKey(name: 'startDate') required DateTime startDate,
    @JsonKey(name: 'endDate') required DateTime endDate,
    @JsonKey(name: 'isActive') required bool isActive,
    @JsonKey(name: 'autoRenew') required bool autoRenew,
  }) = _UserSubscriptionModel;

  factory UserSubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$UserSubscriptionModelFromJson(json);
}

/// Extension to convert to domain entity
extension UserSubscriptionModelX on UserSubscriptionModel {
  UserSubscription toDomain() {
    return UserSubscription(
      planId: planId,
      planName: planName,
      startDate: startDate,
      endDate: endDate,
      isActive: isActive,
      autoRenew: autoRenew,
    );
  }
}

/// Request model for purchasing subscription
@freezed
abstract class PurchaseSubscriptionRequestModel
    with _$PurchaseSubscriptionRequestModel {
  const factory PurchaseSubscriptionRequestModel({
    @JsonKey(name: 'planId') required int planId,
    @JsonKey(name: 'autoRenew') @Default(false) bool autoRenew,
  }) = _PurchaseSubscriptionRequestModel;

  factory PurchaseSubscriptionRequestModel.fromJson(
    Map<String, dynamic> json,
  ) => _$PurchaseSubscriptionRequestModelFromJson(json);
}

/// Request model for purchasing subscription with points
@freezed
abstract class PurchaseSubscriptionWithPointsRequestModel
    with _$PurchaseSubscriptionWithPointsRequestModel {
  const factory PurchaseSubscriptionWithPointsRequestModel({
    @JsonKey(name: 'planId') required int planId,
    @JsonKey(name: 'autoRenew') @Default(false) bool autoRenew,
  }) = _PurchaseSubscriptionWithPointsRequestModel;

  factory PurchaseSubscriptionWithPointsRequestModel.fromJson(
    Map<String, dynamic> json,
  ) => _$PurchaseSubscriptionWithPointsRequestModelFromJson(json);
}

/// Response model for subscription purchase with points
@freezed
abstract class PurchaseWithPointsResponseModel
    with _$PurchaseWithPointsResponseModel {
  const factory PurchaseWithPointsResponseModel({
    required String message,
    @JsonKey(name: 'pointsSpent') required int pointsSpent,
    @JsonKey(name: 'newBalance') required int newBalance,
    @JsonKey(name: 'subscriptionId') required int subscriptionId,
  }) = _PurchaseWithPointsResponseModel;

  factory PurchaseWithPointsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PurchaseWithPointsResponseModelFromJson(json);
}

/// Request model for creating payment order
@freezed
abstract class CreatePaymentOrderRequestModel
    with _$CreatePaymentOrderRequestModel {
  const factory CreatePaymentOrderRequestModel({
    @JsonKey(name: 'planId') required int planId,
    @JsonKey(name: 'autoRenew') @Default(false) bool autoRenew,
  }) = _CreatePaymentOrderRequestModel;

  factory CreatePaymentOrderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentOrderRequestModelFromJson(json);
}

/// Response model for creating payment order
@freezed
abstract class CreatePaymentOrderResponseModel
    with _$CreatePaymentOrderResponseModel {
  const factory CreatePaymentOrderResponseModel({
    @JsonKey(name: 'orderId') required String orderId,
    required int amount,
    required String currency,
    required String receipt,
    @JsonKey(name: 'transactionId') required int transactionId,
    @JsonKey(name: 'planDetails') required SubscriptionPlanModel planDetails,
  }) = _CreatePaymentOrderResponseModel;

  factory CreatePaymentOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentOrderResponseModelFromJson(json);
}

/// Request model for verifying payment
@freezed
abstract class VerifyPaymentRequestModel with _$VerifyPaymentRequestModel {
  const factory VerifyPaymentRequestModel({
    @JsonKey(name: 'transactionId') required int transactionId,
    @JsonKey(name: 'razorpayOrderId') required String razorpayOrderId,
    @JsonKey(name: 'razorpayPaymentId') required String razorpayPaymentId,
    @JsonKey(name: 'razorpaySignature') required String razorpaySignature,
    @JsonKey(name: 'autoRenew') @Default(false) bool autoRenew,
  }) = _VerifyPaymentRequestModel;

  factory VerifyPaymentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyPaymentRequestModelFromJson(json);
}

/// Response model for verifying payment
@freezed
abstract class VerifyPaymentResponseModel with _$VerifyPaymentResponseModel {
  const factory VerifyPaymentResponseModel({
    required bool success,
    required String message,
    @JsonKey(name: 'subscriptionId') required int subscriptionId,
    required UserSubscriptionModel subscription,
  }) = _VerifyPaymentResponseModel;

  factory VerifyPaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyPaymentResponseModelFromJson(json);
}

/// Data model for payment transaction status
@freezed
abstract class PaymentTransactionModel with _$PaymentTransactionModel {
  const factory PaymentTransactionModel({
    @JsonKey(name: 'transactionId') required int transactionId,
    required String status,
    required double amount,
    @JsonKey(name: 'paymentReference') String? paymentReference,
    @JsonKey(name: 'razorpayOrderId') String? razorpayOrderId,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
    @JsonKey(name: 'failureReason') String? failureReason,
    @JsonKey(name: 'planName') String? planName,
  }) = _PaymentTransactionModel;

  factory PaymentTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionModelFromJson(json);
}

/// Extension to convert to domain entity
extension PaymentTransactionModelX on PaymentTransactionModel {
  PaymentTransaction toDomain() {
    return PaymentTransaction(
      id: transactionId,
      status: status,
      amount: amount,
      createdAt: createdAt,
      paymentReference: paymentReference,
      razorpayOrderId: razorpayOrderId,
      failureReason: failureReason,
      planName: planName,
    );
  }
}

/// Error response model for insufficient points
@freezed
abstract class InsufficientPointsErrorModel
    with _$InsufficientPointsErrorModel {
  const factory InsufficientPointsErrorModel({
    required String message,
    @JsonKey(name: 'availablePoints') required int availablePoints,
    @JsonKey(name: 'requiredPoints') required int requiredPoints,
    required int shortfall,
  }) = _InsufficientPointsErrorModel;

  factory InsufficientPointsErrorModel.fromJson(Map<String, dynamic> json) =>
      _$InsufficientPointsErrorModelFromJson(json);
}

/// Error response model for existing active subscription
@freezed
abstract class ExistingSubscriptionErrorModel
    with _$ExistingSubscriptionErrorModel {
  const factory ExistingSubscriptionErrorModel({
    required String message,
    @JsonKey(name: 'activeSubscription')
    required ExistingSubscriptionDetailsModel activeSubscription,
  }) = _ExistingSubscriptionErrorModel;

  factory ExistingSubscriptionErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ExistingSubscriptionErrorModelFromJson(json);
}

/// Model for existing subscription details in error response
@freezed
abstract class ExistingSubscriptionDetailsModel
    with _$ExistingSubscriptionDetailsModel {
  const factory ExistingSubscriptionDetailsModel({
    @JsonKey(name: 'planId') required int planId,
    @JsonKey(name: 'endDate') required DateTime endDate,
  }) = _ExistingSubscriptionDetailsModel;

  factory ExistingSubscriptionDetailsModel.fromJson(
    Map<String, dynamic> json,
  ) => _$ExistingSubscriptionDetailsModelFromJson(json);
}
