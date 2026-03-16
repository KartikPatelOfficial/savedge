import 'package:freezed_annotation/freezed_annotation.dart';

part 'promotion_models.freezed.dart';
part 'promotion_models.g.dart';

@freezed
abstract class PromotionStatusResponse with _$PromotionStatusResponse {
  const factory PromotionStatusResponse({
    required bool isPromotionActive,
    required bool isEnrolled,
    DateTime? enrolledAt,
    DateTime? promotionExpiresAt,
  }) = _PromotionStatusResponse;

  factory PromotionStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$PromotionStatusResponseFromJson(json);
}

@freezed
abstract class EnrollPromotionResponse with _$EnrollPromotionResponse {
  const factory EnrollPromotionResponse({
    required bool success,
    required DateTime enrolledAt,
    required DateTime promotionExpiresAt,
    required String message,
  }) = _EnrollPromotionResponse;

  factory EnrollPromotionResponse.fromJson(Map<String, dynamic> json) =>
      _$EnrollPromotionResponseFromJson(json);
}
