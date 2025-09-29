import 'package:dio/dio.dart';
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
      emit(
        GiftingError(
          _extractErrorMessage(e, fallback: 'Failed to gift coupon'),
        ),
      );
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
      emit(
        GiftingError(
          _extractErrorMessage(e, fallback: 'Failed to transfer points'),
        ),
      );
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
      emit(
        GiftingError(
          _extractErrorMessage(e, fallback: 'Failed to load gift history'),
        ),
      );
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
      emit(
        GiftingError(
          _extractErrorMessage(e, fallback: 'Failed to load points history'),
        ),
      );
    }
  }

  Future<void> _onLoadGiftingHistory(
    LoadGiftingHistory event,
    Emitter<GiftingState> emit,
  ) async {
    emit(const GiftingLoading());

    try {
      // Load both gifted coupons and transferred points history
      final history = await _giftingService.getGiftedCouponsHistory();
      final transfers = await _giftingService.getPointsTransferHistory();

      // Show sent coupons and sent points in "Sent History" tab
      final sentPoints = transfers
          .where((p) => (p.direction).toLowerCase() == 'sent')
          .toList();

      emit(
        GiftingHistoryLoaded(
          giftedCoupons: history.sentCoupons,
          transferredPoints: sentPoints,
        ),
      );
    } catch (e) {
      emit(
        GiftingError(
          _extractErrorMessage(e, fallback: 'Failed to load gifting history'),
        ),
      );
    }
  }

  Future<void> _onLoadReceivedGifts(
    LoadReceivedGifts event,
    Emitter<GiftingState> emit,
  ) async {
    emit(const GiftingLoading());

    try {
      final history = await _giftingService.getGiftedCouponsHistory();
      final transfers = await _giftingService.getPointsTransferHistory();

      // Received gifts/points for current user
      final receivedPoints = transfers
          .where((p) => (p.direction).toLowerCase() == 'received')
          .toList();

      emit(
        ReceivedGiftsLoaded(
          receivedCoupons: history.receivedCoupons,
          receivedPoints: receivedPoints,
        ),
      );
    } catch (e) {
      emit(
        GiftingError(
          _extractErrorMessage(e, fallback: 'Failed to load received gifts'),
        ),
      );
    }
  }

  String _extractErrorMessage(Object error, {required String fallback}) {
    if (error is DioException) {
      final response = error.response;
      if (response?.data is Map) {
        final data = response!.data as Map;
        final message = data['message'] ?? data['Message'] ?? data['error'];
        if (message is String && message.isNotEmpty) {
          return message;
        }
      } else if (response?.data is String) {
        final data = (response!.data as String).trim();
        if (data.isNotEmpty) {
          return data;
        }
      }
      if (error.message != null && error.message!.isNotEmpty) {
        return error.message!;
      }
    }

    return fallback;
  }
}
