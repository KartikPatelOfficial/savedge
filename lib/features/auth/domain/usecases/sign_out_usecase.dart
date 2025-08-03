import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

/// Use case for signing out user
@injectable
class SignOutUseCase implements NoParamsUseCase<void> {
  const SignOutUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, void>> call() async {
    return _repository.signOut();
  }
}
