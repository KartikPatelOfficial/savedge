import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/domain/usecases/get_featured_coupons_usecase.dart';
import 'package:savedge/features/vendors/domain/usecases/get_vendor_coupons_usecase.dart';

part 'coupons_event.dart';
part 'coupons_state.dart';

/// BLoC for managing coupons state
@injectable
class CouponsBloc extends Bloc<CouponsEvent, CouponsState> {
  CouponsBloc({
    required this.getFeaturedCouponsUseCase,
    required this.getVendorCouponsUseCase,
  }) : super(CouponsInitial()) {
    on<LoadFeaturedCoupons>(_onLoadFeaturedCoupons);
    on<RefreshFeaturedCoupons>(_onRefreshFeaturedCoupons);
    on<LoadVendorCoupons>(_onLoadVendorCoupons);
    on<RefreshVendorCoupons>(_onRefreshVendorCoupons);
  }

  final GetFeaturedCouponsUseCase getFeaturedCouponsUseCase;
  final GetVendorCouponsUseCase getVendorCouponsUseCase;

  Future<void> _onLoadFeaturedCoupons(
    LoadFeaturedCoupons event,
    Emitter<CouponsState> emit,
  ) async {
    emit(CouponsLoading());

    final result = await getFeaturedCouponsUseCase(
      GetFeaturedCouponsParams(
        pageNumber: event.pageNumber,
        pageSize: event.pageSize,
      ),
    );

    result.fold(
      (failure) =>
          emit(CouponsError(failure.message ?? 'Failed to load coupons')),
      (coupons) => emit(CouponsLoaded(coupons)),
    );
  }

  Future<void> _onRefreshFeaturedCoupons(
    RefreshFeaturedCoupons event,
    Emitter<CouponsState> emit,
  ) async {
    // Don't emit loading state for refresh to avoid UI flickering
    final result = await getFeaturedCouponsUseCase(
      const GetFeaturedCouponsParams(),
    );

    result.fold(
      (failure) =>
          emit(CouponsError(failure.message ?? 'Failed to refresh coupons')),
      (coupons) => emit(CouponsLoaded(coupons)),
    );
  }

  Future<void> _onLoadVendorCoupons(
    LoadVendorCoupons event,
    Emitter<CouponsState> emit,
  ) async {
    emit(CouponsLoading());

    final result = await getVendorCouponsUseCase(
      GetVendorCouponsParams(
        vendorId: event.vendorId,
        pageNumber: event.pageNumber,
        pageSize: event.pageSize,
        status: event.status,
        isExpired: event.isExpired,
      ),
    );

    result.fold(
      (failure) => emit(
        CouponsError(failure.message ?? 'Failed to load vendor coupons'),
      ),
      (coupons) => emit(CouponsLoaded(coupons)),
    );
  }

  Future<void> _onRefreshVendorCoupons(
    RefreshVendorCoupons event,
    Emitter<CouponsState> emit,
  ) async {
    // Don't emit loading state for refresh to avoid UI flickering
    final result = await getVendorCouponsUseCase(
      GetVendorCouponsParams(vendorId: event.vendorId),
    );

    result.fold(
      (failure) => emit(
        CouponsError(failure.message ?? 'Failed to refresh vendor coupons'),
      ),
      (coupons) => emit(CouponsLoaded(coupons)),
    );
  }
}
