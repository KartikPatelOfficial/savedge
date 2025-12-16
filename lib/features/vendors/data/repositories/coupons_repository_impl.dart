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
        isExpired: isExpired,
      );

      final coupons = _sortCouponsByPriority(
        response.items.map(_mapResponseToEntity).toList(),
      );
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
    String? status = 'active',
    bool isExpired = false,
  }) async {
    try {
      final response = await _remoteDataSource.getVendorCoupons(
        vendorId,
        pageNumber: pageNumber,
        pageSize: pageSize,
        status: status,
        isExpired: isExpired,
      );

      final coupons = _sortCouponsByPriority(
        response.items.map(_mapResponseToEntity).toList(),
      );
      return Right(coupons);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Coupon>>> getFeaturedCoupons({
    int pageNumber = 1,
    int pageSize = 5,
    String? status = 'active',
    bool isExpired = false,
  }) async {
    try {
      final response = await _remoteDataSource.getFeaturedCoupons(
        pageNumber: pageNumber,
        pageSize: pageSize,
        status: status,
        isExpired: isExpired,
      );

      final coupons = _sortCouponsByPriority(
        response.items.map(_mapResponseToEntity).toList(),
      );
      return Right(coupons);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Coupon>>> getSpecialOfferCoupons() async {
    try {
      final response = await _remoteDataSource.getSpecialOfferCoupons();
      
      // Parse the response data
      final data = response.data;
      if (data is List<dynamic>) {
        final coupons = _sortCouponsByPriority(
          data
              .map((item) => CouponResponse.fromJson(item as Map<String, dynamic>))
              .map(_mapResponseToEntity)
              .toList(),
        );
        return Right(coupons);
      } else {
        return const Left(UnexpectedFailure('Invalid response format'));
      }
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  List<Coupon> _sortCouponsByPriority(List<Coupon> coupons) {
    final indexed = coupons.asMap().entries.toList();

    indexed.sort((a, b) {
      final priorityCompare = b.value.specialOfferPriority.compareTo(
        a.value.specialOfferPriority,
      );
      if (priorityCompare != 0) {
        return priorityCompare;
      }
      // Preserve original order for equal priorities to avoid reshuffling.
      return a.key.compareTo(b.key);
    });

    return indexed.map((entry) => entry.value).toList();
  }

  /// Maps API response model to domain entity
  Coupon _mapResponseToEntity(CouponResponse response) {
    return Coupon(
      id: response.id,
      title: response.title,
      description: response.description,
      discountValue: response.discountValue,
      discountType: response.discountType,
      freeItemDescription: response.freeItemDescription,
      minimumOrderAmount: response.minimumOrderAmount,
      maximumDiscountAmount: response.maximumDiscountAmount,
      validFrom: response.validFrom,
      validTo: response.validTo,
      vendorId: response.vendorId,
      vendorUserId: response.vendorUserId,
      status: response.status,
      cashPrice: response.cashPrice,
      termsAndConditions: response.termsAndConditions,
      maxRedemptions: response.maxRedemptions,
      totalClaimed: response.totalClaimed,
      remainingClaims: response.remainingClaims,
      isSpecialOffer: response.isSpecialOffer,
      specialOfferStartDate: response.specialOfferStartDate,
      specialOfferEndDate: response.specialOfferEndDate,
      specialOfferPriority: response.specialOfferPriority,
      specialOfferImageUrl: response.specialOfferImageUrl,
    );
  }
}
