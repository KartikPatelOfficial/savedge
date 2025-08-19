// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_redemption_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RedeemMyCouponRequest _$RedeemMyCouponRequestFromJson(
  Map<String, dynamic> json,
) =>
    _RedeemMyCouponRequest(userCouponId: (json['userCouponId'] as num).toInt());

Map<String, dynamic> _$RedeemMyCouponRequestToJson(
  _RedeemMyCouponRequest instance,
) => <String, dynamic>{'userCouponId': instance.userCouponId};

_RedeemCouponResponse _$RedeemCouponResponseFromJson(
  Map<String, dynamic> json,
) => _RedeemCouponResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  redeemedAt: DateTime.parse(json['redeemedAt'] as String),
  couponTitle: json['couponTitle'] as String,
  vendorName: json['vendorName'] as String,
  discountValue: (json['discountValue'] as num).toDouble(),
  discountType: json['discountType'] as String,
  uniqueCode: json['uniqueCode'] as String,
);

Map<String, dynamic> _$RedeemCouponResponseToJson(
  _RedeemCouponResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'redeemedAt': instance.redeemedAt.toIso8601String(),
  'couponTitle': instance.couponTitle,
  'vendorName': instance.vendorName,
  'discountValue': instance.discountValue,
  'discountType': instance.discountType,
  'uniqueCode': instance.uniqueCode,
};

_ClaimCouponRequest _$ClaimCouponRequestFromJson(Map<String, dynamic> json) =>
    _ClaimCouponRequest(couponId: (json['couponId'] as num).toInt());

Map<String, dynamic> _$ClaimCouponRequestToJson(_ClaimCouponRequest instance) =>
    <String, dynamic>{'couponId': instance.couponId};

_ClaimFromSubscriptionRequest _$ClaimFromSubscriptionRequestFromJson(
  Map<String, dynamic> json,
) => _ClaimFromSubscriptionRequest(couponId: (json['couponId'] as num).toInt());

Map<String, dynamic> _$ClaimFromSubscriptionRequestToJson(
  _ClaimFromSubscriptionRequest instance,
) => <String, dynamic>{'couponId': instance.couponId};

_ClaimCouponResponse _$ClaimCouponResponseFromJson(Map<String, dynamic> json) =>
    _ClaimCouponResponse(
      userCouponId: (json['userCouponId'] as num).toInt(),
      uniqueCode: json['uniqueCode'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ClaimCouponResponseToJson(
  _ClaimCouponResponse instance,
) => <String, dynamic>{
  'userCouponId': instance.userCouponId,
  'uniqueCode': instance.uniqueCode,
  'message': instance.message,
};
