import 'package:equatable/equatable.dart';

abstract class CouponManagerEvent extends Equatable {
  const CouponManagerEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllCoupons extends CouponManagerEvent {
  const LoadAllCoupons();
}

class RefreshAllCoupons extends CouponManagerEvent {
  const RefreshAllCoupons();
}

class LoadCouponsByCategory extends CouponManagerEvent {
  const LoadCouponsByCategory(this.category);

  final String category;

  @override
  List<Object?> get props => [category];
}

class FilterByStatus extends CouponManagerEvent {
  const FilterByStatus(this.status);

  final String? status; // 'All', 'Active', 'Used', 'Expired', or null

  @override
  List<Object?> get props => [status];
}

class FilterByCategory extends CouponManagerEvent {
  const FilterByCategory(this.category);

  final String? category; // Category name or null for 'All'

  @override
  List<Object?> get props => [category];
}

class FilterByVendor extends CouponManagerEvent {
  const FilterByVendor(this.vendorId);

  final int? vendorId; // Vendor ID or null for 'All'

  @override
  List<Object?> get props => [vendorId];
}

class ClearAllFilters extends CouponManagerEvent {
  const ClearAllFilters();
}

class ApplyFilters extends CouponManagerEvent {
  const ApplyFilters({
    this.status,
    this.categories,
    this.vendorId,
  });

  final String? status;
  final List<String>? categories;
  final int? vendorId;

  @override
  List<Object?> get props => [status, categories, vendorId];
}
