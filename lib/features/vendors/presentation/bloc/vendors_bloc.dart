import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_vendors_usecase.dart';
import 'vendors_event.dart';
import 'vendors_state.dart';

class VendorsBloc extends Bloc<VendorsEvent, VendorsState> {
  VendorsBloc({required this.getVendorsUseCase}) : super(VendorsInitial()) {
    on<LoadVendors>(_onLoadVendors);
    on<SearchVendors>(_onSearchVendors);
    on<FilterVendorsByCategory>(_onFilterVendorsByCategory);
    on<LoadMoreVendors>(_onLoadMoreVendors);
    on<RefreshVendors>(_onRefreshVendors);
  }

  final GetVendorsUseCase getVendorsUseCase;

  Future<void> _onLoadVendors(
    LoadVendors event,
    Emitter<VendorsState> emit,
  ) async {
    if (event.refresh || state is VendorsInitial) {
      emit(VendorsLoading());
    }

    final result = await getVendorsUseCase(
      GetVendorsParams(
        pageNumber: event.pageNumber,
        pageSize: event.pageSize,
        searchTerm: event.searchTerm,
        category: event.category,
      ),
    );

    result.fold(
      (failure) => emit(VendorsError(_mapFailureToMessage(failure))),
      (vendors) {
        if (event.refresh ||
            state is VendorsInitial ||
            state is VendorsLoading) {
          emit(
            VendorsLoaded(
              vendors: vendors,
              hasReachedMax: vendors.length < event.pageSize,
              currentPage: event.pageNumber,
              searchTerm: event.searchTerm,
              selectedCategory: event.category,
            ),
          );
        } else if (state is VendorsLoaded) {
          final currentState = state as VendorsLoaded;
          emit(
            currentState.copyWith(
              vendors: [...currentState.vendors, ...vendors],
              hasReachedMax: vendors.length < event.pageSize,
              currentPage: event.pageNumber,
            ),
          );
        }
      },
    );
  }

  Future<void> _onSearchVendors(
    SearchVendors event,
    Emitter<VendorsState> emit,
  ) async {
    add(
      LoadVendors(
        searchTerm: event.searchTerm.isEmpty ? null : event.searchTerm,
        refresh: true,
      ),
    );
  }

  Future<void> _onFilterVendorsByCategory(
    FilterVendorsByCategory event,
    Emitter<VendorsState> emit,
  ) async {
    add(LoadVendors(category: event.category, refresh: true));
  }

  Future<void> _onLoadMoreVendors(
    LoadMoreVendors event,
    Emitter<VendorsState> emit,
  ) async {
    if (state is VendorsLoaded) {
      final currentState = state as VendorsLoaded;
      if (!currentState.hasReachedMax) {
        add(
          LoadVendors(
            pageNumber: currentState.currentPage + 1,
            searchTerm: currentState.searchTerm,
            category: currentState.selectedCategory,
          ),
        );
      }
    }
  }

  Future<void> _onRefreshVendors(
    RefreshVendors event,
    Emitter<VendorsState> emit,
  ) async {
    final currentState = state;
    if (currentState is VendorsLoaded) {
      add(
        LoadVendors(
          searchTerm: currentState.searchTerm,
          category: currentState.selectedCategory,
          refresh: true,
        ),
      );
    } else {
      add(const LoadVendors(refresh: true));
    }
  }

  String _mapFailureToMessage(failure) {
    switch (failure.runtimeType.toString()) {
      case 'NetworkFailure':
        return 'No internet connection. Please check your network.';
      case 'ServerFailure':
        return 'Server error occurred. Please try again.';
      case 'NotFoundFailure':
        return 'No vendors found.';
      case 'AuthFailure':
        return 'Authentication failed. Please login again.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
