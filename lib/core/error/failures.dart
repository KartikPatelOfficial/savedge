import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  const Failure([this.message]);

  final String? message;

  @override
  List<Object?> get props => [message];
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure([String? message])
    : super(message ?? 'Server error occurred');
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure([String? message])
    : super(message ?? 'Cache error occurred');
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure([String? message])
    : super(message ?? 'Network error occurred');
}

/// Not Found failures
class NotFoundFailure extends Failure {
  const NotFoundFailure([String? message])
    : super(message ?? 'Resource not found');
}

/// Authentication-related failures
class AuthFailure extends Failure {
  const AuthFailure([String? message])
    : super(message ?? 'Authentication failed');
}

/// Validation-related failures
class ValidationFailure extends Failure {
  const ValidationFailure([String? message])
    : super(message ?? 'Validation failed');
}

/// Permission-related failures
class PermissionFailure extends Failure {
  const PermissionFailure([String? message])
    : super(message ?? 'Permission denied');
}

/// Unexpected failures
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([String? message])
    : super(message ?? 'An unexpected error occurred');
}
