import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/auth/domain/entities/extended_user_profile.dart';
import 'package:savedge/presentation/profile/widgets/widgets.dart';

/// Profile page displaying user information and account options
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = true;
  ExtendedUserProfile? _userProfile;
  String? _error;

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      setState(() => _isLoading = true);
      
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No authenticated user found');
      }

      final profile = await _authRepository.getUserProfileExtended();
      setState(() => _userProfile = profile);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildErrorView()
              : _buildProfileView(),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load profile',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            _error ?? 'Unknown error occurred',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadUserProfile,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileView() {
    final user = FirebaseAuth.instance.currentUser;
    
    return CustomScrollView(
      slivers: [
        // Custom App Bar
        SliverAppBar(
          expandedHeight: 120,
          backgroundColor: const Color(0xFF6F3FCC),
          pinned: true,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6F3FCC), Color(0xFF9C27B0)],
                ),
              ),
            ),
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: _onSettingsTap,
            ),
          ],
        ),
        
        // Profile Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Header
                ProfileHeader(
                  userProfile: _userProfile,
                  user: user,
                  onEditTap: _onEditProfileTap,
                ),
                
                const SizedBox(height: 20),
                
                // Stats Cards
                if (_userProfile != null)
                  Row(
                    children: [
                      Expanded(
                        child: ProfileStatsCard(
                          title: 'Points Balance',
                          value: '${_userProfile!.pointsBalance}',
                          icon: Icons.stars,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ProfileStatsCard(
                          title: 'Orders',
                          value: '12', // This would come from orders API
                          icon: Icons.shopping_bag,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                
                const SizedBox(height: 24),
                
                // Menu Items
                _buildMenuSection('Account', [
                  ProfileMenuItem(
                    icon: Icons.person,
                    title: 'Edit Profile',
                    subtitle: 'Update your personal information',
                    onTap: _onEditProfileTap,
                  ),
                  ProfileMenuItem(
                    icon: Icons.security,
                    title: 'Privacy & Security',
                    subtitle: 'Manage your account security',
                    onTap: _onPrivacyTap,
                  ),
                  ProfileMenuItem(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    subtitle: 'Configure your notification preferences',
                    onTap: _onNotificationsTap,
                  ),
                ]),
                
                const SizedBox(height: 24),
                
                _buildMenuSection('Activity', [
                  ProfileMenuItem(
                    icon: Icons.history,
                    title: 'Order History',
                    subtitle: 'View your past orders',
                    onTap: _onOrderHistoryTap,
                  ),
                  ProfileMenuItem(
                    icon: Icons.favorite,
                    title: 'Favorites',
                    subtitle: 'Your favorite restaurants and items',
                    onTap: _onFavoritesTap,
                  ),
                  ProfileMenuItem(
                    icon: Icons.card_giftcard,
                    title: 'Gift Cards & Coupons',
                    subtitle: 'Manage your rewards',
                    onTap: _onGiftCardsTap,
                  ),
                ]),
                
                const SizedBox(height: 24),
                
                _buildMenuSection('Support', [
                  ProfileMenuItem(
                    icon: Icons.help,
                    title: 'Help & Support',
                    subtitle: 'Get help with your account',
                    onTap: _onHelpTap,
                  ),
                  ProfileMenuItem(
                    icon: Icons.feedback,
                    title: 'Send Feedback',
                    subtitle: 'Tell us how we can improve',
                    onTap: _onFeedbackTap,
                  ),
                  ProfileMenuItem(
                    icon: Icons.info,
                    title: 'About',
                    subtitle: 'App version and information',
                    onTap: _onAboutTap,
                  ),
                ]),
                
                const SizedBox(height: 24),
                
                // Sign Out Button
                _buildSignOutSection(),
                
                const SizedBox(height: 100), // Bottom padding for nav bar
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildSignOutSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ProfileMenuItem(
        icon: Icons.logout,
        title: 'Sign Out',
        subtitle: 'Sign out of your account',
        titleColor: Colors.red[600],
        iconColor: Colors.red[600],
        showArrow: false,
        onTap: _onSignOutTap,
      ),
    );
  }

  // Event Handlers
  void _onEditProfileTap() {
    debugPrint('Edit profile tapped');
    // TODO: Navigate to edit profile page
  }

  void _onSettingsTap() {
    debugPrint('Settings tapped');
    // TODO: Navigate to settings page
  }

  void _onPrivacyTap() {
    debugPrint('Privacy & Security tapped');
    // TODO: Navigate to privacy settings
  }

  void _onNotificationsTap() {
    debugPrint('Notifications tapped');
    // TODO: Navigate to notification settings
  }

  void _onOrderHistoryTap() {
    debugPrint('Order History tapped');
    // TODO: Navigate to order history
  }

  void _onFavoritesTap() {
    debugPrint('Favorites tapped');
    // TODO: Navigate to favorites
  }

  void _onGiftCardsTap() {
    debugPrint('Gift Cards tapped');
    // TODO: Navigate to gift cards
  }

  void _onHelpTap() {
    debugPrint('Help & Support tapped');
    // TODO: Navigate to help center
  }

  void _onFeedbackTap() {
    debugPrint('Send Feedback tapped');
    // TODO: Navigate to feedback form
  }

  void _onAboutTap() {
    debugPrint('About tapped');
    // TODO: Show about dialog
  }

  void _onSignOutTap() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await FirebaseAuth.instance.signOut();
                // Navigation will be handled by ProfileAuthWrapper
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error signing out: $e')),
                  );
                }
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
