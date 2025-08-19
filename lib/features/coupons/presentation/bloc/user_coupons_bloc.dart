import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:savedge/features/coupons/data/services/coupon_service.dart';
import 'package:savedge/features/coupons/data/models/user_coupon_model.dart';
import 'package:savedge/features/coupons/presentation/bloc/user_coupons_event.dart';
import 'package:savedge/features/coupons/presentation/bloc/user_coupons_state.dart';

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

      // Apply client-side filtering if status is specified
      List<UserCouponModel> filteredCoupons = response.coupons;
      if (event.status != null) {
        switch (event.status) {
          case 'active':
            filteredCoupons = response.coupons.where((c) => c.isValid).toList();
            break;
          case 'used':
            filteredCoupons = response.coupons.where((c) => c.isUsed).toList();
            break;
          case 'expired':
            filteredCoupons = response.coupons
                .where((c) => c.isExpired && !c.isUsed)
                .toList();
            break;
        }
      }

      final currentState = state;
      if (currentState is UserCouponsLoaded && event.pageNumber > 1) {
        // Loading more data
        final updatedCoupons = List.of(currentState.coupons)
          ..addAll(filteredCoupons);

        emit(
          currentState.copyWith(
            coupons: updatedCoupons,
            hasReachedMax: filteredCoupons.isEmpty,
          ),
        );
      } else {
        // Fresh load
        emit(
          UserCouponsLoaded(
            coupons: filteredCoupons,
            totalCount: response.totalCount,
            activeCount: response.activeCount,
            usedCount: response.usedCount,
            expiredCount: response.expiredCount,
            hasReachedMax: filteredCoupons.isEmpty,
          ),
        );
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
      add(
        LoadUserCoupons(pageNumber: _currentPage + 1, status: _currentStatus),
      );
    }
  }
}
