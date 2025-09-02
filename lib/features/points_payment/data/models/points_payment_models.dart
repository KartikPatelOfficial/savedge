import 'package:freezed_annotation/freezed_annotation.dart';

part 'points_payment_models.freezed.dart';
part 'points_payment_models.g.dart';

@freezed
abstract class InitiatePointsPaymentRequest
    with _$InitiatePointsPaymentRequest {
  const factory InitiatePointsPaymentRequest({
    required int vendorProfileId,
    required double amount,
    required int pointsToUse,
  }) = _InitiatePointsPaymentRequest;

  factory InitiatePointsPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$InitiatePointsPaymentRequestFromJson(json);
}

@freezed
abstract class InitiatePointsPaymentResponse
    with _$InitiatePointsPaymentResponse {
  const factory InitiatePointsPaymentResponse({
    required String paymentId,
    required String transactionReference,
    required int pointsToUse,
    required double pointsValue,
    required double billAmount,
    required double remainingAmount,
  }) = _InitiatePointsPaymentResponse;

  factory InitiatePointsPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$InitiatePointsPaymentResponseFromJson(json);
}

@freezed
abstract class VerifyPointsPaymentOtpRequest
    with _$VerifyPointsPaymentOtpRequest {
  const factory VerifyPointsPaymentOtpRequest({
    required String paymentId,
    required String otpCode,
  }) = _VerifyPointsPaymentOtpRequest;

  factory VerifyPointsPaymentOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyPointsPaymentOtpRequestFromJson(json);
}

@freezed
abstract class VerifyPointsPaymentOtpResponse
    with _$VerifyPointsPaymentOtpResponse {
  const factory VerifyPointsPaymentOtpResponse({
    required String paymentId,
    required String transactionReference,
    required int pointsUsed,
    required double pointsValue,
    required double billAmount,
    required double paidAmount,
    required double remainingAmount,
    required String vendorName,
    required DateTime completedAt,
  }) = _VerifyPointsPaymentOtpResponse;

  factory VerifyPointsPaymentOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyPointsPaymentOtpResponseFromJson(json);
}

@freezed
abstract class UserPointsBalanceResponse with _$UserPointsBalanceResponse {
  const factory UserPointsBalanceResponse({
    required int availablePoints,
    required int usedPoints,
    required int expiringPoints,
    required List<PointTransactionDto> recentTransactions,
  }) = _UserPointsBalanceResponse;

  factory UserPointsBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$UserPointsBalanceResponseFromJson(json);
}

@freezed
abstract class PointTransactionDto with _$PointTransactionDto {
  const factory PointTransactionDto({
    required int transactionId,
    required int points,
    required String description,
    required String transactionType,
    required DateTime transactionDate,
    DateTime? expiryDate,
  }) = _PointTransactionDto;

  factory PointTransactionDto.fromJson(Map<String, dynamic> json) =>
      _$PointTransactionDtoFromJson(json);
}

@freezed
abstract class PointsPaymentDetailsResponse
    with _$PointsPaymentDetailsResponse {
  const factory PointsPaymentDetailsResponse({
    required String paymentId,
    required String transactionReference,
    required String customerName,
    required String customerEmail,
    required String vendorName,
    required String vendorEmail,
    required double billAmount,
    required int pointsUsed,
    required double conversionRate,
    required double pointsValue,
    required double remainingAmount,
    required String status,
    required DateTime createdAt,
    DateTime? completedAt,
    required bool isSettled,
    String? settlementId,
  }) = _PointsPaymentDetailsResponse;

  factory PointsPaymentDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$PointsPaymentDetailsResponseFromJson(json);
}
