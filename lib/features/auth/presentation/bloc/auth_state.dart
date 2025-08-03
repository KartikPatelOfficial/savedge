part of 'auth_bloc.dart';

/// Base class for authentication states
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AuthInitial extends AuthState {}

/// Checking authentication status on app start
class AuthStatusChecking extends AuthState {}

/// User is not authenticated (need to login)
class AuthUnauthenticated extends AuthState {}

/// Loading state
class AuthLoading extends AuthState {}

/// OTP sent successfully
class AuthOtpSent extends AuthState {
  const AuthOtpSent(this.phoneAuth);

  final PhoneAuth phoneAuth;

  @override
  List<Object> get props => [phoneAuth];
}

/// Firebase authentication successful
class AuthFirebaseSuccess extends AuthState {
  const AuthFirebaseSuccess(this.firebaseUser);

  final firebase_auth.User firebaseUser;

  @override
  List<Object> get props => [firebaseUser];
}

/// User exists in backend
class AuthUserExists extends AuthState {
  const AuthUserExists(this.firebaseUser, {this.isEmployee = false, this.user});

  final firebase_auth.User firebaseUser;
  final bool isEmployee;
  final User? user;

  @override
  List<Object?> get props => [firebaseUser, isEmployee, user];
}

/// User doesn't exist in backend
class AuthUserNotExists extends AuthState {}

/// User registration successful
class AuthRegisterSuccess extends AuthState {
  const AuthRegisterSuccess(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

/// User profile sync successful
class AuthSyncSuccess extends AuthState {
  const AuthSyncSuccess(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

/// Authentication error
class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

/// User signed out successfully
class AuthSignedOut extends AuthState {}

/// Specific loading states for better UX
class AuthOtpSending extends AuthLoading {}

class AuthOtpVerifying extends AuthLoading {}

class AuthUserChecking extends AuthLoading {}

class AuthUserRegistering extends AuthLoading {}

class AuthProfileSyncing extends AuthLoading {}
