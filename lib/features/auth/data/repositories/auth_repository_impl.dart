import 'package:savedge/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:savedge/features/auth/data/models/auth_models.dart';
import 'package:savedge/features/auth/domain/entities/user_profile.dart';
import 'package:savedge/features/auth/domain/entities/extended_user_profile.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/subscription/data/models/active_subscription_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remote);
  final AuthRemoteDataSource _remote;

  UserProfile _mapBase({
    required String id,
    required String email,
    String? firstName,
    String? lastName,
    String? firebaseUid,
    int? organizationId,
    int? pointsBalance,
    DateTime? pointsExpiry,
    bool? isActive,
    DateTime? createdAt,
  }) => UserProfile(
    id: id,
    email: email,
    firstName: firstName,
    lastName: lastName,
    firebaseUid: firebaseUid,
    organizationId: organizationId,
    pointsBalance: pointsBalance ?? 0,
    pointsExpiry: pointsExpiry,
    isActive: isActive,
    createdAt: createdAt,
  );

  UserProfile _map(UserProfileResponse r) => _mapBase(
    id: r.id,
    email: r.email,
    firstName: r.firstName,
    lastName: r.lastName,
    firebaseUid: r.firebaseUid,
    organizationId: r.organizationId,
    pointsBalance: r.pointsBalance,
    pointsExpiry: r.pointsExpiry,
    isActive: r.isActive,
    createdAt: r.createdAt,
  );

  UserProfile _map2(UserProfileResponse2 r) => _mapBase(
    id: r.id,
    email: r.email,
    firstName: r.firstName,
    lastName: r.lastName,
    firebaseUid: r.firebaseUid,
    organizationId: r.organizationId,
    pointsBalance: r.pointsBalance,
    pointsExpiry: r.pointsExpiry,
    isActive: r.isActive,
    createdAt: r.createdAt,
  );

  ExtendedUserProfile _mapExtended(UserProfileResponse2 r) =>
      ExtendedUserProfile(
        id: r.id,
        email: r.email,
        firstName: r.firstName,
        lastName: r.lastName,
        firebaseUid: r.firebaseUid,
        organizationId: r.organizationId,
        organizationName: r.organizationName,
        pointsBalance: r.pointsBalance,
        pointsExpiry: r.pointsExpiry,
        isActive: r.isActive,
        createdAt: r.createdAt,
        roles: r.roles,
        isEmployee: r.isEmployee,
        employeeCode: r.employeeCode,
        department: r.department,
        position: r.position,
        joinDate: r.joinDate,
        activeSubscription: r.activeSubscription != null
            ? ActiveSubscriptionModel.fromJson(r.activeSubscription!).toDomain()
            : null,
      );

  @override
  Future<UserProfile> getProfile() async => _map(await _remote.getProfile());

  @override
  Future<UserProfile> syncUser({
    required String email,
    String? displayName,
  }) async => _map(
    await _remote.syncUser(
      SyncUserRequest(email: email, displayName: displayName),
    ),
  );

  @override
  Future<void> validateToken(String idToken) async {
    await _remote.validateToken(ValidateTokenRequest(idToken: idToken));
  }

  @override
  Future<UserProfile> updateProfile({
    required String email,
    String? firstName,
    String? lastName,
  }) async {
    final res = await _remote.updateUserProfile(
      UpdateUserProfileRequest(
        email: email,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    return _map2(res);
  }

  @override
  Future<ExtendedUserProfile> getUserProfileExtended() async {
    final res = await _remote.getUserProfile();
    return _mapExtended(res);
  }

  // New unified authentication flow methods
  @override
  Future<AuthStatusResponse> checkAuthStatus() async {
    final res = await _remote.checkAuthStatus();
    return res;
  }

  @override
  Future<PhoneRegistrationResponse> registerIndividualUser({
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    final res = await _remote.registerIndividualUser(
      IndividualRegistrationRequest(
        email: email,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    return res;
  }

  @override
  Future<PhoneRegistrationResponse> registerEmployeeUser({
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    final res = await _remote.registerEmployeeUser(
      EmployeeRegistrationRequest(
        email: email,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    return res;
  }

  // Legacy methods
  @override
  Future<CheckUserExistsResponse> checkUserExists(String firebaseUid) async {
    final res = await _remote.checkUserExists(
      CheckUserExistsRequest(firebaseUid: firebaseUid),
    );
    return res;
  }

  @override
  Future<EmployeeInfoResponse?> checkEmployeeByPhone(String phoneNumber) async {
    try {
      final res = await _remote.checkEmployeeByPhone(
        CheckEmployeeByPhoneRequest(phoneNumber: phoneNumber),
      );
      return res;
    } catch (e) {
      // If employee not found, return null
      return null;
    }
  }

  @override
  Future<PhoneRegistrationResponse> registerEmployeeByPhone({
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    final res = await _remote.registerEmployeeByPhone(
      RegisterEmployeeByPhoneRequest(
        phoneNumber: phoneNumber,
        email: email,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    return res;
  }

  @override
  Future<PhoneRegistrationResponse> registerUserByPhone({
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    final res = await _remote.registerUserByPhone(
      RegisterUserByPhoneRequest(
        phoneNumber: phoneNumber,
        email: email,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    return res;
  }
}
