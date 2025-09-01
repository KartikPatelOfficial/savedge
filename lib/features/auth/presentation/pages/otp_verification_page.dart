import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'dart:convert';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/features/auth/presentation/bloc/otp_auth_cubit.dart';
import 'package:savedge/features/auth/presentation/pages/individual_signup_page.dart';
import 'package:savedge/features/auth/presentation/pages/employee_login_page.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _verifyOtp(String otp) {
    context.read<OtpAuthCubit>().verifyOtp(widget.phoneNumber, otp);
  }

  void _resendOtp() {
    context.read<OtpAuthCubit>().sendOtp(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpAuthCubit, OtpAuthState>(
        listener: (context, state) {
          if (state is OtpAuthNewUser) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => IndividualSignupPage(
                  phoneNumber: widget.phoneNumber,
                ),
              ),
            );
          } else if (state is OtpAuthIndividualUserAuthenticated) {
            // Store auth tokens and navigate to home
            _saveAuthTokens(
              accessToken: state.accessToken,
              refreshToken: state.refreshToken,
              expiresAt: state.expiresAt,
              user: state.user,
            );
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/home',
              (route) => false,
            );
          } else if (state is OtpAuthEmployeeAuthenticated) {
            final hasName = (state.employee.firstName.trim().isNotEmpty) &&
                (state.employee.lastName.trim().isNotEmpty);
            if (hasName) {
              // Store tokens and go straight to dashboard
              _saveAuthTokens(
                accessToken: state.accessToken,
                refreshToken: state.refreshToken,
                expiresAt: state.expiresAt,
                user: state.employee,
              );
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
            } else {
              // Collect missing name info first
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeLoginPage(
                    employee: state.employee,
                    accessToken: state.accessToken,
                    refreshToken: state.refreshToken,
                    expiresAt: state.expiresAt,
                  ),
                ),
              );
            }
          } else if (state is OtpAuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFDC2626),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          } else if (state is OtpAuthCodeSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('OTP sent successfully'),
                backgroundColor: Color(0xFF10B981),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is OtpAuthLoading;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 60),

                    // Header with back button
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFD1D5DB),
                              width: 1,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color(0xFF374151),
                              size: 20,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'Verification',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111827),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 64),

                    // Verification Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6F3FCC),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.security,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Title
                    const Text(
                      'Enter Verification Code',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    // Subtitle
                    Text(
                      'We sent a 6-digit code to\n${widget.phoneNumber}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 48),

                    // OTP Input
                    Pinput(
                      length: 6,
                      controller: _otpController,
                      enabled: !isLoading,
                      onCompleted: _verifyOtp,
                      defaultPinTheme: PinTheme(
                        width: 48,
                        height: 56,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFD1D5DB),
                            width: 1,
                          ),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 48,
                        height: 56,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF6F3FCC),
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Verify Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isLoading || _otpController.text.length != 6
                            ? null
                            : () => _verifyOtp(_otpController.text),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6F3FCC),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: const Color(0xFF9CA3AF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Verify Code',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Resend Option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive the code? ",
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: isLoading ? null : _resendOtp,
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF6F3FCC),
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Resend',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),
                  ],
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
