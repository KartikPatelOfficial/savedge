// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserPointsResponseModel _$UserPointsResponseModelFromJson(
  Map<String, dynamic> json,
) => _UserPointsResponseModel(
  pointsBalance: (json['pointsBalance'] as num).toInt(),
  pointsExpiry: json['pointsExpiry'] == null
      ? null
      : DateTime.parse(json['pointsExpiry'] as String),
);

Map<String, dynamic> _$UserPointsResponseModelToJson(
  _UserPointsResponseModel instance,
) => <String, dynamic>{
  'pointsBalance': instance.pointsBalance,
  'pointsExpiry': instance.pointsExpiry?.toIso8601String(),
};

_PointTransactionModel _$PointTransactionModelFromJson(
  Map<String, dynamic> json,
) => _PointTransactionModel(
  id: (json['id'] as num).toInt(),
  pointsDelta: (json['pointsDelta'] as num).toInt(),
  type: json['type'] as String,
  description: json['description'] as String,
  transactionDate: DateTime.parse(json['transactionDate'] as String),
  expiryDate: json['expiryDate'] == null
      ? null
      : DateTime.parse(json['expiryDate'] as String),
  relatedCouponId: (json['relatedCouponId'] as num?)?.toInt(),
  relatedSubscriptionId: (json['relatedSubscriptionId'] as num?)?.toInt(),
  referenceId: json['referenceId'] as String?,
);

Map<String, dynamic> _$PointTransactionModelToJson(
  _PointTransactionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'pointsDelta': instance.pointsDelta,
  'type': instance.type,
  'description': instance.description,
  'transactionDate': instance.transactionDate.toIso8601String(),
  'expiryDate': instance.expiryDate?.toIso8601String(),
  'relatedCouponId': instance.relatedCouponId,
  'relatedSubscriptionId': instance.relatedSubscriptionId,
  'referenceId': instance.referenceId,
};

_AllocatePointsRequestModel _$AllocatePointsRequestModelFromJson(
  Map<String, dynamic> json,
) => _AllocatePointsRequestModel(
  employeeId: (json['employeeId'] as num).toInt(),
  points: (json['points'] as num).toInt(),
  description: json['description'] as String?,
  customExpiryDate: json['customExpiryDate'] == null
      ? null
      : DateTime.parse(json['customExpiryDate'] as String),
);

Map<String, dynamic> _$AllocatePointsRequestModelToJson(
  _AllocatePointsRequestModel instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'points': instance.points,
  'description': instance.description,
  'customExpiryDate': instance.customExpiryDate?.toIso8601String(),
};

_EmployeePointsResponseModel _$EmployeePointsResponseModelFromJson(
  Map<String, dynamic> json,
) => _EmployeePointsResponseModel(
  employeeId: (json['employeeId'] as num).toInt(),
  currentBalance: (json['currentBalance'] as num).toInt(),
  totalAllocated: (json['totalAllocated'] as num).toInt(),
  totalSpent: (json['totalSpent'] as num).toInt(),
  nextExpiry: json['nextExpiry'] == null
      ? null
      : DateTime.parse(json['nextExpiry'] as String),
  recentTransactions:
      (json['recentTransactions'] as List<dynamic>?)
          ?.map(
            (e) => PointTransactionModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$EmployeePointsResponseModelToJson(
  _EmployeePointsResponseModel instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'currentBalance': instance.currentBalance,
  'totalAllocated': instance.totalAllocated,
  'totalSpent': instance.totalSpent,
  'nextExpiry': instance.nextExpiry?.toIso8601String(),
  'recentTransactions': instance.recentTransactions,
};

_PointsExpirationInfoModel _$PointsExpirationInfoModelFromJson(
  Map<String, dynamic> json,
) => _PointsExpirationInfoModel(
  days: (json['days'] as num).toInt(),
  expiringPoints: (json['expiringPoints'] as num).toInt(),
);

Map<String, dynamic> _$PointsExpirationInfoModelToJson(
  _PointsExpirationInfoModel instance,
) => <String, dynamic>{
  'days': instance.days,
  'expiringPoints': instance.expiringPoints,
};

_ExpiredPointsCountModel _$ExpiredPointsCountModelFromJson(
  Map<String, dynamic> json,
) => _ExpiredPointsCountModel(
  expiredPointsCount: (json['expiredPointsCount'] as num).toInt(),
);

Map<String, dynamic> _$ExpiredPointsCountModelToJson(
  _ExpiredPointsCountModel instance,
) => <String, dynamic>{'expiredPointsCount': instance.expiredPointsCount};
