import 'package:flutter/material.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/features/auth/presentation/pages/phone_verification_page.dart';
import 'package:savedge/features/app/presentation/navigation/main_navigation_page.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:savedge/core/constants/app_constants.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final secureStorage = getIt<SecureStorageService>();
      final isAuthenticated = await secureStorage.isAuthenticated();
      final hasValidToken = await secureStorage.hasValidToken();

      bool finalAuthenticated = isAuthenticated && hasValidToken;

      // If token is expired but we have a refresh token, attempt a refresh before deciding
      if (isAuthenticated && !hasValidToken) {
        final refreshToken = await secureStorage.getRefreshToken();
        if (refreshToken != null && refreshToken.isNotEmpty) {
          try {
            debugPrint('AuthWrapper: Access token expired, attempting refresh...');
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
              options: Options(headers: {'Content-Type': 'application/json'}),
            );
            if (response.statusCode == 200) {
              final data = response.data as Map<String, dynamic>;
              final accessToken = data['accessToken'] as String;
              final newRefreshToken = data['refreshToken'] as String;
              final accessTokenExpires = DateTime.parse(data['accessTokenExpires'] as String);

              await secureStorage.saveTokens(
                accessToken: accessToken,
                refreshToken: newRefreshToken,
                expiresAt: accessTokenExpires,
              );

              debugPrint('AuthWrapper: Token refresh succeeded.');
              finalAuthenticated = true;
            } else {
              debugPrint('AuthWrapper: Token refresh failed with status ${response.statusCode}');
              finalAuthenticated = false;
            }
          } catch (e) {
            debugPrint('AuthWrapper: Token refresh error: $e');
            finalAuthenticated = false;
          }
        }
      }

      setState(() {
        _isAuthenticated = finalAuthenticated;
        _isLoading = false;
      });

      debugPrint('Auth Status: authenticated=$isAuthenticated, validToken=$hasValidToken, final=$finalAuthenticated');
    } catch (e) {
      debugPrint('Error checking auth status: $e');
      setState(() {
        _isAuthenticated = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Color(0xFF6F3FCC),
              ),
              SizedBox(height: 16),
              Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return _isAuthenticated
        ? const MainNavigationPage()
        : const PhoneVerificationPage();
  }
}
