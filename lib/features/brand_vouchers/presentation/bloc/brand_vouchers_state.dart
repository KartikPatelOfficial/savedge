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

// Razorpay payment states
class RazorpayOrderCreating extends BrandVouchersState {}

class RazorpayOrderCreated extends BrandVouchersState {
  final String orderId;
  final int amount;
  final String currency;
  final int voucherOrderId;
  final String brandName;
  final double voucherAmount;
  final double processingFee;
  final double totalAmount;
  final String razorpayKey;

  const RazorpayOrderCreated({
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.voucherOrderId,
    required this.brandName,
    required this.voucherAmount,
    required this.processingFee,
    required this.totalAmount,
    required this.razorpayKey,
  });

  @override
  List<Object> get props => [
        orderId,
        amount,
        currency,
        voucherOrderId,
        brandName,
        voucherAmount,
        processingFee,
        totalAmount,
        razorpayKey,
      ];
}

class RazorpayOrderError extends BrandVouchersState {
  final String message;

  const RazorpayOrderError(this.message);

  @override
  List<Object> get props => [message];
}

class RazorpayPaymentVerifying extends BrandVouchersState {}

class RazorpayPaymentVerified extends BrandVouchersState {
  final int voucherOrderId;
  final String message;

  const RazorpayPaymentVerified({
    required this.voucherOrderId,
    required this.message,
  });

  @override
  List<Object> get props => [voucherOrderId, message];
}

class RazorpayPaymentError extends BrandVouchersState {
  final String message;

  const RazorpayPaymentError(this.message);

  @override
  List<Object> get props => [message];
}