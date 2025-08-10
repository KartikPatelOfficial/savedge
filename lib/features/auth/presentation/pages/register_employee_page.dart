import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/auth/data/models/auth_models.dart';
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
        final employeeInfo = await _repo.checkEmployeeByPhone(firebaseUser!.phoneNumber!);
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
        await _repo.registerEmployeeByPhone(
          phoneNumber: firebaseUser.phoneNumber!,
          email: _employeeInfo!.email, // Use email from employee API
          firstName: firstName,
          lastName: lastName,
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration successful! Redirecting...')),
          );
          
          // Trigger the ProfileAuthWrapper to recheck auth status
          // which will detect the user is now registered and redirect to home
          await Future.delayed(const Duration(seconds: 1));
          ProfileAuthWrapper.recheckAuthStatus();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading employee information...'),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text('Error', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loadEmployeeInfo,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_employeeInfo == null) {
      return const Scaffold(
        body: Center(
          child: Text('No employee information found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Employee Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Employee Code: ${_employeeInfo!.employeeCode}'),
            const SizedBox(height: 8),
            Text('Department: ${_employeeInfo!.department}'),
            const SizedBox(height: 8),
            Text('Position: ${_employeeInfo!.position}'),
            const SizedBox(height: 8),
            Text('Organization: ${_employeeInfo!.organizationName}'),
            const SizedBox(height: 8),
            Text('Email: ${_employeeInfo!.email}'),
            const SizedBox(height: 16),
            TextField(
              controller: _firstController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _lastController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _submit,
                child: _saving
                    ? const CircularProgressIndicator.adaptive()
                    : const Text('Complete Employee Registration'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
