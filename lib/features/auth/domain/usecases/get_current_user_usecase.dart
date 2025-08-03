import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:injectable/injectable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

/// Use case for getting the current authenticated Firebase user
@injectable
class GetCurrentUserUseCase implements UseCase<firebase_auth.User?, NoParams> {
  const GetCurrentUserUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<Failure, firebase_auth.User?>> call(NoParams params) async {
    return Right(_authRepository.currentFirebaseUser);
  }
}
