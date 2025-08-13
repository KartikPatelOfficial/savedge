import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

class RegisterIndividualPage extends StatefulWidget {
  const RegisterIndividualPage({super.key});

  @override
  State<RegisterIndividualPage> createState() => _RegisterIndividualPageState();
}

class _RegisterIndividualPageState extends State<RegisterIndividualPage> {
  final _emailController = TextEditingController();
  final _firstController = TextEditingController();
  final _lastController = TextEditingController();
  bool _saving = false;

  AuthRepository get _repo => GetIt.I<AuthRepository>();

  @override
  void dispose() {
    _emailController.dispose();
    _firstController.dispose();
    _lastController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_saving) return;

    final email = _emailController.text.trim();
    final firstName = _firstController.text.trim();
    final lastName = _lastController.text.trim();

    if (email.isEmpty || firstName.isEmpty || lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Basic email validation
    if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    setState(() => _saving = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'No authenticated user found';
      }

      // Use the phone number from Firebase user
      final phoneNumber = user.phoneNumber;
      if (phoneNumber == null) {
        throw 'No phone number found';
      }

      // Register as individual user
      await _repo.registerUserByPhone(
        phoneNumber: phoneNumber,
        email: email,
        firstName: firstName,
        lastName: lastName,
      );

      // Navigate back to ProfileAuthWrapper to recheck status
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registration failed: $e')));
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
      appBar: AppBar(title: const Text('Complete Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please provide your details to complete registration:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
                hintText: 'your.email@example.com',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _firstController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lastController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _submit,
                child: _saving
                    ? const CircularProgressIndicator.adaptive()
                    : const Text('Complete Registration'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
