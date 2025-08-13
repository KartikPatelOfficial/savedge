import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:savedge/features/vendors/data/models/coupon_models.dart';

part 'coupons_remote_data_source.g.dart';

/// Remote data source for coupons API calls
@RestApi()
abstract class CouponsRemoteDataSource {
  factory CouponsRemoteDataSource(Dio dio, {String baseUrl}) =
      _CouponsRemoteDataSource;

  /// Gets all coupons with pagination and filtering
  @GET('/api/Coupons')
  Future<GetCouponsResponse> getCoupons({
    @Query('pageNumber') int pageNumber = 1,
    @Query('pageSize') int pageSize = 10,
    @Query('searchTerm') String? searchTerm,
    @Query('vendorId') int? vendorId,
    @Query('discountType') String? discountType,
    @Query('status') String? status,
    @Query('isActive') bool? isActive,
    @Query('isExpired') bool? isExpired,
  });

  /// Gets coupons for a specific vendor
  @GET('/api/Coupons')
  Future<GetCouponsResponse> getVendorCoupons(
    @Query('vendorId') int vendorId, {
    @Query('pageNumber') int pageNumber = 1,
    @Query('pageSize') int pageSize = 10,
    @Query('isActive') bool isActive = true,
    @Query('isExpired') bool isExpired = false,
  });

  /// Gets active coupons for featured offers
  @GET('/api/Coupons')
  Future<GetCouponsResponse> getFeaturedCoupons({
    @Query('pageNumber') int pageNumber = 1,
    @Query('pageSize') int pageSize = 5,
    @Query('isActive') bool isActive = true,
    @Query('isExpired') bool isExpired = false,
  });
}
