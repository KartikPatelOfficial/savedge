import 'package:equatable/equatable.dart';

/// Base class for vendor detail events
abstract class VendorDetailEvent extends Equatable {
  const VendorDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load detailed vendor information
class LoadVendorDetail extends VendorDetailEvent {
  const LoadVendorDetail(this.vendorId);

  final int vendorId;

  @override
  List<Object?> get props => [vendorId];
}

/// Event to refresh vendor details
class RefreshVendorDetail extends VendorDetailEvent {
  const RefreshVendorDetail(this.vendorId);

  final int vendorId;

  @override
  List<Object?> get props => [vendorId];
}
