import 'package:flutter/material.dart';
import 'package:savedge/features/static_pages/presentation/pages/about_us_page.dart';
import 'package:savedge/features/static_pages/presentation/pages/contact_us_page.dart';
import 'package:savedge/features/static_pages/presentation/pages/follow_us_page.dart';
import 'package:savedge/features/stores/presentation/pages/stores_page.dart';
import 'package:savedge/features/brand_vouchers/presentation/pages/brand_vouchers_page.dart';

/// Model class for drawer menu items
class DrawerMenuItem {
  const DrawerMenuItem({required this.icon, required this.title, this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
}

/// Custom drawer widget matching the screenshot design
class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    this.userName = 'Jacob David',
    this.userAvatar,
    this.onMenuItemTap,
  });

  final String userName;
  final String? userAvatar;
  final Function(String)? onMenuItemTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // User Profile Section
            _UserProfileSection(userName: userName, userAvatar: userAvatar),
            const SizedBox(height: 20),
            // Menu Items
            Expanded(
              child: _MenuItemsList(
                items: _getMenuItems(context),
                onItemTap: onMenuItemTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DrawerMenuItem> _getMenuItems(BuildContext context) {
    return [
      const DrawerMenuItem(
        icon: Icons.local_offer_outlined,
        title: 'Current Offers',
      ),
      DrawerMenuItem(
        icon: Icons.store_outlined,
        title: 'Stores',
        onTap: () => _navigateToStores(context),
      ),
      DrawerMenuItem(
        icon: Icons.info_outline,
        title: 'About Us',
        onTap: () => _navigateToAboutUs(context),
      ),
      const DrawerMenuItem(icon: Icons.feedback_outlined, title: 'Feedback'),
      DrawerMenuItem(
        icon: Icons.phone_outlined,
        title: 'Contact Us',
        onTap: () => _navigateToContactUs(context),
      ),
      DrawerMenuItem(
        icon: Icons.group_outlined,
        title: 'Follow Us',
        onTap: () => _navigateToFollowUs(context),
      ),
      DrawerMenuItem(
        icon: Icons.card_giftcard_outlined,
        title: 'Brand Vouchers',
        onTap: () => _navigateToBrandVouchers(context),
      ),
    ];
  }

  void _navigateToStores(BuildContext context) {
    Navigator.pop(context); // Close drawer first
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StoresPage()),
    );
  }

  void _navigateToAboutUs(BuildContext context) {
    Navigator.pop(context); // Close drawer first
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutUsPage()),
    );
  }

  void _navigateToContactUs(BuildContext context) {
    Navigator.pop(context); // Close drawer first
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ContactUsPage()),
    );
  }

  void _navigateToFollowUs(BuildContext context) {
    Navigator.pop(context); // Close drawer first
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FollowUsPage()),
    );
  }

  void _navigateToBrandVouchers(BuildContext context) {
    Navigator.pop(context); // Close drawer first
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BrandVouchersPage()),
    );
  }
}

class _UserProfileSection extends StatelessWidget {
  const _UserProfileSection({required this.userName, this.userAvatar});

  final String userName;
  final String? userAvatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // User Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF6F3FCC).withOpacity(0.1),
            ),
            child: userAvatar != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      userAvatar!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _DefaultAvatar(),
                    ),
                  )
                : _DefaultAvatar(),
          ),
          const SizedBox(width: 16),
          // User Name
          Expanded(
            child: Text(
              userName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6F3FCC).withOpacity(0.8),
            const Color(0xFF9C4DFF).withOpacity(0.8),
          ],
        ),
      ),
      child: const Icon(Icons.person, color: Colors.white, size: 28),
    );
  }
}

class _MenuItemsList extends StatelessWidget {
  const _MenuItemsList({required this.items, this.onItemTap});

  final List<DrawerMenuItem> items;
  final Function(String)? onItemTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _DrawerMenuItemTile(
          item: item,
          onTap: () {
            // First try the item's specific onTap, then fall back to the general onItemTap
            if (item.onTap != null) {
              item.onTap!();
            } else {
              onItemTap?.call(item.title);
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}

class _DrawerMenuItemTile extends StatelessWidget {
  const _DrawerMenuItemTile({required this.item, this.onTap});

  final DrawerMenuItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(item.icon, color: Colors.grey[700], size: 20),
      ),
      title: Text(
        item.title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}
