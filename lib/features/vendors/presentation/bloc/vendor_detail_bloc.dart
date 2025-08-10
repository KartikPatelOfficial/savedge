import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/vendors/domain/usecases/get_vendor_usecase.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_event.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendor_detail_state.dart';

/// BLoC for managing vendor detail state
class VendorDetailBloc extends Bloc<VendorDetailEvent, VendorDetailState> {
  VendorDetailBloc({required this.getVendorUseCase}) : super(VendorDetailInitial()) {
    on<LoadVendorDetail>(_onLoadVendorDetail);
    on<RefreshVendorDetail>(_onRefreshVendorDetail);
  }

  final GetVendorUseCase getVendorUseCase;

  Future<void> _onLoadVendorDetail(
    LoadVendorDetail event,
    Emitter<VendorDetailState> emit,
  ) async {
    emit(VendorDetailLoading());
    await _loadVendor(event.vendorId, emit);
  }

  Future<void> _onRefreshVendorDetail(
    RefreshVendorDetail event,
    Emitter<VendorDetailState> emit,
  ) async {
    // Don't emit loading state for refresh to avoid UI flickering
    await _loadVendor(event.vendorId, emit);
  }

  Future<void> _loadVendor(
    int vendorId,
    Emitter<VendorDetailState> emit,
  ) async {
    final result = await getVendorUseCase(vendorId);

    result.fold(
      (failure) => emit(VendorDetailError(_mapFailureToMessage(failure))),
      (vendor) => emit(VendorDetailLoaded(vendor)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred. Please try again.';
      case NetworkFailure:
        return 'No internet connection. Please check your network.';
      case NotFoundFailure:
        return 'Vendor not found.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
