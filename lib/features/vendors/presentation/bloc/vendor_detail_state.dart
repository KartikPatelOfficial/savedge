import 'package:equatable/equatable.dart';

import 'package:savedge/features/vendors/domain/entities/vendor.dart';

/// Base class for vendor detail states
abstract class VendorDetailState extends Equatable {
  const VendorDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state before loading vendor details
class VendorDetailInitial extends VendorDetailState {}

/// State when vendor details are being loaded
class VendorDetailLoading extends VendorDetailState {}

/// State when vendor details are successfully loaded
class VendorDetailLoaded extends VendorDetailState {
  const VendorDetailLoaded(this.vendor);

  final Vendor vendor;

  @override
  List<Object?> get props => [vendor];
}

/// State when there's an error loading vendor details
class VendorDetailError extends VendorDetailState {
  const VendorDetailError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
