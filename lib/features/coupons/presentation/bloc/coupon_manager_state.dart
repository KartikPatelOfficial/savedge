import 'package:equatable/equatable.dart';

import '../../data/models/coupon_gifting_models.dart';

abstract class CouponManagerState extends Equatable {
  const CouponManagerState();

  @override
  List<Object?> get props => [];
}

class CouponManagerInitial extends CouponManagerState {
  const CouponManagerInitial();
}

class CouponManagerLoading extends CouponManagerState {
  const CouponManagerLoading();
}

class CouponManagerLoaded extends CouponManagerState {
  const CouponManagerLoaded({
    required this.couponsData,
    this.filteredCoupons,
    this.selectedStatus,
    this.selectedCategories,
    this.selectedVendorId,
  });

  final UserCouponsResponseModel couponsData;
  final List<UserCouponDetailModel>? filteredCoupons;
  final String? selectedStatus;
  final List<String>? selectedCategories;
  final int? selectedVendorId;

  @override
  List<Object?> get props => [
        couponsData,
        filteredCoupons,
        selectedStatus,
        selectedCategories,
        selectedVendorId,
      ];

  CouponManagerLoaded copyWith({
    UserCouponsResponseModel? couponsData,
    List<UserCouponDetailModel>? filteredCoupons,
    String? selectedStatus,
    List<String>? selectedCategories,
    int? selectedVendorId,
    bool clearFilters = false,
  }) {
    if (clearFilters) {
      return CouponManagerLoaded(
        couponsData: couponsData ?? this.couponsData,
        filteredCoupons: null,
        selectedStatus: null,
        selectedCategories: null,
        selectedVendorId: null,
      );
    }

    return CouponManagerLoaded(
      couponsData: couponsData ?? this.couponsData,
      filteredCoupons: filteredCoupons ?? this.filteredCoupons,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedVendorId: selectedVendorId ?? this.selectedVendorId,
    );
  }
}

class CouponManagerError extends CouponManagerState {
  const CouponManagerError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
