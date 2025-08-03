import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/domain/entities/user.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

/// Response model for user existence check
class UserExistsResult {
  const UserExistsResult({
    required this.exists,
    this.user,
    this.isEmployee = false,
  });

  final bool exists;
  final User? user;
  final bool isEmployee;
}

/// Use case for checking if user exists in the backend system
@injectable
class CheckUserExistsUseCase implements NoParamsUseCase<UserExistsResult> {
  const CheckUserExistsUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, UserExistsResult>> call() async {
    return _repository.checkUserExistsWithProfile();
  }
}
