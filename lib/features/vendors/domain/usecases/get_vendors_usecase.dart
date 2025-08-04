import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/vendor.dart';
import '../repositories/vendors_repository.dart';

class GetVendorsUseCase implements UseCase<List<Vendor>, GetVendorsParams> {
  const GetVendorsUseCase(this.repository);

  final VendorsRepository repository;

  @override
  Future<Either<Failure, List<Vendor>>> call(GetVendorsParams params) async {
    return repository.getVendors(
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
      searchTerm: params.searchTerm,
      category: params.category,
      businessType: params.businessType,
      isApproved: params.isApproved,
      isActive: params.isActive,
    );
  }
}

class GetVendorsParams {
  const GetVendorsParams({
    this.pageNumber = 1,
    this.pageSize = 10,
    this.searchTerm,
    this.category,
    this.businessType,
    this.isApproved = true,
    this.isActive = true,
  });

  final int pageNumber;
  final int pageSize;
  final String? searchTerm;
  final String? category;
  final String? businessType;
  final bool? isApproved;
  final bool? isActive;
}
