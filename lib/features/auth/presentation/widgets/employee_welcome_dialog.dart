import 'package:flutter/material.dart';
import 'package:savedge/core/utils/extensions.dart';
import 'package:savedge/features/auth/domain/entities/user.dart';

/// Dialog shown to employees when they first log in
class EmployeeWelcomeDialog extends StatelessWidget {
  const EmployeeWelcomeDialog({
    super.key,
    required this.user,
    required this.onContinue,
  });

  final User user;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Icon(
            Icons.business,
            color: context.colorScheme.primary,
            size: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Welcome to ${user.organizationName ?? 'your organization'}!',
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello ${user.fullName},',
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'We\'re excited to have you as part of our savings program! Here are your details:',
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          _buildDetailRow(
            context,
            'Employee ID',
            user.employeeCode ?? 'Not assigned',
            Icons.badge,
          ),
          if (user.department != null) ...[
            const SizedBox(height: 8),
            _buildDetailRow(
              context,
              'Department',
              user.department!,
              Icons.domain,
            ),
          ],
          if (user.position != null) ...[
            const SizedBox(height: 8),
            _buildDetailRow(
              context,
              'Position',
              user.position!,
              Icons.work,
            ),
          ],
          const SizedBox(height: 8),
          _buildDetailRow(
            context,
            'Points Balance',
            '${user.pointsBalance} points',
            Icons.stars,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: context.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'You can earn points by participating in company savings programs and redeem them for exciting rewards!',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onContinue,
          child: Text(
            'Get Started',
            style: TextStyle(
              color: context.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: context.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: context.textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
