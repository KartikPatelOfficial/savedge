import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:savedge/features/auth/data/models/auth_requests.dart';
import 'package:savedge/features/auth/data/models/auth_responses.dart';

part 'auth_remote_data_source.g.dart';

/// Remote data source for authentication API calls
@RestApi()
abstract class AuthRemoteDataSource {
  factory AuthRemoteDataSource(Dio dio, {String baseUrl}) = _AuthRemoteDataSource;

  /// Syncs user profile with backend
  @POST('/api/auth/sync')
  Future<UserProfileResponse> syncUserProfile(@Body() SyncUserRequest request);

  /// Gets user profile
  @GET('/api/auth/profile')
  Future<UserProfileResponse> getUserProfile();

  /// Validates Firebase ID token
  @POST('/api/auth/validate-token')
  Future<void> validateToken(@Body() ValidateTokenRequest request);

  /// Registers a new user
  @POST('/api/users/register')
  Future<UserRegistrationResponse> registerUser(@Body() UserRegistrationRequest request);

  /// Gets detailed user profile
  @GET('/api/users/profile')
  Future<UserProfileResponse2> getUserProfileDetailed();

  /// Updates user profile
  @PUT('/api/users/profile')
  Future<UserProfileResponse2> updateUserProfile(@Body() UpdateUserProfileRequest request);

  /// Checks if user exists
  @POST('/api/users/check-exists')
  Future<UserExistsResponse> checkUserExists();

  /// Changes user organization
  @POST('/api/users/{userId}/change-organization')
  Future<UserProfileResponse2> changeUserOrganization(
    @Path('userId') String userId,
    @Body() ChangeOrganizationRequest request,
  );

  /// Removes user from organization
  @POST('/api/users/{userId}/remove-from-organization')
  Future<UserProfileResponse2> removeUserFromOrganization(@Path('userId') String userId);
}
