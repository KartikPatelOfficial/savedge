import 'package:dio/dio.dart';

import 'package:savedge/core/error/exceptions.dart';
import 'package:savedge/core/error/failures.dart';

/// Converts any thrown error/exception into a short, user-friendly message
/// that is safe to display in the UI.
///
/// This never returns raw stack traces, `DioException` dumps, or internal
/// type names. Use it at every `catch` site that feeds a message to a
/// [Failure], a bloc state, a dialog, or a snackbar.
class ErrorMessageMapper {
  const ErrorMessageMapper._();

  static const String generic =
      'Something went wrong. Please try again in a moment.';

  /// Maps an arbitrary [error] to a user-friendly message.
  static String map(Object? error) {
    if (error == null) return generic;

    if (error is DioException) return _fromDio(error);
    if (error is AppException) return _sanitize(error.message);
    if (error is Failure) {
      final message = error.message;
      return (message != null && message.isNotEmpty)
          ? _sanitize(message)
          : generic;
    }

    return _sanitize(error.toString());
  }

  static String _fromDio(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The connection timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      case DioExceptionType.cancel:
        return 'The request was cancelled.';
      case DioExceptionType.badCertificate:
        return generic;
      case DioExceptionType.badResponse:
      case DioExceptionType.unknown:
        return _fromResponse(error);
    }
  }

  static String _fromResponse(DioException error) {
    final serverMessage = _extractServerMessage(error.response?.data);
    switch (error.response?.statusCode) {
      case 400:
        return serverMessage ??
            'The request was invalid. Please check your details and try again.';
      case 401:
        return 'Your session has expired. Please log in again.';
      case 403:
        return 'You don\'t have permission to do that.';
      case 404:
        return serverMessage ?? 'We couldn\'t find what you were looking for.';
      case 409:
        return serverMessage ??
            'This action conflicts with the current state. Please refresh and try again.';
      case 422:
        return serverMessage ?? 'Please check your input and try again.';
      case 429:
        return 'Too many requests. Please wait a moment and try again.';
      case 500:
      case 502:
      case 503:
      case 504:
        return 'Our servers are having trouble right now. Please try again later.';
      default:
        return serverMessage ?? generic;
    }
  }

  /// Extracts a human-friendly message from a structured error body, if one
  /// is present and looks safe to surface.
  static String? _extractServerMessage(dynamic data) {
    if (data is Map) {
      for (final key in const ['message', 'error', 'title', 'detail']) {
        final value = data[key];
        if (value is String && _isSafe(value)) {
          return value.trim();
        }
      }
    }
    return null;
  }

  /// Returns [raw] stripped of common prefixes when it is safe to display,
  /// otherwise falls back to [generic].
  static String _sanitize(String raw) {
    final trimmed = raw
        .replaceFirst(RegExp(r'^(Exception|Error|AppException):\s*'), '')
        .trim();
    return _isSafe(trimmed) ? trimmed : generic;
  }

  /// A message is considered safe when it reads like a sentence rather than a
  /// raw exception/stack-trace dump.
  static bool _isSafe(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty || trimmed.length > 160) return false;

    final lower = trimmed.toLowerCase();
    const unsafeMarkers = [
      'dioexception',
      'exception:',
      'statuscode',
      'status code',
      'stacktrace',
      'stack trace',
      'validatestatus',
      'requestoptions',
      'instance of',
      '#0 ',
      'http://',
      'https://',
      '\n',
    ];
    for (final marker in unsafeMarkers) {
      if (lower.contains(marker)) return false;
    }
    return true;
  }
}
