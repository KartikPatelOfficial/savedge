import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/auth/domain/entities/user.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

/// Use case for syncing user profile with backend
@injectable
class SyncUserProfileUseCase implements UseCase<User, SyncUserProfileParams> {
  const SyncUserProfileUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, User>> call(SyncUserProfileParams params) async {
    return _repository.syncUserProfile(
      email: params.email,
      displayName: params.displayName,
    );
  }
}

class SyncUserProfileParams extends Equatable {
  const SyncUserProfileParams({
    required this.email,
    this.displayName,
  });

  final String email;
  final String? displayName;

  @override
  List<Object?> get props => [email, displayName];
}
