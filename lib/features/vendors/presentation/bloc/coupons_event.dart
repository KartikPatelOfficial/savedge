part of 'coupons_bloc.dart';

/// Base class for coupons events
abstract class CouponsEvent extends Equatable {
  const CouponsEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load featured coupons
class LoadFeaturedCoupons extends CouponsEvent {
  const LoadFeaturedCoupons({this.pageNumber = 1, this.pageSize = 5});

  final int pageNumber;
  final int pageSize;

  @override
  List<Object> get props => [pageNumber, pageSize];
}

/// Event to refresh featured coupons
class RefreshFeaturedCoupons extends CouponsEvent {
  const RefreshFeaturedCoupons();
}

/// Event to load vendor-specific coupons
class LoadVendorCoupons extends CouponsEvent {
  const LoadVendorCoupons({
    required this.vendorId,
    this.pageNumber = 1,
    this.pageSize = 10,
    this.isActive = true,
    this.isExpired = false,
  });

  final int vendorId;
  final int pageNumber;
  final int pageSize;
  final bool isActive;
  final bool isExpired;

  @override
  List<Object> get props => [
    vendorId,
    pageNumber,
    pageSize,
    isActive,
    isExpired,
  ];
}

/// Event to refresh vendor-specific coupons
class RefreshVendorCoupons extends CouponsEvent {
  const RefreshVendorCoupons({required this.vendorId});

  final int vendorId;

  @override
  List<Object> get props => [vendorId];
}
