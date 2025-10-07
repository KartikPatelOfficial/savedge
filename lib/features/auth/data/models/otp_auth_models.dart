import 'package:freezed_annotation/freezed_annotation.dart';

part 'otp_auth_models.freezed.dart';
part 'otp_auth_models.g.dart';

// Request Models
@freezed
abstract class SendOtpRequest with _$SendOtpRequest {
  const factory SendOtpRequest({required String phoneNumber}) = _SendOtpRequest;

  factory SendOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOtpRequestFromJson(json);
}

@freezed
abstract class VerifyOtpRequest with _$VerifyOtpRequest {
  const factory VerifyOtpRequest({
    required String phoneNumber,
    required String otp,
  }) = _VerifyOtpRequest;

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);
}

@freezed
abstract class RegisterIndividualRequest with _$RegisterIndividualRequest {
  const factory RegisterIndividualRequest({
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
    DateTime? dateOfBirth,
  }) = _RegisterIndividualRequest;

  factory RegisterIndividualRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterIndividualRequestFromJson(json);
}

// Response Models
@freezed
abstract class OtpResponse with _$OtpResponse {
  const factory OtpResponse({
    required bool succeeded,
    @Default([]) List<String> errors,
  }) = _OtpResponse;

  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);
}

@freezed
abstract class UserVerificationResponse with _$UserVerificationResponse {
  const factory UserVerificationResponse({
    required bool succeeded,
    UserVerificationResult? value,
    @Default([]) List<String> errors,
  }) = _UserVerificationResponse;

  factory UserVerificationResponse.fromJson(Map<String, dynamic> json) =>
      _$UserVerificationResponseFromJson(json);
}

@freezed
abstract class UserVerificationResult with _$UserVerificationResult {
  const factory UserVerificationResult({
    required UserStatus status,
    UserInfoModel? user,
    EmployeeInfoModel? employee,
    String? accessToken,
    String? refreshToken,
    DateTime? tokenExpiresAt,
  }) = _UserVerificationResult;

  factory UserVerificationResult.fromJson(Map<String, dynamic> json) =>
      _$UserVerificationResultFromJson(json);
}

enum UserStatus {
  @JsonValue(0)
  newUser,
  @JsonValue(1)
  existingIndividualUser,
  @JsonValue(2)
  existingEmployee,
  @JsonValue(3)
  deletedAccountCanRecreate,
}

@freezed
abstract class UserInfoModel with _$UserInfoModel {
  const factory UserInfoModel({
    required String id,
    required String userId,
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String role,
    required bool isEmailConfirmed,
    required DateTime createdAt,
  }) = _UserInfoModel;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
}

@freezed
abstract class EmployeeInfoModel with _$EmployeeInfoModel {
  const factory EmployeeInfoModel({
    required int id,
    required String userId,
    required String email,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String employeeId,
    required String department,
    required String position,
    required OrganizationInfoModel organization,
    required double availablePoints,
    required bool isActive,
  }) = _EmployeeInfoModel;

  factory EmployeeInfoModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeInfoModelFromJson(json);
}

@freezed
abstract class OrganizationInfoModel with _$OrganizationInfoModel {
  const factory OrganizationInfoModel({
    required int id,
    required String name,
    String? logoUrl,
  }) = _OrganizationInfoModel;

  factory OrganizationInfoModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationInfoModelFromJson(json);
}

@freezed
abstract class IndividualRegistrationResponse
    with _$IndividualRegistrationResponse {
  const factory IndividualRegistrationResponse({
    required bool succeeded,
    IndividualRegistrationResult? value,
    @Default([]) List<String> errors,
  }) = _IndividualRegistrationResponse;

  factory IndividualRegistrationResponse.fromJson(Map<String, dynamic> json) =>
      _$IndividualRegistrationResponseFromJson(json);
}

@freezed
abstract class IndividualRegistrationResult
    with _$IndividualRegistrationResult {
  const factory IndividualRegistrationResult({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
    required UserInfoModel user,
  }) = _IndividualRegistrationResult;

  factory IndividualRegistrationResult.fromJson(Map<String, dynamic> json) =>
      _$IndividualRegistrationResultFromJson(json);
}
