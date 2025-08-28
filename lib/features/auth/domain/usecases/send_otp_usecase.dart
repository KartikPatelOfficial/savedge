import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/domain/repositories/otp_auth_repository.dart';

@lazySingleton
class SendOtpUseCase implements UseCase<void, SendOtpParams> {
  final OtpAuthRepository repository;

  SendOtpUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SendOtpParams params) async {
    return await repository.sendOtp(params.phoneNumber);
  }
}

class SendOtpParams extends Equatable {
  final String phoneNumber;

  const SendOtpParams({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}