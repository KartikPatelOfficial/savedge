// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserRegistrationResponse _$UserRegistrationResponseFromJson(
  Map<String, dynamic> json,
) => _UserRegistrationResponse(
  id: json['id'] as String,
  email: json['email'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  firebaseUid: json['firebaseUid'] as String?,
  role: json['role'] as String?,
  organizationId: (json['organizationId'] as num?)?.toInt(),
  organizationName: json['organizationName'] as String?,
  pointsBalance: (json['pointsBalance'] as num?)?.toInt() ?? 0,
  pointsExpiry: json['pointsExpiry'] == null
      ? null
      : DateTime.parse(json['pointsExpiry'] as String),
  isActive: json['isActive'] as bool? ?? true,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  isNewUser: json['isNewUser'] as bool? ?? false,
  isEmployee: json['isEmployee'] as bool? ?? false,
  employeeCode: json['employeeCode'] as String?,
  department: json['department'] as String?,
  position: json['position'] as String?,
);

Map<String, dynamic> _$UserRegistrationResponseToJson(
  _UserRegistrationResponse instance,
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
  'createdAt': instance.createdAt?.toIso8601String(),
  'isNewUser': instance.isNewUser,
  'isEmployee': instance.isEmployee,
  'employeeCode': instance.employeeCode,
  'department': instance.department,
  'position': instance.position,
};

_UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) =>
    _UserProfileResponse(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      firebaseUid: json['firebaseUid'] as String?,
      organizationId: (json['organizationId'] as num?)?.toInt(),
      pointsBalance: (json['pointsBalance'] as num?)?.toInt() ?? 0,
      pointsExpiry: json['pointsExpiry'] == null
          ? null
          : DateTime.parse(json['pointsExpiry'] as String),
      isActive: json['isActive'] as bool? ?? true,
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
  pointsBalance: (json['pointsBalance'] as num?)?.toInt() ?? 0,
  pointsExpiry: json['pointsExpiry'] == null
      ? null
      : DateTime.parse(json['pointsExpiry'] as String),
  isActive: json['isActive'] as bool? ?? true,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  isEmployee: json['isEmployee'] as bool? ?? false,
  employeeCode: json['employeeCode'] as String?,
  department: json['department'] as String?,
  position: json['position'] as String?,
  joinDate: json['joinDate'] == null
      ? null
      : DateTime.parse(json['joinDate'] as String),
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
  'createdAt': instance.createdAt?.toIso8601String(),
  'isEmployee': instance.isEmployee,
  'employeeCode': instance.employeeCode,
  'department': instance.department,
  'position': instance.position,
  'joinDate': instance.joinDate?.toIso8601String(),
};

_UserExistsResponse _$UserExistsResponseFromJson(Map<String, dynamic> json) =>
    _UserExistsResponse(
      exists: json['exists'] as bool,
      firebaseUid: json['firebaseUid'] as String?,
      userProfile: json['userProfile'] == null
          ? null
          : UserProfileResponse2.fromJson(
              json['userProfile'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$UserExistsResponseToJson(_UserExistsResponse instance) =>
    <String, dynamic>{
      'exists': instance.exists,
      'firebaseUid': instance.firebaseUid,
      'userProfile': instance.userProfile,
    };
