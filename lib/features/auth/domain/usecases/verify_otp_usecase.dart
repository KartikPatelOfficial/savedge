import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';
import 'package:savedge/features/auth/domain/repositories/otp_auth_repository.dart';

@lazySingleton
class VerifyOtpUseCase implements UseCase<UserVerificationResult, VerifyOtpParams> {
  final OtpAuthRepository repository;

  VerifyOtpUseCase(this.repository);

  @override
  Future<Either<Failure, UserVerificationResult>> call(VerifyOtpParams params) async {
    return await repository.verifyOtp(params.phoneNumber, params.otp);
  }
}

class VerifyOtpParams extends Equatable {
  final String phoneNumber;
  final String otp;

  const VerifyOtpParams({
    required this.phoneNumber,
    required this.otp,
  });

  @override
  List<Object> get props => [phoneNumber, otp];
}