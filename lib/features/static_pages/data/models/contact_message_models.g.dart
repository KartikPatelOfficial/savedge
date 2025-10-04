// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_message_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubmitContactMessageRequest _$SubmitContactMessageRequestFromJson(
  Map<String, dynamic> json,
) => _SubmitContactMessageRequest(
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  subject: json['subject'] as String?,
  message: json['message'] as String,
  source: json['source'] as String?,
);

Map<String, dynamic> _$SubmitContactMessageRequestToJson(
  _SubmitContactMessageRequest instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'email': instance.email,
  'subject': instance.subject,
  'message': instance.message,
  'source': instance.source,
};

_ContactMessageResponse _$ContactMessageResponseFromJson(
  Map<String, dynamic> json,
) => _ContactMessageResponse(id: (json['id'] as num).toInt());

Map<String, dynamic> _$ContactMessageResponseToJson(
  _ContactMessageResponse instance,
) => <String, dynamic>{'id': instance.id};
