import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/domain/repositories/otp_auth_repository.dart';

/// Sends a login OTP to the given phone number via the backend.
@lazySingleton
class SendOtpUseCase implements UseCase<Unit, SendOtpParams> {
  SendOtpUseCase(this.repository);

  final OtpAuthRepository repository;

  @override
  Future<Either<Failure, Unit>> call(SendOtpParams params) {
    return repository.sendOtp(params.phoneNumber);
  }
}

class SendOtpParams extends Equatable {
  const SendOtpParams({required this.phoneNumber});

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}
