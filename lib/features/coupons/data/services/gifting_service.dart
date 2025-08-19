import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/coupon_gifting_models.dart';

part 'gifting_service.g.dart';

@RestApi()
abstract class GiftingService {
  factory GiftingService(Dio dio, {String baseUrl}) = _GiftingService;

  @GET('/api/gifting/colleagues')
  Future<List<ColleagueModel>> getColleagues();

  @POST('/api/gifting/coupon')
  Future<GiftCouponResponse> giftCoupon(@Body() GiftCouponRequest request);

  @POST('/api/gifting/points')
  Future<TransferPointsResponse> transferPoints(
    @Body() TransferPointsRequest request,
  );

  @GET('/api/gifting/coupons/history')
  Future<GiftedCouponsHistoryResponseModel> getGiftedCouponsHistory();

  @GET('/api/gifting/points/history')
  Future<List<PointsTransferHistoryModel>> getPointsTransferHistory();
}
