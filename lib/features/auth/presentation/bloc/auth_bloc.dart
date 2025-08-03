import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/domain/entities/phone_auth.dart';
import 'package:savedge/features/auth/domain/entities/user.dart';
import 'package:savedge/features/auth/domain/usecases/check_user_exists_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/sync_user_profile_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/verify_otp_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// BLoC for handling authentication flow
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._sendOtpUseCase,
    this._verifyOtpUseCase,
    this._checkUserExistsUseCase,
    this._registerUserUseCase,
    this._syncUserProfileUseCase,
    this._getCurrentUserUseCase,
    this._signOutUseCase,
  ) : super(AuthInitial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<CheckUserExistsEvent>(_onCheckUserExists);
    on<RegisterUserEvent>(_onRegisterUser);
    on<SyncUserProfileEvent>(_onSyncUserProfile);
    on<SignOutEvent>(_onSignOut);
  }

  final SendOtpUseCase _sendOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final CheckUserExistsUseCase _checkUserExistsUseCase;
  final RegisterUserUseCase _registerUserUseCase;
  final SyncUserProfileUseCase _syncUserProfileUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final SignOutUseCase _signOutUseCase;

  firebase_auth.User? _currentFirebaseUser;

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _sendOtpUseCase(
      SendOtpParams(
        phoneNumber: event.phoneNumber,
        countryCode: event.countryCode,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (phoneAuth) => emit(AuthOtpSent(phoneAuth)),
    );
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _verifyOtpUseCase(
      VerifyOtpParams(verificationId: event.verificationId, otp: event.otp),
    );

    result.fold((failure) => emit(AuthError(failure.message)), (firebaseUser) {
      _currentFirebaseUser = firebaseUser;
      emit(AuthFirebaseSuccess(firebaseUser));
    });
  }

  Future<void> _onCheckUserExists(
    CheckUserExistsEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _checkUserExistsUseCase();

    result.fold((failure) => emit(AuthError(failure.message)), (
      userExistsResult,
    ) {
      if (userExistsResult.exists && _currentFirebaseUser != null) {
        emit(
          AuthUserExists(
            _currentFirebaseUser!,
            isEmployee: userExistsResult.isEmployee,
            user: userExistsResult.user,
          ),
        );
      } else {
        emit(AuthUserNotExists());
      }
    });
  }

  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _registerUserUseCase(
      RegisterUserParams(
        email: event.email,
        firstName: event.firstName,
        lastName: event.lastName,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthRegisterSuccess(user)),
    );
  }

  Future<void> _onSyncUserProfile(
    SyncUserProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await _syncUserProfileUseCase(
      SyncUserProfileParams(email: event.email, displayName: event.displayName),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSyncSuccess(user)),
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStatusChecking());

    try {
      // Get current Firebase user
      final result = await _getCurrentUserUseCase(const NoParams());

      await result.fold(
        (failure) async {
          if (!emit.isDone) {
            emit(AuthError(failure.toString()));
          }
        },
        (firebaseUser) async {
          if (firebaseUser != null) {
            _currentFirebaseUser = firebaseUser;

            // Check if user exists in database
            final userExistsResult = await _checkUserExistsUseCase();

            await userExistsResult.fold(
              (failure) async {
                if (!emit.isDone) {
                  emit(AuthError(failure.toString()));
                }
              },
              (userExistsData) async {
                if (!emit.isDone) {
                  if (userExistsData.exists) {
                    // User is authenticated and exists in database
                    emit(
                      AuthUserExists(
                        firebaseUser,
                        isEmployee: userExistsData.isEmployee,
                        user: userExistsData.user,
                      ),
                    );
                  } else {
                    // User is authenticated with Firebase but doesn't exist in database
                    // Sign out the user as requested
                    await _signOutFirebaseUser();
                    emit(AuthUnauthenticated());
                  }
                }
              },
            );
          } else {
            // No Firebase user, show login page
            if (!emit.isDone) {
              emit(AuthUnauthenticated());
            }
          }
        },
      );
    } catch (e) {
      if (!emit.isDone) {
        emit(
          AuthError('Failed to check authentication status: ${e.toString()}'),
        );
      }
    }
  }

  /// Helper method to sign out Firebase user without using the SignOutEvent
  Future<void> _signOutFirebaseUser() async {
    try {
      await _signOutUseCase();
      _currentFirebaseUser = null;
    } catch (e) {
      // Handle sign out error silently or log it
      print('Error signing out Firebase user: $e');
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await _signOutUseCase();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSignedOut()),
    );
  }
}
