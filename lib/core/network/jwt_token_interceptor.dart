import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Interceptor that attaches JWT token to each request for OTP-based authentication.
class JwtTokenInterceptor extends Interceptor {
  JwtTokenInterceptor({
    this.refreshThresholdSeconds = 120,
  });

  final int refreshThresholdSeconds;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      
      if (token != null && token.isNotEmpty) {
        // TODO: Add token expiry check if needed
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      if (kDebugMode) debugPrint('JwtTokenInterceptor error: $e');
    }
    handler.next(options);
  }
}