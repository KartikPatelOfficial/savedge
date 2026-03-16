// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PromotionStatusResponse _$PromotionStatusResponseFromJson(
  Map<String, dynamic> json,
) => _PromotionStatusResponse(
  isPromotionActive: json['isPromotionActive'] as bool,
  isEnrolled: json['isEnrolled'] as bool,
  enrolledAt: json['enrolledAt'] == null
      ? null
      : DateTime.parse(json['enrolledAt'] as String),
  promotionExpiresAt: json['promotionExpiresAt'] == null
      ? null
      : DateTime.parse(json['promotionExpiresAt'] as String),
);

Map<String, dynamic> _$PromotionStatusResponseToJson(
  _PromotionStatusResponse instance,
) => <String, dynamic>{
  'isPromotionActive': instance.isPromotionActive,
  'isEnrolled': instance.isEnrolled,
  'enrolledAt': instance.enrolledAt?.toIso8601String(),
  'promotionExpiresAt': instance.promotionExpiresAt?.toIso8601String(),
};

_EnrollPromotionResponse _$EnrollPromotionResponseFromJson(
  Map<String, dynamic> json,
) => _EnrollPromotionResponse(
  success: json['success'] as bool,
  enrolledAt: DateTime.parse(json['enrolledAt'] as String),
  promotionExpiresAt: DateTime.parse(json['promotionExpiresAt'] as String),
  message: json['message'] as String,
);

Map<String, dynamic> _$EnrollPromotionResponseToJson(
  _EnrollPromotionResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'enrolledAt': instance.enrolledAt.toIso8601String(),
  'promotionExpiresAt': instance.promotionExpiresAt.toIso8601String(),
  'message': instance.message,
};
