import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/domain/repositories/coupons_repository.dart';

/// Use case for getting special offer coupons for hot deals section
@injectable
class GetSpecialOfferCouponsUseCase
    implements UseCase<List<Coupon>, GetSpecialOfferCouponsParams> {
  const GetSpecialOfferCouponsUseCase(this._repository);

  final CouponsRepository _repository;

  @override
  Future<Either<Failure, List<Coupon>>> call(
    GetSpecialOfferCouponsParams params,
  ) async {
    return _repository.getSpecialOfferCoupons(cityId: params.cityId);
  }
}

/// Parameters for GetSpecialOfferCouponsUseCase
class GetSpecialOfferCouponsParams extends Equatable {
  const GetSpecialOfferCouponsParams({this.cityId});

  final int? cityId;

  @override
  List<Object?> get props => [cityId];
}