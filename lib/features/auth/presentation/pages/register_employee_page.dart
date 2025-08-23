import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/auth/data/models/auth_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

class RegisterEmployeePage extends StatefulWidget {
  const RegisterEmployeePage({super.key});

  @override
  State<RegisterEmployeePage> createState() => _RegisterEmployeePageState();
}

class _RegisterEmployeePageState extends State<RegisterEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstController = TextEditingController();
  final _lastController = TextEditingController();
  bool _saving = false;
  bool _isLoading = true;
  EmployeeInfoResponse? _employeeInfo;
  String? _error;

  AuthRepository get _repo => GetIt.I<AuthRepository>();

  @override
  void initState() {
    super.initState();
    _loadEmployeeInfo();
  }

  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose();
    super.dispose();
  }

  Future<void> _loadEmployeeInfo() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser?.phoneNumber != null) {
        final employeeInfo = await _repo.checkEmployeeByPhone(
          firebaseUser!.phoneNumber!,
        );
        if (mounted) {
          setState(() {
            _employeeInfo = employeeInfo;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _error = 'No phone number found';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load employee information: $e';
          _isLoading = false;
        });
      }
    }
  }

  String? _validateName(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    if (value.trim().length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    return null;
  }

  Future<void> _submit() async {
    if (_saving || _employeeInfo == null) return;

    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _saving = true);

    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        await _repo.registerEmployeeUser(
          email: _employeeInfo!.email,
          firstName: _firstController.text.trim(),
          lastName: _lastController.text.trim(),
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.white),
                  SizedBox(width: 12),
                  Text('Employee registration successful! Welcome aboard!'),
                ],
              ),
              backgroundColor: const Color(0xFF10B981),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(20),
            ),
          );

          await Future.delayed(const Duration(milliseconds: 1500));
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text('Registration failed: $e')),
              ],
            ),
            backgroundColor: const Color(0xFFE53E3E),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(20),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF374151),
              size: 20,
            ),
          ),
        ),
        title: const Text(
          'Step 2 of 2',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if (_isLoading)
            _buildLoadingView()
          else if (_error != null)
            _buildErrorView()
          else
            _buildMainContent(),

          // Loading Overlay
          if (_saving)
            Container(
              color: const Color(0xFF6F3FCC).withOpacity(0.1),
              child: const Center(
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.all(40),
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: Color(0xFF6F3FCC),
                          strokeWidth: 3,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Creating your employee account...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Container(
        color: const Color(0xFF6F3FCC).withOpacity(0.1),
        child: const Center(
          child: Card(
            elevation: 0,
            margin: EdgeInsets.all(40),
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFF6F3FCC),
                    strokeWidth: 3,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading employee information...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53E3E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    size: 32,
                    color: Color(0xFFE53E3E),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Unable to Load Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                            _error = null;
                          });
                          _loadEmployeeInfo();
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF6F3FCC),
                          side: const BorderSide(color: Color(0xFF6F3FCC)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Retry',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6F3FCC),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Go Back',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              const Text(
                'Employee Registration',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Complete your employee profile to access exclusive features and team benefits.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A5568),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // Employee Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF10B981).withOpacity(0.2),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, size: 16, color: Color(0xFF10B981)),
                    SizedBox(width: 6),
                    Text(
                      'Employee Verified',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Employee Info Card
              if (_employeeInfo != null) ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Organization Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A202C),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(
                        Icons.business,
                        'Company',
                        _employeeInfo!.organizationName,
                      ),
                      Container(
                        height: 1,
                        color: const Color(0xFFCBD5E0),
                        margin: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      _buildInfoRow(
                        Icons.email_outlined,
                        'Email',
                        _employeeInfo!.email,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],

              // Form Fields
              _buildTextField(
                controller: _firstController,
                label: 'First Name',
                hint: 'Enter your first name',
                icon: Icons.person_outline,
                validator: (value) => _validateName(value, 'First name'),
              ),

              const SizedBox(height: 20),

              _buildTextField(
                controller: _lastController,
                label: 'Last Name',
                hint: 'Enter your last name',
                icon: Icons.person_outline,
                validator: (value) => _validateName(value, 'Last name'),
              ),

              const SizedBox(height: 40),

              // Primary Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saving ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F3FCC),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(
                      0xFF6F3FCC,
                    ).withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: _saving
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Complete Employee Registration',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 40),

              // Privacy Footer
              _buildPrivacyFooter(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3748),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1A202C),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(icon, color: const Color(0xFF6B7280), size: 20),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6F3FCC), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE53E3E), width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE53E3E), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            errorStyle: const TextStyle(
              color: Color(0xFFE53E3E),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF6B7280)),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyFooter() {
    return Center(
      child: Text.rich(
        TextSpan(
          text: 'By continuing, you agree to our ',
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
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const TextSpan(
              text: ' and ',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  // TODO: Open terms of service
                },
                child: const Text(
                  'Terms of Service',
                  style: TextStyle(
                    color: Color(0xFF6F3FCC),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const TextSpan(
              text: '.',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
