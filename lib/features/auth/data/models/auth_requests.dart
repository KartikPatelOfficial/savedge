import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_requests.freezed.dart';
part 'auth_requests.g.dart';

/// Request model for user registration
@freezed
abstract class UserRegistrationRequest with _$UserRegistrationRequest {
  const factory UserRegistrationRequest({
    required String email,
    String? firstName,
    String? lastName,
  }) = _UserRegistrationRequest;

  factory UserRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRegistrationRequestFromJson(json);
}

/// Request model for syncing user profile
@freezed
abstract class SyncUserRequest with _$SyncUserRequest {
  const factory SyncUserRequest({
    required String email,
    String? displayName,
  }) = _SyncUserRequest;

  factory SyncUserRequest.fromJson(Map<String, dynamic> json) =>
      _$SyncUserRequestFromJson(json);
}

/// Request model for validating token
@freezed
abstract class ValidateTokenRequest with _$ValidateTokenRequest {
  const factory ValidateTokenRequest({
    required String idToken,
  }) = _ValidateTokenRequest;

  factory ValidateTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidateTokenRequestFromJson(json);
}

/// Request model for updating user profile
@freezed
abstract class UpdateUserProfileRequest with _$UpdateUserProfileRequest {
  const factory UpdateUserProfileRequest({
    String? firstName,
    String? lastName,
  }) = _UpdateUserProfileRequest;

  factory UpdateUserProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserProfileRequestFromJson(json);
}

/// Request model for changing organization
@freezed
abstract class ChangeOrganizationRequest with _$ChangeOrganizationRequest {
  const factory ChangeOrganizationRequest({
    required int organizationId,
  }) = _ChangeOrganizationRequest;

  factory ChangeOrganizationRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangeOrganizationRequestFromJson(json);
}
