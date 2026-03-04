import 'package:flutter/material.dart';
import 'package:savedge/features/coupons/presentation/pages/redemption_history_page.dart';
import 'package:savedge/features/static_pages/presentation/pages/about_us_page.dart';
import 'package:savedge/features/static_pages/presentation/pages/contact_us_page.dart';
import 'package:savedge/features/static_pages/presentation/pages/follow_us_page.dart';
import 'package:savedge/features/stores/presentation/pages/stores_page.dart';
import 'dart:ui';

/// Model class for drawer menu items
class DrawerMenuItem {
  const DrawerMenuItem({required this.icon, required this.title, this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
}

/// Premium custom drawer widget
class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    this.userName = '',
    this.userAvatar,
    this.onMenuItemTap,
  });

  final String userName;
  final String? userAvatar;
  final Function(String)? onMenuItemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1A202C).withOpacity(0.85), // Deep premium dark glass background
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 40.0, bottom: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Premium Header
              _PremiumUserProfileSection(
                  userName: userName, userAvatar: userAvatar),
              const SizedBox(height: 40),
              // Menu Items List - left aligned
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65, // Constrain menu width
                  child: _PremiumMenuItemsList(
                    items: _getMenuItems(context),
                    onItemTap: onMenuItemTap,
                  ),
                ),
              ),
              // Footer element
              Text(
                'Savedge App v1.0.0',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DrawerMenuItem> _getMenuItems(BuildContext context) {
    return [
      DrawerMenuItem(
        icon: Icons.history_rounded,
        title: 'Redemption History',
        onTap: () => _navigateToRedemptionHistory(context),
      ),
      DrawerMenuItem(
        icon: Icons.storefront_rounded,
        title: 'Stores',
        onTap: () => _navigateToStores(context),
      ),
      DrawerMenuItem(
        icon: Icons.card_giftcard_rounded,
        title: 'Gift Cards',
        onTap: () => _navigateToGiftCards(context),
      ),
      DrawerMenuItem(
        icon: Icons.info_outline_rounded,
        title: 'About Us',
        onTap: () => _navigateToAboutUs(context),
      ),
      DrawerMenuItem(
        icon: Icons.support_agent_rounded,
        title: 'Contact Us',
        onTap: () => _navigateToContactUs(context),
      ),
      DrawerMenuItem(
        icon: Icons.handshake_rounded,
        title: 'Follow Us',
        onTap: () => _navigateToFollowUs(context),
      ),
    ];
  }

  void _navigateToRedemptionHistory(BuildContext context) {
    onMenuItemTap?.call('Redemption History');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RedemptionHistoryPage()),
    );
  }

  void _navigateToStores(BuildContext context) {
    onMenuItemTap?.call('Stores');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StoresPage()),
    );
  }

  void _navigateToAboutUs(BuildContext context) {
    onMenuItemTap?.call('About Us');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutUsPage()),
    );
  }

  void _navigateToContactUs(BuildContext context) {
    onMenuItemTap?.call('Contact Us');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ContactUsPage()),
    );
  }

  void _navigateToFollowUs(BuildContext context) {
    onMenuItemTap?.call('Follow Us');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FollowUsPage()),
    );
  }

  void _navigateToGiftCards(BuildContext context) {
    onMenuItemTap?.call('Gift Cards');
    Navigator.pushNamed(context, '/gift-cards');
  }
}

class _PremiumUserProfileSection extends StatelessWidget {
  const _PremiumUserProfileSection({required this.userName, this.userAvatar});

  final String userName;
  final String? userAvatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Avatar
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6F3FCC).withOpacity(0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: userAvatar != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      userAvatar!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _PremiumInitialsAvatar(name: userName),
                    ),
                  )
                : _PremiumInitialsAvatar(name: userName),
          ),
          const SizedBox(height: 24),
          // Greeting & Name
          Text(
            'Welcome back,',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
              height: 1.1,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _PremiumInitialsAvatar extends StatelessWidget {
  const _PremiumInitialsAvatar({required this.name});

  final String name;

  String _getInitials() {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6F3FCC),
            Color(0xFF9C4DFF),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        _getInitials(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class _PremiumMenuItemsList extends StatelessWidget {
  const _PremiumMenuItemsList({required this.items, this.onItemTap});

  final List<DrawerMenuItem> items;
  final Function(String)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _PremiumDrawerMenuItemTile(
          item: item,
          onTap: () {
            // First try the item's specific onTap, then fall back to the general onItemTap
            if (item.onTap != null) {
              item.onTap!();
            } else {
              onItemTap?.call(item.title);
            }
          },
        );
      },
    );
  }
}

class _PremiumDrawerMenuItemTile extends StatelessWidget {
  const _PremiumDrawerMenuItemTile({required this.item, this.onTap});

  final DrawerMenuItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          highlightColor: Colors.white.withOpacity(0.05),
          splashColor: Colors.white.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon,
                      color: Colors.white, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
