import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';
import 'package:savedge/features/vendors/domain/repositories/coupons_repository.dart';
import 'package:savedge/features/vendors/data/datasources/coupons_remote_data_source.dart';
import 'package:savedge/features/vendors/data/models/coupon_models.dart';

/// Implementation of CouponsRepository using real API
@LazySingleton(as: CouponsRepository)
class CouponsRepositoryImpl implements CouponsRepository {
  const CouponsRepositoryImpl(this._remoteDataSource);

  final CouponsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<Coupon>>> getCoupons({
    int pageNumber = 1,
    int pageSize = 10,
    String? searchTerm,
    int? vendorId,
    String? discountType,
    String? status,
    bool? isActive,
    bool? isExpired,
  }) async {
    try {
      final response = await _remoteDataSource.getCoupons(
        pageNumber: pageNumber,
        pageSize: pageSize,
        searchTerm: searchTerm,
        vendorId: vendorId,
        discountType: discountType,
        status: status,
        isActive: isActive,
        isExpired: isExpired,
      );

      final coupons = response.items.map(_mapResponseToEntity).toList();
      return Right(coupons);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Coupon>>> getVendorCoupons(
    int vendorId, {
    int pageNumber = 1,
    int pageSize = 10,
    bool isActive = true,
    bool isExpired = false,
  }) async {
    try {
      final response = await _remoteDataSource.getVendorCoupons(
        vendorId,
        pageNumber: pageNumber,
        pageSize: pageSize,
        isActive: isActive,
        isExpired: isExpired,
      );

      final coupons = response.items.map(_mapResponseToEntity).toList();
      return Right(coupons);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Coupon>>> getFeaturedCoupons({
    int pageNumber = 1,
    int pageSize = 5,
    bool isActive = true,
    bool isExpired = false,
  }) async {
    try {
      final response = await _remoteDataSource.getFeaturedCoupons(
        pageNumber: pageNumber,
        pageSize: pageSize,
        isActive: isActive,
        isExpired: isExpired,
      );

      final coupons = response.items.map(_mapResponseToEntity).toList();
      return Right(coupons);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  /// Maps API response model to domain entity
  Coupon _mapResponseToEntity(CouponResponse response) {
    return Coupon(
      id: response.id,
      title: response.title,
      description: response.description,
      discountValue: response.discountValue,
      discountType: response.discountType,
      minimumOrderAmount: response.minimumOrderAmount,
      maximumDiscountAmount: response.maximumDiscountAmount,
      validFrom: response.validFrom,
      validTo: response.validTo,
      isActive: response.isActive,
      vendorId: response.vendorId,
      status: response.status,
      termsAndConditions: response.termsAndConditions,
      usageCount: response.usageCount,
      maxUsageCount: response.maxUsageCount,
    );
  }
}
