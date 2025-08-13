import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pinput.dart';
import 'package:savedge/features/auth/presentation/bloc/phone_auth_cubit.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _codeSent = false;
  bool _submittingCode = false;

  @override
  void initState() {
    super.initState();
    // If user already authenticated, pop back to ProfileAuthWrapper
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  bool get _isValidPhone =>
      _phoneController.text.trim().length >= 8; // simplistic validation

  void _startVerification() {
    FocusScope.of(context).unfocus();
    context.read<PhoneAuthCubit>().startPhoneVerification(_normalizedPhone());
  }

  String _normalizedPhone() {
    final raw = _phoneController.text.trim();
    // Ensure starts with +; assume +1 default if not provided
    if (raw.startsWith('+')) return raw;
    return '+1$raw';
  }

  Future<void> _submitOtp(String code) async {
    setState(() => _submittingCode = true);
    await context.read<PhoneAuthCubit>().submitOtp(code);
    if (mounted) setState(() => _submittingCode = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneAuthCodeSent) {
          setState(() => _codeSent = true);
        } else if (state is PhoneAuthVerified) {
          // Pop back to ProfileAuthWrapper to re-check auth status
          Navigator.of(context).pop();
        } else if (state is PhoneAuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is PhoneAuthLoading || _submittingCode;
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(toolbarHeight: 0, elevation: 0),
              body: SafeArea(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _codeSent
                      ? _buildOtpView(theme, isLoading)
                      : _buildPhoneInputView(theme, isLoading),
                ),
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    color: Colors.black.withOpacity(0.05),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildPhoneInputView(ThemeData theme, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Center(
            child: Column(
              children: [
                Text(
                  'Welcome to Savedge',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Login to Break Price Chains!',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text('Mobile Number', style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Enter mobile number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              isDense: true,
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: !_isValidPhone || isLoading
                  ? null
                  : _startVerification,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: const StadiumBorder(),
              ),
              child: const Text('Log In'),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: isLoading
                  ? null
                  : () => Navigator.of(context).pushReplacementNamed('/home'),
              child: const Text('Skip'),
            ),
          ),
          const Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text.rich(
                TextSpan(
                  text: 'By continue to login, you accept our\n',
                  style: theme.textTheme.bodySmall,
                  children: [
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          // TODO: open privacy policy URL
                        },
                        child: Text(
                          'Privacy Policy.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpView(ThemeData theme, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OTP Verification',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "We've sent a verification code to your mobile number.\nPlease enter the code below to continue.",
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          Text('Type your 6 digit code', style: theme.textTheme.labelLarge),
          const SizedBox(height: 12),
          Pinput(
            length: 6,
            controller: _otpController,
            enabled: !isLoading,
            onCompleted: (code) => _submitOtp(code),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading || _otpController.text.length != 6
                  ? null
                  : () => _submitOtp(_otpController.text),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: const StadiumBorder(),
              ),
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
