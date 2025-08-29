import 'package:savedge/features/auth/domain/entities/user_profile.dart';
import 'package:savedge/features/auth/domain/entities/extended_user_profile.dart';
import 'package:savedge/features/auth/data/models/auth_models.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';

abstract class AuthRepository {
  Future<UserProfile> syncUser({required String email, String? displayName});
  Future<UserProfile> getProfile();
  Future<void> validateToken(String idToken);
  Future<UserProfile> updateProfile({
    required String email,
    String? firstName,
    String? lastName,
  });
  Future<ExtendedUserProfile> getUserProfileExtended();
  Future<UserProfileResponse3> getCurrentUserProfile();
  Future<UserProfileResponse3> updateCurrentUserProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? profileImageUrl,
  });

  // Unified authentication flow methods
  Future<AuthStatusResponse> checkAuthStatus();
  Future<EmployeeInfoResponse?> checkEmployeeByPhone(String phoneNumber);
  Future<PhoneRegistrationResponse> registerIndividualUser({
    required String email,
    required String firstName,
    required String lastName,
  });
  Future<PhoneRegistrationResponse> registerEmployeeUser({
    required String email,
    required String firstName,
    required String lastName,
  });

  // Legacy methods - kept for compatibility
  Future<CheckUserExistsResponse> checkUserExists(String firebaseUid);
  Future<PhoneRegistrationResponse> registerEmployeeByPhone({
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
  });
  Future<PhoneRegistrationResponse> registerUserByPhone({
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
  });
}
