import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:savedge/features/auth/data/models/auth_models.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _AuthRemoteDataSource;

  @POST('/api/auth/sync')
  Future<UserProfileResponse> syncUser(@Body() SyncUserRequest request);

  @GET('/api/auth/profile')
  Future<UserProfileResponse> getProfile();

  @POST('/api/auth/validate-token')
  Future<HttpResponse<dynamic>> validateToken(
    @Body() ValidateTokenRequest request,
  );

  // Extended user profile endpoints
  @GET('/api/users/me')
  Future<UserProfileResponse3> getUserProfile();

  @PUT('/api/users/me')
  Future<UserProfileResponse3> updateUserProfile(
    @Body() UpdateUserProfileRequest3 request,
  );

  @DELETE('/api/users/me')
  Future<HttpResponse<void>> deleteCurrentUserAccount();

  // Unified authentication flow endpoints
  @POST('/api/users/check-auth-status')
  Future<AuthStatusResponse> checkAuthStatus();

  @POST('/api/employees/check-by-phone')
  Future<EmployeeInfoResponse> checkEmployeeByPhone(
    @Body() CheckEmployeeByPhoneRequest request,
  );

  @POST('/api/users/register-individual')
  Future<PhoneRegistrationResponse> registerIndividualUser(
    @Body() IndividualRegistrationRequest request,
  );

  @POST('/api/users/register-employee')
  Future<PhoneRegistrationResponse> registerEmployeeUser(
    @Body() EmployeeRegistrationRequest request,
  );

  // Legacy endpoints - deprecated
  @POST('/api/users/check-exists')
  Future<CheckUserExistsResponse> checkUserExists(
    @Body() CheckUserExistsRequest request,
  );

  @POST('/api/employees/register-by-phone')
  Future<PhoneRegistrationResponse> registerEmployeeByPhone(
    @Body() RegisterEmployeeByPhoneRequest request,
  );

  @POST('/api/users/register-with-phone')
  Future<PhoneRegistrationResponse> registerUserByPhone(
    @Body() RegisterUserByPhoneRequest request,
  );
}
