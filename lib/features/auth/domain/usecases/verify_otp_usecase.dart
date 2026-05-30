import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';
import 'package:savedge/features/auth/domain/repositories/otp_auth_repository.dart';

/// Verifies a login OTP with the backend and returns the user's verification
/// status (new user, existing individual, existing employee, or deleted account).
@lazySingleton
class VerifyOtpUseCase
    implements UseCase<UserVerificationResult, VerifyOtpParams> {
  VerifyOtpUseCase(this.repository);

  final OtpAuthRepository repository;

  @override
  Future<Either<Failure, UserVerificationResult>> call(VerifyOtpParams params) {
    return repository.verifyOtp(params.phoneNumber, params.otp);
  }
}

class VerifyOtpParams extends Equatable {
  const VerifyOtpParams({required this.phoneNumber, required this.otp});

  final String phoneNumber;
  final String otp;

  @override
  List<Object> get props => [phoneNumber, otp];
}
