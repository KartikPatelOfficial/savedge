import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  bool get _isValidPhone => _phoneController.text.trim().length >= 8;

  void _startVerification() {
    FocusScope.of(context).unfocus();
    context.read<PhoneAuthCubit>().startPhoneVerification(_normalizedPhone());
  }

  String _normalizedPhone() {
    final raw = _phoneController.text.trim();
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
    return BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, state) {
        if (state is PhoneAuthCodeSent) {
          setState(() => _codeSent = true);
        } else if (state is PhoneAuthVerified) {
          Navigator.of(context).pop();
        } else if (state is PhoneAuthError) {
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
        }
      },
      builder: (context, state) {
        final isLoading = state is PhoneAuthLoading || _submittingCode;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _codeSent
                  ? _buildOtpView(isLoading)
                  : _buildPhoneInputView(isLoading),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhoneInputView(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 80),

          // App Logo - Simple flat icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF6F3FCC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.savings_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),

          const SizedBox(height: 40),

          // Welcome Title
          const Text(
            'Welcome to Savedge',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6F3FCC),
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          // Subtitle
          const Text(
            'Login to continue',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 64),

          // Phone Input Field
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mobile Number',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF111827),
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your mobile number',
                  hintStyle: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    color: Color(0xFF6B7280),
                    size: 20,
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF9FAFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFD1D5DB),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFD1D5DB),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF6F3FCC),
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Log In Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: !_isValidPhone || isLoading
                  ? null
                  : _startVerification,
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
                      'Log In',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 16),

          // Skip Button
          TextButton(
            onPressed: isLoading
                ? null
                : () => Navigator.of(context).pushReplacementNamed('/home'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF6B7280),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text(
              'Skip',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),

          const Spacer(),

          // Privacy Policy Footer
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Text.rich(
              TextSpan(
                text: 'By continuing, you accept our ',
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Open privacy policy
                      },
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Color(0xFF6F3FCC),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
        ],
      ),
    );
  }

  Widget _buildOtpView(bool isLoading) {
    return Padding(
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
                  border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
                ),
                child: IconButton(
                  onPressed: () => setState(() => _codeSent = false),
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
            child: const Icon(Icons.security, color: Colors.white, size: 40),
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
            'We sent a 6-digit code to\n${_normalizedPhone()}',
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
            onCompleted: (code) => _submitOtp(code),
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
                border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
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
                border: Border.all(color: const Color(0xFF6F3FCC), width: 2),
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
                  : () => _submitOtp(_otpController.text),
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
                onPressed: isLoading ? null : _startVerification,
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
    );
  }
}
