import 'package:flutter/material.dart';

/// Header widget for the home page containing location, notifications, and profile
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    this.location = 'Mota Varachha',
    this.city = 'Surat',
    this.notificationCount = 1,
    this.onLocationTap,
    this.onFavoriteTap,
    this.onNotificationTap,
    this.onMenuTap,
  });

  final String location;
  final String city;
  final int notificationCount;
  final VoidCallback? onLocationTap;
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      color: Colors.white,
      child: Row(
        children: [
          // Menu/Profile button with modern design
          _MenuButton(onTap: onMenuTap),
          const SizedBox(width: 16),
          // Location selector
          _LocationSelector(
            location: location,
            city: city,
            onTap: onLocationTap,
          ),
          const Spacer(),
          // Action buttons
          _ActionButton(icon: Icons.favorite_border, onPressed: onFavoriteTap),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: const Color(0xFF6F3FCC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.menu, color: Colors.white, size: 22),
      ),
    );
  }
}

class _LocationSelector extends StatelessWidget {
  const _LocationSelector({
    required this.location,
    required this.city,
    this.onTap,
  });

  final String location;
  final String city;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                location,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A202C),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xFF1A202C),
                size: 20,
              ),
            ],
          ),
          Text(
            city,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF718096),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF6F3FCC).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: const Color(0xFF6F3FCC)),
        iconSize: 22,
      ),
    );
  }
}
