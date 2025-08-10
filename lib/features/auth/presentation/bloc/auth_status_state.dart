part of 'auth_status_cubit.dart';

abstract class AuthStatusState extends Equatable { const AuthStatusState(); @override List<Object?> get props => []; }
class AuthStatusInitial extends AuthStatusState { const AuthStatusInitial(); }
class AuthStatusLoading extends AuthStatusState { const AuthStatusLoading(); }
class AuthStatusLoaded extends AuthStatusState { const AuthStatusLoaded({required this.profile, required this.status}); final UserProfile profile; final AuthFlowStatus status; @override List<Object?> get props => [profile, status]; }
class AuthStatusError extends AuthStatusState { const AuthStatusError(this.message); final String message; @override List<Object?> get props => [message]; }
