import 'package:flutter/material.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

/// Page for managing notification preferences (push, email, SMS, WhatsApp)
class NotificationPreferencesPage extends StatefulWidget {
  const NotificationPreferencesPage({super.key});

  @override
  State<NotificationPreferencesPage> createState() =>
      _NotificationPreferencesPageState();
}

class _NotificationPreferencesPageState
    extends State<NotificationPreferencesPage> {
  final AuthRepository _authRepository = getIt<AuthRepository>();

  bool _loading = true;
  bool _saving = false;
  String? _error;

  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = true;
  bool _whatsAppNotifications = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      setState(() {
        _loading = true;
        _error = null;
      });
      final profile = await _authRepository.getCurrentUserProfile();
      setState(() {
        _pushNotifications = profile.pushNotifications;
        _emailNotifications = profile.emailNotifications;
        _smsNotifications = profile.smsNotifications;
        _whatsAppNotifications = profile.whatsAppNotifications;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load preferences';
        _loading = false;
      });
    }
  }

  Future<void> _savePreference({
    bool? push,
    bool? email,
    bool? sms,
    bool? whatsApp,
  }) async {
    setState(() => _saving = true);
    try {
      await _authRepository.updateCurrentUserProfile(
        pushNotifications: push,
        emailNotifications: email,
        smsNotifications: sms,
        whatsAppNotifications: whatsApp,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update preference')),
        );
        // Revert the toggle
        await _loadPreferences();
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Preferences'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_error!, style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadPreferences,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      'Choose how you want to receive notifications',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildPreferenceCard(
                      icon: Icons.notifications_active,
                      iconColor: Colors.blue,
                      title: 'Push Notifications',
                      subtitle: 'Receive alerts on your device',
                      value: _pushNotifications,
                      onChanged: (val) {
                        setState(() => _pushNotifications = val);
                        _savePreference(push: val);
                      },
                    ),
                    _buildPreferenceCard(
                      icon: Icons.email_outlined,
                      iconColor: Colors.orange,
                      title: 'Email Notifications',
                      subtitle: 'Receive updates via email',
                      value: _emailNotifications,
                      onChanged: (val) {
                        setState(() => _emailNotifications = val);
                        _savePreference(email: val);
                      },
                    ),
                    _buildPreferenceCard(
                      icon: Icons.sms_outlined,
                      iconColor: Colors.purple,
                      title: 'SMS Notifications',
                      subtitle: 'Receive text messages',
                      value: _smsNotifications,
                      onChanged: (val) {
                        setState(() => _smsNotifications = val);
                        _savePreference(sms: val);
                      },
                    ),
                    _buildPreferenceCard(
                      icon: Icons.chat,
                      iconColor: const Color(0xFF25D366),
                      title: 'WhatsApp Notifications',
                      subtitle:
                          'Receive deals, reminders & greetings on WhatsApp',
                      value: _whatsAppNotifications,
                      onChanged: (val) {
                        setState(() => _whatsAppNotifications = val);
                        _savePreference(whatsApp: val);
                      },
                    ),
                    if (_saving)
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                  ],
                ),
    );
  }

  Widget _buildPreferenceCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.dividerColor.withValues(alpha: 0.3),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        trailing: Switch.adaptive(
          value: value,
          onChanged: _saving ? null : onChanged,
          activeColor: iconColor,
        ),
      ),
    );
  }
}
