import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_models.freezed.dart';
part 'auth_models.g.dart';

@freezed
abstract class UserProfileResponse with _$UserProfileResponse {
  const factory UserProfileResponse({
    required String id,
    required String email,
    String? firstName,
    String? lastName,
    int? organizationId,
    required int pointsBalance,
    DateTime? pointsExpiry,
    bool? isActive,
    DateTime? createdAt,
  }) = _UserProfileResponse;

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);
}

@freezed
abstract class SyncUserRequest with _$SyncUserRequest {
  const factory SyncUserRequest({required String email, String? displayName}) =
      _SyncUserRequest;

  factory SyncUserRequest.fromJson(Map<String, dynamic> json) =>
      _$SyncUserRequestFromJson(json);
}

@freezed
abstract class ValidateTokenRequest with _$ValidateTokenRequest {
  const factory ValidateTokenRequest({required String idToken}) =
      _ValidateTokenRequest;

  factory ValidateTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidateTokenRequestFromJson(json);
}

// Add extended profile response and update request
@freezed
abstract class UserProfileResponse2 with _$UserProfileResponse2 {
  const factory UserProfileResponse2({
    required String id,
    required String email,
    String? firstName,
    String? lastName,
    int? organizationId,
    String? organizationName,
    required int pointsBalance,
    DateTime? pointsExpiry,
    required bool isActive,
    required DateTime createdAt,
    required List<String> roles,
    required bool isEmployee,
    String? employeeCode,
    String? department,
    String? position,
    DateTime? joinDate,
    Map<String, dynamic>? activeSubscription,
  }) = _UserProfileResponse2;

  factory UserProfileResponse2.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponse2FromJson(json);
}

@freezed
abstract class UpdateUserProfileRequest with _$UpdateUserProfileRequest {
  const factory UpdateUserProfileRequest({
    required String email,
    String? firstName,
    String? lastName,
  }) = _UpdateUserProfileRequest;

  factory UpdateUserProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserProfileRequestFromJson(json);
}

// New models for the phone-based authentication flow

// New unified authentication status models
@freezed
abstract class AuthStatusResponse with _$AuthStatusResponse {
  const factory AuthStatusResponse({
    required AuthStatusEnum status,
    UserProfileResponse2? userProfile,
    EmployeeInfoResponse? employeeInfo,
    required String message,
  }) = _AuthStatusResponse;

  factory AuthStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthStatusResponseFromJson(json);
}

enum AuthStatusEnum {
  @JsonValue('UserExists')
  userExists,
  @JsonValue('EmployeeFound')
  employeeFound,
  @JsonValue('NewUser')
  newUser,
}

@freezed
abstract class CheckUserExistsRequest with _$CheckUserExistsRequest {
  const factory CheckUserExistsRequest({required String firebaseUid}) =
      _CheckUserExistsRequest;

  factory CheckUserExistsRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckUserExistsRequestFromJson(json);
}

@freezed
abstract class CheckUserExistsResponse with _$CheckUserExistsResponse {
  const factory CheckUserExistsResponse({
    required bool exists,
    required String firebaseUid,
    UserProfileResponse2? userProfile,
  }) = _CheckUserExistsResponse;

  factory CheckUserExistsResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckUserExistsResponseFromJson(json);
}

@freezed
abstract class CheckEmployeeByPhoneRequest with _$CheckEmployeeByPhoneRequest {
  const factory CheckEmployeeByPhoneRequest({required String phoneNumber}) =
      _CheckEmployeeByPhoneRequest;

  factory CheckEmployeeByPhoneRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckEmployeeByPhoneRequestFromJson(json);
}

@freezed
abstract class EmployeeInfoResponse with _$EmployeeInfoResponse {
  const factory EmployeeInfoResponse({
    required int id,
    required String email,
    required String employeeCode,
    required String department,
    required String position,
    required String phoneNumber,
    required DateTime joinDate,
    required bool isRegistered,
    required int organizationId,
    required String organizationName,
    required bool isActive,
  }) = _EmployeeInfoResponse;

  factory EmployeeInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$EmployeeInfoResponseFromJson(json);
}

// New unified registration models
@freezed
abstract class IndividualRegistrationRequest
    with _$IndividualRegistrationRequest {
  const factory IndividualRegistrationRequest({
    required String email,
    required String firstName,
    required String lastName,
  }) = _IndividualRegistrationRequest;

  factory IndividualRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$IndividualRegistrationRequestFromJson(json);
}

@freezed
abstract class EmployeeRegistrationRequest with _$EmployeeRegistrationRequest {
  const factory EmployeeRegistrationRequest({
    required String email,
    required String firstName,
    required String lastName,
  }) = _EmployeeRegistrationRequest;

  factory EmployeeRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRegistrationRequestFromJson(json);
}

@freezed
abstract class RegisterEmployeeByPhoneRequest
    with _$RegisterEmployeeByPhoneRequest {
  const factory RegisterEmployeeByPhoneRequest({
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
  }) = _RegisterEmployeeByPhoneRequest;

  factory RegisterEmployeeByPhoneRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterEmployeeByPhoneRequestFromJson(json);
}

@freezed
abstract class RegisterUserByPhoneRequest with _$RegisterUserByPhoneRequest {
  const factory RegisterUserByPhoneRequest({
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
  }) = _RegisterUserByPhoneRequest;

  factory RegisterUserByPhoneRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserByPhoneRequestFromJson(json);
}

@freezed
abstract class PhoneRegistrationResponse with _$PhoneRegistrationResponse {
  const factory PhoneRegistrationResponse({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required String role,
    int? organizationId,
    String? organizationName,
    required int pointsBalance,
    DateTime? pointsExpiry,
    required bool isActive,
    required DateTime createdAt,
    required bool isNewUser,
    required bool isEmployee,
    String? employeeCode,
    String? department,
    String? position,
  }) = _PhoneRegistrationResponse;

  factory PhoneRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$PhoneRegistrationResponseFromJson(json);
}
