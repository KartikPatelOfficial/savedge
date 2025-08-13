part of 'phone_auth_cubit.dart';

abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();
  @override
  List<Object?> get props => [];
}

class PhoneAuthInitial extends PhoneAuthState {
  const PhoneAuthInitial();
}

class PhoneAuthLoading extends PhoneAuthState {
  const PhoneAuthLoading();
}

class PhoneAuthCodeSent extends PhoneAuthState {
  const PhoneAuthCodeSent();
}

class PhoneAuthVerified extends PhoneAuthState {
  const PhoneAuthVerified(this.user);
  final User user;
  @override
  List<Object?> get props => [user.uid];
}

class PhoneAuthError extends PhoneAuthState {
  const PhoneAuthError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
