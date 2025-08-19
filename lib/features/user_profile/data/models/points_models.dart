import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/entities/points.dart';

part 'points_models.freezed.dart';
part 'points_models.g.dart';

/// Data model for user points response
@freezed
abstract class UserPointsResponseModel with _$UserPointsResponseModel {
  const factory UserPointsResponseModel({
    @JsonKey(name: 'pointsBalance') required int pointsBalance,
    @JsonKey(name: 'pointsExpiry') DateTime? pointsExpiry,
  }) = _UserPointsResponseModel;

  factory UserPointsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserPointsResponseModelFromJson(json);
}

/// Extension to convert to domain entity
extension UserPointsResponseModelX on UserPointsResponseModel {
  Points toDomain() {
    return Points(balance: pointsBalance, expirationDate: pointsExpiry);
  }
}

/// Data model for point transaction ledger entry
@freezed
abstract class PointTransactionModel with _$PointTransactionModel {
  const factory PointTransactionModel({
    required int id,
    @JsonKey(name: 'pointsDelta') required int pointsDelta,
    required String type,
    required String description,
    @JsonKey(name: 'transactionDate') required DateTime transactionDate,
    @JsonKey(name: 'expiryDate') DateTime? expiryDate,
    @JsonKey(name: 'relatedCouponId') int? relatedCouponId,
    @JsonKey(name: 'relatedSubscriptionId') int? relatedSubscriptionId,
    @JsonKey(name: 'referenceId') String? referenceId,
  }) = _PointTransactionModel;

  factory PointTransactionModel.fromJson(Map<String, dynamic> json) =>
      _$PointTransactionModelFromJson(json);
}

/// Extension to convert to domain entity
extension PointTransactionModelX on PointTransactionModel {
  PointTransaction toDomain() {
    return PointTransaction(
      id: id,
      pointsDelta: pointsDelta,
      type: type,
      description: description,
      transactionDate: transactionDate,
      expiryDate: expiryDate,
      relatedCouponId: relatedCouponId,
      relatedSubscriptionId: relatedSubscriptionId,
      referenceId: referenceId,
    );
  }
}

/// Request model for allocating points (admin/organization use)
@freezed
abstract class AllocatePointsRequestModel with _$AllocatePointsRequestModel {
  const factory AllocatePointsRequestModel({
    required int employeeId,
    required int points,
    String? description,
    DateTime? customExpiryDate,
  }) = _AllocatePointsRequestModel;

  factory AllocatePointsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AllocatePointsRequestModelFromJson(json);
}

/// Response model for employee points details
@freezed
abstract class EmployeePointsResponseModel with _$EmployeePointsResponseModel {
  const factory EmployeePointsResponseModel({
    required int employeeId,
    required int currentBalance,
    required int totalAllocated,
    required int totalSpent,
    DateTime? nextExpiry,
    @Default([]) List<PointTransactionModel> recentTransactions,
  }) = _EmployeePointsResponseModel;

  factory EmployeePointsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeePointsResponseModelFromJson(json);
}

/// Response model for points expiration information
@freezed
abstract class PointsExpirationInfoModel with _$PointsExpirationInfoModel {
  const factory PointsExpirationInfoModel({
    required int days,
    required int expiringPoints,
  }) = _PointsExpirationInfoModel;

  factory PointsExpirationInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PointsExpirationInfoModelFromJson(json);
}

/// Response model for expired points count
@freezed
abstract class ExpiredPointsCountModel with _$ExpiredPointsCountModel {
  const factory ExpiredPointsCountModel({
    @JsonKey(name: 'expiredPointsCount') required int expiredPointsCount,
  }) = _ExpiredPointsCountModel;

  factory ExpiredPointsCountModel.fromJson(Map<String, dynamic> json) =>
      _$ExpiredPointsCountModelFromJson(json);
}
