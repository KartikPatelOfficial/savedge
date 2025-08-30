import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:savedge/core/constants/app_constants.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';

/// Interceptor that attaches JWT token to each request for OTP-based authentication.
class JwtTokenInterceptor extends Interceptor {
  JwtTokenInterceptor({this.refreshThresholdMinutes = 2});

  final int refreshThresholdMinutes;
  bool _isRefreshing = false;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final secureStorage = getIt<SecureStorageService>();

      // Get current tokens
      final accessToken = await secureStorage.getAccessToken();
      final refreshToken = await secureStorage.getRefreshToken();
      final expiresAt = await secureStorage.getTokenExpiresAt();

      // If no access token, let the request fail and handle in onError
      if (accessToken == null || accessToken.isEmpty) {
        if (kDebugMode)
          debugPrint('JwtTokenInterceptor: No access token available');
        handler.next(options);
        return;
      }

      // Check if token is expired or about to expire
      bool needsRefresh = false;
      if (expiresAt != null) {
        final now = DateTime.now();
        final timeUntilExpiry = expiresAt.difference(now);
        needsRefresh = timeUntilExpiry.inMinutes <= refreshThresholdMinutes;

        if (kDebugMode && needsRefresh) {
          debugPrint(
            'JwtTokenInterceptor: Token expires in ${timeUntilExpiry.inMinutes} minutes, needs refresh',
          );
        }
      }

      // If token needs refresh and we have refresh token, do it proactively
      if (needsRefresh &&
          refreshToken != null &&
          refreshToken.isNotEmpty &&
          !_isRefreshing) {
        if (kDebugMode)
          debugPrint('JwtTokenInterceptor: Proactively refreshing token');

        final success = await _attemptTokenRefresh(refreshToken);
        if (success) {
          final newToken = await secureStorage.getAccessToken();
          if (newToken != null && newToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $newToken';
            if (kDebugMode)
              debugPrint(
                'JwtTokenInterceptor: Added refreshed token to request',
              );
          }
        } else {
          // Refresh failed, use existing token and let 401 handler deal with it
          options.headers['Authorization'] = 'Bearer $accessToken';
          if (kDebugMode)
            debugPrint(
              'JwtTokenInterceptor: Refresh failed, using existing token',
            );
        }
      } else {
        // Use existing token
        options.headers['Authorization'] = 'Bearer $accessToken';
        if (kDebugMode)
          debugPrint('JwtTokenInterceptor: Added existing token to request');
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
      if (kDebugMode)
        debugPrint(
          'JwtTokenInterceptor: 401 Unauthorized, attempting token refresh',
        );

      try {
        final secureStorage = getIt<SecureStorageService>();
        final refreshToken = await secureStorage.getRefreshToken();

        if (refreshToken != null && refreshToken.isNotEmpty && !_isRefreshing) {
          final success = await _attemptTokenRefresh(refreshToken);
          if (success) {
            // Retry the original request with new token
            final newToken = await secureStorage.getAccessToken();
            if (newToken != null && newToken.isNotEmpty) {
              if (kDebugMode)
                debugPrint(
                  'JwtTokenInterceptor: Retrying request with new token',
                );

              // Create a new request with the updated token
              final requestOptions = err.requestOptions;
              requestOptions.headers['Authorization'] = 'Bearer $newToken';

              try {
                // Use the original Dio instance from DI to maintain configuration
                final dio = getIt<Dio>();
                final response = await dio.fetch(requestOptions);
                handler.resolve(response);
                return;
              } catch (retryError) {
                if (kDebugMode)
                  debugPrint(
                    'JwtTokenInterceptor: Retry request failed: $retryError',
                  );
                // Don't clear tokens here, let it fail normally
              }
            }
          } else {
            if (kDebugMode)
              debugPrint('JwtTokenInterceptor: Token refresh failed');
            // Only clear tokens if refresh explicitly failed with invalid token
            await secureStorage.clearAll();
          }
        } else if (refreshToken == null || refreshToken.isEmpty) {
          if (kDebugMode)
            debugPrint(
              'JwtTokenInterceptor: No refresh token available, clearing tokens',
            );
          await secureStorage.clearAll();
        } else {
          if (kDebugMode)
            debugPrint(
              'JwtTokenInterceptor: Refresh already in progress, skipping',
            );
        }
      } catch (e) {
        if (kDebugMode)
          debugPrint('JwtTokenInterceptor: Error handling 401: $e');
      }
    }

    handler.next(err);
  }

  Future<bool> _attemptTokenRefresh(String refreshToken) async {
    if (_isRefreshing) {
      if (kDebugMode)
        debugPrint('JwtTokenInterceptor: Token refresh already in progress');
      return false;
    }

    _isRefreshing = true;

    try {
      if (kDebugMode) debugPrint('JwtTokenInterceptor: Starting token refresh');

      final dio = Dio();
      // Accept dev self-signed certs on Android emulator
      if (kDebugMode && !kIsWeb && Platform.isAndroid) {
        dio.httpClientAdapter = IOHttpClientAdapter()
          ..onHttpClientCreate = (client) {
            client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
            return client;
          };
      }
      final response = await dio.post(
        '${AppConstants.baseUrl}/api/auth/refresh',
        data: {'RefreshToken': refreshToken},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final secureStorage = getIt<SecureStorageService>();

        final accessTokenExpires = DateTime.parse(data['accessTokenExpires']);
        await secureStorage.saveTokens(
          accessToken: data['accessToken'],
          refreshToken: data['refreshToken'],
          expiresAt: accessTokenExpires,
        );

        if (kDebugMode)
          debugPrint('JwtTokenInterceptor: Token refresh successful');
        return true;
      } else {
        if (kDebugMode)
          debugPrint(
            'JwtTokenInterceptor: Token refresh failed with status: ${response.statusCode}',
          );
        return false;
      }
    } catch (e) {
      if (kDebugMode)
        debugPrint('JwtTokenInterceptor: Token refresh error: $e');
      return false;
    } finally {
      _isRefreshing = false;
    }
  }
}
