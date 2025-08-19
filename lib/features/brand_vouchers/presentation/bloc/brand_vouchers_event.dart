part of 'brand_vouchers_bloc.dart';

abstract class BrandVouchersEvent extends Equatable {
  const BrandVouchersEvent();

  @override
  List<Object?> get props => [];
}

class LoadBrandVouchers extends BrandVouchersEvent {
  final int pageNumber;
  final int pageSize;
  final bool? isActive;
  final String? searchTerm;

  const LoadBrandVouchers({
    this.pageNumber = 1,
    this.pageSize = 20,
    this.isActive = true,
    this.searchTerm,
  });

  @override
  List<Object?> get props => [pageNumber, pageSize, isActive, searchTerm];
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