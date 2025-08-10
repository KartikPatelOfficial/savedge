import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:savedge/features/auth/data/models/auth_models.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) = _AuthRemoteDataSource;

  @POST('/api/auth/sync')
  Future<UserProfileResponse> syncUser(@Body() SyncUserRequest request);

  @GET('/api/auth/profile')
  Future<UserProfileResponse> getProfile();

  @POST('/api/auth/validate-token')
  Future<HttpResponse<dynamic>> validateToken(@Body() ValidateTokenRequest request);

  // Extended user profile endpoints
  @GET('/api/users/profile')
  Future<UserProfileResponse2> getUserProfile();

  @PUT('/api/users/profile')
  Future<UserProfileResponse2> updateUserProfile(@Body() UpdateUserProfileRequest request);

  // New phone-based authentication flow endpoints
  @POST('/api/users/check-exists')
  Future<CheckUserExistsResponse> checkUserExists(@Body() CheckUserExistsRequest request);

  @POST('/api/employees/check-by-phone')
  Future<EmployeeInfoResponse> checkEmployeeByPhone(@Body() CheckEmployeeByPhoneRequest request);

  @POST('/api/employees/register-by-phone')
  Future<PhoneRegistrationResponse> registerEmployeeByPhone(@Body() RegisterEmployeeByPhoneRequest request);

  @POST('/api/users/register-with-phone')
  Future<PhoneRegistrationResponse> registerUserByPhone(@Body() RegisterUserByPhoneRequest request);
}
