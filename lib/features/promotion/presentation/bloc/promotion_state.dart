part of 'promotion_bloc.dart';

@freezed
abstract class PromotionState with _$PromotionState {
  const factory PromotionState.initial() = _Initial;

  const factory PromotionState.loading() = _Loading;

  const factory PromotionState.active({
    required PromotionStatusResponse status,
  }) = _Active;

  const factory PromotionState.enrolling() = _Enrolling;

  const factory PromotionState.enrolled({
    required EnrollPromotionResponse response,
  }) = _Enrolled;

  const factory PromotionState.inactive() = _Inactive;

  const factory PromotionState.error({required String message}) = _Error;
}
