part of 'brand_vouchers_bloc.dart';

abstract class BrandVouchersState extends Equatable {
  const BrandVouchersState();

  @override
  List<Object?> get props => [];
}

class BrandVouchersInitial extends BrandVouchersState {}

class BrandVouchersLoading extends BrandVouchersState {}

class BrandVouchersLoaded extends BrandVouchersState {
  final List<BrandVoucherEntity> vouchers;

  const BrandVouchersLoaded(this.vouchers);

  @override
  List<Object> get props => [vouchers];
}

class BrandVouchersError extends BrandVouchersState {
  final String message;

  const BrandVouchersError(this.message);

  @override
  List<Object> get props => [message];
}

class VoucherOrderCreating extends BrandVouchersState {}

class VoucherOrderCreated extends BrandVouchersState {
  final int orderId;

  const VoucherOrderCreated(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class VoucherOrderError extends BrandVouchersState {
  final String message;

  const VoucherOrderError(this.message);

  @override
  List<Object> get props => [message];
}

class VoucherOrdersLoading extends BrandVouchersState {}

class VoucherOrdersLoaded extends BrandVouchersState {
  final List<VoucherOrderEntity> orders;

  const VoucherOrdersLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class VoucherOrdersError extends BrandVouchersState {
  final String message;

  const VoucherOrdersError(this.message);

  @override
  List<Object> get props => [message];
}