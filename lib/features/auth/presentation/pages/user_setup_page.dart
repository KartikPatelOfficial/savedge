import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/utils/extensions.dart';
import 'package:savedge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:savedge/shared/widgets/custom_button.dart';
import 'package:savedge/shared/widgets/custom_text_field.dart';

/// User setup page for new users to complete their profile
class UserSetupPage extends StatefulWidget {
  const UserSetupPage({super.key});

  @override
  State<UserSetupPage> createState() => _UserSetupPageState();
}

class _UserSetupPageState extends State<UserSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _onCompleteProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
            RegisterUserEvent(
              email: _emailController.text.trim(),
              firstName: _firstNameController.text.trim().isEmpty 
                  ? null 
                  : _firstNameController.text.trim(),
              lastName: _lastNameController.text.trim().isEmpty 
                  ? null 
                  : _lastNameController.text.trim(),
            ),
          );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }
    if (value.length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    if (value.length > 50) {
      return '$fieldName must be less than 50 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthRegisterSuccess) {
                // Registration successful, sync profile
                context.read<AuthBloc>().add(
                      SyncUserProfileEvent(
                        email: _emailController.text.trim(),
                        displayName: _firstNameController.text.trim().isEmpty
                            ? null
                            : '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}',
                      ),
                    );
              } else if (state is AuthSyncSuccess) {
                // Profile synced successfully, navigate to home
                context.pushNamedAndClearStack('/home');
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
                      const SizedBox(height: 20),
                      
                      // Header
                      Text(
                        'Welcome to Savedge!',
                        style: context.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please complete your profile to get started',
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Email field (required)
                      CustomTextField(
                        label: 'Email Address *',
                        hint: 'Enter your email address',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: _validateEmail,
                        prefixIcon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 20),

                      // First name field (optional)
                      CustomTextField(
                        label: 'First Name',
                        hint: 'Enter your first name (optional)',
                        controller: _firstNameController,
                        textInputAction: TextInputAction.next,
                        validator: (value) => _validateName(value, 'First name'),
                        prefixIcon: Icons.person_outline,
                      ),
                      const SizedBox(height: 20),

                      // Last name field (optional)
                      CustomTextField(
                        label: 'Last Name',
                        hint: 'Enter your last name (optional)',
                        controller: _lastNameController,
                        textInputAction: TextInputAction.done,
                        validator: (value) => _validateName(value, 'Last name'),
                        prefixIcon: Icons.person_outline,
                        onSubmitted: (_) => _onCompleteProfile(),
                      ),
                      const SizedBox(height: 32),

                      // Complete profile button
                      CustomButton(
                        text: 'Complete Profile',
                        onPressed: _onCompleteProfile,
                        isLoading: state is AuthLoading,
                        width: double.infinity,
                        height: 50,
                      ),
                      const SizedBox(height: 16),

                      // Information text
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: context.colorScheme.primary.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: context.colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'If you\'re part of an organization, your employer will have already added your details. Your account will be automatically linked.',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Loading indicator
                      if (state is AuthLoading)
                        const Center(
                          child: Column(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text('Setting up your account...'),
                            ],
                          ),
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
