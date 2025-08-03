import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/domain/entities/phone_auth.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

/// Use case for sending OTP to phone number
@injectable
class SendOtpUseCase implements UseCase<PhoneAuth, SendOtpParams> {
  const SendOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, PhoneAuth>> call(SendOtpParams params) async {
    return _repository.sendOtp(
      phoneNumber: params.phoneNumber,
      countryCode: params.countryCode,
    );
  }
}

class SendOtpParams extends Equatable {
  const SendOtpParams({
    required this.phoneNumber,
    required this.countryCode,
  });

  final String phoneNumber;
  final String countryCode;

  @override
  List<Object> get props => [phoneNumber, countryCode];
}
