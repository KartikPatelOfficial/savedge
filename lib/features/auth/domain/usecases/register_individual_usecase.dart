import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';
import 'package:savedge/features/auth/domain/repositories/otp_auth_repository.dart';

@lazySingleton
class RegisterIndividualUseCase implements UseCase<IndividualRegistrationResult, RegisterIndividualParams> {
  final OtpAuthRepository repository;

  RegisterIndividualUseCase(this.repository);

  @override
  Future<Either<Failure, IndividualRegistrationResult>> call(RegisterIndividualParams params) async {
    return await repository.registerIndividual(
      params.phoneNumber,
      params.email,
      params.firstName,
      params.lastName,
      params.dateOfBirth,
      params.residentialAddress,
      params.city,
      params.state,
      params.country,
      params.pinCode,
    );
  }
}

class RegisterIndividualParams extends Equatable {
  final String phoneNumber;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final String residentialAddress;
  final String city;
  final String state;
  final String country;
  final String pinCode;

  const RegisterIndividualParams({
    required this.phoneNumber,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    required this.residentialAddress,
    required this.city,
    required this.state,
    this.country = 'India',
    required this.pinCode,
  });

  @override
  List<Object?> get props => [phoneNumber, email, firstName, lastName, dateOfBirth, residentialAddress, city, state, country, pinCode];
}