import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/city/domain/entities/city.dart';
import 'package:savedge/features/city/presentation/bloc/city_bloc.dart';
import 'package:savedge/features/city/presentation/bloc/city_event.dart';
import 'package:savedge/features/city/presentation/bloc/city_state.dart';
import 'package:savedge/features/city/presentation/pages/region_unavailable_page.dart';
import 'package:savedge/features/city/presentation/widgets/city_selection_sheet.dart';
import 'package:savedge/features/coupons/presentation/pages/coupons_page.dart';
import 'package:savedge/features/coupons/presentation/pages/gift_page.dart';
import 'package:savedge/features/home/presentation/pages/home_content_page.dart';
import 'package:savedge/features/home/presentation/widgets/widgets.dart';
import 'package:savedge/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:savedge/features/user_profile/presentation/pages/profile_page.dart';

/// Main navigation wrapper that handles bottom navigation
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isEmployee = false;
  bool _isLoadingProfile = true;
  bool _citySelectionShown = false;
  late List<Widget> _pages;
  bool _isNavBarVisible = true;
  
  bool _isDrawerOpen = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );
    _slideAnimation = Tween<double>(begin: 0.0, end: 260.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _buildPages();
    _loadUserProfile();
    _initializeNotifications();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Show city selection sheet if no city is selected yet
  void _showCitySelectionIfNeeded(CityState cityState) {
    if (_citySelectionShown) return;

    // Only show if cities are loaded but none selected
    if (cityState is CitiesLoaded && cityState.selectedCityId == null) {
      _citySelectionShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        CitySelectionSheet.show(
          context,
          showCloseButton: false,
          isDismissible: false,
        );
      });
    }
  }

  void _initializeNotifications() {
    // Register device token and load unread count
    final notificationBloc = context.read<NotificationBloc>();
    notificationBloc.add(const RegisterDeviceToken());
    notificationBloc.add(const LoadUnreadCount());

    // Log app open activity for engagement tracking (AppOpen = 0)
    notificationBloc.add(const LogUserActivity(activityType: 0));
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
      HomeContentPage(onMenuTap: _toggleDrawer), // Home page content without bottom nav
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

    return BlocConsumer<CityBloc, CityState>(
      listener: (context, cityState) {
        _showCitySelectionIfNeeded(cityState);
      },
      builder: (context, cityState) {
        // Show loading while city state is being determined
        if (cityState is CityInitial || cityState is CityLoading) {
          // Trigger loading cities if not already loading
          if (cityState is CityInitial) {
            context.read<CityBloc>().add(const LoadCities());
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
            ),
          );
        }

        // If "Other" city is selected, show region unavailable page
        if (cityState is CitiesLoaded &&
            cityState.selectedCityId == City.otherCityId) {
          return RegionUnavailablePage(
            onNavigateToGiftVouchers: () {
              // Navigate to gift vouchers - this will be handled by the page
              Navigator.pushNamed(context, '/voucher-orders');
            },
            onNavigateToBrandVouchers: () {
              // Navigate to brand vouchers - this will be handled by the page
              Navigator.pushNamed(context, '/voucher-orders');
            },
          );
        }

        // Check if city selection is needed
        _showCitySelectionIfNeeded(cityState);

        // Show normal navigation for valid city selection
        return Scaffold(
          extendBody: true,
          backgroundColor: const Color(0xFF1A202C), // Dark background for the beautiful drawer
          body: Stack(
            children: [
              // Bottom Layer: The beautiful full screen background menu
              HomeDrawer(
                userName: 'Welcome',
                onMenuItemTap: (title) {
                  _toggleDrawer();
                  // Additional navigation logic based on title
                },
              ),
              
              // Top Layer: The actual app scaling and sliding
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_slideAnimation.value, 0),
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      alignment: Alignment.centerLeft, // Scale from the left edge
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(_isDrawerOpen ? 40 : 0),
                        child: Stack(
                          children: [
                            Scaffold(
                              backgroundColor: Colors.white,
                              extendBody: true,
                              body: Stack(
                                children: [
                                  NotificationListener<UserScrollNotification>(
                                    onNotification: (notification) {
                                      if (notification.direction == ScrollDirection.forward) {
                                        if (!_isNavBarVisible) setState(() => _isNavBarVisible = true);
                                      } else if (notification.direction == ScrollDirection.reverse) {
                                        if (_isNavBarVisible) setState(() => _isNavBarVisible = false);
                                      }
                                      return false;
                                    },
                                    child: IndexedStack(index: _currentIndex, children: _pages),
                                  ),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: AnimatedSlide(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeOutCubic,
                                      offset: _isNavBarVisible ? Offset.zero : const Offset(0, 1.5),
                                      child: HomeBottomNavBar(
                                        currentIndex: _currentIndex,
                                        onTap: _onBottomNavTap,
                                        isEmployee: _isEmployee,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Semi-transparent overlay to tap to close menu when open
                            if (_isDrawerOpen)
                              Positioned.fill(
                                child: GestureDetector(
                                  onTap: _toggleDrawer,
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _onBottomNavTap(int index) {
    if (_isDrawerOpen) {
      _toggleDrawer();
    }
    setState(() {
      _currentIndex = index;
    });
  }

  void _toggleDrawer() {
    if (_isDrawerOpen) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }
}

