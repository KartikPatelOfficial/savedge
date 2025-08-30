import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/domain/repositories/coupons_repository.dart';

/// Use case for getting coupons for a specific vendor
@injectable
class GetVendorCouponsUseCase
    implements UseCase<List<Coupon>, GetVendorCouponsParams> {
  const GetVendorCouponsUseCase(this._repository);

  final CouponsRepository _repository;

  @override
  Future<Either<Failure, List<Coupon>>> call(
    GetVendorCouponsParams params,
  ) async {
    return _repository.getVendorCoupons(
      params.vendorId,
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
      status: params.status,
      isExpired: params.isExpired,
    );
  }
}

class GetVendorCouponsParams extends Equatable {
  const GetVendorCouponsParams({
    required this.vendorId,
    this.pageNumber = 1,
    this.pageSize = 10,
    this.status = 'active',
    this.isExpired = false,
  });

  final int vendorId;
  final int pageNumber;
  final int pageSize;
  final String? status;
  final bool isExpired;

  @override
  List<Object?> get props => [
    vendorId,
    pageNumber,
    pageSize,
    status,
    isExpired,
  ];
}
