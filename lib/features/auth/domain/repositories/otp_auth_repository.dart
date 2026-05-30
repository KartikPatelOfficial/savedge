import 'package:dartz/dartz.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';

abstract class OtpAuthRepository {
  /// Sends a login OTP to [phoneNumber] via the backend.
  Future<Either<Failure, Unit>> sendOtp(String phoneNumber);

  /// Verifies the login [otp] for [phoneNumber] with the backend.
  /// Returns the verification result (user status + session tokens for existing users).
  Future<Either<Failure, UserVerificationResult>> verifyOtp(
    String phoneNumber,
    String otp,
  );

  Future<Either<Failure, IndividualRegistrationResult>> registerIndividual(
    String phoneNumber,
    String email,
    String firstName,
    String lastName,
    DateTime? dateOfBirth,
    String residentialAddress,
    String city,
    String state,
    String country,
    String pinCode,
  );
}
