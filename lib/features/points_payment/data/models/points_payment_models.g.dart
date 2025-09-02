// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_payment_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InitiatePointsPaymentRequest _$InitiatePointsPaymentRequestFromJson(
  Map<String, dynamic> json,
) => _InitiatePointsPaymentRequest(
  vendorProfileId: (json['vendorProfileId'] as num).toInt(),
  amount: (json['amount'] as num).toDouble(),
  pointsToUse: (json['pointsToUse'] as num).toInt(),
);

Map<String, dynamic> _$InitiatePointsPaymentRequestToJson(
  _InitiatePointsPaymentRequest instance,
) => <String, dynamic>{
  'vendorProfileId': instance.vendorProfileId,
  'amount': instance.amount,
  'pointsToUse': instance.pointsToUse,
};

_InitiatePointsPaymentResponse _$InitiatePointsPaymentResponseFromJson(
  Map<String, dynamic> json,
) => _InitiatePointsPaymentResponse(
  paymentId: json['paymentId'] as String,
  transactionReference: json['transactionReference'] as String,
  pointsToUse: (json['pointsToUse'] as num).toInt(),
  pointsValue: (json['pointsValue'] as num).toDouble(),
  billAmount: (json['billAmount'] as num).toDouble(),
  remainingAmount: (json['remainingAmount'] as num).toDouble(),
);

Map<String, dynamic> _$InitiatePointsPaymentResponseToJson(
  _InitiatePointsPaymentResponse instance,
) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'transactionReference': instance.transactionReference,
  'pointsToUse': instance.pointsToUse,
  'pointsValue': instance.pointsValue,
  'billAmount': instance.billAmount,
  'remainingAmount': instance.remainingAmount,
};

_VerifyPointsPaymentOtpRequest _$VerifyPointsPaymentOtpRequestFromJson(
  Map<String, dynamic> json,
) => _VerifyPointsPaymentOtpRequest(
  paymentId: json['paymentId'] as String,
  otpCode: json['otpCode'] as String,
);

Map<String, dynamic> _$VerifyPointsPaymentOtpRequestToJson(
  _VerifyPointsPaymentOtpRequest instance,
) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'otpCode': instance.otpCode,
};

_VerifyPointsPaymentOtpResponse _$VerifyPointsPaymentOtpResponseFromJson(
  Map<String, dynamic> json,
) => _VerifyPointsPaymentOtpResponse(
  paymentId: json['paymentId'] as String,
  transactionReference: json['transactionReference'] as String,
  pointsUsed: (json['pointsUsed'] as num).toInt(),
  pointsValue: (json['pointsValue'] as num).toDouble(),
  billAmount: (json['billAmount'] as num).toDouble(),
  paidAmount: (json['paidAmount'] as num).toDouble(),
  remainingAmount: (json['remainingAmount'] as num).toDouble(),
  vendorName: json['vendorName'] as String,
  completedAt: DateTime.parse(json['completedAt'] as String),
);

Map<String, dynamic> _$VerifyPointsPaymentOtpResponseToJson(
  _VerifyPointsPaymentOtpResponse instance,
) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'transactionReference': instance.transactionReference,
  'pointsUsed': instance.pointsUsed,
  'pointsValue': instance.pointsValue,
  'billAmount': instance.billAmount,
  'paidAmount': instance.paidAmount,
  'remainingAmount': instance.remainingAmount,
  'vendorName': instance.vendorName,
  'completedAt': instance.completedAt.toIso8601String(),
};

_UserPointsBalanceResponse _$UserPointsBalanceResponseFromJson(
  Map<String, dynamic> json,
) => _UserPointsBalanceResponse(
  availablePoints: (json['availablePoints'] as num).toInt(),
  usedPoints: (json['usedPoints'] as num).toInt(),
  expiringPoints: (json['expiringPoints'] as num).toInt(),
  recentTransactions: (json['recentTransactions'] as List<dynamic>)
      .map((e) => PointTransactionDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserPointsBalanceResponseToJson(
  _UserPointsBalanceResponse instance,
) => <String, dynamic>{
  'availablePoints': instance.availablePoints,
  'usedPoints': instance.usedPoints,
  'expiringPoints': instance.expiringPoints,
  'recentTransactions': instance.recentTransactions,
};

_PointTransactionDto _$PointTransactionDtoFromJson(Map<String, dynamic> json) =>
    _PointTransactionDto(
      transactionId: (json['transactionId'] as num).toInt(),
      points: (json['points'] as num).toInt(),
      description: json['description'] as String,
      transactionType: json['transactionType'] as String,
      transactionDate: DateTime.parse(json['transactionDate'] as String),
      expiryDate: json['expiryDate'] == null
          ? null
          : DateTime.parse(json['expiryDate'] as String),
    );

Map<String, dynamic> _$PointTransactionDtoToJson(
  _PointTransactionDto instance,
) => <String, dynamic>{
  'transactionId': instance.transactionId,
  'points': instance.points,
  'description': instance.description,
  'transactionType': instance.transactionType,
  'transactionDate': instance.transactionDate.toIso8601String(),
  'expiryDate': instance.expiryDate?.toIso8601String(),
};

_PointsPaymentDetailsResponse _$PointsPaymentDetailsResponseFromJson(
  Map<String, dynamic> json,
) => _PointsPaymentDetailsResponse(
  paymentId: json['paymentId'] as String,
  transactionReference: json['transactionReference'] as String,
  customerName: json['customerName'] as String,
  customerEmail: json['customerEmail'] as String,
  vendorName: json['vendorName'] as String,
  vendorEmail: json['vendorEmail'] as String,
  billAmount: (json['billAmount'] as num).toDouble(),
  pointsUsed: (json['pointsUsed'] as num).toInt(),
  conversionRate: (json['conversionRate'] as num).toDouble(),
  pointsValue: (json['pointsValue'] as num).toDouble(),
  remainingAmount: (json['remainingAmount'] as num).toDouble(),
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  isSettled: json['isSettled'] as bool,
  settlementId: json['settlementId'] as String?,
);

Map<String, dynamic> _$PointsPaymentDetailsResponseToJson(
  _PointsPaymentDetailsResponse instance,
) => <String, dynamic>{
  'paymentId': instance.paymentId,
  'transactionReference': instance.transactionReference,
  'customerName': instance.customerName,
  'customerEmail': instance.customerEmail,
  'vendorName': instance.vendorName,
  'vendorEmail': instance.vendorEmail,
  'billAmount': instance.billAmount,
  'pointsUsed': instance.pointsUsed,
  'conversionRate': instance.conversionRate,
  'pointsValue': instance.pointsValue,
  'remainingAmount': instance.remainingAmount,
  'status': instance.status,
  'createdAt': instance.createdAt.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'isSettled': instance.isSettled,
  'settlementId': instance.settlementId,
};
