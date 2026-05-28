import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/core/constants/app_constants.dart';
import 'package:savedge/core/utils/failure_message_mapper.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';
import 'package:savedge/features/auth/domain/usecases/register_individual_usecase.dart';
import 'package:savedge/features/auth/domain/usecases/verify_msg91_token_usecase.dart';
import 'package:sendotp_flutter_sdk/sendotp_flutter_sdk.dart';

part 'otp_auth_state.dart';

@injectable
class OtpAuthCubit extends Cubit<OtpAuthState> {
  OtpAuthCubit(
    this._verifyMsg91TokenUseCase,
    this._registerIndividualUseCase,
  ) : super(const OtpAuthInitial());

  final VerifyMsg91TokenUseCase _verifyMsg91TokenUseCase;
  final RegisterIndividualUseCase _registerIndividualUseCase;

  /// Trigger OTP send via the MSG91 widget SDK.
  /// Whitelisted bypass phones short-circuit without calling MSG91.
  Future<void> sendOtp(String phoneNumber) async {
    emit(const OtpAuthLoading());

    final normalized = _normalize(phoneNumber);
    if (AppConstants.bypassPhoneNumbers.contains(normalized)) {
      emit(const OtpAuthCodeSent());
      return;
    }

    try {
      final response = await OTPWidget.sendOTP(<String, String>{
        'identifier': _stripPlus(normalized),
      });
      if (response == null) {
        emit(const OtpAuthError('Failed to send OTP. Please try again.'));
        return;
      }
      if (_isSuccess(response)) {
        emit(const OtpAuthCodeSent());
      } else {
        emit(OtpAuthError(_messageOrDefault(response, 'Failed to send OTP')));
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('OTPWidget.sendOTP error: $e');
      }
      emit(const OtpAuthError('Failed to send OTP. Please try again.'));
    }
  }

  /// Verify the OTP via the MSG91 SDK and then exchange the resulting access
  /// token with the backend to obtain SavEdge session tokens.
  Future<void> verifyOtp(String phoneNumber, String otp) async {
    emit(const OtpAuthLoading());

    final normalized = _normalize(phoneNumber);

    String accessToken;
    if (AppConstants.bypassPhoneNumbers.contains(normalized) &&
        otp == AppConstants.bypassOtp) {
      accessToken = '${AppConstants.bypassTokenPrefix}$normalized';
    } else {
      try {
        final response = await OTPWidget.verifyOTP(<String, String>{
          'identifier': _stripPlus(normalized),
          'otp': otp,
        });
        if (response == null) {
          emit(const OtpAuthError('OTP verification failed. Please try again.'));
          return;
        }
        if (!_isSuccess(response)) {
          emit(OtpAuthError(_messageOrDefault(response, 'Invalid OTP')));
          return;
        }
        final message = response['message'];
        if (message is! String || message.isEmpty) {
          emit(const OtpAuthError('OTP verification returned an empty token'));
          return;
        }
        accessToken = message;
      } catch (e) {
        if (kDebugMode) {
          debugPrint('OTPWidget.verifyOTP error: $e');
        }
        emit(const OtpAuthError('OTP verification failed. Please try again.'));
        return;
      }
    }

    final result = await _verifyMsg91TokenUseCase(
      VerifyMsg91TokenParams(accessToken: accessToken),
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

  static String _stripPlus(String phoneNumber) =>
      phoneNumber.startsWith('+') ? phoneNumber.substring(1) : phoneNumber;

  static bool _isSuccess(Map<String, dynamic> response) =>
      response['type']?.toString().toLowerCase() == 'success';

  static String _messageOrDefault(
    Map<String, dynamic> response,
    String fallback,
  ) {
    final raw = response['message'];
    if (raw == null) return fallback;
    final text = raw.toString();
    return text.isEmpty ? fallback : text;
  }
}
