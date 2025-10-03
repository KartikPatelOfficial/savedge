import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/brand_voucher_entity.dart';

abstract class BrandVoucherRepository {
  Future<Either<Failure, List<BrandVoucherEntity>>> getBrandVouchers({
    bool? isActive,
    String? searchTerm,
  });

  Future<Either<Failure, BrandVoucherEntity>> getBrandVoucher(int id);

  Future<Either<Failure, int>> createVoucherOrder({
    required String userId,
    required int brandVoucherId,
    required double voucherAmount,
  });

  Future<Either<Failure, List<VoucherOrderEntity>>> getVoucherOrders({
    VoucherOrderStatusEntity? status,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<Failure, VoucherOrderEntity>> getVoucherOrder(int id);
}