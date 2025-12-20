import 'package:dartz/dartz.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart';

/// Repository interface for coupons
abstract class CouponsRepository {
  /// Gets paginated list of coupons
  Future<Either<Failure, List<Coupon>>> getCoupons({
    int pageNumber = 1,
    int pageSize = 10,
    String? searchTerm,
    int? vendorId,
    String? discountType,
    String? status,
    bool? isExpired,
  });

  /// Gets coupons for a specific vendor
  Future<Either<Failure, List<Coupon>>> getVendorCoupons(
    int vendorId, {
    int pageNumber = 1,
    int pageSize = 10,
    String? status = 'active',
    bool isExpired = false,
  });

  /// Gets featured/active coupons for offers section
  Future<Either<Failure, List<Coupon>>> getFeaturedCoupons({
    int pageNumber = 1,
    int pageSize = 5,
    String? status = 'active',
    bool isExpired = false,
  });

  /// Gets special offer coupons for hot deals section
  Future<Either<Failure, List<Coupon>>> getSpecialOfferCoupons({int? cityId});
}
