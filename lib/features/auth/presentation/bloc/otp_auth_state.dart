part of 'otp_auth_cubit.dart';

abstract class OtpAuthState extends Equatable {
  const OtpAuthState();

  @override
  List<Object?> get props => [];
}

class OtpAuthInitial extends OtpAuthState {
  const OtpAuthInitial();
}

class OtpAuthLoading extends OtpAuthState {
  const OtpAuthLoading();
}

class OtpAuthCodeSent extends OtpAuthState {
  const OtpAuthCodeSent();
}

class OtpAuthNewUser extends OtpAuthState {
  final String phoneNumber;

  const OtpAuthNewUser(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class OtpAuthDeletedAccountCanRecreate extends OtpAuthState {
  final String phoneNumber;

  const OtpAuthDeletedAccountCanRecreate(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class OtpAuthIndividualUserAuthenticated extends OtpAuthState {
  final UserInfoModel user;
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  const OtpAuthIndividualUserAuthenticated(
    this.user,
    this.accessToken,
    this.refreshToken,
    this.expiresAt,
  );

  @override
  List<Object> get props => [user, accessToken, refreshToken, expiresAt];
}

class OtpAuthEmployeeAuthenticated extends OtpAuthState {
  final EmployeeInfoModel employee;
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  const OtpAuthEmployeeAuthenticated(
    this.employee,
    this.accessToken,
    this.refreshToken,
    this.expiresAt,
  );

  @override
  List<Object> get props => [employee, accessToken, refreshToken, expiresAt];
}

class OtpAuthIndividualUserRegistered extends OtpAuthState {
  final UserInfoModel user;
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  const OtpAuthIndividualUserRegistered(
    this.user,
    this.accessToken,
    this.refreshToken,
    this.expiresAt,
  );

  @override
  List<Object> get props => [user, accessToken, refreshToken, expiresAt];
}

class OtpAuthError extends OtpAuthState {
  final String message;

  const OtpAuthError(this.message);

  @override
  List<Object> get props => [message];
}