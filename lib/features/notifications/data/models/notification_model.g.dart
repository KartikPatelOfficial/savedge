// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    _NotificationModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      body: json['body'] as String,
      type: (json['type'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
      data: json['data'] as String?,
      sentAt: DateTime.parse(json['sentAt'] as String),
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
    );

Map<String, dynamic> _$NotificationModelToJson(_NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'type': instance.type,
      'imageUrl': instance.imageUrl,
      'data': instance.data,
      'sentAt': instance.sentAt.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
    };

_RegisterDeviceTokenRequest _$RegisterDeviceTokenRequestFromJson(
  Map<String, dynamic> json,
) => _RegisterDeviceTokenRequest(
  token: json['token'] as String,
  platform: (json['platform'] as num).toInt(),
  deviceId: json['deviceId'] as String?,
  deviceName: json['deviceName'] as String?,
  appVersion: json['appVersion'] as String?,
);

Map<String, dynamic> _$RegisterDeviceTokenRequestToJson(
  _RegisterDeviceTokenRequest instance,
) => <String, dynamic>{
  'token': instance.token,
  'platform': instance.platform,
  'deviceId': instance.deviceId,
  'deviceName': instance.deviceName,
  'appVersion': instance.appVersion,
};

_LogActivityRequest _$LogActivityRequestFromJson(Map<String, dynamic> json) =>
    _LogActivityRequest(
      activityType: (json['activityType'] as num).toInt(),
      entityType: json['entityType'] as String?,
      entityId: (json['entityId'] as num?)?.toInt(),
      details: json['details'] as String?,
    );

Map<String, dynamic> _$LogActivityRequestToJson(_LogActivityRequest instance) =>
    <String, dynamic>{
      'activityType': instance.activityType,
      'entityType': instance.entityType,
      'entityId': instance.entityId,
      'details': instance.details,
    };

_NotificationListResponse _$NotificationListResponseFromJson(
  Map<String, dynamic> json,
) => _NotificationListResponse(
  items: (json['items'] as List<dynamic>)
      .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  hasPreviousPage: json['hasPreviousPage'] as bool,
  hasNextPage: json['hasNextPage'] as bool,
);

Map<String, dynamic> _$NotificationListResponseToJson(
  _NotificationListResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'pageNumber': instance.pageNumber,
  'totalPages': instance.totalPages,
  'totalCount': instance.totalCount,
  'hasPreviousPage': instance.hasPreviousPage,
  'hasNextPage': instance.hasNextPage,
};

_UnreadCountResponse _$UnreadCountResponseFromJson(Map<String, dynamic> json) =>
    _UnreadCountResponse(count: (json['count'] as num).toInt());

Map<String, dynamic> _$UnreadCountResponseToJson(
  _UnreadCountResponse instance,
) => <String, dynamic>{'count': instance.count};
