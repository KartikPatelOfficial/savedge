import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/brand_voucher_entity.dart';
import '../repositories/brand_voucher_repository.dart';

@injectable
class GetBrandVouchersUseCase
    implements UseCase<List<BrandVoucherEntity>, GetBrandVouchersParams> {
  final BrandVoucherRepository repository;

  GetBrandVouchersUseCase(this.repository);

  @override
  Future<Either<Failure, List<BrandVoucherEntity>>> call(
    GetBrandVouchersParams params,
  ) async {
    return await repository.getBrandVouchers(
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
      isActive: params.isActive,
      searchTerm: params.searchTerm,
    );
  }
}

class GetBrandVouchersParams extends Equatable {
  final int pageNumber;
  final int pageSize;
  final bool? isActive;
  final String? searchTerm;

  const GetBrandVouchersParams({
    this.pageNumber = 1,
    this.pageSize = 10,
    this.isActive,
    this.searchTerm,
  });

  @override
  List<Object?> get props => [pageNumber, pageSize, isActive, searchTerm];
}
