// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatePaymentOrderRequest _$CreatePaymentOrderRequestFromJson(
  Map<String, dynamic> json,
) => _CreatePaymentOrderRequest(
  planId: (json['planId'] as num).toInt(),
  autoRenew: json['autoRenew'] as bool? ?? false,
);

Map<String, dynamic> _$CreatePaymentOrderRequestToJson(
  _CreatePaymentOrderRequest instance,
) => <String, dynamic>{
  'planId': instance.planId,
  'autoRenew': instance.autoRenew,
};

_CreatePaymentOrderResponse _$CreatePaymentOrderResponseFromJson(
  Map<String, dynamic> json,
) => _CreatePaymentOrderResponse(
  orderId: json['orderId'] as String,
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String,
  receipt: json['receipt'] as String,
  transactionId: (json['transactionId'] as num).toInt(),
  razorpayKeyId: json['razorpayKeyId'] as String,
  planDetails: json['planDetails'] == null
      ? null
      : PlanDetailsDto.fromJson(json['planDetails'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreatePaymentOrderResponseToJson(
  _CreatePaymentOrderResponse instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'amount': instance.amount,
  'currency': instance.currency,
  'receipt': instance.receipt,
  'transactionId': instance.transactionId,
  'razorpayKeyId': instance.razorpayKeyId,
  'planDetails': instance.planDetails,
};

_PlanDetailsDto _$PlanDetailsDtoFromJson(Map<String, dynamic> json) =>
    _PlanDetailsDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      durationMonths: (json['durationMonths'] as num).toInt(),
      features: json['features'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$PlanDetailsDtoToJson(_PlanDetailsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'durationMonths': instance.durationMonths,
      'features': instance.features,
      'imageUrl': instance.imageUrl,
    };

_VerifyPaymentRequest _$VerifyPaymentRequestFromJson(
  Map<String, dynamic> json,
) => _VerifyPaymentRequest(
  transactionId: (json['transactionId'] as num).toInt(),
  razorpayOrderId: json['razorpayOrderId'] as String,
  razorpayPaymentId: json['razorpayPaymentId'] as String,
  razorpaySignature: json['razorpaySignature'] as String,
  autoRenew: json['autoRenew'] as bool? ?? false,
);

Map<String, dynamic> _$VerifyPaymentRequestToJson(
  _VerifyPaymentRequest instance,
) => <String, dynamic>{
  'transactionId': instance.transactionId,
  'razorpayOrderId': instance.razorpayOrderId,
  'razorpayPaymentId': instance.razorpayPaymentId,
  'razorpaySignature': instance.razorpaySignature,
  'autoRenew': instance.autoRenew,
};

_VerifyPaymentResponse _$VerifyPaymentResponseFromJson(
  Map<String, dynamic> json,
) => _VerifyPaymentResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  subscriptionId: (json['subscriptionId'] as num?)?.toInt(),
);

Map<String, dynamic> _$VerifyPaymentResponseToJson(
  _VerifyPaymentResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'subscriptionId': instance.subscriptionId,
};

_PaymentStatusResponse _$PaymentStatusResponseFromJson(
  Map<String, dynamic> json,
) => _PaymentStatusResponse(
  transactionId: (json['transactionId'] as num).toInt(),
  status: json['status'] as String,
  amount: (json['amount'] as num).toDouble(),
  paymentReference: json['paymentReference'] as String?,
  paymentOrderId: json['paymentOrderId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  failureReason: json['failureReason'] as String?,
  planName: json['planName'] as String?,
);

Map<String, dynamic> _$PaymentStatusResponseToJson(
  _PaymentStatusResponse instance,
) => <String, dynamic>{
  'transactionId': instance.transactionId,
  'status': instance.status,
  'amount': instance.amount,
  'paymentReference': instance.paymentReference,
  'paymentOrderId': instance.paymentOrderId,
  'createdAt': instance.createdAt.toIso8601String(),
  'failureReason': instance.failureReason,
  'planName': instance.planName,
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
