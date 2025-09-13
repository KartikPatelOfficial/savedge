import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/domain/repositories/coupons_repository.dart';

/// Use case for getting special offer coupons for hot deals section
@injectable
class GetSpecialOfferCouponsUseCase
    implements UseCase<List<Coupon>, NoParams> {
  const GetSpecialOfferCouponsUseCase(this._repository);

  final CouponsRepository _repository;

  @override
  Future<Either<Failure, List<Coupon>>> call(NoParams params) async {
    return _repository.getSpecialOfferCoupons();
  }
}