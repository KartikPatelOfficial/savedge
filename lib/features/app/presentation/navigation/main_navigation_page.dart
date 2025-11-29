import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/coupons/presentation/pages/coupons_page.dart';
import 'package:savedge/features/coupons/presentation/pages/gift_page.dart';
import 'package:savedge/features/home/presentation/pages/home_content_page.dart';
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
  late List<Widget> _pages;

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  @override
  void initState() {
    super.initState();
    _buildPages();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      final UserProfileResponse3 profile =
          await _authRepository.getCurrentUserProfile();
      if (!mounted) return;
      setState(() {
        final bool wasEmployee = _isEmployee;
        _isEmployee = profile.isEmployee;

        if (wasEmployee != _isEmployee) {
          _buildPages();
          if (_currentIndex >= _pages.length) {
            _currentIndex = 0;
          }
        }

        _isLoadingProfile = false;
      });
    } catch (e) {
      if (!mounted) return;
      // Default to non-employee if profile fetch fails
      setState(() {
        if (_isEmployee) {
          // if it was employee, we need to rebuild pages
          _isEmployee = false;
          _buildPages();
          if (_currentIndex >= _pages.length) {
            _currentIndex = 0;
          }
        }
        _isLoadingProfile = false;
      });
    }
  }

  void _buildPages() {
    _pages = <Widget>[
      const HomeContentPage(), // Home page content without bottom nav
    ];

    // Only add Gift page for employees
    if (_isEmployee) {
      _pages.add(const GiftPage());
    }

    _pages.addAll([
      const CouponsPage(), // Enhanced coupon management page
      const ProfilePage(),
    ]);
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
