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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          // Menu/Profile button with purple background
          _MenuButton(onTap: onMenuTap),
          const SizedBox(width: 12),
          // Location selector
          _LocationSelector(
            location: location,
            city: city,
            onTap: onLocationTap,
          ),
          const Spacer(),
          // Action buttons
          _ActionButton(icon: Icons.favorite_border, onPressed: onFavoriteTap),
          _NotificationButton(
            count: notificationCount,
            onPressed: onNotificationTap,
          ),
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
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Color(0xFF6F3FCC),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.menu, color: Colors.white, size: 20),
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
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black87,
                size: 20,
              ),
            ],
          ),
          Text(
            city,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
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
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.grey[600]),
      iconSize: 24,
    );
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton({required this.count, this.onPressed});

  final int count;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.notifications_outlined, color: Colors.grey[600]),
          iconSize: 24,
        ),
        if (count > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}