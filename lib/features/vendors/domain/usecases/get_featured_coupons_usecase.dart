import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/domain/repositories/coupons_repository.dart';

/// Use case for getting featured coupons for offers section
@injectable
class GetFeaturedCouponsUseCase implements UseCase<List<Coupon>, GetFeaturedCouponsParams> {
  const GetFeaturedCouponsUseCase(this._repository);

  final CouponsRepository _repository;

  @override
  Future<Either<Failure, List<Coupon>>> call(GetFeaturedCouponsParams params) async {
    return _repository.getFeaturedCoupons(
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
      isActive: params.isActive,
      isExpired: params.isExpired,
    );
  }
}

class GetFeaturedCouponsParams extends Equatable {
  const GetFeaturedCouponsParams({
    this.pageNumber = 1,
    this.pageSize = 5,
    this.isActive = true,
    this.isExpired = false,
  });

  final int pageNumber;
  final int pageSize;
  final bool isActive;
  final bool isExpired;

  @override
  List<Object> get props => [pageNumber, pageSize, isActive, isExpired];
}
