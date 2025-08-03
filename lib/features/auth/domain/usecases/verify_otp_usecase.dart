import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

/// Use case for verifying OTP and signing in user
@injectable
class VerifyOtpUseCase implements UseCase<firebase_auth.User, VerifyOtpParams> {
  const VerifyOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, firebase_auth.User>> call(VerifyOtpParams params) async {
    return _repository.verifyOtp(
      verificationId: params.verificationId,
      otp: params.otp,
    );
  }
}

class VerifyOtpParams extends Equatable {
  const VerifyOtpParams({
    required this.verificationId,
    required this.otp,
  });

  final String verificationId;
  final String otp;

  @override
  List<Object> get props => [verificationId, otp];
}
