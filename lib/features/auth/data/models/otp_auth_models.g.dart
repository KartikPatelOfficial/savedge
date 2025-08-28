// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SendOtpRequest _$SendOtpRequestFromJson(Map<String, dynamic> json) =>
    _SendOtpRequest(phoneNumber: json['phoneNumber'] as String);

Map<String, dynamic> _$SendOtpRequestToJson(_SendOtpRequest instance) =>
    <String, dynamic>{'phoneNumber': instance.phoneNumber};

_VerifyOtpRequest _$VerifyOtpRequestFromJson(Map<String, dynamic> json) =>
    _VerifyOtpRequest(
      phoneNumber: json['phoneNumber'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$VerifyOtpRequestToJson(_VerifyOtpRequest instance) =>
    <String, dynamic>{'phoneNumber': instance.phoneNumber, 'otp': instance.otp};

_RegisterIndividualRequest _$RegisterIndividualRequestFromJson(
  Map<String, dynamic> json,
) => _RegisterIndividualRequest(
  phoneNumber: json['phoneNumber'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  dateOfBirth: json['dateOfBirth'] == null
      ? null
      : DateTime.parse(json['dateOfBirth'] as String),
);

Map<String, dynamic> _$RegisterIndividualRequestToJson(
  _RegisterIndividualRequest instance,
) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
};

_OtpResponse _$OtpResponseFromJson(Map<String, dynamic> json) => _OtpResponse(
  succeeded: json['succeeded'] as bool,
  errors:
      (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$OtpResponseToJson(_OtpResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
    };

_UserVerificationResponse _$UserVerificationResponseFromJson(
  Map<String, dynamic> json,
) => _UserVerificationResponse(
  succeeded: json['succeeded'] as bool,
  value: json['value'] == null
      ? null
      : UserVerificationResult.fromJson(json['value'] as Map<String, dynamic>),
  errors:
      (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$UserVerificationResponseToJson(
  _UserVerificationResponse instance,
) => <String, dynamic>{
  'succeeded': instance.succeeded,
  'value': instance.value,
  'errors': instance.errors,
};

_UserVerificationResult _$UserVerificationResultFromJson(
  Map<String, dynamic> json,
) => _UserVerificationResult(
  status: $enumDecode(_$UserStatusEnumMap, json['status']),
  user: json['user'] == null
      ? null
      : UserInfoModel.fromJson(json['user'] as Map<String, dynamic>),
  employee: json['employee'] == null
      ? null
      : EmployeeInfoModel.fromJson(json['employee'] as Map<String, dynamic>),
  accessToken: json['accessToken'] as String?,
  refreshToken: json['refreshToken'] as String?,
  tokenExpiresAt: json['tokenExpiresAt'] == null
      ? null
      : DateTime.parse(json['tokenExpiresAt'] as String),
);

Map<String, dynamic> _$UserVerificationResultToJson(
  _UserVerificationResult instance,
) => <String, dynamic>{
  'status': _$UserStatusEnumMap[instance.status]!,
  'user': instance.user,
  'employee': instance.employee,
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'tokenExpiresAt': instance.tokenExpiresAt?.toIso8601String(),
};

const _$UserStatusEnumMap = {
  UserStatus.newUser: 0,
  UserStatus.existingIndividualUser: 1,
  UserStatus.existingEmployee: 2,
};

_UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    _UserInfoModel(
      id: (json['id'] as num).toInt(),
      userId: json['userId'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      role: json['role'] as String,
      isEmailConfirmed: json['isEmailConfirmed'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserInfoModelToJson(_UserInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'role': instance.role,
      'isEmailConfirmed': instance.isEmailConfirmed,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_EmployeeInfoModel _$EmployeeInfoModelFromJson(Map<String, dynamic> json) =>
    _EmployeeInfoModel(
      id: (json['id'] as num).toInt(),
      userId: json['userId'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      employeeId: json['employeeId'] as String,
      department: json['department'] as String,
      position: json['position'] as String,
      organization: OrganizationInfoModel.fromJson(
        json['organization'] as Map<String, dynamic>,
      ),
      availablePoints: (json['availablePoints'] as num).toDouble(),
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$EmployeeInfoModelToJson(_EmployeeInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'employeeId': instance.employeeId,
      'department': instance.department,
      'position': instance.position,
      'organization': instance.organization,
      'availablePoints': instance.availablePoints,
      'isActive': instance.isActive,
    };

_OrganizationInfoModel _$OrganizationInfoModelFromJson(
  Map<String, dynamic> json,
) => _OrganizationInfoModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  logoUrl: json['logoUrl'] as String?,
);

Map<String, dynamic> _$OrganizationInfoModelToJson(
  _OrganizationInfoModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'logoUrl': instance.logoUrl,
};

_IndividualRegistrationResponse _$IndividualRegistrationResponseFromJson(
  Map<String, dynamic> json,
) => _IndividualRegistrationResponse(
  succeeded: json['succeeded'] as bool,
  value: json['value'] == null
      ? null
      : IndividualRegistrationResult.fromJson(
          json['value'] as Map<String, dynamic>,
        ),
  errors:
      (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$IndividualRegistrationResponseToJson(
  _IndividualRegistrationResponse instance,
) => <String, dynamic>{
  'succeeded': instance.succeeded,
  'value': instance.value,
  'errors': instance.errors,
};

_IndividualRegistrationResult _$IndividualRegistrationResultFromJson(
  Map<String, dynamic> json,
) => _IndividualRegistrationResult(
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  user: UserInfoModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$IndividualRegistrationResultToJson(
  _IndividualRegistrationResult instance,
) => <String, dynamic>{
  'accessToken': instance.accessToken,
  'refreshToken': instance.refreshToken,
  'expiresAt': instance.expiresAt.toIso8601String(),
  'user': instance.user,
};
