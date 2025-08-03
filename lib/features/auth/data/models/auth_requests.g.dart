// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_requests.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserRegistrationRequest _$UserRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => _UserRegistrationRequest(
  email: json['email'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
);

Map<String, dynamic> _$UserRegistrationRequestToJson(
  _UserRegistrationRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};

_SyncUserRequest _$SyncUserRequestFromJson(Map<String, dynamic> json) =>
    _SyncUserRequest(
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
    );

Map<String, dynamic> _$SyncUserRequestToJson(_SyncUserRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'displayName': instance.displayName,
    };

_ValidateTokenRequest _$ValidateTokenRequestFromJson(
  Map<String, dynamic> json,
) => _ValidateTokenRequest(idToken: json['idToken'] as String);

Map<String, dynamic> _$ValidateTokenRequestToJson(
  _ValidateTokenRequest instance,
) => <String, dynamic>{'idToken': instance.idToken};

_UpdateUserProfileRequest _$UpdateUserProfileRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateUserProfileRequest(
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
);

Map<String, dynamic> _$UpdateUserProfileRequestToJson(
  _UpdateUserProfileRequest instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};

_ChangeOrganizationRequest _$ChangeOrganizationRequestFromJson(
  Map<String, dynamic> json,
) => _ChangeOrganizationRequest(
  organizationId: (json['organizationId'] as num).toInt(),
);

Map<String, dynamic> _$ChangeOrganizationRequestToJson(
  _ChangeOrganizationRequest instance,
) => <String, dynamic>{'organizationId': instance.organizationId};
