import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';

part 'otp_auth_remote_data_source.g.dart';

@RestApi()
abstract class OtpAuthRemoteDataSource {
  factory OtpAuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _OtpAuthRemoteDataSource;

  /// Sends a login OTP to the phone number. The backend delivers the OTP via
  /// SMS (Twilio Verify); no client-side OTP provider is involved.
  @POST('/api/v1/auth/user-auth/send-otp')
  Future<OtpResponse> sendLoginOtp(@Body() SendOtpRequest request);

  /// Verifies the login OTP and returns the user's verification status plus
  /// session tokens for existing users.
  @POST('/api/v1/auth/user-auth/verify-otp')
  Future<UserVerificationResponse> verifyLoginOtp(
    @Body() VerifyOtpRequest request,
  );

  /// Legacy server-driven OTP send. Used for OTP-gated in-app actions
  /// (e.g. confirming the sender's phone before gifting a coupon).
  @POST('/api/auth/user-auth/send-otp')
  Future<OtpResponse> sendOtp(@Body() SendOtpRequest request);

  /// Legacy server-driven OTP verify. Paired with [sendOtp].
  @POST('/api/auth/user-auth/verify-otp')
  Future<OtpResponse> verifyOtp(@Body() VerifyOtpRequest request);

  @POST('/api/auth/user-auth/register-individual')
  Future<IndividualRegistrationResponse> registerIndividual(
    @Body() RegisterIndividualRequest request,
  );
}
