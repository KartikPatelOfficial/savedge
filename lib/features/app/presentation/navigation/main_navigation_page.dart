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
  final int initialTab;
  const MainNavigationPage({super.key, this.initialTab = 0});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> with SingleTickerProviderStateMixin {
  late int _currentIndex = widget.initialTab;
  bool _isEmployee = false;
  bool _isLoadingProfile = true;
  bool _citySelectionShown = false;
  UserProfileResponse3? _userProfile;
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
        _userProfile = profile;
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
          backgroundColor: Colors.transparent, // Transparent to show global aurora backdrop
          body: AnimatedBuilder(
            animation: _animationController,
            child: Stack(
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
            builder: (context, child) {
              final animValue = _animationController.value;
              return Stack(
                children: [
                  // Bottom Layer: The drawer (always in tree to preserve indices)
                  IgnorePointer(
                    ignoring: animValue == 0,
                    child: Opacity(
                      opacity: animValue,
                      child: Transform.translate(
                        offset: Offset(-80 * (1 - animValue), 0),
                        child: HomeDrawer(
                          userName: _userProfile?.displayName ?? '',
                          onMenuItemTap: (title) {
                            _toggleDrawer();
                          },
                        ),
                      ),
                    ),
                  ),

                  // Top Layer: The actual app scaling and sliding
                  Transform.translate(
                    offset: Offset(_slideAnimation.value, 0),
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(animValue * 32),
                        child: Stack(
                          children: [
                            // Opaque background that fades in during drawer animation
                            // so content doesn't show through to dark drawer
                            Opacity(
                              opacity: animValue,
                              child: Container(color: const Color(0xFFF6F8FB)),
                            ),
                            child!,

                            // Overlay to tap to close menu when open
                            if (animValue > 0)
                              Positioned.fill(
                                child: GestureDetector(
                                  onTap: _toggleDrawer,
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
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
    _isDrawerOpen = !_isDrawerOpen;
    if (_isDrawerOpen) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}

