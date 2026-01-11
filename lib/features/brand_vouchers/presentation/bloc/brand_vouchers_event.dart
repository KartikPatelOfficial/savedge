part of 'brand_vouchers_bloc.dart';

abstract class BrandVouchersEvent extends Equatable {
  const BrandVouchersEvent();

  @override
  List<Object?> get props => [];
}

class LoadBrandVouchers extends BrandVouchersEvent {
  final bool? isActive;
  final String? searchTerm;

  const LoadBrandVouchers({
    this.isActive = true,
    this.searchTerm,
  });

  @override
  List<Object?> get props => [isActive, searchTerm];
}

class RefreshBrandVouchers extends BrandVouchersEvent {
  const RefreshBrandVouchers();
}

class CreateVoucherOrder extends BrandVouchersEvent {
  final String userId;
  final int brandVoucherId;
  final double voucherAmount;

  const CreateVoucherOrder({
    required this.userId,
    required this.brandVoucherId,
    required this.voucherAmount,
  });

  @override
  List<Object> get props => [userId, brandVoucherId, voucherAmount];
}

class LoadVoucherOrders extends BrandVouchersEvent {
  final VoucherOrderStatusEntity? status;
  final int pageNumber;
  final int pageSize;

  const LoadVoucherOrders({
    this.status,
    this.pageNumber = 1,
    this.pageSize = 20,
  });

  @override
  List<Object?> get props => [status, pageNumber, pageSize];
}

class CreatePineLabsOrder extends BrandVouchersEvent {
  final int brandVoucherId;
  final double voucherAmount;

  const CreatePineLabsOrder({
    required this.brandVoucherId,
    required this.voucherAmount,
  });

  @override
  List<Object> get props => [brandVoucherId, voucherAmount];
}

class CheckPineLabsPaymentStatus extends BrandVouchersEvent {
  final int voucherOrderId;

  const CheckPineLabsPaymentStatus({
    required this.voucherOrderId,
  });

  @override
  List<Object> get props => [voucherOrderId];
}