import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/features/promotion/data/models/promotion_models.dart';
import 'package:savedge/features/promotion/data/repositories/promotion_repository.dart';

part 'promotion_event.dart';
part 'promotion_state.dart';
part 'promotion_bloc.freezed.dart';

@injectable
class PromotionBloc extends Bloc<PromotionEvent, PromotionState> {
  final PromotionRepository _repository;

  PromotionBloc(this._repository) : super(const PromotionState.initial()) {
    on<_CheckStatus>(_onCheckStatus);
    on<_Enroll>(_onEnroll);
  }

  Future<void> _onCheckStatus(
    _CheckStatus event,
    Emitter<PromotionState> emit,
  ) async {
    emit(const PromotionState.loading());
    try {
      final status = await _repository.getPromotionStatus();
      if (status.isPromotionActive) {
        emit(PromotionState.active(status: status));
      } else {
        emit(const PromotionState.inactive());
      }
    } catch (e) {
      emit(PromotionState.error(message: e.toString()));
    }
  }

  Future<void> _onEnroll(
    _Enroll event,
    Emitter<PromotionState> emit,
  ) async {
    emit(const PromotionState.enrolling());
    try {
      final response = await _repository.enrollInPromotion();
      emit(PromotionState.enrolled(response: response));
    } catch (e) {
      emit(PromotionState.error(message: e.toString()));
    }
  }
}
