/// Base exception class for the application
abstract class AppException implements Exception {
  const AppException({
    required this.message,
    this.statusCode,
  });

  final String message;
  final int? statusCode;

  @override
  String toString() => 'AppException: $message';
}

/// Server-related exceptions
class ServerException extends AppException {
  const ServerException({
    super.message = 'Server error occurred',
    super.statusCode,
  });
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException({
    super.message = 'Network error occurred',
    super.statusCode,
  });
}

/// Cache-related exceptions
class CacheException extends AppException {
  const CacheException({
    super.message = 'Cache error occurred',
    super.statusCode,
  });
}

/// Validation-related exceptions
class ValidationException extends AppException {
  const ValidationException({
    super.message = 'Validation error occurred',
    super.statusCode,
  });
}

/// Authentication-related exceptions
class AuthException extends AppException {
  const AuthException({
    super.message = 'Authentication error occurred',
    super.statusCode,
  });
}

/// Permission-related exceptions
class PermissionException extends AppException {
  const PermissionException({
    super.message = 'Permission error occurred',
    super.statusCode,
  });
}
