import 'package:savedge/features/auth/domain/entities/user_profile.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

class SyncUserUseCase {
  const SyncUserUseCase(this._repository);
  final AuthRepository _repository;
  Future<UserProfile> call({required String email, String? displayName}) =>
      _repository.syncUser(email: email, displayName: displayName);
}
