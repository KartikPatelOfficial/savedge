import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/points_payment/presentation/widgets/points_payment_dialog.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';

class PaymentOptionsBottomSheet extends StatefulWidget {
  const PaymentOptionsBottomSheet({super.key, required this.vendor});

  final Vendor vendor;

  @override
  State<PaymentOptionsBottomSheet> createState() =>
      _PaymentOptionsBottomSheetState();
}

class _PaymentOptionsBottomSheetState extends State<PaymentOptionsBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  bool _isLoadingProfile = true;
  UserProfileResponse3? _userProfile;
  int _availablePoints = 0;

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();

  SecureStorageService get _secureStorage => GetIt.I<SecureStorageService>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _slideAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
    _animationController.forward();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    try {
      final isAuthenticated = await _secureStorage.isAuthenticated();
      if (!isAuthenticated) {
        if (mounted) {
          setState(() {
            _isLoadingProfile = false;
          });
        }
        return;
      }

      final profile = await _authRepository.getCurrentUserProfile();
      if (mounted) {
        setState(() {
          _userProfile = profile;
          _availablePoints = profile.pointsBalance;
          _isLoadingProfile = false;
        });
        print('User profile loaded:');
        print('User ID: ${profile.id}');
        print('Available Points: $_availablePoints');
        print('Has Employee Info: ${profile.employeeInfo != null}');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingProfile = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) => Container(
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Transform.translate(
          offset: Offset(0, (1 - _slideAnimation.value) * 100),
          child: Opacity(opacity: _slideAnimation.value, child: child),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6F3FCC).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.payment,
                        color: Color(0xFF6F3FCC),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Choose Payment Method',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A202C),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'For ${widget.vendor.businessName}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Payment Options
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Pay with Points Option
                  _buildPaymentOption(
                    icon: Icons.stars,
                    title: 'Pay with Points',
                    subtitle: _isLoadingProfile
                        ? 'Loading...'
                        : 'Balance: $_availablePoints points',
                    description: '1 Point = ₹1',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6F3FCC), Color(0xFF9F7AEA)],
                    ),
                    isEnabled: !_isLoadingProfile && _availablePoints > 0,
                    onTap: () => _handlePayWithPoints(context),
                  ),
                  const SizedBox(height: 16),
                  // Use Coupons Option
                  _buildPaymentOption(
                    icon: Icons.local_offer,
                    title: 'Use Coupons',
                    subtitle: 'Redeem available offers',
                    description: 'Browse and apply discount coupons',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF38A169), Color(0xFF68D391)],
                    ),
                    isEnabled: true,
                    onTap: () => _handleUseCoupons(context),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required LinearGradient gradient,
    required bool isEnabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.white : Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isEnabled ? gradient.colors.first : Colors.grey[300]!,
            width: 1.5,
          ),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: gradient.colors.first.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: isEnabled ? gradient : null,
                color: !isEnabled ? Colors.grey[200] : null,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: isEnabled ? Colors.white : Colors.grey[400],
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isEnabled
                          ? const Color(0xFF1A202C)
                          : Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isEnabled
                          ? gradient.colors.first
                          : Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isEnabled ? gradient.colors.first : Colors.grey[300],
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  void _handlePayWithPoints(BuildContext context) {
    if (!_isLoadingProfile && _availablePoints > 0) {
      HapticFeedback.lightImpact();
      Navigator.pop(context); // Close bottom sheet
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => PointsPaymentDialog(
          vendor: widget.vendor,
          availablePoints: _availablePoints,
        ),
      );
    } else if (_availablePoints == 0) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('You don\'t have any points to use'),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  void _handleUseCoupons(BuildContext context) {
    HapticFeedback.lightImpact();
    Navigator.pop(context); // Close bottom sheet
    // The existing coupon flow is already shown in the vendor details page
  }
}
