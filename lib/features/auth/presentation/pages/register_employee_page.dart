import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/auth/data/models/auth_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/auth/presentation/widgets/profile_auth_wrapper.dart';

class RegisterEmployeePage extends StatefulWidget {
  const RegisterEmployeePage({super.key});

  @override
  State<RegisterEmployeePage> createState() => _RegisterEmployeePageState();
}

class _RegisterEmployeePageState extends State<RegisterEmployeePage> {
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

  Future<void> _submit() async {
    if (_saving || _employeeInfo == null) return;

    final firstName = _firstController.text.trim();
    final lastName = _lastController.text.trim();

    if (firstName.isEmpty || lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        await _repo.registerEmployeeUser(
          email: _employeeInfo!.email, // Use email from employee API
          firstName: firstName,
          lastName: lastName,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful! Redirecting...'),
            ),
          );

          // Trigger the ProfileAuthWrapper to recheck auth status
          // which will detect the user is now registered and redirect to home
          await Future.delayed(const Duration(seconds: 1));
          ProfileAuthWrapper.recheckAuthStatus();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registration failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Loading employee information...',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4A5568),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53E3E).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    color: Color(0xFFE53E3E),
                    size: 48,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Something went wrong',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4A5568),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _loadEmployeeInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F3FCC),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Try Again',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_employeeInfo == null) {
      return const Scaffold(
        body: Center(child: Text('No employee information found')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Employee Registration'),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Welcome text
              const Text(
                'Welcome, Employee!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Complete your profile to access exclusive employee benefits.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4A5568),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              // Employee Information Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF6F3FCC).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF6F3FCC).withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Employee Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6F3FCC),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Employee Code', _employeeInfo!.employeeCode),
                    _buildInfoRow('Department', _employeeInfo!.department),
                    _buildInfoRow('Position', _employeeInfo!.position),
                    _buildInfoRow(
                      'Organization',
                      _employeeInfo!.organizationName,
                    ),
                    _buildInfoRow('Email', _employeeInfo!.email, isLast: true),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // First Name Field
              _buildTextField(
                controller: _firstController,
                label: 'First Name',
                hint: 'Enter your first name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 20),
              // Last Name Field
              _buildTextField(
                controller: _lastController,
                label: 'Last Name',
                hint: 'Enter your last name',
                icon: Icons.person_outline,
              ),
              const Spacer(),
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saving ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F3FCC),
                    disabledBackgroundColor: const Color(
                      0xFF6F3FCC,
                    ).withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
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
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isLast = false}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                '$label:',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D3748),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 14, color: Color(0xFF4A5568)),
              ),
            ),
          ],
        ),
        if (!isLast) ...[
          const SizedBox(height: 12),
          const Divider(color: Color(0xFF6F3FCC), thickness: 0.5),
          const SizedBox(height: 12),
        ],
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? icon,
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
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 16, color: Color(0xFF1A202C)),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF718096),
                fontSize: 16,
              ),
              prefixIcon: icon != null
                  ? Icon(icon, color: const Color(0xFF6F3FCC), size: 22)
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: icon != null ? 16 : 20,
                vertical: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
