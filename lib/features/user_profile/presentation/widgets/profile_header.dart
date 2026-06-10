import 'package:flutter/material.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';

/// Profile header widget displaying user avatar and basic info.
///
/// Also carries the user's employee identity (organization, employee ID,
/// role) as compact chips so it doesn't need a separate card on the page.
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, this.userProfile, this.onEditTap});

  final UserProfileResponse3? userProfile;
  final VoidCallback? onEditTap;

  static const Color _primary = Color(0xFF6F3FCC);

  @override
  Widget build(BuildContext context) {
    final employeeInfo = userProfile?.employeeInfo;
    final isEmployee = userProfile?.isEmployee == true && employeeInfo != null;
    final roleLine = isEmployee
        ? [employeeInfo.position, employeeInfo.department]
              .where((s) => s.trim().isNotEmpty)
              .join(' · ')
        : '';

    return Column(
      children: [
        Row(
          children: [
            // The whole avatar is the edit tap target; the small badge is
            // just the visual affordance.
            Semantics(
              button: onEditTap != null,
              label: 'Edit profile',
              child: GestureDetector(onTap: onEditTap, child: _buildAvatar()),
            ),

            const SizedBox(width: 16),

            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getDisplayName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userProfile?.email ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                  if (isEmployee) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _InfoChip(
                          label: employeeInfo.organizationName,
                          icon: Icons.business_rounded,
                          foreground: _primary,
                          background: _primary.withValues(alpha: 0.1),
                        ),
                        if (employeeInfo.employeeCode.trim().isNotEmpty)
                          _InfoChip(
                            label: employeeInfo.employeeCode,
                            icon: Icons.badge_outlined,
                            foreground: const Color(0xFF4A5568),
                            background: const Color(0xFFEDF2F7),
                          ),
                      ],
                    ),
                    if (roleLine.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        roleLine,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ],
        ),

        // Profile Completion Indicator
        if (userProfile != null && !userProfile!.hasCompletedProfile)
          Container(
            margin: const EdgeInsets.only(top: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange[700],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Complete your profile to unlock all features',
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onEditTap,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    minimumSize: const Size(0, 32),
                  ),
                  child: Text(
                    'Complete',
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildAvatar() {
    final imageUrl = userProfile?.profileImageUrl;
    final hasPhoto = imageUrl != null && imageUrl.trim().isNotEmpty;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 72,
          height: 72,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF9F7AEA), _primary],
            ),
            image: hasPhoto
                ? DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                    onError: (_, _) {},
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: _primary.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: hasPhoto
              ? null
              : Text(
                  _initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
        ),
        if (onEditTap != null)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: _primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(
                Icons.edit_rounded,
                color: Colors.white,
                size: 13,
              ),
            ),
          ),
      ],
    );
  }

  String get _initials {
    final name = _getDisplayName().trim();
    final parts = name
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return (parts.first.characters.first + parts.last.characters.first)
        .toUpperCase();
  }

  String _getDisplayName() {
    if (userProfile != null) {
      return userProfile!.displayName;
    }

    return 'User';
  }
}

/// Small tinted pill used for organization and employee identity.
class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.label,
    required this.icon,
    required this.foreground,
    required this.background,
  });

  final String label;
  final IconData icon;
  final Color foreground;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: foreground),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: foreground,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
