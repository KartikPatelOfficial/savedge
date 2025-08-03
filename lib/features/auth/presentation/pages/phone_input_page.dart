import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_picker/country_picker.dart';

import 'package:savedge/core/utils/extensions.dart';
import 'package:savedge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:savedge/features/auth/presentation/pages/otp_verification_args.dart';
import 'package:savedge/shared/widgets/custom_button.dart';

/// Phone number input page for authentication
class PhoneInputPage extends StatefulWidget {
  const PhoneInputPage({super.key});

  @override
  State<PhoneInputPage> createState() => _PhoneInputPageState();
}

class _PhoneInputPageState extends State<PhoneInputPage> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Country _selectedCountry = Country.parse('IN'); // Default to India

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onCountryPickerTap() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
        });
      },
    );
  }

  void _onSendOtp() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            SendOtpEvent(
              phoneNumber: _phoneController.text.trim(),
              countryCode: '+${_selectedCountry.phoneCode}',
            ),
          );
    }
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone number should contain only digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthOtpSent) {
              Navigator.pushNamed(
                context,
                '/otp-verification',
                arguments: OtpVerificationArgs(
                  phoneNumber: _phoneController.text.trim(),
                  countryCode: '+${_selectedCountry.phoneCode}',
                  verificationId: state.phoneAuth.verificationId!,
                ),
              );
            } else if (state is AuthUserExists) {
              // User is already authenticated and exists, navigate to home
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            } else if (state is AuthError) {
              context.showErrorSnackBar(state.message);
            }
          },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      
                      // Header
                      Text(
                        'Welcome to Savedge',
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter your phone number to get started',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Country selector and phone input
                      Text(
                        'Phone Number',
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Country picker
                          GestureDetector(
                            onTap: _onCountryPickerTap,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _selectedCountry.flagEmoji,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '+${_selectedCountry.phoneCode}',
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          
                          // Phone number input
                          Expanded(
                            child: TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              validator: _validatePhoneNumber,
                              decoration: const InputDecoration(
                                hintText: 'Enter phone number',
                              ),
                              onFieldSubmitted: (_) => _onSendOtp(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Send OTP button
                      CustomButton(
                        text: 'Send OTP',
                        onPressed: _onSendOtp,
                        isLoading: state is AuthLoading,
                        width: double.infinity,
                        height: 50,
                      ),

                      const Spacer(),

                      // Terms and conditions
                      Text(
                        'By continuing, you agree to our Terms of Service and Privacy Policy',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
    );
  }
}
