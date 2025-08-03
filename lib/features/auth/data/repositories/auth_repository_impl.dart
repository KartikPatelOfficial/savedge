import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/exceptions.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:savedge/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:savedge/features/auth/data/datasources/firebase_auth_data_source.dart';
import 'package:savedge/features/auth/data/models/auth_requests.dart';
import 'package:savedge/features/auth/domain/entities/phone_auth.dart';
import 'package:savedge/features/auth/domain/entities/user.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/auth/domain/usecases/check_user_exists_usecase.dart';

/// Implementation of AuthRepository
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._firebaseDataSource,
  );

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final FirebaseAuthDataSource _firebaseDataSource;

  @override
  Future<Either<Failure, bool>> checkUserExists() async {
    try {
      final response = await _remoteDataSource.checkUserExists();
      return Right(response.exists);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserExistsResult>> checkUserExistsWithProfile() async {
    try {
      final response = await _remoteDataSource.checkUserExists();
      
      if (response.exists && response.userProfile != null) {
        final user = response.userProfile!.toUserModel().toEntity();
        final isEmployee = response.userProfile!.isEmployee;
        
        return Right(UserExistsResult(
          exists: true,
          user: user,
          isEmployee: isEmployee,
        ));
      } else {
        return const Right(UserExistsResult(exists: false));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> registerUser({
    required String email,
    String? firstName,
    String? lastName,
  }) async {
    try {
      final request = UserRegistrationRequest(
        email: email,
        firstName: firstName,
        lastName: lastName,
      );
      
      final response = await _remoteDataSource.registerUser(request);
      final user = User(
        id: response.id,
        email: response.email,
        firebaseUid: response.firebaseUid ?? '',
        firstName: response.firstName,
        lastName: response.lastName,
        organizationId: response.organizationId,
        organizationName: response.organizationName,
        pointsBalance: response.pointsBalance ?? 0,
        pointsExpiry: response.pointsExpiry,
        isActive: response.isActive ?? true,
        createdAt: response.createdAt,
      );
      
      // Cache user locally
      await _localDataSource.cacheUser(user.toModel());
      
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> syncUserProfile({
    required String email,
    String? displayName,
  }) async {
    try {
      final request = SyncUserRequest(
        email: email,
        displayName: displayName,
      );
      
      final response = await _remoteDataSource.syncUserProfile(request);
      final user = User(
        id: response.id,
        email: response.email,
        firebaseUid: response.firebaseUid ?? '',
        firstName: response.firstName,
        lastName: response.lastName,
        organizationId: response.organizationId,
        organizationName: response.organizationId.toString(),
        pointsBalance: response.pointsBalance ?? 0,
        pointsExpiry: response.pointsExpiry,
        isActive: response.isActive ?? true,
        createdAt: response.createdAt,
      );
      
      // Cache user locally
      await _localDataSource.cacheUser(user.toModel());
      
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUserProfile() async {
    try {
      final response = await _remoteDataSource.getUserProfile();
      final user = User(
        id: response.id,
        email: response.email,
        firebaseUid: response.firebaseUid ?? '',
        firstName: response.firstName,
        lastName: response.lastName,
        organizationId: response.organizationId,
        organizationName: response.organizationId.toString(),
        pointsBalance: response.pointsBalance ?? 0,
        pointsExpiry: response.pointsExpiry,
        isActive: response.isActive ?? true,
        createdAt: response.createdAt,
      );
      
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserProfile({
    String? firstName,
    String? lastName,
  }) async {
    try {
      final currentUser = await getCurrentUser();
      final email = currentUser.fold(
        (failure) => throw Exception('No current user'),
        (user) => user?.email ?? '',
      );
      
      final request = UpdateUserProfileRequest(
        firstName: firstName,
        lastName: lastName,
      );
      
      final response = await _remoteDataSource.updateUserProfile(request);
      final user = User(
        id: response.id,
        email: response.email,
        firebaseUid: response.firebaseUid ?? '',
        firstName: response.firstName,
        lastName: response.lastName,
        organizationId: response.organizationId,
        organizationName: response.organizationName,
        pointsBalance: response.pointsBalance ?? 0,
        pointsExpiry: response.pointsExpiry,
        isActive: response.isActive ?? true,
        createdAt: response.createdAt,
      );
      
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> changeOrganization({
    required String userId,
    required int organizationId,
  }) async {
    try {
      final request = ChangeOrganizationRequest(
        organizationId: organizationId, // This should be provided by the UI
      );
      
      final response = await _remoteDataSource.changeUserOrganization(userId, request);
      final user = User(
        id: response.id,
        email: response.email,
        firebaseUid: response.firebaseUid ?? '',
        firstName: response.firstName,
        lastName: response.lastName,
        organizationId: response.organizationId,
        organizationName: response.organizationName,
        pointsBalance: response.pointsBalance ?? 0,
        pointsExpiry: response.pointsExpiry,
        isActive: response.isActive ?? true,
        createdAt: response.createdAt,
      );
      
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> removeFromOrganization(String userId) async {
    try {
      final response = await _remoteDataSource.removeUserFromOrganization(userId);
      final user = User(
        id: response.id,
        email: response.email,
        firebaseUid: response.firebaseUid ?? '',
        firstName: response.firstName,
        lastName: response.lastName,
        organizationId: response.organizationId,
        organizationName: response.organizationName,
        pointsBalance: response.pointsBalance ?? 0,
        pointsExpiry: response.pointsExpiry,
        isActive: response.isActive ?? true,
        createdAt: response.createdAt,
      );
      
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> validateToken(String idToken) async {
    try {
      final request = ValidateTokenRequest(idToken: idToken);
      await _remoteDataSource.validateToken(request);
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  // Firebase Authentication methods
  @override
  Future<Either<Failure, PhoneAuth>> sendOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    try {
      final phoneAuth = await _firebaseDataSource.sendOtp(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
      );
      return Right(phoneAuth);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, firebase_auth.User>> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    try {
      final user = await _firebaseDataSource.verifyOtp(
        verificationId: verificationId,
        otp: otp,
      );
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PhoneAuth>> resendOtp({
    required String phoneNumber,
    required String countryCode,
    int? forceResendingToken,
  }) async {
    try {
      final phoneAuth = await _firebaseDataSource.resendOtp(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        forceResendingToken: forceResendingToken,
      );
      return Right(phoneAuth);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _firebaseDataSource.signOut();
      await _localDataSource.clearUser();
      await _localDataSource.clearAuthToken();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message, statusCode: e.statusCode));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  firebase_auth.User? get currentFirebaseUser => _firebaseDataSource.currentUser;

  @override
  Stream<firebase_auth.User?> get authStateChanges => _firebaseDataSource.authStateChanges;

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      // Check if user is authenticated with Firebase
      final firebaseUser = _firebaseDataSource.currentUser;
      if (firebaseUser == null) {
        // No Firebase user, clear local cache and return null
        await _localDataSource.clearUser();
        return const Right(null);
      }

      // Check local cache first
      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        // Validate cached user with backend
        try {
          final idToken = await firebaseUser.getIdToken();
          if (idToken?.isEmpty ?? true) {
            // No valid token, sign out Firebase user and clear cache
            await signOut();
            return const Right(null);
          }
          final validateResult = await validateToken(idToken!);
          
          return validateResult.fold(
            (failure) async {
              // Token validation failed, sign out Firebase user and clear cache
              await signOut();
              return const Right(null);
            },
            (isValid) {
              if (isValid) {
                return Right(cachedUser.toEntity());
              } else {
                // Invalid token, sign out and clear cache
                signOut();
                return const Right(null);
              }
            },
          );
        } catch (e) {
          // Error validating token, try to check user exists in backend
          try {
            final userExistsResult = await checkUserExists();
            return userExistsResult.fold(
              (failure) async {
                // User doesn't exist in backend, sign out Firebase user
                await signOut();
                return const Right(null);
              },
              (userExists) {
                if (userExists) {
                  return Right(cachedUser.toEntity());
                } else {
                  // User doesn't exist in backend, sign out Firebase user
                  signOut();
                  return const Right(null);
                }
              },
            );
          } catch (e) {
            // If all checks fail, sign out
            await signOut();
            return const Right(null);
          }
        }
      } else {
        // No cached user, check if user exists in backend
        try {
          final userExistsResult = await checkUserExists();
          return userExistsResult.fold(
            (failure) async {
              // User doesn't exist in backend, sign out Firebase user
              await signOut();
              return const Right(null);
            },
            (userExists) async {
              if (userExists) {
                // User exists in backend, sync and cache
                final email = firebaseUser.email ?? '';
                final syncResult = await syncUserProfile(email: email);
                return syncResult.fold(
                  (failure) async {
                    await signOut();
                    return const Right(null);
                  },
                  (user) async {
                    await _localDataSource.cacheUser(user.toModel());
                    return Right(user);
                  },
                );
              } else {
                // User doesn't exist in backend, sign out Firebase user
                await signOut();
                return const Right(null);
              }
            },
          );
        } catch (e) {
          // If check fails, sign out
          await signOut();
          return const Right(null);
        }
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserToLocal(User user) async {
    try {
      await _localDataSource.cacheUser(user.toModel());
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearLocalUser() async {
    try {
      await _localDataSource.clearUser();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
