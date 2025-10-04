import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/coupons/presentation/pages/coupons_page.dart';
import 'package:savedge/features/coupons/presentation/pages/gift_page.dart';
import 'package:savedge/features/home/presentation/widgets/widgets.dart';
import 'package:savedge/features/user_profile/presentation/pages/profile_page.dart';

/// Main navigation wrapper that handles bottom navigation
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  bool _isEmployee = false;
  bool _isLoadingProfile = true;

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final UserProfileResponse3 profile = await _authRepository
          .getCurrentUserProfile();
      setState(() {
        _isEmployee = profile.isEmployee;
        _isLoadingProfile = false;
      });
    } catch (e) {
      // Default to non-employee if profile fetch fails
      setState(() {
        _isEmployee = false;
        _isLoadingProfile = false;
      });
    }
  }

  List<Widget> get _pages {
    final List<Widget> pages = [
      const HomeContentPage(), // Home page content without bottom nav
    ];

    // Only add Gift page for employees
    if (_isEmployee) {
      pages.add(const GiftPage());
    }

    pages.addAll([
      const CouponsPage(), // Enhanced coupon management page
      const ProfilePage(),
    ]);

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingProfile) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
        ),
      );
    }

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        isEmployee: _isEmployee,
      ),
    );
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
