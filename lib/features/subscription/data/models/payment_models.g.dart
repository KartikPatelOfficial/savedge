// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatePaymentOrderRequest _$CreatePaymentOrderRequestFromJson(
  Map<String, dynamic> json,
) => _CreatePaymentOrderRequest(
  planId: (json['planId'] as num).toInt(),
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
);

Map<String, dynamic> _$CreatePaymentOrderRequestToJson(
  _CreatePaymentOrderRequest instance,
) => <String, dynamic>{
  'planId': instance.planId,
  'amount': instance.amount,
  'currency': instance.currency,
};

_CreatePaymentOrderResponse _$CreatePaymentOrderResponseFromJson(
  Map<String, dynamic> json,
) => _CreatePaymentOrderResponse(
  orderId: json['orderId'] as String,
  razorpayOrderId: json['razorpayOrderId'] as String,
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  key: json['key'] as String,
  transactionId: (json['transactionId'] as num).toInt(),
);

Map<String, dynamic> _$CreatePaymentOrderResponseToJson(
  _CreatePaymentOrderResponse instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'razorpayOrderId': instance.razorpayOrderId,
  'amount': instance.amount,
  'currency': instance.currency,
  'key': instance.key,
  'transactionId': instance.transactionId,
};

_VerifyPaymentRequest _$VerifyPaymentRequestFromJson(
  Map<String, dynamic> json,
) => _VerifyPaymentRequest(
  razorpayPaymentId: json['razorpayPaymentId'] as String,
  razorpayOrderId: json['razorpayOrderId'] as String,
  razorpaySignature: json['razorpaySignature'] as String,
  transactionId: (json['transactionId'] as num).toInt(),
);

Map<String, dynamic> _$VerifyPaymentRequestToJson(
  _VerifyPaymentRequest instance,
) => <String, dynamic>{
  'razorpayPaymentId': instance.razorpayPaymentId,
  'razorpayOrderId': instance.razorpayOrderId,
  'razorpaySignature': instance.razorpaySignature,
  'transactionId': instance.transactionId,
};

_PaymentVerificationResponse _$PaymentVerificationResponseFromJson(
  Map<String, dynamic> json,
) => _PaymentVerificationResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  subscriptionId: json['subscriptionId'] as String?,
);

Map<String, dynamic> _$PaymentVerificationResponseToJson(
  _PaymentVerificationResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'subscriptionId': instance.subscriptionId,
};

_PurchaseSubscriptionRequest _$PurchaseSubscriptionRequestFromJson(
  Map<String, dynamic> json,
) => _PurchaseSubscriptionRequest(
  planId: (json['planId'] as num).toInt(),
  autoRenew: json['autoRenew'] as bool? ?? false,
  paymentMethod: json['paymentMethod'] as String?,
);

Map<String, dynamic> _$PurchaseSubscriptionRequestToJson(
  _PurchaseSubscriptionRequest instance,
) => <String, dynamic>{
  'planId': instance.planId,
  'autoRenew': instance.autoRenew,
  'paymentMethod': instance.paymentMethod,
};

_PurchaseSubscriptionResponse _$PurchaseSubscriptionResponseFromJson(
  Map<String, dynamic> json,
) => _PurchaseSubscriptionResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  subscriptionId: json['subscriptionId'] as String?,
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
);

Map<String, dynamic> _$PurchaseSubscriptionResponseToJson(
  _PurchaseSubscriptionResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'subscriptionId': instance.subscriptionId,
  'startDate': instance.startDate?.toIso8601String(),
  'endDate': instance.endDate?.toIso8601String(),
};
