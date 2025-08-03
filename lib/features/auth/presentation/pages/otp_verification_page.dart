import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import 'package:savedge/core/utils/extensions.dart';
import 'package:savedge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:savedge/features/auth/presentation/pages/otp_verification_args.dart';
import 'package:savedge/features/auth/presentation/widgets/employee_welcome_dialog.dart';
import 'package:savedge/shared/widgets/custom_button.dart';

/// OTP verification page for phone authentication
class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpController = TextEditingController();
  late OtpVerificationArgs args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as OtpVerificationArgs;
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _onVerifyOtp() {
    if (_otpController.text.length == 6) {
      context.read<AuthBloc>().add(
            VerifyOtpEvent(
              verificationId: args.verificationId,
              otp: _otpController.text,
            ),
          );
    }
  }

  void _onResendOtp() {
    context.read<AuthBloc>().add(
          SendOtpEvent(
            phoneNumber: args.phoneNumber,
            countryCode: args.countryCode,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: context.textTheme.headlineSmall,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.colorScheme.primary, width: 2),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.grey.shade100,
        border: Border.all(color: context.colorScheme.primary),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFirebaseSuccess) {
              // Firebase authentication successful, now check if user exists
              context.read<AuthBloc>().add(const CheckUserExistsEvent());
            } else if (state is AuthUserExists) {
              if (state.isEmployee && state.user != null) {
                // Show employee welcome dialog first
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => EmployeeWelcomeDialog(
                    user: state.user!,
                    onContinue: () {
                      Navigator.of(context).pop();
                      // Then sync profile and navigate to home
                      context.read<AuthBloc>().add(SyncUserProfileEvent(
                        email: state.firebaseUser.email ?? '',
                        displayName: state.firebaseUser.displayName,
                      ));
                    },
                  ),
                );
              } else {
                // User is an individual user, sync profile and navigate to home
                context.read<AuthBloc>().add(SyncUserProfileEvent(
                  email: state.firebaseUser.email ?? '',
                  displayName: state.firebaseUser.displayName,
                ));
              }
            } else if (state is AuthSyncSuccess) {
              // Profile synced successfully, navigate to home
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            } else if (state is AuthUserNotExists) {
              // User doesn't exist in backend, navigate to registration
              Navigator.pushReplacementNamed(
                context,
                '/user-setup',
                arguments: args.phoneNumber,
              );
            } else if (state is AuthOtpSent) {
              // OTP resent successfully
              context.showSuccessSnackBar('OTP sent successfully!');
            } else if (state is AuthError) {
              context.showErrorSnackBar(state.message);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Header
                  Icon(
                    Icons.message_outlined,
                    size: 80,
                    color: context.colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  
                  Text(
                    'Verify your phone number',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                      children: [
                        const TextSpan(text: 'We\'ve sent a 6-digit code to '),
                        TextSpan(
                          text: '${args.countryCode} ${args.phoneNumber}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),

                  // OTP Input
                  Pinput(
                    controller: _otpController,
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    autofocus: true,
                    onCompleted: (_) => _onVerifyOtp(),
                  ),
                  const SizedBox(height: 32),

                  // Verify button
                  CustomButton(
                    text: 'Verify',
                    onPressed: _onVerifyOtp,
                    isLoading: state is AuthLoading,
                    width: double.infinity,
                    height: 50,
                  ),
                  const SizedBox(height: 24),

                  // Resend OTP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Didn\'t receive the code? ',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      GestureDetector(
                        onTap: state is AuthLoading ? null : _onResendOtp,
                        child: Text(
                          'Resend',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const Spacer(),

                  // Edit phone number
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      'Wrong phone number? Tap to edit',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
