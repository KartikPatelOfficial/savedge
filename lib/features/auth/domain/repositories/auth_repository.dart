import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/auth/domain/entities/phone_auth.dart';
import 'package:savedge/features/auth/domain/entities/user.dart';
import 'package:savedge/features/auth/domain/usecases/check_user_exists_usecase.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Checks if user exists in the backend system
  Future<Either<Failure, bool>> checkUserExists();

  /// Checks if user exists and returns user profile if available
  Future<Either<Failure, UserExistsResult>> checkUserExistsWithProfile();

  /// Registers a new user
  Future<Either<Failure, User>> registerUser({
    required String email,
    String? firstName,
    String? lastName,
  });

  /// Syncs user profile with backend after Firebase authentication
  Future<Either<Failure, User>> syncUserProfile({
    required String email,
    String? displayName,
  });

  /// Gets current user profile
  Future<Either<Failure, User>> getUserProfile();

  /// Updates user profile
  Future<Either<Failure, User>> updateUserProfile({
    String? firstName,
    String? lastName,
  });

  /// Changes user organization
  Future<Either<Failure, User>> changeOrganization({
    required String userId,
    required int organizationId,
  });

  /// Removes user from organization
  Future<Either<Failure, User>> removeFromOrganization(String userId);

  /// Validates Firebase ID token
  Future<Either<Failure, bool>> validateToken(String idToken);

  /// Firebase Authentication methods
  /// Sends OTP to phone number
  Future<Either<Failure, PhoneAuth>> sendOtp({
    required String phoneNumber,
    required String countryCode,
  });

  /// Verifies OTP and signs in user
  Future<Either<Failure, firebase_auth.User>> verifyOtp({
    required String verificationId,
    required String otp,
  });

  /// Resends OTP
  Future<Either<Failure, PhoneAuth>> resendOtp({
    required String phoneNumber,
    required String countryCode,
    int? forceResendingToken,
  });

  /// Signs out user
  Future<Either<Failure, void>> signOut();

  /// Gets current Firebase user
  firebase_auth.User? get currentFirebaseUser;

  /// Stream of Firebase auth state changes
  Stream<firebase_auth.User?> get authStateChanges;

  /// Gets current app user from local storage
  Future<Either<Failure, User?>> getCurrentUser();

  /// Saves user to local storage
  Future<Either<Failure, void>> saveUserToLocal(User user);

  /// Clears local user data
  Future<Either<Failure, void>> clearLocalUser();
}
