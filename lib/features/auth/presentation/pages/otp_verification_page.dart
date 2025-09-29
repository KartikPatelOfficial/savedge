import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/features/auth/presentation/bloc/otp_auth_cubit.dart';
import 'package:savedge/features/auth/presentation/pages/employee_login_page.dart';
import 'package:savedge/features/auth/presentation/pages/individual_signup_page.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage>
    with TickerProviderStateMixin {
  final _otpController = TextEditingController();
  late AnimationController _fadeAnimationController;
  late AnimationController _slideAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  Timer? _timer;
  int _resendCountdown = 30;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startResendTimer();
  }

  void _initializeAnimations() {
    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _slideAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _fadeAnimationController.forward();
    _slideAnimationController.forward();
  }

  void _startResendTimer() {
    _canResend = false;
    _resendCountdown = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _verifyOtp(String otp) {
    HapticFeedback.mediumImpact();
    FocusScope.of(context).unfocus();
    context.read<OtpAuthCubit>().verifyOtp(widget.phoneNumber, otp);
  }

  void _resendOtp() {
    if (!_canResend) return;

    HapticFeedback.lightImpact();
    _startResendTimer();
    context.read<OtpAuthCubit>().sendOtp(widget.phoneNumber);
  }

  String get _formatPhoneNumber {
    if (widget.phoneNumber.length <= 4) return widget.phoneNumber;
    final start = widget.phoneNumber.substring(
      0,
      widget.phoneNumber.length - 4,
    );
    final end = widget.phoneNumber.substring(widget.phoneNumber.length - 4);
    return '$start****$end';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<OtpAuthCubit, OtpAuthState>(
      listener: (context, state) {
        if (state is OtpAuthNewUser) {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  IndividualSignupPage(phoneNumber: widget.phoneNumber),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: animation.drive(
                        Tween(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).chain(CurveTween(curve: Curves.easeInOutCubic)),
                      ),
                      child: child,
                    );
                  },
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        } else if (state is OtpAuthIndividualUserAuthenticated) {
          HapticFeedback.lightImpact();
          _saveAuthTokens(
            accessToken: state.accessToken,
            refreshToken: state.refreshToken,
            expiresAt: state.expiresAt,
            user: state.user,
          );
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/home', (route) => false);
        } else if (state is OtpAuthEmployeeAuthenticated) {
          HapticFeedback.lightImpact();
          final hasName =
              (state.employee.firstName.trim().isNotEmpty) &&
              (state.employee.lastName.trim().isNotEmpty);
          if (hasName) {
            _saveAuthTokens(
              accessToken: state.accessToken,
              refreshToken: state.refreshToken,
              expiresAt: state.expiresAt,
              user: state.employee,
            );
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/home', (route) => false);
          } else {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    EmployeeLoginPage(
                      employee: state.employee,
                      accessToken: state.accessToken,
                      refreshToken: state.refreshToken,
                      expiresAt: state.expiresAt,
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: animation.drive(
                          Tween(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.easeInOutCubic)),
                        ),
                        child: child,
                      );
                    },
                transitionDuration: const Duration(milliseconds: 400),
              ),
            );
          }
        } else if (state is OtpAuthError) {
          HapticFeedback.heavyImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFFDC2626),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(16),
            ),
          );
        } else if (state is OtpAuthCodeSent) {
          HapticFeedback.lightImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Verification code sent successfully',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFF10B981),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.all(16),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is OtpAuthLoading;

        return Scaffold(
          backgroundColor: const Color(0xFFFAFBFC),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFAFBFC), Color(0xFFF3F4F6)],
                stops: [0.0, 1.0],
              ),
            ),
            child: SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: 24,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight:
                            screenHeight -
                            MediaQuery.of(context).padding.top -
                            MediaQuery.of(context).padding.bottom -
                            48,
                      ),
                      child: Column(
                        children: [
                          // Header
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Color(0xFF1F2937),
                                    size: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Expanded(
                                child: Text(
                                  'Verify Code',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: screenHeight * 0.08),

                          // Main Content
                          Column(
                            children: [
                              // Phone Icon (You can replace with Lottie animation)
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6F3FCC),
                                      Color(0xFF8B5FD1),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Icon(
                                  Icons.smartphone_rounded,
                                  color: Colors.white,
                                  size: 48,
                                ),
                              ),

                              SizedBox(height: screenHeight * 0.06),

                              // Title
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color(0xFF1F2937),
                                        Color(0xFF374151),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ).createShader(bounds),
                                child: const Text(
                                  'Almost there!',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    letterSpacing: -0.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Subtitle
                              Text(
                                'Please enter the 6-digit code sent to\n${_formatPhoneNumber}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: const Color(
                                    0xFF6B7280,
                                  ).withOpacity(0.8),
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: screenHeight * 0.08),

                              // OTP Input Container
                              Container(
                                padding: const EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: const Color(0xFFE2E8F0),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    // Pin Input
                                    Pinput(
                                      length: 6,
                                      controller: _otpController,
                                      enabled: !isLoading,
                                      onCompleted: _verifyOtp,
                                      defaultPinTheme: PinTheme(
                                        width: 52,
                                        height: 60,
                                        textStyle: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1F2937),
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF8FAFC),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFFE2E8F0),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                      focusedPinTheme: PinTheme(
                                        width: 52,
                                        height: 60,
                                        textStyle: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1F2937),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFF6F3FCC),
                                            width: 2.5,
                                          ),
                                        ),
                                      ),
                                      submittedPinTheme: PinTheme(
                                        width: 52,
                                        height: 60,
                                        textStyle: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1F2937),
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF6F3FCC,
                                          ).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFF6F3FCC),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 32),

                                    // Verify Button
                                    AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      width: double.infinity,
                                      height: 56,
                                      child: ElevatedButton(
                                        onPressed:
                                            isLoading ||
                                                _otpController.text.length != 6
                                            ? null
                                            : () => _verifyOtp(
                                                _otpController.text,
                                              ),
                                        style:
                                            ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFF6F3FCC,
                                              ),
                                              foregroundColor: Colors.white,
                                              disabledBackgroundColor:
                                                  const Color(0xFFE5E7EB),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              elevation: 0,
                                            ).copyWith(
                                              backgroundColor:
                                                  WidgetStateProperty.resolveWith<
                                                    Color
                                                  >((Set<WidgetState> states) {
                                                    if (states.contains(
                                                      WidgetState.disabled,
                                                    )) {
                                                      return const Color(
                                                        0xFFE5E7EB,
                                                      );
                                                    }
                                                    if (states.contains(
                                                      WidgetState.pressed,
                                                    )) {
                                                      return const Color(
                                                        0xFF5B2FA3,
                                                      );
                                                    }
                                                    return const Color(
                                                      0xFF6F3FCC,
                                                    );
                                                  }),
                                            ),
                                        child: isLoading
                                            ? const SizedBox(
                                                width: 24,
                                                height: 24,
                                                child:
                                                    CircularProgressIndicator(
                                                      color: Colors.white,
                                                      strokeWidth: 2.5,
                                                    ),
                                              )
                                            : const Text(
                                                'Verify & Continue',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.2,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: screenHeight * 0.04),

                              // Resend Section
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: const Color(
                                      0xFFE2E8F0,
                                    ).withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Didn't receive the code? ",
                                      style: TextStyle(
                                        color: const Color(
                                          0xFF6B7280,
                                        ).withOpacity(0.8),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    if (!_canResend)
                                      Text(
                                        'Resend in ${_resendCountdown}s',
                                        style: const TextStyle(
                                          color: Color(0xFF9CA3AF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    else
                                      GestureDetector(
                                        onTap: isLoading ? null : _resendOtp,
                                        child: const Text(
                                          'Resend Code',
                                          style: TextStyle(
                                            color: Color(0xFF6F3FCC),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Color(0xFF6F3FCC),
                                            decorationThickness: 1.5,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveAuthTokens({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
    required dynamic user,
  }) async {
    try {
      final secureStorage = getIt<SecureStorageService>();

      // Save tokens
      await secureStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresAt: expiresAt,
      );

      // Save user data
      if (user.id != null) {
        await secureStorage.saveUserId(user.id.toString());
      }

      // Save full user data as JSON
      await secureStorage.saveUserData(jsonEncode(user.toJson()));

      debugPrint('Auth tokens and user data saved successfully');
    } catch (e) {
      debugPrint('Error saving auth tokens: $e');
    }
  }
}
