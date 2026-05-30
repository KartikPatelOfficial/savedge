import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/core/utils/failure_message_mapper.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';
import 'package:savedge/features/auth/domain/usecases/register_individual_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/verify_otp_usecase.dart';

part 'otp_auth_state.dart';

@injectable
class OtpAuthCubit extends Cubit<OtpAuthState> {
  OtpAuthCubit(
    this._sendOtpUseCase,
    this._verifyOtpUseCase,
    this._registerIndividualUseCase,
  ) : super(const OtpAuthInitial());

  final SendOtpUseCase _sendOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final RegisterIndividualUseCase _registerIndividualUseCase;

  /// Request the backend to send an OTP to the phone number (via SMS).
  Future<void> sendOtp(String phoneNumber) async {
    emit(const OtpAuthLoading());

    final normalized = _normalize(phoneNumber);

    final result = await _sendOtpUseCase(SendOtpParams(phoneNumber: normalized));

    result.fold(
      (failure) =>
          emit(OtpAuthError(FailureMessageMapper.mapFailureToMessage(failure))),
      (_) => emit(const OtpAuthCodeSent()),
    );
  }

  /// Verify the OTP with the backend, which returns the user's verification
  /// status along with SavEdge session tokens for existing users.
  Future<void> verifyOtp(String phoneNumber, String otp) async {
    emit(const OtpAuthLoading());

    final normalized = _normalize(phoneNumber);

    final result = await _verifyOtpUseCase(
      VerifyOtpParams(phoneNumber: normalized, otp: otp),
    );

    result.fold(
      (failure) =>
          emit(OtpAuthError(FailureMessageMapper.mapFailureToMessage(failure))),
      (verificationResult) {
        switch (verificationResult.status) {
          case UserStatus.newUser:
            emit(OtpAuthNewUser(normalized));
          case UserStatus.deletedAccountCanRecreate:
            emit(OtpAuthDeletedAccountCanRecreate(normalized));
          case UserStatus.existingIndividualUser:
            if (verificationResult.user != null &&
                verificationResult.accessToken != null) {
              emit(
                OtpAuthIndividualUserAuthenticated(
                  verificationResult.user!,
                  verificationResult.accessToken!,
                  verificationResult.refreshToken!,
                  verificationResult.tokenExpiresAt!,
                ),
              );
            } else {
              emit(const OtpAuthError('Invalid user data received'));
            }
          case UserStatus.existingEmployee:
            if (verificationResult.employee != null &&
                verificationResult.accessToken != null) {
              emit(
                OtpAuthEmployeeAuthenticated(
                  verificationResult.employee!,
                  verificationResult.accessToken!,
                  verificationResult.refreshToken!,
                  verificationResult.tokenExpiresAt!,
                ),
              );
            } else {
              emit(const OtpAuthError('Invalid employee data received'));
            }
        }
      },
    );
  }

  Future<void> registerIndividual({
    required String phoneNumber,
    required String email,
    required String firstName,
    required String lastName,
    DateTime? dateOfBirth,
    required String residentialAddress,
    required String city,
    required String state,
    String country = 'India',
    required String pinCode,
  }) async {
    emit(const OtpAuthLoading());

    final result = await _registerIndividualUseCase(
      RegisterIndividualParams(
        phoneNumber: phoneNumber,
        email: email,
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        residentialAddress: residentialAddress,
        city: city,
        state: state,
        country: country,
        pinCode: pinCode,
      ),
    );

    result.fold(
      (failure) =>
          emit(OtpAuthError(FailureMessageMapper.mapFailureToMessage(failure))),
      (registrationResult) => emit(
        OtpAuthIndividualUserRegistered(
          registrationResult.user,
          registrationResult.accessToken,
          registrationResult.refreshToken,
          registrationResult.expiresAt,
        ),
      ),
    );
  }

  void reset() {
    emit(const OtpAuthInitial());
  }

  static String _normalize(String phoneNumber) {
    final trimmed = phoneNumber.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed.startsWith('+') ? trimmed : '+91$trimmed';
  }
}
