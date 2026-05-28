import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';
import 'package:savedge/features/auth/domain/repositories/otp_auth_repository.dart';

/// Verifies an MSG91 widget access token (obtained client-side from the SDK after
/// the user completed OTP entry) and returns the user's verification status.
@lazySingleton
class VerifyMsg91TokenUseCase
    implements UseCase<UserVerificationResult, VerifyMsg91TokenParams> {
  VerifyMsg91TokenUseCase(this.repository);

  final OtpAuthRepository repository;

  @override
  Future<Either<Failure, UserVerificationResult>> call(
    VerifyMsg91TokenParams params,
  ) {
    return repository.verifyMsg91Token(params.accessToken);
  }
}

class VerifyMsg91TokenParams extends Equatable {
  const VerifyMsg91TokenParams({required this.accessToken});

  final String accessToken;

  @override
  List<Object> get props => [accessToken];
}
