part of 'auth_bloc.dart';

/// Base class for authentication events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event to send OTP to phone number
class SendOtpEvent extends AuthEvent {
  const SendOtpEvent({required this.phoneNumber, required this.countryCode});

  final String phoneNumber;
  final String countryCode;

  @override
  List<Object> get props => [phoneNumber, countryCode];
}

/// Event to verify OTP
class VerifyOtpEvent extends AuthEvent {
  const VerifyOtpEvent({required this.verificationId, required this.otp});

  final String verificationId;
  final String otp;

  @override
  List<Object> get props => [verificationId, otp];
}

/// Event to check if user exists in backend
class CheckUserExistsEvent extends AuthEvent {
  const CheckUserExistsEvent();
}

/// Event to register a new user
class RegisterUserEvent extends AuthEvent {
  const RegisterUserEvent({required this.email, this.firstName, this.lastName});

  final String email;
  final String? firstName;
  final String? lastName;

  @override
  List<Object?> get props => [email, firstName, lastName];
}

/// Event to sync user profile with backend
class SyncUserProfileEvent extends AuthEvent {
  const SyncUserProfileEvent({required this.email, this.displayName});

  final String email;
  final String? displayName;

  @override
  List<Object?> get props => [email, displayName];
}

/// Event to check authentication status on app start
class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

/// Event to sign out user
class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}
