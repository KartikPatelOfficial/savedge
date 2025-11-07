import 'package:freezed_annotation/freezed_annotation.dart';

part 'free_trial_models.freezed.dart';
part 'free_trial_models.g.dart';

enum FreeTrialStatus {
  @JsonValue(0)
  notStarted,
  @JsonValue(1)
  active,
  @JsonValue(2)
  expired,
  @JsonValue(3)
  used,
}

@freezed
abstract class FreeTrialStatusResponse with _$FreeTrialStatusResponse {
  const factory FreeTrialStatusResponse({
    required FreeTrialStatus status,
    required bool canActivate,
    DateTime? activatedAt,
    DateTime? expiresAt,
    required DateTime offerExpiresAt,
    RemainingTimeResponse? remainingTime,
    required bool hasActiveSubscription,
  }) = _FreeTrialStatusResponse;

  factory FreeTrialStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$FreeTrialStatusResponseFromJson(json);
}

@freezed
abstract class RemainingTimeResponse with _$RemainingTimeResponse {
  const factory RemainingTimeResponse({
    required int days,
    required int hours,
    required int minutes,
    required int seconds,
    required int totalSeconds,
  }) = _RemainingTimeResponse;

  factory RemainingTimeResponse.fromJson(Map<String, dynamic> json) =>
      _$RemainingTimeResponseFromJson(json);
}

@freezed
abstract class ActivateFreeTrialResponse with _$ActivateFreeTrialResponse {
  const factory ActivateFreeTrialResponse({
    required bool success,
    required DateTime expiresAt,
    required String message,
  }) = _ActivateFreeTrialResponse;

  factory ActivateFreeTrialResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivateFreeTrialResponseFromJson(json);
}
