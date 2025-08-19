// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionPlanModel _$SubscriptionPlanModelFromJson(
  Map<String, dynamic> json,
) => _SubscriptionPlanModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  price: (json['price'] as num).toDouble(),
  durationMonths: (json['durationMonths'] as num).toInt(),
  bonusPoints: (json['bonusPoints'] as num).toInt(),
  maxCoupons: (json['maxCoupons'] as num).toInt(),
  features: json['features'] as String?,
  imageUrl: json['imageUrl'] as String?,
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$SubscriptionPlanModelToJson(
  _SubscriptionPlanModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'durationMonths': instance.durationMonths,
  'bonusPoints': instance.bonusPoints,
  'maxCoupons': instance.maxCoupons,
  'features': instance.features,
  'imageUrl': instance.imageUrl,
  'isActive': instance.isActive,
};

_UserSubscriptionModel _$UserSubscriptionModelFromJson(
  Map<String, dynamic> json,
) => _UserSubscriptionModel(
  planId: (json['planId'] as num).toInt(),
  planName: json['planName'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  isActive: json['isActive'] as bool,
  autoRenew: json['autoRenew'] as bool,
);

Map<String, dynamic> _$UserSubscriptionModelToJson(
  _UserSubscriptionModel instance,
) => <String, dynamic>{
  'planId': instance.planId,
  'planName': instance.planName,
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'isActive': instance.isActive,
  'autoRenew': instance.autoRenew,
};

_PurchaseSubscriptionRequestModel _$PurchaseSubscriptionRequestModelFromJson(
  Map<String, dynamic> json,
) => _PurchaseSubscriptionRequestModel(
  planId: (json['planId'] as num).toInt(),
  autoRenew: json['autoRenew'] as bool? ?? false,
);

Map<String, dynamic> _$PurchaseSubscriptionRequestModelToJson(
  _PurchaseSubscriptionRequestModel instance,
) => <String, dynamic>{
  'planId': instance.planId,
  'autoRenew': instance.autoRenew,
};

_PurchaseSubscriptionWithPointsRequestModel
_$PurchaseSubscriptionWithPointsRequestModelFromJson(
  Map<String, dynamic> json,
) => _PurchaseSubscriptionWithPointsRequestModel(
  planId: (json['planId'] as num).toInt(),
  autoRenew: json['autoRenew'] as bool? ?? false,
);

Map<String, dynamic> _$PurchaseSubscriptionWithPointsRequestModelToJson(
  _PurchaseSubscriptionWithPointsRequestModel instance,
) => <String, dynamic>{
  'planId': instance.planId,
  'autoRenew': instance.autoRenew,
};

_PurchaseWithPointsResponseModel _$PurchaseWithPointsResponseModelFromJson(
  Map<String, dynamic> json,
) => _PurchaseWithPointsResponseModel(
  message: json['message'] as String,
  pointsSpent: (json['pointsSpent'] as num).toInt(),
  bonusPoints: (json['bonusPoints'] as num).toInt(),
  newBalance: (json['newBalance'] as num).toInt(),
  subscriptionId: (json['subscriptionId'] as num).toInt(),
);

Map<String, dynamic> _$PurchaseWithPointsResponseModelToJson(
  _PurchaseWithPointsResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'pointsSpent': instance.pointsSpent,
  'bonusPoints': instance.bonusPoints,
  'newBalance': instance.newBalance,
  'subscriptionId': instance.subscriptionId,
};

_CreatePaymentOrderRequestModel _$CreatePaymentOrderRequestModelFromJson(
  Map<String, dynamic> json,
) => _CreatePaymentOrderRequestModel(
  planId: (json['planId'] as num).toInt(),
  autoRenew: json['autoRenew'] as bool? ?? false,
);

Map<String, dynamic> _$CreatePaymentOrderRequestModelToJson(
  _CreatePaymentOrderRequestModel instance,
) => <String, dynamic>{
  'planId': instance.planId,
  'autoRenew': instance.autoRenew,
};

_CreatePaymentOrderResponseModel _$CreatePaymentOrderResponseModelFromJson(
  Map<String, dynamic> json,
) => _CreatePaymentOrderResponseModel(
  orderId: json['orderId'] as String,
  amount: (json['amount'] as num).toInt(),
  currency: json['currency'] as String,
  receipt: json['receipt'] as String,
  transactionId: (json['transactionId'] as num).toInt(),
  planDetails: SubscriptionPlanModel.fromJson(
    json['planDetails'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$CreatePaymentOrderResponseModelToJson(
  _CreatePaymentOrderResponseModel instance,
) => <String, dynamic>{
  'orderId': instance.orderId,
  'amount': instance.amount,
  'currency': instance.currency,
  'receipt': instance.receipt,
  'transactionId': instance.transactionId,
  'planDetails': instance.planDetails,
};

_VerifyPaymentRequestModel _$VerifyPaymentRequestModelFromJson(
  Map<String, dynamic> json,
) => _VerifyPaymentRequestModel(
  transactionId: (json['transactionId'] as num).toInt(),
  razorpayOrderId: json['razorpayOrderId'] as String,
  razorpayPaymentId: json['razorpayPaymentId'] as String,
  razorpaySignature: json['razorpaySignature'] as String,
  autoRenew: json['autoRenew'] as bool? ?? false,
);

Map<String, dynamic> _$VerifyPaymentRequestModelToJson(
  _VerifyPaymentRequestModel instance,
) => <String, dynamic>{
  'transactionId': instance.transactionId,
  'razorpayOrderId': instance.razorpayOrderId,
  'razorpayPaymentId': instance.razorpayPaymentId,
  'razorpaySignature': instance.razorpaySignature,
  'autoRenew': instance.autoRenew,
};

_VerifyPaymentResponseModel _$VerifyPaymentResponseModelFromJson(
  Map<String, dynamic> json,
) => _VerifyPaymentResponseModel(
  success: json['success'] as bool,
  message: json['message'] as String,
  subscriptionId: (json['subscriptionId'] as num).toInt(),
  subscription: UserSubscriptionModel.fromJson(
    json['subscription'] as Map<String, dynamic>,
  ),
  bonusPointsAwarded: (json['bonusPointsAwarded'] as num).toInt(),
);

Map<String, dynamic> _$VerifyPaymentResponseModelToJson(
  _VerifyPaymentResponseModel instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'subscriptionId': instance.subscriptionId,
  'subscription': instance.subscription,
  'bonusPointsAwarded': instance.bonusPointsAwarded,
};

_PaymentTransactionModel _$PaymentTransactionModelFromJson(
  Map<String, dynamic> json,
) => _PaymentTransactionModel(
  transactionId: (json['transactionId'] as num).toInt(),
  status: json['status'] as String,
  amount: (json['amount'] as num).toDouble(),
  paymentReference: json['paymentReference'] as String?,
  razorpayOrderId: json['razorpayOrderId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  failureReason: json['failureReason'] as String?,
  planName: json['planName'] as String?,
);

Map<String, dynamic> _$PaymentTransactionModelToJson(
  _PaymentTransactionModel instance,
) => <String, dynamic>{
  'transactionId': instance.transactionId,
  'status': instance.status,
  'amount': instance.amount,
  'paymentReference': instance.paymentReference,
  'razorpayOrderId': instance.razorpayOrderId,
  'createdAt': instance.createdAt.toIso8601String(),
  'failureReason': instance.failureReason,
  'planName': instance.planName,
};

_InsufficientPointsErrorModel _$InsufficientPointsErrorModelFromJson(
  Map<String, dynamic> json,
) => _InsufficientPointsErrorModel(
  message: json['message'] as String,
  availablePoints: (json['availablePoints'] as num).toInt(),
  requiredPoints: (json['requiredPoints'] as num).toInt(),
  shortfall: (json['shortfall'] as num).toInt(),
);

Map<String, dynamic> _$InsufficientPointsErrorModelToJson(
  _InsufficientPointsErrorModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'availablePoints': instance.availablePoints,
  'requiredPoints': instance.requiredPoints,
  'shortfall': instance.shortfall,
};

_ExistingSubscriptionErrorModel _$ExistingSubscriptionErrorModelFromJson(
  Map<String, dynamic> json,
) => _ExistingSubscriptionErrorModel(
  message: json['message'] as String,
  activeSubscription: ExistingSubscriptionDetailsModel.fromJson(
    json['activeSubscription'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$ExistingSubscriptionErrorModelToJson(
  _ExistingSubscriptionErrorModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'activeSubscription': instance.activeSubscription,
};

_ExistingSubscriptionDetailsModel _$ExistingSubscriptionDetailsModelFromJson(
  Map<String, dynamic> json,
) => _ExistingSubscriptionDetailsModel(
  planId: (json['planId'] as num).toInt(),
  endDate: DateTime.parse(json['endDate'] as String),
);

Map<String, dynamic> _$ExistingSubscriptionDetailsModelToJson(
  _ExistingSubscriptionDetailsModel instance,
) => <String, dynamic>{
  'planId': instance.planId,
  'endDate': instance.endDate.toIso8601String(),
};
