import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/services/coupon_service.dart';
import 'user_coupons_event.dart';
import 'user_coupons_state.dart';

/// BLoC for managing user coupons
class UserCouponsBloc extends Bloc<UserCouponsEvent, UserCouponsState> {
  UserCouponsBloc() : super(UserCouponsInitial()) {
    on<LoadUserCoupons>(_onLoadUserCoupons);
    on<RefreshUserCoupons>(_onRefreshUserCoupons);
  }

  final CouponService _couponService = GetIt.I<CouponService>();
  int _currentPage = 1;
  String? _currentStatus;

  Future<void> _onLoadUserCoupons(
    LoadUserCoupons event,
    Emitter<UserCouponsState> emit,
  ) async {
    if (state is UserCouponsInitial || event.pageNumber == 1) {
      emit(UserCouponsLoading());
      _currentPage = 1;
      _currentStatus = event.status;
    }

    try {
      final response = await _couponService.getUserCoupons(
        pageNumber: event.pageNumber,
        pageSize: event.pageSize,
        status: event.status,
      );

      final currentState = state;
      if (currentState is UserCouponsLoaded && event.pageNumber > 1) {
        // Loading more data
        final updatedCoupons = List.of(currentState.coupons)
          ..addAll(response.coupons);
        
        emit(currentState.copyWith(
          coupons: updatedCoupons,
          hasReachedMax: response.coupons.isEmpty,
        ));
      } else {
        // Fresh load
        emit(UserCouponsLoaded(
          coupons: response.coupons,
          totalCount: response.totalCount,
          activeCount: response.activeCount,
          usedCount: response.usedCount,
          expiredCount: response.expiredCount,
          hasReachedMax: response.coupons.isEmpty,
        ));
      }

      _currentPage = event.pageNumber;
    } catch (e) {
      emit(UserCouponsError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onRefreshUserCoupons(
    RefreshUserCoupons event,
    Emitter<UserCouponsState> emit,
  ) async {
    _currentStatus = event.status;
    add(LoadUserCoupons(pageNumber: 1, status: event.status));
  }

  /// Load next page of coupons
  void loadNextPage() {
    final currentState = state;
    if (currentState is UserCouponsLoaded && !currentState.hasReachedMax) {
      add(LoadUserCoupons(
        pageNumber: _currentPage + 1,
        status: _currentStatus,
      ));
    }
  }
}
