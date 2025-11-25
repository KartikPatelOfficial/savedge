import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/free_trial_models.dart';
import '../../data/repositories/free_trial_repository.dart';

part 'free_trial_event.dart';
part 'free_trial_state.dart';
part 'free_trial_bloc.freezed.dart';

@injectable
class FreeTrialBloc extends Bloc<FreeTrialEvent, FreeTrialState> {
  final FreeTrialRepository _repository;
  Timer? _countdownTimer;

  FreeTrialBloc(this._repository) : super(const FreeTrialState.initial()) {
    on<_LoadStatus>(_onLoadStatus);
    on<_ActivateTrial>(_onActivateTrial);
    on<_UpdateCountdown>(_onUpdateCountdown);
  }

  Future<void> _onLoadStatus(
    _LoadStatus event,
    Emitter<FreeTrialState> emit,
  ) async {
    print('🔍 FreeTrialBloc: Loading free trial status...');
    emit(const FreeTrialState.loading());
    try {
      final status = await _repository.getFreeTrialStatus();
      print('✅ FreeTrialBloc: Status loaded - ${status.status}');
      print('   Can activate: ${status.canActivate}');
      if (status.remainingTime != null) {
        print('   Remaining time: ${status.remainingTime!.days}d ${status.remainingTime!.hours}h ${status.remainingTime!.minutes}m');
      }
      emit(FreeTrialState.loaded(status: status));

      // Start countdown timer if trial is active
      if (status.status == FreeTrialStatus.active && status.remainingTime != null) {
        print('⏰ FreeTrialBloc: Starting countdown timer');
        _startCountdownTimer();
      }
    } catch (e) {
      print('❌ FreeTrialBloc: Error loading status: $e');
      emit(FreeTrialState.error(message: e.toString()));
    }
  }

  Future<void> _onActivateTrial(
    _ActivateTrial event,
    Emitter<FreeTrialState> emit,
  ) async {
    emit(const FreeTrialState.activating());
    try {
      final response = await _repository.activateFreeTrial();
      emit(FreeTrialState.activated(response: response));

      // Reload status after activation
      await Future.delayed(const Duration(seconds: 1));
      add(const FreeTrialEvent.loadStatus());
    } catch (e) {
      emit(FreeTrialState.error(message: e.toString()));
    }
  }

  void _onUpdateCountdown(
    _UpdateCountdown event,
    Emitter<FreeTrialState> emit,
  ) {
    final currentState = state;
    if (currentState is _Loaded) {
      // Trigger a reload to get updated countdown
      add(const FreeTrialEvent.loadStatus());
    }
  }

  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(
      const Duration(seconds: 60), // Update every minute
      (_) => add(const FreeTrialEvent.updateCountdown()),
    );
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
