import 'package:flutter/material.dart';
import 'package:savedge/features/auth/presentation/bloc/auth_status_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

class RegisterEmployeePage extends StatefulWidget {
  const RegisterEmployeePage({super.key});

  @override
  State<RegisterEmployeePage> createState() => _RegisterEmployeePageState();
}

class _RegisterEmployeePageState extends State<RegisterEmployeePage> {
  final _firstController = TextEditingController();
  final _lastController = TextEditingController();
  bool _saving = false;
  AuthRepository get _repo => GetIt.I<AuthRepository>();

  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose();
    super.dispose();
  }

  Future<void> _submit(String email) async {
    if (_saving) return;
    setState(() => _saving = true);
    try {
      await _repo.updateProfile(
        email: email,
        firstName: _firstController.text.trim(),
        lastName: _lastController.text.trim(),
      );
      if (!mounted) return;
      await context.read<AuthStatusCubit>().checkStatus();
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = context.watch<AuthStatusCubit>().state;
    if (profileState is! AuthStatusLoaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final profile = profileState.profile;
    return Scaffold(
      appBar: AppBar(title: const Text('Employee Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Work Email: ${profile.email}'),
            const SizedBox(height: 8),
            Text('Organization ID: ${profile.organizationId}'),
            const SizedBox(height: 16),
            TextField(controller: _firstController, decoration: const InputDecoration(labelText: 'First Name')),
            const SizedBox(height: 12),
            TextField(controller: _lastController, decoration: const InputDecoration(labelText: 'Last Name')),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : () => _submit(profile.email),
                child: _saving
                    ? const CircularProgressIndicator.adaptive()
                    : const Text('Finish Employee Setup'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
