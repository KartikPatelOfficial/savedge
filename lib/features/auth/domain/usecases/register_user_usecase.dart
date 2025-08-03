import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/domain/entities/user.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

/// Use case for registering a new user
@injectable
class RegisterUserUseCase implements UseCase<User, RegisterUserParams> {
  const RegisterUserUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, User>> call(RegisterUserParams params) async {
    return _repository.registerUser(
      email: params.email,
      firstName: params.firstName,
      lastName: params.lastName,
    );
  }
}

class RegisterUserParams extends Equatable {
  const RegisterUserParams({
    required this.email,
    this.firstName,
    this.lastName,
  });

  final String email;
  final String? firstName;
  final String? lastName;

  @override
  List<Object?> get props => [email, firstName, lastName];
}
