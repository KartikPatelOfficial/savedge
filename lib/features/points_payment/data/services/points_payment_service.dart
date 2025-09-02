import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:savedge/core/constants/app_constants.dart';
import 'package:savedge/features/points_payment/data/models/points_payment_models.dart';

part 'points_payment_service.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
@injectable
abstract class PointsPaymentService {
  @factoryMethod
  factory PointsPaymentService(Dio dio) = _PointsPaymentService;

  @POST('/api/points-payment/initiate')
  Future<InitiatePointsPaymentResponse> initiatePayment(
    @Body() InitiatePointsPaymentRequest request,
  );

  @POST('/api/points-payment/verify-otp')
  Future<VerifyPointsPaymentOtpResponse> verifyOtp(
    @Body() VerifyPointsPaymentOtpRequest request,
  );

  @GET('/api/points-payment/balance')
  Future<UserPointsBalanceResponse> getBalance();

  @GET('/api/points-payment/transaction/{id}')
  Future<PointsPaymentDetailsResponse> getPaymentDetails(@Path('id') String id);
}