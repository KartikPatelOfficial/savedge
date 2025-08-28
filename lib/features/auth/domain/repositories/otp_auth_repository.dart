import 'package:dartz/dartz.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';

abstract class OtpAuthRepository {
  Future<Either<Failure, void>> sendOtp(String phoneNumber);
  
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
  );
}