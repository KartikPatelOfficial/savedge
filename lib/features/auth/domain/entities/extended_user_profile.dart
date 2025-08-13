/// Extended user profile entity with complete profile information
class ExtendedUserProfile {
  const ExtendedUserProfile({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.firebaseUid,
    this.organizationId,
    this.organizationName,
    required this.pointsBalance,
    this.pointsExpiry,
    required this.isActive,
    required this.createdAt,
    required this.roles,
    required this.isEmployee,
    this.employeeCode,
    this.department,
    this.position,
    this.joinDate,
  });

  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? firebaseUid;
  final int? organizationId;
  final String? organizationName;
  final int pointsBalance;
  final DateTime? pointsExpiry;
  final bool isActive;
  final DateTime createdAt;
  final List<String> roles;
  final bool isEmployee;
  final String? employeeCode;
  final String? department;
  final String? position;
  final DateTime? joinDate;

  /// Check if user has completed their basic profile
  bool get hasCompletedProfile =>
      firstName?.isNotEmpty == true && lastName?.isNotEmpty == true;

  /// Check if user is an employee with organization
  bool get isEmployeeWithOrganization => isEmployee && organizationId != null;

  /// Check if user needs employee profile completion
  bool get needsEmployeeCompletion =>
      isEmployee && organizationId != null && !hasCompletedProfile;
}
