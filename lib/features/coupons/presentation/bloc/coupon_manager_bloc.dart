import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/services/enhanced_coupon_service.dart';
import 'coupon_manager_event.dart';
import 'coupon_manager_state.dart';

@injectable
class CouponManagerBloc extends Bloc<CouponManagerEvent, CouponManagerState> {
  CouponManagerBloc(this._enhancedCouponService)
    : super(const CouponManagerInitial()) {
    on<LoadAllCoupons>(_onLoadAllCoupons);
    on<RefreshAllCoupons>(_onRefreshAllCoupons);
    on<LoadCouponsByCategory>(_onLoadCouponsByCategory);
  }

  final EnhancedCouponService _enhancedCouponService;

  Future<void> _onLoadAllCoupons(
    LoadAllCoupons event,
    Emitter<CouponManagerState> emit,
  ) async {
    emit(const CouponManagerLoading());

    try {
      final couponsData = await _enhancedCouponService.getMyCoupons();
      emit(CouponManagerLoaded(couponsData));
    } catch (e) {
      emit(CouponManagerError('Failed to load coupons: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshAllCoupons(
    RefreshAllCoupons event,
    Emitter<CouponManagerState> emit,
  ) async {
    // Don't show loading state for refresh
    try {
      final couponsData = await _enhancedCouponService.getMyCoupons();
      emit(CouponManagerLoaded(couponsData));
    } catch (e) {
      emit(CouponManagerError('Failed to refresh coupons: ${e.toString()}'));
    }
  }

  Future<void> _onLoadCouponsByCategory(
    LoadCouponsByCategory event,
    Emitter<CouponManagerState> emit,
  ) async {
    emit(const CouponManagerLoading());

    try {
      final couponsData = await _enhancedCouponService.getMyCouponsByCategory(
        event.category,
      );
      emit(CouponManagerLoaded(couponsData));
    } catch (e) {
      emit(CouponManagerError('Failed to load coupons: ${e.toString()}'));
    }
  }
}
