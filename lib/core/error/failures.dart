import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    this.statusCode,
  });

  final String message;
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Server error occurred. Please try again.',
    super.statusCode,
  });
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection. Please check your network.',
    super.statusCode,
  });
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Failed to access local storage.',
    super.statusCode,
  });
}

/// Validation-related failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    super.message = 'Invalid input provided.',
    super.statusCode,
  });
}

/// Authentication-related failures
class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Authentication failed.',
    super.statusCode,
  });
}

/// Permission-related failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    super.message = 'Permission denied.',
    super.statusCode,
  });
}

/// Unexpected failures
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'An unexpected error occurred.',
    super.statusCode,
  });
}
