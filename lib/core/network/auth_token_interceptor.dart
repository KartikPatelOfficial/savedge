import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Interceptor that attaches Firebase ID token to each request.
class AuthTokenInterceptor extends Interceptor {
  AuthTokenInterceptor(this._firebaseAuth, {this.refreshThresholdSeconds = 120});

  final FirebaseAuth _firebaseAuth;
  final int refreshThresholdSeconds;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final result = await user.getIdTokenResult();
        bool forceRefresh = false;
        final expiry = result.expirationTime;
        if (expiry != null) {
          final remaining = expiry.difference(DateTime.now()).inSeconds;
          forceRefresh = remaining < refreshThresholdSeconds;
        }
        final token = await user.getIdToken(forceRefresh);
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      if (kDebugMode) debugPrint('AuthTokenInterceptor error: $e');
    }
    handler.next(options);
  }
}
