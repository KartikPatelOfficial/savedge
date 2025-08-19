import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/brand_voucher_entity.dart';
import '../repositories/brand_voucher_repository.dart';

@injectable
class GetVoucherOrdersUseCase
    implements UseCase<List<VoucherOrderEntity>, GetVoucherOrdersParams> {
  final BrandVoucherRepository repository;

  GetVoucherOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, List<VoucherOrderEntity>>> call(
      GetVoucherOrdersParams params) async {
    return await repository.getVoucherOrders(
      status: params.status,
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
    );
  }
}

class GetVoucherOrdersParams extends Equatable {
  final VoucherOrderStatusEntity? status;
  final int pageNumber;
  final int pageSize;

  const GetVoucherOrdersParams({
    this.status,
    this.pageNumber = 1,
    this.pageSize = 10,
  });

  @override
  List<Object?> get props => [status, pageNumber, pageSize];
}