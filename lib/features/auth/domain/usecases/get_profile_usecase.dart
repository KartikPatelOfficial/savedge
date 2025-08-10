import 'package:savedge/features/auth/domain/entities/user_profile.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

class GetProfileUseCase {
  const GetProfileUseCase(this._repository);
  final AuthRepository _repository;
  Future<UserProfile> call() => _repository.getProfile();
}
