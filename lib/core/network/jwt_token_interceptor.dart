import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';

/// Interceptor that attaches JWT token to each request for OTP-based authentication.
class JwtTokenInterceptor extends Interceptor {
  JwtTokenInterceptor({
    this.refreshThresholdMinutes = 2,
  });

  final int refreshThresholdMinutes;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final secureStorage = getIt<SecureStorageService>();
      
      // Check if we have a valid token
      final hasValidToken = await secureStorage.hasValidToken();
      
      if (hasValidToken) {
        final token = await secureStorage.getAccessToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
          if (kDebugMode) debugPrint('JwtTokenInterceptor: Added auth token to request');
        }
      } else {
        if (kDebugMode) debugPrint('JwtTokenInterceptor: No valid token available');
        
        // Check if we need to refresh the token
        final expiresAt = await secureStorage.getTokenExpiresAt();
        final refreshToken = await secureStorage.getRefreshToken();
        
        if (expiresAt != null && refreshToken != null) {
          // Token is expired but we have a refresh token
          if (kDebugMode) debugPrint('JwtTokenInterceptor: Token expired, refresh needed');
          // TODO: Implement token refresh logic with backend endpoint
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint('JwtTokenInterceptor error: $e');
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized responses
    if (err.response?.statusCode == 401) {
      if (kDebugMode) debugPrint('JwtTokenInterceptor: 401 Unauthorized, clearing tokens');
      
      try {
        final secureStorage = getIt<SecureStorageService>();
        await secureStorage.clearAll();
      } catch (e) {
        if (kDebugMode) debugPrint('Error clearing tokens: $e');
      }
    }
    
    handler.next(err);
  }
}