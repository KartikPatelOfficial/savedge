import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon_gifting_models.freezed.dart';
part 'coupon_gifting_models.g.dart';

@freezed
abstract class ColleagueModel with _$ColleagueModel {
  const factory ColleagueModel({
    required String userId,
    required String email,
    required String employeeCode,
    required String department,
    required String position,
    required String firstName,
    required String lastName,
  }) = _ColleagueModel;

  factory ColleagueModel.fromJson(Map<String, dynamic> json) =>
      _$ColleagueModelFromJson(json);
}

@freezed
abstract class GiftCouponRequest with _$GiftCouponRequest {
  const factory GiftCouponRequest({
    required int userCouponId,
    required String toUserId,
    String? message,
  }) = _GiftCouponRequest;

  factory GiftCouponRequest.fromJson(Map<String, dynamic> json) =>
      _$GiftCouponRequestFromJson(json);
}

@freezed
abstract class GiftCouponResponse with _$GiftCouponResponse {
  const factory GiftCouponResponse({
    required bool success,
    required String message,
    required int giftedCouponId,
    required String uniqueCode,
  }) = _GiftCouponResponse;

  factory GiftCouponResponse.fromJson(Map<String, dynamic> json) =>
      _$GiftCouponResponseFromJson(json);
}

@freezed
abstract class TransferPointsRequest with _$TransferPointsRequest {
  const factory TransferPointsRequest({
    required String toUserId,
    required int points,
    String? message,
  }) = _TransferPointsRequest;

  factory TransferPointsRequest.fromJson(Map<String, dynamic> json) =>
      _$TransferPointsRequestFromJson(json);
}

@freezed
abstract class TransferPointsResponse with _$TransferPointsResponse {
  const factory TransferPointsResponse({
    required bool success,
    required String message,
    required String transferReference,
    required int transferredPoints,
  }) = _TransferPointsResponse;

  factory TransferPointsResponse.fromJson(Map<String, dynamic> json) =>
      _$TransferPointsResponseFromJson(json);
}

@freezed
abstract class UserCouponDetailModel with _$UserCouponDetailModel {
  const factory UserCouponDetailModel({
    required int id,
    required int couponId,
    required String title,
    String? description,
    @JsonKey(name: 'vendorProfileId') required int vendorId,
    required String vendorUserId,
    required String vendorName,
    required String status,
    @JsonKey(name: 'purchasedDate') required DateTime acquiredDate,
    DateTime? redeemedDate,
    @JsonKey(name: 'validUntil') required DateTime expiryDate,
    required String uniqueCode,
    String? qrCode,
    required String discountType,
    required double discountValue,
    double? minCartValue,
    String? imageUrl,
    required bool isGifted,
    String? giftedFromUserId,
    String? giftedToUserId,
    DateTime? giftedDate,
    String? giftMessage,
  }) = _UserCouponDetailModel;

  factory UserCouponDetailModel.fromJson(Map<String, dynamic> json) =>
      _$UserCouponDetailModelFromJson(json);
}

extension UserCouponDetailModelX on UserCouponDetailModel {
  bool get isExpired => DateTime.now().isAfter(expiryDate);

  bool get isUsed => status.toLowerCase() == 'redeemed';

  bool get isActive => status.toLowerCase() == 'unused' && !isExpired;

  String get discountDisplay {
    if (discountType.toLowerCase() == 'percentage') {
      return '${discountValue.toInt()}% OFF';
    } else {
      return '₹${discountValue.toInt()} OFF';
    }
  }

  String get statusDisplay {
    if (isUsed) return 'Used';
    if (isExpired) return 'Expired';
    if (status.toLowerCase() == 'gifted') return 'Gifted';
    return 'Active';
  }
}

@freezed
abstract class UserCouponsResponseModel with _$UserCouponsResponseModel {
  const factory UserCouponsResponseModel({
    @Default([]) List<UserCouponDetailModel> purchasedCoupons,
    @Default([]) List<UserCouponDetailModel> usedCoupons,
    @Default([]) List<UserCouponDetailModel> expiredCoupons,
    @Default([]) List<UserCouponDetailModel> giftedReceivedCoupons,
    @Default([]) List<UserCouponDetailModel> giftedSentCoupons,
    @Default(0) int totalCount,
    @Default(0) int activeCount,
    @Default(0) int usedCount,
    @Default(0) int expiredCount,
    @Default(0) int giftedCount,
  }) = _UserCouponsResponseModel;

  factory UserCouponsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserCouponsResponseModelFromJson(json);
}

@freezed
abstract class GiftedCouponHistoryModel with _$GiftedCouponHistoryModel {
  const factory GiftedCouponHistoryModel({
    required int id,
    required String couponTitle,
    required String recipientUserId,
    required DateTime giftedDate,
    String? message,
    required String status,
    required String direction, // "Sent" or "Received"
  }) = _GiftedCouponHistoryModel;

  factory GiftedCouponHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$GiftedCouponHistoryModelFromJson(json);
}

@freezed
abstract class GiftedCouponsHistoryResponseModel
    with _$GiftedCouponsHistoryResponseModel {
  const factory GiftedCouponsHistoryResponseModel({
    required List<GiftedCouponHistoryModel> sentCoupons,
    required List<GiftedCouponHistoryModel> receivedCoupons,
  }) = _GiftedCouponsHistoryResponseModel;

  factory GiftedCouponsHistoryResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$GiftedCouponsHistoryResponseModelFromJson(json);
}

@freezed
abstract class PointsTransferHistoryModel with _$PointsTransferHistoryModel {
  const factory PointsTransferHistoryModel({
    required int id,
    required String fromUserId,
    required String toUserId,
    required int points,
    required String status,
    required DateTime transferDate,
    String? message,
    required String direction, // "Sent" or "Received"
  }) = _PointsTransferHistoryModel;

  factory PointsTransferHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$PointsTransferHistoryModelFromJson(json);
}
