part of 'free_trial_bloc.dart';

@freezed
abstract class FreeTrialState with _$FreeTrialState {
  const factory FreeTrialState.initial() = _Initial;

  const factory FreeTrialState.loading() = _Loading;

  const factory FreeTrialState.loaded({
    required FreeTrialStatusResponse status,
  }) = _Loaded;

  const factory FreeTrialState.activating() = _Activating;

  const factory FreeTrialState.activated({
    required ActivateFreeTrialResponse response,
  }) = _Activated;

  const factory FreeTrialState.error({required String message}) = _Error;
}
