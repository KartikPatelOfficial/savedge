import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';

part 'otp_auth_remote_data_source.g.dart';

@RestApi()
abstract class OtpAuthRemoteDataSource {
  factory OtpAuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _OtpAuthRemoteDataSource;

  @POST('/api/user-auth/send-otp')
  Future<OtpResponse> sendOtp(@Body() SendOtpRequest request);

  @POST('/api/user-auth/verify-otp')
  Future<UserVerificationResponse> verifyOtp(@Body() VerifyOtpRequest request);

  @POST('/api/user-auth/register-individual')
  Future<IndividualRegistrationResponse> registerIndividual(
    @Body() RegisterIndividualRequest request,
  );
}