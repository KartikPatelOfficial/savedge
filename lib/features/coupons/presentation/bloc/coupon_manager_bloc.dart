import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/coupon_gifting_models.dart';
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
    on<FilterByStatus>(_onFilterByStatus);
    on<FilterByCategory>(_onFilterByCategory);
    on<FilterByVendor>(_onFilterByVendor);
    on<ClearAllFilters>(_onClearAllFilters);
    on<ApplyFilters>(_onApplyFilters);
  }

  final EnhancedCouponService _enhancedCouponService;

  Future<void> _onLoadAllCoupons(
    LoadAllCoupons event,
    Emitter<CouponManagerState> emit,
  ) async {
    emit(const CouponManagerLoading());

    try {
      final couponsData = await _enhancedCouponService.getMyCoupons();
      emit(CouponManagerLoaded(couponsData: couponsData));
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
      emit(CouponManagerLoaded(couponsData: couponsData));
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
      emit(CouponManagerLoaded(couponsData: couponsData));
    } catch (e) {
      emit(CouponManagerError('Failed to load coupons: ${e.toString()}'));
    }
  }

  void _onFilterByStatus(
    FilterByStatus event,
    Emitter<CouponManagerState> emit,
  ) {
    if (state is! CouponManagerLoaded) return;

    final currentState = state as CouponManagerLoaded;
    final filtered = _applyFilters(
      currentState.couponsData,
      status: event.status,
      categories: currentState.selectedCategories,
      vendorId: currentState.selectedVendorId,
    );

    emit(currentState.copyWith(
      filteredCoupons: filtered,
      selectedStatus: event.status,
    ));
  }

  void _onFilterByCategory(
    FilterByCategory event,
    Emitter<CouponManagerState> emit,
  ) {
    if (state is! CouponManagerLoaded) return;

    final currentState = state as CouponManagerLoaded;
    // Convert single category to list for backward compatibility
    final categories = event.category != null && event.category != 'All'
        ? [event.category!]
        : null;
    final filtered = _applyFilters(
      currentState.couponsData,
      status: currentState.selectedStatus,
      categories: categories,
      vendorId: currentState.selectedVendorId,
    );

    emit(currentState.copyWith(
      filteredCoupons: filtered,
      selectedCategories: categories,
    ));
  }

  void _onFilterByVendor(
    FilterByVendor event,
    Emitter<CouponManagerState> emit,
  ) {
    if (state is! CouponManagerLoaded) return;

    final currentState = state as CouponManagerLoaded;
    final filtered = _applyFilters(
      currentState.couponsData,
      status: currentState.selectedStatus,
      categories: currentState.selectedCategories,
      vendorId: event.vendorId,
    );

    emit(currentState.copyWith(
      filteredCoupons: filtered,
      selectedVendorId: event.vendorId,
    ));
  }

  void _onClearAllFilters(
    ClearAllFilters event,
    Emitter<CouponManagerState> emit,
  ) {
    if (state is! CouponManagerLoaded) return;

    final currentState = state as CouponManagerLoaded;
    emit(currentState.copyWith(clearFilters: true));
  }

  void _onApplyFilters(
    ApplyFilters event,
    Emitter<CouponManagerState> emit,
  ) {
    if (state is! CouponManagerLoaded) return;

    final currentState = state as CouponManagerLoaded;
    final filtered = _applyFilters(
      currentState.couponsData,
      status: event.status,
      categories: event.categories,
      vendorId: event.vendorId,
    );

    emit(currentState.copyWith(
      filteredCoupons: filtered,
      selectedStatus: event.status,
      selectedCategories: event.categories,
      selectedVendorId: event.vendorId,
    ));
  }

  /// Apply filters to coupons
  List<UserCouponDetailModel> _applyFilters(
    UserCouponsResponseModel couponsData, {
    String? status,
    List<String>? categories,
    int? vendorId,
  }) {
    // Get all coupons
    List<UserCouponDetailModel> allCoupons = [
      ...couponsData.purchasedCoupons,
      ...couponsData.giftedReceivedCoupons,
      ...couponsData.usedCoupons,
      ...couponsData.expiredCoupons,
    ];

    // Filter by status
    if (status != null && status != 'All') {
      switch (status) {
        case 'Active':
          allCoupons = allCoupons.where((c) => c.isActive).toList();
          break;
        case 'Used':
          allCoupons = allCoupons.where((c) => c.isUsed).toList();
          break;
        case 'Expired':
          allCoupons = allCoupons.where((c) => c.isExpired).toList();
          break;
      }
    }

    // Filter by categories (multiple categories with OR logic)
    if (categories != null && categories.isNotEmpty) {
      allCoupons = allCoupons.where((c) {
        // Check if coupon's category matches any of the selected categories
        for (final category in categories) {
          final categoryLower = category.toLowerCase();

          // First, check backend vendorCategory field (now populated from API)
          if (c.vendorCategory.isNotEmpty) {
            if (c.vendorCategory.toLowerCase() == categoryLower) {
              return true;
            }
          }

          // Fallback: Search in vendor name and title for category keywords
          final searchText = '${c.vendorName} ${c.title}'.toLowerCase();
          if (searchText.contains(categoryLower)) {
            return true;
          }
        }
        return false;
      }).toList();
    }

    // Filter by vendor
    if (vendorId != null) {
      allCoupons = allCoupons.where((c) => c.vendorId == vendorId).toList();
    }

    // Sort by expiry date (soonest first for active coupons)
    allCoupons.sort((a, b) {
      if (a.isActive && !b.isActive) return -1;
      if (!a.isActive && b.isActive) return 1;
      return a.expiryDate.compareTo(b.expiryDate);
    });

    // Return all filtered coupons (no artificial limit)
    return allCoupons;
  }
}
