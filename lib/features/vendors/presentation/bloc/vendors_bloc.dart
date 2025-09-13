import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/utils/failure_message_mapper.dart';
import 'package:savedge/features/vendors/domain/usecases/get_vendors_usecase.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_event.dart';
import 'package:savedge/features/vendors/presentation/bloc/vendors_state.dart';

/// BLoC for managing vendor list state
///
/// Handles loading, searching, filtering, and pagination of vendors.
/// Uses the GetVendorsUseCase to fetch data and provides error handling
/// with user-friendly messages.
class VendorsBloc extends Bloc<VendorsEvent, VendorsState> {
  VendorsBloc({required this.getVendorsUseCase}) : super(VendorsInitial()) {
    on<LoadVendors>(_onLoadVendors);
    on<SearchVendors>(_onSearchVendors);
    on<FilterVendorsByCategory>(_onFilterVendorsByCategory);
    on<LoadMoreVendors>(_onLoadMoreVendors);
    on<RefreshVendors>(_onRefreshVendors);
    on<LoadTopOfferVendors>(_onLoadTopOfferVendors);
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
      (failure) => emit(
        VendorsError(FailureMessageMapper.mapVendorFailureToMessage(failure)),
      ),
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

  Future<void> _onLoadTopOfferVendors(
    LoadTopOfferVendors event,
    Emitter<VendorsState> emit,
  ) async {
    emit(VendorsLoading());

    // Call the use case with special flag to get top offers
    final result = await getVendorsUseCase(
      const GetVendorsParams(
        isTopOffers: true,
        pageSize: 10,
      ),
    );

    result.fold(
      (failure) => emit(
        VendorsError(FailureMessageMapper.mapVendorFailureToMessage(failure)),
      ),
      (vendors) => emit(
        VendorsLoaded(
          vendors: vendors,
          hasReachedMax: true,
          currentPage: 1,
        ),
      ),
    );
  }
}
