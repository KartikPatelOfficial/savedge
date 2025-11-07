// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'free_trial_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FreeTrialStatusResponse _$FreeTrialStatusResponseFromJson(
  Map<String, dynamic> json,
) => _FreeTrialStatusResponse(
  status: $enumDecode(_$FreeTrialStatusEnumMap, json['status']),
  canActivate: json['canActivate'] as bool,
  activatedAt: json['activatedAt'] == null
      ? null
      : DateTime.parse(json['activatedAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  offerExpiresAt: DateTime.parse(json['offerExpiresAt'] as String),
  remainingTime: json['remainingTime'] == null
      ? null
      : RemainingTimeResponse.fromJson(
          json['remainingTime'] as Map<String, dynamic>,
        ),
  hasActiveSubscription: json['hasActiveSubscription'] as bool,
);

Map<String, dynamic> _$FreeTrialStatusResponseToJson(
  _FreeTrialStatusResponse instance,
) => <String, dynamic>{
  'status': _$FreeTrialStatusEnumMap[instance.status]!,
  'canActivate': instance.canActivate,
  'activatedAt': instance.activatedAt?.toIso8601String(),
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'offerExpiresAt': instance.offerExpiresAt.toIso8601String(),
  'remainingTime': instance.remainingTime,
  'hasActiveSubscription': instance.hasActiveSubscription,
};

const _$FreeTrialStatusEnumMap = {
  FreeTrialStatus.notStarted: 0,
  FreeTrialStatus.active: 1,
  FreeTrialStatus.expired: 2,
  FreeTrialStatus.used: 3,
};

_RemainingTimeResponse _$RemainingTimeResponseFromJson(
  Map<String, dynamic> json,
) => _RemainingTimeResponse(
  days: (json['days'] as num).toInt(),
  hours: (json['hours'] as num).toInt(),
  minutes: (json['minutes'] as num).toInt(),
  seconds: (json['seconds'] as num).toInt(),
  totalSeconds: (json['totalSeconds'] as num).toInt(),
);

Map<String, dynamic> _$RemainingTimeResponseToJson(
  _RemainingTimeResponse instance,
) => <String, dynamic>{
  'days': instance.days,
  'hours': instance.hours,
  'minutes': instance.minutes,
  'seconds': instance.seconds,
  'totalSeconds': instance.totalSeconds,
};

_ActivateFreeTrialResponse _$ActivateFreeTrialResponseFromJson(
  Map<String, dynamic> json,
) => _ActivateFreeTrialResponse(
  success: json['success'] as bool,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  message: json['message'] as String,
);

Map<String, dynamic> _$ActivateFreeTrialResponseToJson(
  _ActivateFreeTrialResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'expiresAt': instance.expiresAt.toIso8601String(),
  'message': instance.message,
};
