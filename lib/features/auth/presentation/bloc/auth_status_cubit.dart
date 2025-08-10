import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:savedge/features/auth/domain/entities/user_profile.dart';
import 'package:savedge/features/auth/domain/usecases/sync_user_usecase.dart';

part 'auth_status_state.dart';

enum AuthFlowStatus { newUser, employeeFound, existingUser }

class AuthStatusCubit extends Cubit<AuthStatusState> {
  AuthStatusCubit({required FirebaseAuth firebaseAuth, required SyncUserUseCase syncUserUseCase})
      : _firebaseAuth = firebaseAuth,
        _syncUserUseCase = syncUserUseCase,
        super(const AuthStatusInitial());

  final FirebaseAuth _firebaseAuth;
  final SyncUserUseCase _syncUserUseCase;

  Future<void> checkStatus() async {
    emit(const AuthStatusLoading());
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        emit(const AuthStatusError('Not authenticated'));
        return;
      }
      final email = user.email ?? user.phoneNumber ?? '';
      final profile = await _syncUserUseCase(email: email, displayName: user.displayName);
      emit(_mapProfile(profile));
    } catch (e) {
      emit(AuthStatusError(e.toString()));
    }
  }

  AuthStatusLoaded _mapProfile(UserProfile profile) {
    AuthFlowStatus status;
    if (profile.hasCompletedProfile) {
      status = AuthFlowStatus.existingUser;
    } else if (profile.organizationId != null) {
      status = AuthFlowStatus.employeeFound;
    } else {
      status = AuthFlowStatus.newUser;
    }
    return AuthStatusLoaded(profile: profile, status: status);
  }
}
