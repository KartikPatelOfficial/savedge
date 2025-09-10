// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileResponse3 _$UserProfileResponse3FromJson(
  Map<String, dynamic> json,
) => _UserProfileResponse3(
  id: json['id'] as String,
  email: json['email'] as String,
  phoneNumber: json['phoneNumber'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  fullName: json['fullName'] as String,
  profileImageUrl: json['profileImageUrl'] as String?,
  isActive: json['isActive'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastLoginAt: json['lastLoginAt'] == null
      ? null
      : DateTime.parse(json['lastLoginAt'] as String),
  roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
  employeeInfo: json['employeeInfo'] == null
      ? null
      : EmployeeInfo.fromJson(json['employeeInfo'] as Map<String, dynamic>),
  vendorInfo: json['vendorInfo'] == null
      ? null
      : VendorInfo.fromJson(json['vendorInfo'] as Map<String, dynamic>),
  organizationInfo: json['organizationInfo'] == null
      ? null
      : OrganizationInfo.fromJson(
          json['organizationInfo'] as Map<String, dynamic>,
        ),
  subscriptionInfo: json['subscriptionInfo'] == null
      ? null
      : SubscriptionInfo.fromJson(
          json['subscriptionInfo'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$UserProfileResponse3ToJson(
  _UserProfileResponse3 instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'fullName': instance.fullName,
  'profileImageUrl': instance.profileImageUrl,
  'isActive': instance.isActive,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
  'roles': instance.roles,
  'employeeInfo': instance.employeeInfo,
  'vendorInfo': instance.vendorInfo,
  'organizationInfo': instance.organizationInfo,
  'subscriptionInfo': instance.subscriptionInfo,
};

_EmployeeInfo _$EmployeeInfoFromJson(Map<String, dynamic> json) =>
    _EmployeeInfo(
      organizationId: (json['organizationId'] as num).toInt(),
      organizationName: json['organizationName'] as String,
      department: json['department'] as String,
      position: json['position'] as String,
      employeeCode: json['employeeCode'] as String,
      availablePoints: (json['availablePoints'] as num).toInt(),
    );

Map<String, dynamic> _$EmployeeInfoToJson(_EmployeeInfo instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'organizationName': instance.organizationName,
      'department': instance.department,
      'position': instance.position,
      'employeeCode': instance.employeeCode,
      'availablePoints': instance.availablePoints,
    };

_VendorInfo _$VendorInfoFromJson(Map<String, dynamic> json) => _VendorInfo(
  businessName: json['businessName'] as String,
  category: json['category'] as String,
  approvalStatus: json['approvalStatus'] as String,
  isActive: json['isActive'] as bool,
);

Map<String, dynamic> _$VendorInfoToJson(_VendorInfo instance) =>
    <String, dynamic>{
      'businessName': instance.businessName,
      'category': instance.category,
      'approvalStatus': instance.approvalStatus,
      'isActive': instance.isActive,
    };

_OrganizationInfo _$OrganizationInfoFromJson(Map<String, dynamic> json) =>
    _OrganizationInfo(
      organizationId: (json['organizationId'] as num).toInt(),
      organizationName: json['organizationName'] as String,
      position: json['position'] as String,
    );

Map<String, dynamic> _$OrganizationInfoToJson(_OrganizationInfo instance) =>
    <String, dynamic>{
      'organizationId': instance.organizationId,
      'organizationName': instance.organizationName,
      'position': instance.position,
    };

_SubscriptionInfo _$SubscriptionInfoFromJson(Map<String, dynamic> json) =>
    _SubscriptionInfo(
      planId: (json['planId'] as num).toInt(),
      planName: json['planName'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool,
      autoRenew: json['autoRenew'] as bool,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$SubscriptionInfoToJson(_SubscriptionInfo instance) =>
    <String, dynamic>{
      'planId': instance.planId,
      'planName': instance.planName,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'isActive': instance.isActive,
      'autoRenew': instance.autoRenew,
      'price': instance.price,
    };

_UpdateUserProfileRequest3 _$UpdateUserProfileRequest3FromJson(
  Map<String, dynamic> json,
) => _UpdateUserProfileRequest3(
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  profileImageUrl: json['profileImageUrl'] as String?,
);

Map<String, dynamic> _$UpdateUserProfileRequest3ToJson(
  _UpdateUserProfileRequest3 instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'profileImageUrl': instance.profileImageUrl,
};
