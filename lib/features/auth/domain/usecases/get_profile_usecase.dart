import 'package:dartz/dartz.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/domain/entities/user_profile.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

/// Use case for retrieving the current user's profile
///
/// This use case fetches the authenticated user's profile information
/// from the repository layer, handling any failures that may occur.
class GetProfileUseCase extends UseCase<UserProfile, NoParams> {
  const GetProfileUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, UserProfile>> call(NoParams params) async {
    try {
      final profile = await _repository.getProfile();
      return Right(profile);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
