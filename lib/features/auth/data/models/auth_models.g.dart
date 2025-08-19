// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) =>
    _UserProfileResponse(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      firebaseUid: json['firebaseUid'] as String?,
      organizationId: (json['organizationId'] as num?)?.toInt(),
      pointsBalance: (json['pointsBalance'] as num).toInt(),
      pointsExpiry: json['pointsExpiry'] == null
          ? null
          : DateTime.parse(json['pointsExpiry'] as String),
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserProfileResponseToJson(
  _UserProfileResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'firebaseUid': instance.firebaseUid,
  'organizationId': instance.organizationId,
  'pointsBalance': instance.pointsBalance,
  'pointsExpiry': instance.pointsExpiry?.toIso8601String(),
  'isActive': instance.isActive,
  'createdAt': instance.createdAt?.toIso8601String(),
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

_UserProfileResponse2 _$UserProfileResponse2FromJson(
  Map<String, dynamic> json,
) => _UserProfileResponse2(
  id: json['id'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  firebaseUid: json['firebaseUid'] as String?,
  organizationId: (json['organizationId'] as num?)?.toInt(),
  organizationName: json['organizationName'] as String?,
  pointsBalance: (json['pointsBalance'] as num).toInt(),
  pointsExpiry: json['pointsExpiry'] == null
      ? null
      : DateTime.parse(json['pointsExpiry'] as String),
  isActive: json['isActive'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
  isEmployee: json['isEmployee'] as bool,
  employeeCode: json['employeeCode'] as String?,
  department: json['department'] as String?,
  position: json['position'] as String?,
  joinDate: json['joinDate'] == null
      ? null
      : DateTime.parse(json['joinDate'] as String),
  activeSubscription: json['activeSubscription'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$UserProfileResponse2ToJson(
  _UserProfileResponse2 instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'firebaseUid': instance.firebaseUid,
  'organizationId': instance.organizationId,
  'organizationName': instance.organizationName,
  'pointsBalance': instance.pointsBalance,
  'pointsExpiry': instance.pointsExpiry?.toIso8601String(),
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'roles': instance.roles,
  'isEmployee': instance.isEmployee,
  'employeeCode': instance.employeeCode,
  'department': instance.department,
  'position': instance.position,
  'joinDate': instance.joinDate?.toIso8601String(),
  'activeSubscription': instance.activeSubscription,
};

_UpdateUserProfileRequest _$UpdateUserProfileRequestFromJson(
  Map<String, dynamic> json,
) => _UpdateUserProfileRequest(
  email: json['email'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
);

Map<String, dynamic> _$UpdateUserProfileRequestToJson(
  _UpdateUserProfileRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};

_AuthStatusResponse _$AuthStatusResponseFromJson(Map<String, dynamic> json) =>
    _AuthStatusResponse(
      status: $enumDecode(_$AuthStatusEnumEnumMap, json['status']),
      userProfile: json['userProfile'] == null
          ? null
          : UserProfileResponse2.fromJson(
              json['userProfile'] as Map<String, dynamic>,
            ),
      employeeInfo: json['employeeInfo'] == null
          ? null
          : EmployeeInfoResponse.fromJson(
              json['employeeInfo'] as Map<String, dynamic>,
            ),
      message: json['message'] as String,
    );

Map<String, dynamic> _$AuthStatusResponseToJson(_AuthStatusResponse instance) =>
    <String, dynamic>{
      'status': _$AuthStatusEnumEnumMap[instance.status]!,
      'userProfile': instance.userProfile,
      'employeeInfo': instance.employeeInfo,
      'message': instance.message,
    };

const _$AuthStatusEnumEnumMap = {
  AuthStatusEnum.userExists: 'UserExists',
  AuthStatusEnum.employeeFound: 'EmployeeFound',
  AuthStatusEnum.newUser: 'NewUser',
};

_CheckUserExistsRequest _$CheckUserExistsRequestFromJson(
  Map<String, dynamic> json,
) => _CheckUserExistsRequest(firebaseUid: json['firebaseUid'] as String);

Map<String, dynamic> _$CheckUserExistsRequestToJson(
  _CheckUserExistsRequest instance,
) => <String, dynamic>{'firebaseUid': instance.firebaseUid};

_CheckUserExistsResponse _$CheckUserExistsResponseFromJson(
  Map<String, dynamic> json,
) => _CheckUserExistsResponse(
  exists: json['exists'] as bool,
  firebaseUid: json['firebaseUid'] as String,
  userProfile: json['userProfile'] == null
      ? null
      : UserProfileResponse2.fromJson(
          json['userProfile'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$CheckUserExistsResponseToJson(
  _CheckUserExistsResponse instance,
) => <String, dynamic>{
  'exists': instance.exists,
  'firebaseUid': instance.firebaseUid,
  'userProfile': instance.userProfile,
};

_CheckEmployeeByPhoneRequest _$CheckEmployeeByPhoneRequestFromJson(
  Map<String, dynamic> json,
) => _CheckEmployeeByPhoneRequest(phoneNumber: json['phoneNumber'] as String);

Map<String, dynamic> _$CheckEmployeeByPhoneRequestToJson(
  _CheckEmployeeByPhoneRequest instance,
) => <String, dynamic>{'phoneNumber': instance.phoneNumber};

_EmployeeInfoResponse _$EmployeeInfoResponseFromJson(
  Map<String, dynamic> json,
) => _EmployeeInfoResponse(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  employeeCode: json['employeeCode'] as String,
  department: json['department'] as String,
  position: json['position'] as String,
  phoneNumber: json['phoneNumber'] as String,
  joinDate: DateTime.parse(json['joinDate'] as String),
  isRegistered: json['isRegistered'] as bool,
  organizationId: (json['organizationId'] as num).toInt(),
  organizationName: json['organizationName'] as String,
  isActive: json['isActive'] as bool,
);

Map<String, dynamic> _$EmployeeInfoResponseToJson(
  _EmployeeInfoResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'employeeCode': instance.employeeCode,
  'department': instance.department,
  'position': instance.position,
  'phoneNumber': instance.phoneNumber,
  'joinDate': instance.joinDate.toIso8601String(),
  'isRegistered': instance.isRegistered,
  'organizationId': instance.organizationId,
  'organizationName': instance.organizationName,
  'isActive': instance.isActive,
};

_IndividualRegistrationRequest _$IndividualRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => _IndividualRegistrationRequest(
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
);

Map<String, dynamic> _$IndividualRegistrationRequestToJson(
  _IndividualRegistrationRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};

_EmployeeRegistrationRequest _$EmployeeRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => _EmployeeRegistrationRequest(
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
);

Map<String, dynamic> _$EmployeeRegistrationRequestToJson(
  _EmployeeRegistrationRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};

_RegisterEmployeeByPhoneRequest _$RegisterEmployeeByPhoneRequestFromJson(
  Map<String, dynamic> json,
) => _RegisterEmployeeByPhoneRequest(
  phoneNumber: json['phoneNumber'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
);

Map<String, dynamic> _$RegisterEmployeeByPhoneRequestToJson(
  _RegisterEmployeeByPhoneRequest instance,
) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};

_RegisterUserByPhoneRequest _$RegisterUserByPhoneRequestFromJson(
  Map<String, dynamic> json,
) => _RegisterUserByPhoneRequest(
  phoneNumber: json['phoneNumber'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
);

Map<String, dynamic> _$RegisterUserByPhoneRequestToJson(
  _RegisterUserByPhoneRequest instance,
) => <String, dynamic>{
  'phoneNumber': instance.phoneNumber,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
};

_PhoneRegistrationResponse _$PhoneRegistrationResponseFromJson(
  Map<String, dynamic> json,
) => _PhoneRegistrationResponse(
  id: json['id'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  firebaseUid: json['firebaseUid'] as String,
  role: json['role'] as String,
  organizationId: (json['organizationId'] as num?)?.toInt(),
  organizationName: json['organizationName'] as String?,
  pointsBalance: (json['pointsBalance'] as num).toInt(),
  pointsExpiry: json['pointsExpiry'] == null
      ? null
      : DateTime.parse(json['pointsExpiry'] as String),
  isActive: json['isActive'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  isNewUser: json['isNewUser'] as bool,
  isEmployee: json['isEmployee'] as bool,
  employeeCode: json['employeeCode'] as String?,
  department: json['department'] as String?,
  position: json['position'] as String?,
);

Map<String, dynamic> _$PhoneRegistrationResponseToJson(
  _PhoneRegistrationResponse instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'firebaseUid': instance.firebaseUid,
  'role': instance.role,
  'organizationId': instance.organizationId,
  'organizationName': instance.organizationName,
  'pointsBalance': instance.pointsBalance,
  'pointsExpiry': instance.pointsExpiry?.toIso8601String(),
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'isNewUser': instance.isNewUser,
  'isEmployee': instance.isEmployee,
  'employeeCode': instance.employeeCode,
  'department': instance.department,
  'position': instance.position,
};
