part of 'coupons_bloc.dart';

/// Base class for coupons states
abstract class CouponsState extends Equatable {
  const CouponsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class CouponsInitial extends CouponsState {}

/// Loading state
class CouponsLoading extends CouponsState {}

/// State when coupons are successfully loaded
class CouponsLoaded extends CouponsState {
  const CouponsLoaded(this.coupons);

  final List<Coupon> coupons;

  @override
  List<Object> get props => [coupons];
}

/// Error state
class CouponsError extends CouponsState {
  const CouponsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
