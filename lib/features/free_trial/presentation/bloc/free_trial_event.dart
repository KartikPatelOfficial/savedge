part of 'free_trial_bloc.dart';

@freezed
class FreeTrialEvent with _$FreeTrialEvent {
  const factory FreeTrialEvent.loadStatus() = _LoadStatus;
  const factory FreeTrialEvent.activateTrial() = _ActivateTrial;
  const factory FreeTrialEvent.updateCountdown() = _UpdateCountdown;
}
