import 'package:flutter/material.dart';
import 'package:savedge/core/utils/extensions.dart';
import 'package:savedge/features/auth/domain/entities/user.dart';
import 'package:savedge/shared/widgets/custom_button.dart';

/// Page for handling organization changes for employees
class OrganizationChangePage extends StatefulWidget {
  const OrganizationChangePage({super.key});

  @override
  State<OrganizationChangePage> createState() => _OrganizationChangePageState();
}

class _OrganizationChangePageState extends State<OrganizationChangePage> {
  final _formKey = GlobalKey<FormState>();
  final _employeeCodeController = TextEditingController();
  final _departmentController = TextEditingController();
  final _positionController = TextEditingController();
  
  int? _selectedOrganizationId;
  User? _currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the user data passed as arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is User) {
      _currentUser = args;
    }
  }

  @override
  void dispose() {
    _employeeCodeController.dispose();
    _departmentController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate() && _selectedOrganizationId != null && _currentUser != null) {
      // Here you would typically call a use case to change organization
      // For now, we'll show a success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Your organization change request has been submitted. Please wait for approval.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to previous screen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Organization'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current organization info
                if (_currentUser?.organizationName != null) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Organization',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _currentUser!.organizationName!,
                          style: context.textTheme.bodyLarge,
                        ),
                        if (_currentUser!.department != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Department: ${_currentUser!.department}',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                        if (_currentUser!.position != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Position: ${_currentUser!.position}',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                Text(
                  'New Organization Details',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Organization selection (simplified - in real app would be a dropdown)
                Text(
                  'New Organization ID',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter organization ID',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _selectedOrganizationId = int.tryParse(value);
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter organization ID';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Employee code
                Text(
                  'Employee Code',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _employeeCodeController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your employee code',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your employee code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Department
                Text(
                  'Department',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _departmentController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your department',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your department';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Position
                Text(
                  'Position',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _positionController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your position',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your position';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),

                // Info box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: context.colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Your organization change request will need to be approved by the new organization. You will receive a notification once it\'s processed.',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),

                // Submit button
                CustomButton(
                  text: 'Request Organization Change',
                  onPressed: _onSubmit,
                  width: double.infinity,
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
