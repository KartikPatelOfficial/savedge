import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:savedge/features/auth/data/models/user_model.dart';

part 'auth_responses.freezed.dart';
part 'auth_responses.g.dart';

/// Response model for user registration
@freezed
abstract class UserRegistrationResponse with _$UserRegistrationResponse {
  const factory UserRegistrationResponse({
    required String id,
    required String email,
    String? firstName,
    String? lastName,
    String? firebaseUid,
    String? role,
    int? organizationId,
    String? organizationName,
    @Default(0) int pointsBalance,
    DateTime? pointsExpiry,
    @Default(true) bool isActive,
    DateTime? createdAt,
    @Default(false) bool isNewUser,
    @Default(false) bool isEmployee,
    String? employeeCode,
    String? department,
    String? position,
  }) = _UserRegistrationResponse;

  const UserRegistrationResponse._();

  factory UserRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationResponseFromJson(json);

  /// Converts response to user model
  UserModel toUserModel() {
    return UserModel(
      id: id,
      email: email,
      firebaseUid: firebaseUid ?? '',
      firstName: firstName,
      lastName: lastName,
      organizationId: organizationId,
      organizationName: organizationName,
      pointsBalance: pointsBalance,
      pointsExpiry: pointsExpiry,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}

/// Response model for user profile
@freezed
abstract class UserProfileResponse with _$UserProfileResponse {
  const factory UserProfileResponse({
    required String id,
    required String email,
    String? firstName,
    String? lastName,
    String? firebaseUid,
    int? organizationId,
    @Default(0) int pointsBalance,
    DateTime? pointsExpiry,
    @Default(true) bool isActive,
    DateTime? createdAt,
  }) = _UserProfileResponse;

  const UserProfileResponse._();

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  /// Converts response to user model
  UserModel toUserModel() {
    return UserModel(
      id: id,
      email: email,
      firebaseUid: firebaseUid ?? '',
      firstName: firstName,
      lastName: lastName,
      organizationId: organizationId,
      pointsBalance: pointsBalance,
      pointsExpiry: pointsExpiry,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}

/// Response model for user profile with organization details
@freezed
abstract class UserProfileResponse2 with _$UserProfileResponse2 {
  const factory UserProfileResponse2({
    required String id,
    required String email,
    String? firstName,
    String? lastName,
    String? firebaseUid,
    int? organizationId,
    String? organizationName,
    @Default(0) int pointsBalance,
    DateTime? pointsExpiry,
    @Default(true) bool isActive,
    DateTime? createdAt,
    @Default(false) bool isEmployee,
    String? employeeCode,
    String? department,
    String? position,
    DateTime? joinDate,
  }) = _UserProfileResponse2;

  const UserProfileResponse2._();

  factory UserProfileResponse2.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponse2FromJson(json);

  /// Converts response to user model
  UserModel toUserModel() {
    return UserModel(
      id: id,
      email: email,
      firebaseUid: firebaseUid ?? '',
      firstName: firstName,
      lastName: lastName,
      organizationId: organizationId,
      organizationName: organizationName,
      pointsBalance: pointsBalance,
      pointsExpiry: pointsExpiry,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}

/// Response model for checking if user exists
@freezed
abstract class UserExistsResponse with _$UserExistsResponse {
  const factory UserExistsResponse({
    required bool exists, 
    String? firebaseUid,
    UserProfileResponse2? userProfile,
  }) = _UserExistsResponse;

  factory UserExistsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserExistsResponseFromJson(json);
}
