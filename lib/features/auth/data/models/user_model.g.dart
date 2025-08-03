// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  firebaseUid: json['firebaseUid'] as String,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
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

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firebaseUid': instance.firebaseUid,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
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
