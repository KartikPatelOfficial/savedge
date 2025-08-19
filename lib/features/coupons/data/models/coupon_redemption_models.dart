import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon_redemption_models.freezed.dart';
part 'coupon_redemption_models.g.dart';

/// Request model for redeeming a user's owned coupon
@freezed
abstract class RedeemMyCouponRequest with _$RedeemMyCouponRequest {
  const factory RedeemMyCouponRequest({
    required int userCouponId,
  }) = _RedeemMyCouponRequest;

  factory RedeemMyCouponRequest.fromJson(Map<String, dynamic> json) =>
      _$RedeemMyCouponRequestFromJson(json);
}

/// Response model for coupon redemption
@freezed
abstract class RedeemCouponResponse with _$RedeemCouponResponse {
  const factory RedeemCouponResponse({
    required bool success,
    required String message,
    required DateTime redeemedAt,
    required String couponTitle,
    required String vendorName,
    required double discountValue,
    required String discountType,
    required String uniqueCode,
  }) = _RedeemCouponResponse;

  factory RedeemCouponResponse.fromJson(Map<String, dynamic> json) =>
      _$RedeemCouponResponseFromJson(json);
}

/// Request model for claiming a coupon with points
@freezed
abstract class ClaimCouponRequest with _$ClaimCouponRequest {
  const factory ClaimCouponRequest({
    required int couponId,
  }) = _ClaimCouponRequest;

  factory ClaimCouponRequest.fromJson(Map<String, dynamic> json) =>
      _$ClaimCouponRequestFromJson(json);
}

/// Request model for claiming a coupon from subscription
@freezed
abstract class ClaimFromSubscriptionRequest with _$ClaimFromSubscriptionRequest {
  const factory ClaimFromSubscriptionRequest({
    required int couponId,
  }) = _ClaimFromSubscriptionRequest;

  factory ClaimFromSubscriptionRequest.fromJson(Map<String, dynamic> json) =>
      _$ClaimFromSubscriptionRequestFromJson(json);
}

/// Response model for coupon claiming
@freezed
abstract class ClaimCouponResponse with _$ClaimCouponResponse {
  const factory ClaimCouponResponse({
    required int userCouponId,
    required String uniqueCode,
    required String message,
  }) = _ClaimCouponResponse;

  factory ClaimCouponResponse.fromJson(Map<String, dynamic> json) =>
      _$ClaimCouponResponseFromJson(json);
}

/// Extension to get formatted discount display
extension RedeemCouponResponseX on RedeemCouponResponse {
  String get discountDisplay {
    if (discountType.toLowerCase() == 'percentage') {
      return '${discountValue.toInt()}% OFF';
    } else {
      return '₹${discountValue.toInt()} OFF';
    }
  }
}