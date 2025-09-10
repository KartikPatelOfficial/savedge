import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_models.freezed.dart';
part 'user_profile_models.g.dart';

/// Main user profile response that matches backend /api/users/me endpoint
@freezed
abstract class UserProfileResponse3 with _$UserProfileResponse3 {
  const factory UserProfileResponse3({
    required String id,
    required String email,
    required String phoneNumber,
    required String firstName,
    required String lastName,
    required String fullName,
    String? profileImageUrl,
    required bool isActive,
    required DateTime createdAt,
    DateTime? lastLoginAt,
    required List<String> roles,
    EmployeeInfo? employeeInfo,
    VendorInfo? vendorInfo,
    OrganizationInfo? organizationInfo,
    SubscriptionInfo? subscriptionInfo,
  }) = _UserProfileResponse3;

  factory UserProfileResponse3.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponse3FromJson(json);
}

/// Employee information embedded in user profile
@freezed
abstract class EmployeeInfo with _$EmployeeInfo {
  const factory EmployeeInfo({
    required int organizationId,
    required String organizationName,
    required String department,
    required String position,
    required String employeeCode,
    required int availablePoints,
  }) = _EmployeeInfo;

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) =>
      _$EmployeeInfoFromJson(json);
}

/// Vendor information embedded in user profile
@freezed
abstract class VendorInfo with _$VendorInfo {
  const factory VendorInfo({
    required String businessName,
    required String category,
    required String approvalStatus,
    required bool isActive,
  }) = _VendorInfo;

  factory VendorInfo.fromJson(Map<String, dynamic> json) =>
      _$VendorInfoFromJson(json);
}

/// Organization information embedded in user profile
@freezed
abstract class OrganizationInfo with _$OrganizationInfo {
  const factory OrganizationInfo({
    required int organizationId,
    required String organizationName,
    required String position,
  }) = _OrganizationInfo;

  factory OrganizationInfo.fromJson(Map<String, dynamic> json) =>
      _$OrganizationInfoFromJson(json);
}

/// Subscription information embedded in user profile
@freezed
abstract class SubscriptionInfo with _$SubscriptionInfo {
  const factory SubscriptionInfo({
    required int planId,
    required String planName,
    required DateTime startDate,
    required DateTime endDate,
    required bool isActive,
    required bool autoRenew,
    required double price,
  }) = _SubscriptionInfo;

  factory SubscriptionInfo.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionInfoFromJson(json);
}

/// Extension methods for user profile
extension UserProfileResponse3Extensions on UserProfileResponse3 {
  /// Check if user has completed their basic profile
  bool get hasCompletedProfile => firstName.isNotEmpty && lastName.isNotEmpty;

  /// Check if user is an employee
  bool get isEmployee => roles.contains('Employee');

  /// Check if user is an individual
  bool get isIndividual => roles.contains('Individual');

  /// Check if user is a vendor
  bool get isVendor => roles.contains('VendorOwner');

  /// Check if user is an organization owner
  bool get isOrganizationOwner => roles.contains('OrganizationOwner');

  /// Check if user is an admin
  bool get isAdmin => roles.contains('Administrator');

  /// Check if user is an employee with organization
  bool get isEmployeeWithOrganization => isEmployee && employeeInfo != null;

  /// Get points balance (from employee info or 0 for others)
  int get pointsBalance => employeeInfo?.availablePoints ?? 0;

  /// Get display name
  String get displayName {
    if (fullName.isNotEmpty) return fullName;
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return '$firstName $lastName';
    }
    if (firstName.isNotEmpty) return firstName;
    if (lastName.isNotEmpty) return lastName;
    return email.split('@').first;
  }

  /// Get primary role for display
  String get primaryRole {
    if (isEmployee) return 'Employee';
    if (isVendor) return 'Vendor';
    if (isOrganizationOwner) return 'Organization Owner';
    if (isAdmin) return 'Administrator';
    return 'Individual';
  }

  /// Get organization display name
  String? get organizationName {
    if (employeeInfo != null) return employeeInfo!.organizationName;
    if (organizationInfo != null) return organizationInfo!.organizationName;
    return null;
  }

  /// Check if user needs profile completion
  bool get needsProfileCompletion =>
      !hasCompletedProfile || (isEmployee && employeeInfo == null);

  /// Check if user has an active subscription
  bool get hasActiveSubscription => subscriptionInfo?.isActive == true;
}

/// Update user profile request
@freezed
abstract class UpdateUserProfileRequest3 with _$UpdateUserProfileRequest3 {
  const factory UpdateUserProfileRequest3({
    String? firstName,
    String? lastName,
    String? email,
    String? profileImageUrl,
  }) = _UpdateUserProfileRequest3;

  factory UpdateUserProfileRequest3.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserProfileRequest3FromJson(json);
}
