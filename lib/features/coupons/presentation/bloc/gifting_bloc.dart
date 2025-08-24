import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/services/gifting_service.dart';
import 'gifting_event.dart';
import 'gifting_state.dart';

@injectable
class GiftingBloc extends Bloc<GiftingEvent, GiftingState> {
  GiftingBloc(this._giftingService) : super(const GiftingInitial()) {
    on<LoadColleagues>(_onLoadColleagues);
    on<GiftCoupon>(_onGiftCoupon);
    on<TransferPoints>(_onTransferPoints);
    on<LoadGiftHistory>(_onLoadGiftHistory);
    on<LoadPointsHistory>(_onLoadPointsHistory);
    on<LoadGiftingHistory>(_onLoadGiftingHistory);
    on<LoadReceivedGifts>(_onLoadReceivedGifts);
  }

  final GiftingService _giftingService;

  Future<void> _onLoadColleagues(
    LoadColleagues event,
    Emitter<GiftingState> emit,
  ) async {
    emit(const GiftingLoading());

    try {
      final colleagues = await _giftingService.getColleagues();
      emit(ColleaguesLoaded(colleagues));
    } catch (e) {
      emit(GiftingError('Failed to load colleagues: ${e.toString()}'));
    }
  }

  Future<void> _onGiftCoupon(
    GiftCoupon event,
    Emitter<GiftingState> emit,
  ) async {
    emit(const GiftingLoading());

    try {
      final response = await _giftingService.giftCoupon(event.request);
      if (response.success) {
        emit(GiftingSuccess(response.message));
      } else {
        emit(GiftingError(response.message));
      }
    } catch (e) {
      emit(GiftingError('Failed to gift coupon: ${e.toString()}'));
    }
  }

  Future<void> _onTransferPoints(
    TransferPoints event,
    Emitter<GiftingState> emit,
  ) async {
    emit(const GiftingLoading());

    try {
      final response = await _giftingService.transferPoints(event.request);
      if (response.success) {
        emit(GiftingSuccess(response.message));
      } else {
        emit(GiftingError(response.message));
      }
    } catch (e) {
      emit(GiftingError('Failed to transfer points: ${e.toString()}'));
    }
  }

  Future<void> _onLoadGiftHistory(
    LoadGiftHistory event,
    Emitter<GiftingState> emit,
  ) async {
    emit(const GiftingLoading());

    try {
      final history = await _giftingService.getGiftedCouponsHistory();
      emit(GiftHistoryLoaded(history));
    } catch (e) {
      emit(GiftingError('Failed to load gift history: ${e.toString()}'));
    }
  }

  Future<void> _onLoadPointsHistory(
    LoadPointsHistory event,
    Emitter<GiftingState> emit,
  ) async {
    emit(const GiftingLoading());

    try {
      final history = await _giftingService.getPointsTransferHistory();
      emit(PointsHistoryLoaded(history));
    } catch (e) {
      emit(GiftingError('Failed to load points history: ${e.toString()}'));
    }
  }

  Future<void> _onLoadGiftingHistory(
    LoadGiftingHistory event,
    Emitter<GiftingState> emit,
  ) async {
    emit(const GiftingLoading());

    try {
      // Load both gifted coupons and transferred points history
      final giftedCoupons = await _giftingService.getGiftedCouponsHistory();
      final transferredPoints = await _giftingService
          .getPointsTransferHistory();

      emit(
        GiftingHistoryLoaded(
          giftedCoupons: [],
          transferredPoints: transferredPoints,
        ),
      );
    } catch (e) {
      emit(GiftingError('Failed to load gifting history: ${e.toString()}'));
    }
  }

  Future<void> _onLoadReceivedGifts(
    LoadReceivedGifts event,
    Emitter<GiftingState> emit,
  ) async {
    emit(const GiftingLoading());

    try {
      // For now, return empty lists as the backend might not have these endpoints yet
      // These can be implemented when the backend APIs are ready
      emit(const ReceivedGiftsLoaded(receivedCoupons: [], receivedPoints: []));
    } catch (e) {
      emit(GiftingError('Failed to load received gifts: ${e.toString()}'));
    }
  }
}
