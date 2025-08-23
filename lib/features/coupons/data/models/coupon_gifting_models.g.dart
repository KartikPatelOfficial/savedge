// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_gifting_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ColleagueModel _$ColleagueModelFromJson(Map<String, dynamic> json) =>
    _ColleagueModel(
      userId: json['userId'] as String,
      email: json['email'] as String,
      employeeCode: json['employeeCode'] as String,
      department: json['department'] as String,
      position: json['position'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );

Map<String, dynamic> _$ColleagueModelToJson(_ColleagueModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'employeeCode': instance.employeeCode,
      'department': instance.department,
      'position': instance.position,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };

_GiftCouponRequest _$GiftCouponRequestFromJson(Map<String, dynamic> json) =>
    _GiftCouponRequest(
      userCouponId: (json['userCouponId'] as num).toInt(),
      toUserId: json['toUserId'] as String,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GiftCouponRequestToJson(_GiftCouponRequest instance) =>
    <String, dynamic>{
      'userCouponId': instance.userCouponId,
      'toUserId': instance.toUserId,
      'message': instance.message,
    };

_GiftCouponResponse _$GiftCouponResponseFromJson(Map<String, dynamic> json) =>
    _GiftCouponResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      giftedCouponId: (json['giftedCouponId'] as num).toInt(),
      uniqueCode: json['uniqueCode'] as String,
    );

Map<String, dynamic> _$GiftCouponResponseToJson(_GiftCouponResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'giftedCouponId': instance.giftedCouponId,
      'uniqueCode': instance.uniqueCode,
    };

_TransferPointsRequest _$TransferPointsRequestFromJson(
  Map<String, dynamic> json,
) => _TransferPointsRequest(
  toUserId: json['toUserId'] as String,
  points: (json['points'] as num).toInt(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$TransferPointsRequestToJson(
  _TransferPointsRequest instance,
) => <String, dynamic>{
  'toUserId': instance.toUserId,
  'points': instance.points,
  'message': instance.message,
};

_TransferPointsResponse _$TransferPointsResponseFromJson(
  Map<String, dynamic> json,
) => _TransferPointsResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
  transferReference: json['transferReference'] as String,
  transferredPoints: (json['transferredPoints'] as num).toInt(),
);

Map<String, dynamic> _$TransferPointsResponseToJson(
  _TransferPointsResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'transferReference': instance.transferReference,
  'transferredPoints': instance.transferredPoints,
};

_UserCouponDetailModel _$UserCouponDetailModelFromJson(
  Map<String, dynamic> json,
) => _UserCouponDetailModel(
  id: (json['id'] as num).toInt(),
  couponId: (json['couponId'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String?,
  vendorId: (json['vendorId'] as num).toInt(),
  vendorName: json['vendorName'] as String,
  status: json['status'] as String,
  acquiredDate: DateTime.parse(json['acquiredDate'] as String),
  redeemedDate: json['redeemedDate'] == null
      ? null
      : DateTime.parse(json['redeemedDate'] as String),
  expiryDate: DateTime.parse(json['expiryDate'] as String),
  uniqueCode: json['uniqueCode'] as String,
  qrCode: json['qrCode'] as String?,
  discountType: json['discountType'] as String,
  discountValue: (json['discountValue'] as num).toDouble(),
  minCartValue: (json['minCartValue'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String?,
  isGifted: json['isGifted'] as bool,
  giftedFromUserId: json['giftedFromUserId'] as String?,
  giftedToUserId: json['giftedToUserId'] as String?,
  giftedDate: json['giftedDate'] == null
      ? null
      : DateTime.parse(json['giftedDate'] as String),
  giftMessage: json['giftMessage'] as String?,
);

Map<String, dynamic> _$UserCouponDetailModelToJson(
  _UserCouponDetailModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'couponId': instance.couponId,
  'title': instance.title,
  'description': instance.description,
  'vendorId': instance.vendorId,
  'vendorName': instance.vendorName,
  'status': instance.status,
  'acquiredDate': instance.acquiredDate.toIso8601String(),
  'redeemedDate': instance.redeemedDate?.toIso8601String(),
  'expiryDate': instance.expiryDate.toIso8601String(),
  'uniqueCode': instance.uniqueCode,
  'qrCode': instance.qrCode,
  'discountType': instance.discountType,
  'discountValue': instance.discountValue,
  'minCartValue': instance.minCartValue,
  'imageUrl': instance.imageUrl,
  'isGifted': instance.isGifted,
  'giftedFromUserId': instance.giftedFromUserId,
  'giftedToUserId': instance.giftedToUserId,
  'giftedDate': instance.giftedDate?.toIso8601String(),
  'giftMessage': instance.giftMessage,
};

_UserCouponsResponseModel _$UserCouponsResponseModelFromJson(
  Map<String, dynamic> json,
) => _UserCouponsResponseModel(
  purchasedCoupons:
      (json['purchasedCoupons'] as List<dynamic>?)
          ?.map(
            (e) => UserCouponDetailModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  usedCoupons:
      (json['usedCoupons'] as List<dynamic>?)
          ?.map(
            (e) => UserCouponDetailModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  expiredCoupons:
      (json['expiredCoupons'] as List<dynamic>?)
          ?.map(
            (e) => UserCouponDetailModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  giftedReceivedCoupons:
      (json['giftedReceivedCoupons'] as List<dynamic>?)
          ?.map(
            (e) => UserCouponDetailModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  giftedSentCoupons:
      (json['giftedSentCoupons'] as List<dynamic>?)
          ?.map(
            (e) => UserCouponDetailModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  activeCount: (json['activeCount'] as num?)?.toInt() ?? 0,
  usedCount: (json['usedCount'] as num?)?.toInt() ?? 0,
  expiredCount: (json['expiredCount'] as num?)?.toInt() ?? 0,
  giftedCount: (json['giftedCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$UserCouponsResponseModelToJson(
  _UserCouponsResponseModel instance,
) => <String, dynamic>{
  'purchasedCoupons': instance.purchasedCoupons,
  'usedCoupons': instance.usedCoupons,
  'expiredCoupons': instance.expiredCoupons,
  'giftedReceivedCoupons': instance.giftedReceivedCoupons,
  'giftedSentCoupons': instance.giftedSentCoupons,
  'totalCount': instance.totalCount,
  'activeCount': instance.activeCount,
  'usedCount': instance.usedCount,
  'expiredCount': instance.expiredCount,
  'giftedCount': instance.giftedCount,
};

_GiftedCouponHistoryModel _$GiftedCouponHistoryModelFromJson(
  Map<String, dynamic> json,
) => _GiftedCouponHistoryModel(
  id: (json['id'] as num).toInt(),
  couponTitle: json['couponTitle'] as String,
  recipientUserId: json['recipientUserId'] as String,
  giftedDate: DateTime.parse(json['giftedDate'] as String),
  message: json['message'] as String?,
  status: json['status'] as String,
  direction: json['direction'] as String,
);

Map<String, dynamic> _$GiftedCouponHistoryModelToJson(
  _GiftedCouponHistoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'couponTitle': instance.couponTitle,
  'recipientUserId': instance.recipientUserId,
  'giftedDate': instance.giftedDate.toIso8601String(),
  'message': instance.message,
  'status': instance.status,
  'direction': instance.direction,
};

_GiftedCouponsHistoryResponseModel _$GiftedCouponsHistoryResponseModelFromJson(
  Map<String, dynamic> json,
) => _GiftedCouponsHistoryResponseModel(
  sentCoupons: (json['sentCoupons'] as List<dynamic>)
      .map((e) => GiftedCouponHistoryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  receivedCoupons: (json['receivedCoupons'] as List<dynamic>)
      .map((e) => GiftedCouponHistoryModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GiftedCouponsHistoryResponseModelToJson(
  _GiftedCouponsHistoryResponseModel instance,
) => <String, dynamic>{
  'sentCoupons': instance.sentCoupons,
  'receivedCoupons': instance.receivedCoupons,
};

_PointsTransferHistoryModel _$PointsTransferHistoryModelFromJson(
  Map<String, dynamic> json,
) => _PointsTransferHistoryModel(
  id: (json['id'] as num).toInt(),
  fromUserId: json['fromUserId'] as String,
  toUserId: json['toUserId'] as String,
  points: (json['points'] as num).toInt(),
  status: json['status'] as String,
  transferDate: DateTime.parse(json['transferDate'] as String),
  message: json['message'] as String?,
  direction: json['direction'] as String,
);

Map<String, dynamic> _$PointsTransferHistoryModelToJson(
  _PointsTransferHistoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'fromUserId': instance.fromUserId,
  'toUserId': instance.toUserId,
  'points': instance.points,
  'status': instance.status,
  'transferDate': instance.transferDate.toIso8601String(),
  'message': instance.message,
  'direction': instance.direction,
};
