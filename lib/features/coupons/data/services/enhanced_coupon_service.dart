import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/coupon_gifting_models.dart';

part 'enhanced_coupon_service.g.dart';

@RestApi()
abstract class EnhancedCouponService {
  factory EnhancedCouponService(Dio dio, {String baseUrl}) =
      _EnhancedCouponService;

  @GET('/api/user/coupons')
  Future<UserCouponsResponseModel> getMyCoupons({
    @Query('category') String? category,
  });

  @GET('/api/user/coupons')
  Future<UserCouponsResponseModel> getMyCouponsByCategory(
    @Query('category') String category,
  );
}
