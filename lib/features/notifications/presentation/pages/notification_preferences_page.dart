import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

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
          SnackBar(
            content: const Text('Failed to update preference'),
            backgroundColor: const Color(0xFF1A202C),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        await _loadPreferences();
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          _buildAppBar(),
          if (_loading)
            const SliverToBoxAdapter(child: _Skeleton())
          else if (_error != null)
            SliverFillRemaining(
              hasScrollBody: false,
              child: _ErrorBody(
                message: _error!,
                onRetry: _loadPreferences,
              ),
            )
          else
            SliverToBoxAdapter(child: _buildContent()),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 150,
      backgroundColor: Colors.transparent,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      iconTheme: const IconThemeData(color: Color(0xFF1A202C)),
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          const expandedHeight = 150.0;
          final minHeight =
              kToolbarHeight + MediaQuery.of(context).padding.top;
          final t = ((constraints.maxHeight - minHeight) /
                  (expandedHeight - minHeight))
              .clamp(0.0, 1.0);
          final leftPadding = 20.0 + (52.0 * (1 - t));

          return Container(
            decoration: BoxDecoration(
              color: Color.lerp(Colors.white, Colors.transparent, t),
            ),
            child: Stack(
              children: [
                if (t > 0.05)
                  Positioned(
                    bottom: 52,
                    left: 20,
                    child: Opacity(
                      opacity: t.clamp(0.0, 1.0),
                      child: const Text(
                        'Manage your alerts',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ),
                  ),
                FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                    left: leftPadding,
                    bottom: 16,
                    right: 20,
                  ),
                  centerTitle: false,
                  title: Text(
                    'Preferences',
                    style: TextStyle(
                      color: const Color(0xFF1A202C),
                      fontSize: t > 0.5 ? 24 : 20,
                      fontWeight: t > 0.5 ? FontWeight.w800 : FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          const Text(
            'Choose how you want to hear from us. You can change these anytime.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9CA3AF),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // Channels section
          _buildSectionLabel('CHANNELS'),
          const SizedBox(height: 12),

          _ToggleTile(
            accent: const Color(0xFF3B82F6),
            title: 'Push Notifications',
            subtitle: 'Alerts directly on your device',
            value: _pushNotifications,
            saving: _saving,
            onChanged: (val) {
              setState(() => _pushNotifications = val);
              _savePreference(push: val);
            },
          ),
          const SizedBox(height: 10),
          _ToggleTile(
            accent: const Color(0xFFF59E0B),
            title: 'Email',
            subtitle: 'Deals and updates in your inbox',
            value: _emailNotifications,
            saving: _saving,
            onChanged: (val) {
              setState(() => _emailNotifications = val);
              _savePreference(email: val);
            },
          ),
          const SizedBox(height: 10),
          _ToggleTile(
            accent: const Color(0xFF6F3FCC),
            title: 'SMS',
            subtitle: 'Text messages for important alerts',
            value: _smsNotifications,
            saving: _saving,
            onChanged: (val) {
              setState(() => _smsNotifications = val);
              _savePreference(sms: val);
            },
          ),
          const SizedBox(height: 10),
          _ToggleTile(
            accent: const Color(0xFF25D366),
            title: 'WhatsApp',
            subtitle: 'Deals, reminders & greetings',
            value: _whatsAppNotifications,
            saving: _saving,
            onChanged: (val) {
              setState(() => _whatsAppNotifications = val);
              _savePreference(whatsApp: val);
            },
          ),

          const SizedBox(height: 28),

          // Info note
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FB),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFF0F0F0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: Color(0xFF3B82F6),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'We will still send you important account and security notifications regardless of your preferences.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9CA3AF),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
            color: Color(0xFFB0B7C3),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(height: 1, color: const Color(0xFFF0F0F0)),
        ),
      ],
    );
  }
}

// ─── Toggle Tile ────────────────────────────────────────────

class _ToggleTile extends StatelessWidget {
  const _ToggleTile({
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.saving,
    required this.onChanged,
  });

  final Color accent;
  final String title;
  final String subtitle;
  final bool value;
  final bool saving;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: value
            ? accent.withValues(alpha: 0.04)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: value
              ? accent.withValues(alpha: 0.15)
              : const Color(0xFFF0F0F0),
        ),
      ),
      child: Row(
        children: [
          // Accent dot
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: value
                  ? accent
                  : const Color(0xFFD1D5DB),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 14),
          // Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          // Toggle
          SizedBox(
            height: 28,
            child: FittedBox(
              child: Switch.adaptive(
                value: value,
                onChanged: saving ? null : onChanged,
                activeColor: accent,
                activeTrackColor: accent.withValues(alpha: 0.30),
                inactiveTrackColor: const Color(0xFFE5E7EB),
                inactiveThumbColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Error State ────────────────────────────────────────────

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.06),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.wifi_off_rounded,
              size: 36,
              color: Color(0xFFEF4444),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Something went wrong',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF9CA3AF),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 16),
            label: const Text(
              'Try again',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF6F3FCC),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              side: const BorderSide(color: Color(0xFF6F3FCC)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Skeleton ───────────────────────────────────────────────

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          // Description skeleton
          Container(
            height: 12,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 12,
              width: 200,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          const SizedBox(height: 28),
          // Toggle tile skeletons
          for (int i = 0; i < 4; i++) ...[
            Container(
              height: 68,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8FA),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
