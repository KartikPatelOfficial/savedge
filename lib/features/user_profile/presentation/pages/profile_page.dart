import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/auth/domain/entities/extended_user_profile.dart';
import 'package:savedge/features/user_profile/presentation/widgets/widgets.dart';
import 'package:savedge/features/user_profile/presentation/pages/edit_profile_page.dart';
import 'package:savedge/features/user_profile/presentation/pages/points_wallet_page.dart';
import 'package:savedge/features/coupons/presentation/pages/gift_page.dart';

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
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
            )
          : _error != null
          ? _buildErrorView()
          : _buildProfileView(),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFE53E3E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 48,
                color: Color(0xFFE53E3E),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Failed to load profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _error ?? 'Unknown error occurred',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF4A5568),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _loadUserProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6F3FCC),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileView() {
    final user = FirebaseAuth.instance.currentUser;

    return CustomScrollView(
      slivers: [
        // Custom App Bar
        SliverAppBar(
          expandedHeight: 140,
          backgroundColor: Colors.white,
          pinned: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(color: Colors.white),
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Color(0xFF1A202C),
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF6F3FCC).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Color(0xFF6F3FCC),
                ),
                onPressed: _onSettingsTap,
              ),
            ),
          ],
        ),

        // Profile Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                if (_userProfile != null) ...[
                  // Show subscription status in stats if user has active subscription
                  if (_userProfile!.hasActiveSubscription) ...[
                    Row(
                      children: [
                        Expanded(
                          child: ProfileStatsCard(
                            title: 'Points Balance',
                            value: '${_userProfile!.pointsBalance}',
                            icon: Icons.stars_outlined,
                            color: const Color(0xFFD69E2E),
                            onTap: _onPointsBalanceTap,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ProfileStatsCard(
                            title: 'Subscription',
                            value: _userProfile!.activeSubscription!.statusDisplay,
                            icon: Icons.star,
                            color: _userProfile!.activeSubscription!.hasExpired
                                ? Colors.red
                                : _userProfile!.activeSubscription!.isExpiringSoon
                                    ? Colors.orange
                                    : Colors.green,
                            onTap: _onManageSubscriptionTap,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    // For users without subscriptions, show original layout
                    Row(
                      children: [
                        Expanded(
                          child: ProfileStatsCard(
                            title: 'Points Balance',
                            value: '${_userProfile!.pointsBalance}',
                            icon: Icons.stars_outlined,
                            color: const Color(0xFFD69E2E),
                            onTap: _onPointsBalanceTap,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ProfileStatsCard(
                            title: _userProfile!.isEmployee
                                ? 'Redemptions'
                                : 'Orders',
                            value: '12', // This would come from appropriate API
                            icon: _userProfile!.isEmployee
                                ? Icons.redeem_outlined
                                : Icons.shopping_bag_outlined,
                            color: const Color(0xFF38A169),
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Employee-specific stats (only show for employees)
                  if (_userProfile!.isEmployee &&
                      _userProfile!.organizationName != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFE2E8F0),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF6F3FCC,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.business_outlined,
                                  color: Color(0xFF6F3FCC),
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _userProfile!.organizationName!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1A202C),
                                      ),
                                    ),
                                    if (_userProfile!.department != null)
                                      Text(
                                        _userProfile!.department!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF718096),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (_userProfile!.employeeCode != null ||
                              _userProfile!.position != null) ...[
                            const SizedBox(height: 16),
                            const Divider(
                              color: Color(0xFFE2E8F0),
                              height: 1,
                              thickness: 1,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                if (_userProfile!.employeeCode != null) ...[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Employee ID',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF718096),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _userProfile!.employeeCode!,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF2D3748),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                if (_userProfile!.position != null) ...[
                                  if (_userProfile!.employeeCode != null)
                                    const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Position',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF718096),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _userProfile!.position!,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF2D3748),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],

                const SizedBox(height: 20),


                // Subscription Status Card (show for all users who have subscriptions)
                if (_userProfile != null && _userProfile!.activeSubscription != null) ...[
                  SubscriptionStatusCard(
                    activeSubscription: _userProfile!.activeSubscription,
                    onManageSubscriptionTap: _onManageSubscriptionTap,
                    onUpgradeTap: _onUpgradeSubscriptionTap,
                  ),
                  const SizedBox(height: 20),
                ],

                // Menu Items
                if (_userProfile != null) ...[
                  _buildMenuSection('Account', [
                    ProfileMenuItem(
                      icon: Icons.person,
                      title: 'View Profile',
                      subtitle: _userProfile!.isEmployee
                          ? 'View your profile information'
                          : 'Update your personal information',
                      onTap: _onEditProfileTap,
                    ),
                    // Show subscription menu for all users (employees and non-employees)
                    ProfileMenuItem(
                      icon: Icons.card_membership,
                      title: _userProfile!.hasActiveSubscription
                          ? 'Manage Subscription'
                          : 'Get Premium',
                      subtitle: _userProfile!.hasActiveSubscription
                          ? 'Manage your subscription plan'
                          : 'Unlock premium features',
                      onTap: _userProfile!.hasActiveSubscription
                          ? _onManageSubscriptionTap
                          : _onUpgradeSubscriptionTap,
                    ),
                    if (!_userProfile!.isEmployee) ...[
                      ProfileMenuItem(
                        icon: Icons.security,
                        title: 'Privacy & Security',
                        subtitle: 'Manage your account security',
                        onTap: _onPrivacyTap,
                      ),
                    ],
                    ProfileMenuItem(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      subtitle: 'Configure your notification preferences',
                      onTap: _onNotificationsTap,
                    ),
                  ]),

                  const SizedBox(height: 24),

                  _buildMenuSection('Activity', [
                    if (!_userProfile!.isEmployee) ...[
                      ProfileMenuItem(
                        icon: Icons.history,
                        title: 'Order History',
                        subtitle: 'View your past orders',
                        onTap: _onOrderHistoryTap,
                      ),
                    ],
                    ProfileMenuItem(
                      icon: Icons.favorite,
                      title: 'Favorites',
                      subtitle: 'Your favorite restaurants and items',
                      onTap: _onFavoritesTap,
                    ),
                    ProfileMenuItem(
                      icon: Icons.card_giftcard,
                      title: _userProfile!.isEmployee
                          ? 'Coupons & Benefits'
                          : 'Gift Cards & Coupons',
                      subtitle: _userProfile!.isEmployee
                          ? 'View your employee benefits and coupons'
                          : 'Manage your rewards',
                      onTap: _onGiftCardsTap,
                    ),
                    // Gift to colleagues (show for employees only)
                    if (_userProfile!.isEmployee) ...[
                      ProfileMenuItem(
                        icon: Icons.card_giftcard_outlined,
                        title: 'Send & Receive Gifts',
                        subtitle: 'Gift coupons or points to colleagues',
                        onTap: _onSendGiftsTap,
                      ),
                    ],
                    if (_userProfile!.isEmployee) ...[
                      ProfileMenuItem(
                        icon: Icons.redeem,
                        title: 'Redemption History',
                        subtitle: 'View your coupon redemptions',
                        onTap: _onRedemptionHistoryTap,
                      ),
                    ],
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
                ],

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
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A202C),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE53E3E).withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: ProfileMenuItem(
        icon: Icons.logout,
        title: 'Sign Out',
        subtitle: 'Sign out of your account',
        titleColor: const Color(0xFFE53E3E),
        iconColor: const Color(0xFFE53E3E),
        showArrow: false,
        onTap: _onSignOutTap,
      ),
    );
  }

  // Event Handlers
  void _onEditProfileTap() async {
    if (_userProfile?.isEmployee == true) {
      // For employees, just show their profile in view mode
      debugPrint('View employee profile tapped');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditProfilePage(userProfile: _userProfile!),
        ),
      );
    } else {
      // For individual users, allow editing
      debugPrint('Edit individual profile tapped');
      final result = await Navigator.of(context).push<bool>(
        MaterialPageRoute(
          builder: (context) => EditProfilePage(userProfile: _userProfile!),
        ),
      );

      // If profile was updated, reload the data
      if (result == true) {
        _loadUserProfile();
      }
    }
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
    // TODO: Navigate to gift cards/coupons
  }

  void _onSendGiftsTap() {
    debugPrint('Send & Receive Gifts tapped');
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const GiftPage(),
      ),
    );
  }

  void _onRedemptionHistoryTap() {
    debugPrint('Redemption History tapped');
    // TODO: Navigate to redemption history for employees
  }

  void _onManageSubscriptionTap() {
    debugPrint('Manage Subscription tapped');
    // TODO: Navigate to subscription management page
  }

  void _onUpgradeSubscriptionTap() {
    debugPrint('Upgrade Subscription tapped');
    // Navigate to subscription purchase page
    Navigator.of(context).pushNamed('/subscription-purchase');
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

  void _onPointsBalanceTap() {
    debugPrint('Points Balance tapped');
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PointsWalletPage(),
      ),
    );
  }

  void _onSignOutTap() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A202C),
          ),
        ),
        content: const Text(
          'Are you sure you want to sign out of your account?',
          style: TextStyle(fontSize: 16, color: Color(0xFF4A5568)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF718096),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53E3E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Sign Out',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
