import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savedge/core/constants/app_constants.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/features/app/presentation/navigation/main_navigation_page.dart';
import 'package:savedge/features/auth/presentation/pages/phone_verification_page.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  bool _isAuthenticated = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Set status bar to transparent for immersive splash
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // Initialize animations
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
    _checkAuthStatus();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
            debugPrint(
              'AuthWrapper: Access token expired, attempting refresh...',
            );
            final dio = Dio();
            // Accept dev self-signed certs on Android emulator
            if (kDebugMode && !kIsWeb && Platform.isAndroid) {
              dio.httpClientAdapter = IOHttpClientAdapter()
                ..onHttpClientCreate = (client) {
                  client.badCertificateCallback =
                      (X509Certificate cert, String host, int port) => true;
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
              final accessTokenExpires = DateTime.parse(
                data['accessTokenExpires'] as String,
              );

              await secureStorage.saveTokens(
                accessToken: accessToken,
                refreshToken: newRefreshToken,
                expiresAt: accessTokenExpires,
              );

              debugPrint('AuthWrapper: Token refresh succeeded.');
              finalAuthenticated = true;
            } else {
              debugPrint(
                'AuthWrapper: Token refresh failed with status ${response.statusCode}',
              );
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

      debugPrint(
        'Auth Status: authenticated=$isAuthenticated, validToken=$hasValidToken, final=$finalAuthenticated',
      );
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
      return _buildSplashScreen(context);
    }

    return _isAuthenticated
        ? const MainNavigationPage()
        : const PhoneVerificationPage();
  }

  Widget _buildSplashScreen(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background decorative circles
          Positioned(
            top: -80,
            right: -80,
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) => Opacity(
                opacity: _fadeAnimation.value * 0.5,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF6F3FCC).withValues(alpha: 0.15),
                        const Color(0xFF6F3FCC).withValues(alpha: 0.0),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) => Opacity(
                opacity: _fadeAnimation.value * 0.5,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFC0CA33).withValues(alpha: 0.2),
                        const Color(0xFFC0CA33).withValues(alpha: 0.0),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          // Small accent circle
          Positioned(
            top: size.height * 0.3,
            left: -30,
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) => Opacity(
                opacity: _fadeAnimation.value * 0.3,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: size.width * 0.5,
                          maxHeight: size.width * 0.45,
                        ),
                        child: Image.asset(
                          'assets/images/logo_transparant.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildFallbackLogo();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Tagline with slide animation
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Unbeatable Savings & Coupons',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Footer section
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) => Opacity(
                opacity: _fadeAnimation.value,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Vocal for Local
                        const Text(
                          'Vocal for Local',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Made in India with flag
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Made in ',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                            const Text(
                              'India',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Indian flag representation
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFF9933),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2),
                                        topRight: Radius.circular(2),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 5,
                                    color: Colors.white,
                                    child: Center(
                                      child: Container(
                                        width: 3,
                                        height: 3,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF000080),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 20,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF138808),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(2),
                                        bottomRight: Radius.circular(2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Loading indicator
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFF6F3FCC).withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF6F3FCC).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.local_offer_rounded,
            size: 64,
            color: Color(0xFF6F3FCC),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'SAVEDGE',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Color(0xFF6F3FCC),
          ),
        ),
      ],
    );
  }
}
