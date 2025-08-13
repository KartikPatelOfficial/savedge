import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/domain/repositories/vendors_repository.dart';

/// Use case for retrieving a paginated list of vendors
///
/// This use case handles the business logic for fetching vendors
/// with optional filtering by search term, category, and business type.
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

/// Parameters for the GetVendorsUseCase
class GetVendorsParams extends Equatable {
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

  @override
  List<Object?> get props => [
    pageNumber,
    pageSize,
    searchTerm,
    category,
    businessType,
    isApproved,
    isActive,
  ];
}
