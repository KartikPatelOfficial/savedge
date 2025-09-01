import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/network/network_client.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';

class EmployeeLoginPage extends StatefulWidget {
  final EmployeeInfoModel employee;
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  const EmployeeLoginPage({
    super.key,
    required this.employee,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  @override
  State<EmployeeLoginPage> createState() => _EmployeeLoginPageState();
}

class _EmployeeLoginPageState extends State<EmployeeLoginPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _saving = false;

  bool get _needsName =>
      (widget.employee.firstName.trim().isEmpty) &&
      (widget.employee.lastName.trim().isEmpty);

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.employee.firstName;
    _lastNameController.text = widget.employee.lastName;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _saveTokens() async {
    final secureStorage = getIt<SecureStorageService>();
    await secureStorage.saveTokens(
      accessToken: widget.accessToken,
      refreshToken: widget.refreshToken,
      expiresAt: widget.expiresAt,
    );
  }

  Future<void> _saveAndContinue() async {
    try {
      setState(() => _saving = true);
      // Ensure tokens are saved so Authorization header is attached
      await _saveTokens();

      if (_needsName) {
        final first = _firstNameController.text.trim();
        final last = _lastNameController.text.trim();
        if (first.isEmpty || last.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter your first and last name'),
            ),
          );
          setState(() => _saving = false);
          return;
        }

        // Update current user profile with names
        final http = getIt<HttpClient>();
        await http.put(
          '/api/users/me',
          data: {'firstName': first, 'lastName': last},
          options: Options(headers: {'Content-Type': 'application/json'}),
        );

        final updatedEmployee = widget.employee.copyWith(
          firstName: first,
          lastName: last,
        );
        final secureStorage = getIt<SecureStorageService>();
        await secureStorage.saveUserId(updatedEmployee.id.toString());
        await secureStorage.saveUserData(jsonEncode(updatedEmployee.toJson()));
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/home', (route) => false);
        return;
      }

      // Names already present, just persist and continue
      final secureStorage = getIt<SecureStorageService>();
      await secureStorage.saveUserId(widget.employee.id.toString());
      await secureStorage.saveUserData(jsonEncode(widget.employee.toJson()));
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } catch (e) {
      debugPrint('Error during employee onboarding: $e');
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Gradient Header
                    Container(
                      height: 140,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF6F3FCC), Color(0xFF8B5FE6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome Back',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Employee Account Verified',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Employee Details / Onboarding Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF0B102580).withOpacity(0.06),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFFE5E7EB),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (widget.employee.organization.logoUrl != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                widget.employee.organization.logoUrl!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    _buildOrganizationPlaceholder(),
                              ),
                            )
                          else
                            _buildOrganizationPlaceholder(),

                          const SizedBox(height: 12),
                          Text(
                            widget.employee.organization.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111827),
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 8),

                          // Employee Information
                          _buildInfoRow(
                            'Employee ID',
                            widget.employee.employeeId,
                          ),
                          _buildInfoRow(
                            'Department',
                            widget.employee.department.isNotEmpty
                                ? widget.employee.department
                                : 'N/A',
                          ),
                          _buildInfoRow(
                            'Position',
                            widget.employee.position.isNotEmpty
                                ? widget.employee.position
                                : 'N/A',
                          ),
                          _buildInfoRow('Phone', widget.employee.phoneNumber),
                          _buildInfoRow('Email', widget.employee.email),

                          const SizedBox(height: 8),
                          if (_needsName) ...[
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Complete your profile',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111827),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildTextField(
                              controller: _firstNameController,
                              label: 'First Name',
                              hint: 'Enter your first name',
                            ),
                            const SizedBox(height: 12),
                            _buildTextField(
                              controller: _lastNameController,
                              label: 'Last Name',
                              hint: 'Enter your last name',
                            ),
                            const SizedBox(height: 8),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _saving ? null : _saveAndContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6F3FCC),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: _saving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                _needsName
                                    ? 'Save & Continue'
                                    : 'Continue to App',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Note
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        'Note: Your employee details cannot be modified in this app. Please contact your organization administrator for any changes.',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
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

  Widget _buildOrganizationPlaceholder() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF6F3FCC).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.business, color: Color(0xFF6F3FCC), size: 30),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF111827),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6F3FCC), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
