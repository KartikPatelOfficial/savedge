import 'package:savedge/core/error/failures.dart';

/// Utility class for mapping failures to user-friendly error messages
///
/// This class centralizes error message mapping logic to ensure
/// consistency across the application and make it easier to maintain.
class FailureMessageMapper {
  const FailureMessageMapper._();

  /// Maps a [Failure] to a user-friendly error message
  ///
  /// Returns appropriate error messages based on the type of failure.
  /// If the failure has a custom message, it uses that; otherwise,
  /// it provides default messages for each failure type.
  static String mapFailureToMessage(Failure failure) {
    // Use custom message if available
    if (failure.message != null && failure.message!.isNotEmpty) {
      return failure.message!;
    }

    // Default messages based on failure type
    switch (failure.runtimeType) {
      case NetworkFailure _:
        return 'No internet connection. Please check your network.';
      case ServerFailure _:
        return 'Server error occurred. Please try again.';
      case NotFoundFailure _:
        return 'The requested resource was not found.';
      case AuthFailure _:
        return 'Authentication failed. Please login again.';
      case ValidationFailure _:
        return 'Please check your input and try again.';
      case PermissionFailure _:
        return 'You don\'t have permission to perform this action.';
      case CacheFailure _:
        return 'Data loading failed. Please try again.';
      case UnexpectedFailure _:
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  /// Maps a failure to a specific message for vendors context
  static String mapVendorFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NotFoundFailure _:
        return 'No vendors found matching your criteria.';
      case NetworkFailure _:
        return 'Unable to load vendors. Check your connection.';
      default:
        return mapFailureToMessage(failure);
    }
  }

  /// Maps a failure to a specific message for coupons context
  static String mapCouponFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NotFoundFailure _:
        return 'No coupons available at the moment.';
      case NetworkFailure _:
        return 'Unable to load coupons. Check your connection.';
      default:
        return mapFailureToMessage(failure);
    }
  }

  /// Maps a failure to a specific message for authentication context
  static String mapAuthFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case AuthFailure _:
        return 'Login failed. Please check your credentials.';
      case ValidationFailure _:
        return 'Please enter valid login information.';
      case NetworkFailure _:
        return 'Unable to connect. Check your internet connection.';
      default:
        return mapFailureToMessage(failure);
    }
  }
}
