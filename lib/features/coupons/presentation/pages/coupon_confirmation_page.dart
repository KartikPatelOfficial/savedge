import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:savedge/features/coupons/data/models/user_coupon_model.dart';

import '../../../coupons/data/models/coupon_claim_models.dart';
import '../../../coupons/data/models/coupon_gifting_models.dart';
import '../../../coupons/data/services/coupon_payment_service.dart';
import '../../../coupons/data/services/coupon_service.dart';
import '../../../qr_scanner/presentation/pages/qr_scanner_page.dart';
import 'redeemed_coupon_page.dart';

/// Confirmation page for coupon usage/redemption
class CouponConfirmationPage extends StatefulWidget {
  const CouponConfirmationPage({
    super.key,
    this.userCoupon,
    this.claimCoupon,
    this.redemptionMethod,
    required this.confirmationType,
  });

  final UserCouponDetailModel? userCoupon; // For owned coupons
  final CouponCheckResponse? claimCoupon; // For claiming new coupons
  final String? redemptionMethod; // points, online, membership
  final CouponConfirmationType confirmationType;

  @override
  State<CouponConfirmationPage> createState() => _CouponConfirmationPageState();
}

class _CouponConfirmationPageState extends State<CouponConfirmationPage>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _isConfirming = false;
  int? _claimedCouponId; // Store the claimed coupon ID for direct redemption
  final CouponService _couponService = GetIt.I<CouponService>();
  final CouponPaymentService _couponPaymentService =
      GetIt.I<CouponPaymentService>();

  // Pine Labs payment tracking
  int? _currentTransactionId;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    // Start animations
    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _couponPaymentService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE1E5E9), width: 1),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 100, 20, 40),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildModernCouponCard(),
                const SizedBox(height: 32),
                _buildModernConfirmationDetails(),
                const SizedBox(height: 32),
                _buildModernActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final isUse = widget.confirmationType == CouponConfirmationType.use;
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isUse
                  ? [const Color(0xFF4CAF50), const Color(0xFF45A049)]
                  : [const Color(0xFF6F3FCC), const Color(0xFF8E44AD)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color:
                    (isUse ? const Color(0xFF4CAF50) : const Color(0xFF6F3FCC))
                        .withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            isUse ? Icons.check_circle_outline : Icons.redeem,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          isUse ? 'Ready to Use!' : 'Almost There!',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isUse
              ? 'Scan vendor QR code to verify and redeem your coupon'
              : 'Review and confirm your purchase',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildModernCouponCard() {
    final title = widget.userCoupon?.title ?? widget.claimCoupon?.title ?? '';
    final vendorName =
        widget.userCoupon?.vendorName ?? widget.claimCoupon?.vendorName ?? '';
    final discountDisplay =
        widget.userCoupon?.discountDisplay ??
        widget.claimCoupon?.discountDisplay ??
        '';
    final description =
        widget.userCoupon?.description ?? widget.claimCoupon?.description ?? '';
    final minCartValue =
        widget.userCoupon?.minCartValue ??
        widget.claimCoupon?.minCartValue ??
        0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.store_outlined,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  vendorName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFE1E5E9),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        discountDisplay,
                        style: const TextStyle(
                          color: Color(0xFF6F3FCC),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (minCartValue > 0) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Minimum order: ₹${minCartValue.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Decorative elements
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            left: -20,
            bottom: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernConfirmationDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE1E5E9), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6F3FCC), Color(0xFF8E44AD)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.assignment_turned_in,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'Confirmation Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ..._buildModernConfirmationItems(),
        ],
      ),
    );
  }

  List<Widget> _buildModernConfirmationItems() {
    final items = <Widget>[];

    switch (widget.confirmationType) {
      case CouponConfirmationType.use:
        items.add(
          _buildModernConfirmationItem(
            icon: Icons.check_circle_outline,
            title: 'Action',
            subtitle: _getCouponTypeText(),
            color: const Color(0xFF4CAF50),
          ),
        );

        if (widget.userCoupon?.isGifted == true) {
          items.add(
            _buildModernConfirmationItem(
              icon: Icons.card_giftcard,
              title: 'Special Gift',
              subtitle: 'Shared by a colleague',
              color: const Color(0xFFFF6B35),
            ),
          );
        }

        // Show remaining uses for subscription coupons
        if (_isSubscriptionCoupon()) {
          items.add(
            _buildModernConfirmationItem(
              icon: Icons.repeat,
              title: 'What\'s Next',
              subtitle: _getAfterUseText(),
              color: const Color(0xFF6F3FCC),
            ),
          );
        }
        break;

      case CouponConfirmationType.claim:
        items.add(
          _buildModernConfirmationItem(
            icon: _getPaymentIcon(),
            title: 'Payment Method',
            subtitle: _getPaymentMethodText(),
            color: _getPaymentColor(),
          ),
        );

        if (widget.redemptionMethod == 'membership') {
          // Remaining claims should be based on total subscription claims (not used count)
          // Prefer server-computed remaining claims if available
          final remaining =
              widget.claimCoupon?.remainingSubscriptionClaims ??
              ((widget.claimCoupon?.userMaxRedemptions ?? 1) -
                  (widget.claimCoupon?.userUsedRedemptions ?? 0));
          items.add(
            _buildModernConfirmationItem(
              icon: Icons.workspace_premium,
              title: 'Membership Status',
              subtitle: 'You\'ll have ${remaining - 1} claims remaining',
              color: const Color(0xFF6F3FCC),
            ),
          );
        }

        if (widget.redemptionMethod == 'freeTrial') {
          // Remaining claims should be based on total subscription claims (not used count)
          // Prefer server-computed remaining claims if available
          final remaining =
              widget.claimCoupon?.remainingSubscriptionClaims ??
              ((widget.claimCoupon?.userMaxRedemptions ?? 1) -
                  (widget.claimCoupon?.userUsedRedemptions ?? 0));
          items.add(
            _buildModernConfirmationItem(
              icon: Icons.celebration,
              title: 'Free Trial Status',
              subtitle: 'You\'ll have ${remaining - 1} claims remaining',
              color: const Color(0xFFFF6B35),
            ),
          );
        }
        break;
    }

    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return Padding(
        padding: EdgeInsets.only(bottom: index < items.length - 1 ? 20 : 0),
        child: item,
      );
    }).toList();
  }

  Widget _buildModernConfirmationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.check_circle, color: color, size: 20),
        ],
      ),
    );
  }

  Widget _buildModernActionButtons() {
    final buttonColor = widget.confirmationType == CouponConfirmationType.use
        ? const Color(0xFF4CAF50)
        : const Color(0xFF6F3FCC);

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 64,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: ElevatedButton(
            onPressed: _isConfirming ? null : _handleConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey[300],
              disabledForegroundColor: Colors.grey[500],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
            ),
            child: _isConfirming
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          strokeWidth: 2,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        widget.confirmationType == CouponConfirmationType.use
                            ? 'Opening Scanner...'
                            : 'Processing...',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_getConfirmIcon(), size: 22),
                      const SizedBox(width: 10),
                      Text(
                        _getConfirmButtonText(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: TextButton(
            onPressed: _isConfirming ? null : () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Go Back',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  String _getCouponTypeText() {
    if (widget.userCoupon?.isGifted == true) {
      return 'Use your gifted coupon';
    }
    return 'Use your purchased coupon';
  }

  bool _isSubscriptionCoupon() {
    // Check if this is a subscription-based coupon
    // This could be determined by:
    // 1. Coupon type/category
    // 2. If user has subscription and this coupon is part of subscription benefits
    // 3. If coupon has multiple uses per period

    // For demonstration, let's say subscription coupons have specific patterns
    final title = widget.userCoupon?.title.toLowerCase() ?? '';
    return title.contains('subscription') ||
        title.contains('membership') ||
        title.contains('unlimited');
  }

  String _getAfterUseText() {
    if (_isSubscriptionCoupon()) {
      // For subscription coupons, show remaining uses
      return 'You can use this coupon 2 more times this month';
    } else {
      // For regular coupons, they're usually one-time use
      return 'This coupon will be marked as used';
    }
  }

  String _getPaymentMethodText() {
    switch (widget.redemptionMethod) {
      case 'online':
        final amount = widget.claimCoupon?.cashPrice ?? 0;
        return 'Pay ₹$amount with card/UPI';
      case 'membership':
        return 'Use membership benefits';
      case 'freeTrial':
        return 'Use free trial benefits';
      default:
        return 'Unknown payment method';
    }
  }

  IconData _getConfirmIcon() {
    switch (widget.confirmationType) {
      case CouponConfirmationType.use:
        return Icons.check_circle_outline;
      case CouponConfirmationType.claim:
        return Icons.get_app;
    }
  }

  String _getConfirmButtonText() {
    switch (widget.confirmationType) {
      case CouponConfirmationType.use:
        return 'Verify & Use';
      case CouponConfirmationType.claim:
        return 'Claim Coupon';
    }
  }

  IconData _getPaymentIcon() {
    switch (widget.redemptionMethod) {
      case 'online':
        return Icons.credit_card;
      case 'membership':
        return Icons.workspace_premium;
      case 'freeTrial':
        return Icons.celebration;
      default:
        return Icons.payment;
    }
  }

  Color _getPaymentColor() {
    switch (widget.redemptionMethod) {
      case 'online':
        return const Color(0xFF00C851);
      case 'membership':
        return const Color(0xFF6F3FCC);
      case 'freeTrial':
        return const Color(0xFFFF6B35);
      default:
        return const Color(0xFF2196F3);
    }
  }

  Future<void> _handleConfirm() async {
    setState(() => _isConfirming = true);

    try {
      if (widget.confirmationType == CouponConfirmationType.use) {
        // For using existing coupon, open QR scanner for vendor verification first
        if (widget.userCoupon == null) {
          throw Exception(
            'Error: Owned coupon data is missing. Cannot proceed with redemption.',
          );
        }
        await _navigateToQRScanner();
      } else {
        // Claim new coupon
        if (widget.claimCoupon == null) {
          throw Exception(
            'Error: Coupon data is missing. Cannot proceed with claiming.',
          );
        }

        // Route based on redemption method. For online payment, redirect to payment page.
        if (widget.redemptionMethod == 'membership' || widget.redemptionMethod == 'freeTrial') {
          await _claimNewCoupon();
          if (!mounted) return;
          _showSuccessDialog();
        } else if (widget.redemptionMethod == 'online') {
          await _handleOnlinePayment();
          // User will be redirected to payment page, then back to app
        } else {
          throw Exception('Invalid redemption method');
        }
      }
    } catch (e) {
      if (!mounted) return;
      _showErrorDialog(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isConfirming = false);
      }
    }
  }

  Future<void> _navigateToQRScanner() async {
    if (widget.userCoupon == null) {
      throw Exception('User coupon not found');
    }

    // Navigate to QR scanner for vendor verification
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => QRScannerPage(
          couponId: widget.userCoupon!.couponId,
          expectedVendorUid: widget.userCoupon!.vendorUserId,
          expectedVendorName: widget.userCoupon!.vendorName,
        ),
      ),
    );

    // Handle the result from QR scanner
    if (result == true) {
      // QR verification and redemption was successful
      if (!mounted) return;
      _showSuccessDialog();
    } else {
      // QR verification failed or was cancelled
      // Do nothing - user remains on confirmation page
    }
  }

  Future<void> _claimNewCoupon() async {
    if (widget.claimCoupon == null) {
      throw Exception('Coupon data not found');
    }

    switch (widget.redemptionMethod) {
      case 'membership':
      case 'freeTrial':
        final response = await _couponService.claimCouponFromSubscription(
          widget.claimCoupon!.couponId,
        );
        // Store the claimed coupon ID for potential direct redemption
        _claimedCouponId = response.userCouponId;
        break;
      case 'online':
        // Handled separately in _handleConfirm to ensure proper flow
        break;
      default:
        throw Exception('Invalid redemption method');
    }
  }

  Future<void> _handleOnlinePayment() async {
    if (widget.claimCoupon == null) {
      throw Exception('Coupon data not found');
    }

    try {
      // Start payment flow - creates order and opens payment URL
      final result = await _couponPaymentService.startPayment(
        couponId: widget.claimCoupon!.couponId,
      );

      if (!result.success) {
        throw Exception(result.errorMessage ?? 'Failed to start payment');
      }

      _currentTransactionId = result.transactionId;

      if (!mounted) return;

      // Show dialog informing user about payment redirect
      _showPaymentPendingDialog();
    } catch (e) {
      throw Exception('Failed to initialize payment: $e');
    }
  }

  void _showPaymentPendingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.open_in_browser, color: Color(0xFF6F3FCC), size: 24),
            SizedBox(width: 8),
            Text('Payment Started'),
          ],
        ),
        content: const Text(
          'You\'ve been redirected to the payment page. After completing payment, return to the app to check your coupon status.',
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              // Check payment status
              await _checkPaymentStatus();
            },
            child: const Text('Check Status'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Go back
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _checkPaymentStatus() async {
    if (_currentTransactionId == null) {
      _showErrorDialog('Transaction ID not found');
      return;
    }

    setState(() => _isConfirming = true);

    try {
      final status = await _couponPaymentService.checkPaymentStatus(
        _currentTransactionId!,
      );

      final statusStr = status['status']?.toString() ?? '';

      if (statusStr == 'Success') {
        int? userCouponId =
            status['userCouponId'] as int? ??
            status['data']?['userCouponId'] as int?;
        if (userCouponId != null) {
          _claimedCouponId = userCouponId;
        }

        setState(() => _isConfirming = false);
        _showSuccessDialog();
      } else if (statusStr == 'Failed') {
        final errorMsg = status['failureReason']?.toString() ?? 'Payment failed';
        setState(() => _isConfirming = false);
        _showErrorDialog(errorMsg);
      } else {
        // Still pending
        setState(() => _isConfirming = false);
        _showPaymentPendingDialog();
      }
    } catch (e) {
      setState(() => _isConfirming = false);
      _showErrorDialog('Failed to check payment status: $e');
    }
  }

  void _showSuccessDialog() {
    final isUse = widget.confirmationType == CouponConfirmationType.use;
    final successColor = isUse
        ? const Color(0xFF4CAF50)
        : const Color(0xFF6F3FCC);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isUse
                        ? [const Color(0xFF4CAF50), const Color(0xFF45A049)]
                        : [const Color(0xFF6F3FCC), const Color(0xFF8E44AD)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isUse ? Icons.check_circle : Icons.celebration,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                isUse ? 'Used Successfully! 🎉' : 'Claimed Successfully! 🎉',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isUse
                    ? 'Show this to the vendor for your discount'
                    : 'Your coupon is ready to use!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              // Show different actions based on type
              if (isUse) ...[
                // For used coupons - navigate to redeemed coupon page
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pop(); // Close confirmation page
                      // Navigate to redeemed coupon page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RedeemedCouponPage(
                            userCoupon: _convertToUserCouponModel(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: successColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                // For claimed coupons - show Use Now option
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Close the dialog and open QR scanner like "Verify & Use"
                          Navigator.of(context).pop();
                          _navigateToUseNow();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: successColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.redeem, size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              'Use Now',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                          Navigator.of(
                            context,
                          ).pop(true); // Return to previous screen
                        },
                        child: Text(
                          'Go to Wallet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToUseNow() async {
    // For newly claimed coupons, navigate to QR scanner for verification before use
    if (_claimedCouponId == null || widget.claimCoupon == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: Claimed coupon data not found'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Navigate to QR scanner for newly claimed coupon
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (context) => QRScannerPage(
            couponId: widget.claimCoupon!.couponId,
            expectedVendorUid: widget.claimCoupon!.vendorUserId,
            expectedVendorName: widget.claimCoupon!.vendorName,
            userCouponId: _claimedCouponId, // Use the already claimed coupon
          ),
        ),
      );

      if (result == true) {
        // QR verification and redemption was successful
        // Return to previous screen (close confirmation page)
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
      // If result is false or null (cancelled/failed), just stay on the success dialog
      // User can choose "Go to Wallet" if they want to leave
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 24),
            SizedBox(width: 8),
            Text('Error'),
          ],
        ),
        content: Text(error.replaceAll('Exception: ', '')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Convert UserCouponDetailModel to UserCouponModel for RedeemedCouponPage
  UserCouponModel _convertToUserCouponModel() {
    final userCoupon = widget.userCoupon!;
    return UserCouponModel(
      id: userCoupon.id,
      couponId: userCoupon.couponId,
      title: userCoupon.title,
      description: userCoupon.description ?? '',
      discountValue: userCoupon.discountValue,
      discountType: userCoupon.discountType,
      discountDisplay: _generateDiscountDisplay(
        userCoupon.discountType,
        userCoupon.discountValue,
      ),
      minCartValue: userCoupon.minCartValue ?? 0.0,
      maxDiscountAmount: 0.0,
      // Not available in UserCouponDetailModel
      vendorId: userCoupon.vendorId,
      vendorUserId: userCoupon.vendorUserId,
      vendorName: userCoupon.vendorName,
      expiryDate: userCoupon.expiryDate.toIso8601String(),
      isUsed: true,
      // Since this is called after successful redemption
      usedAt: DateTime.now().toIso8601String(),
      // Current time as redemption time
      claimedAt: userCoupon.acquiredDate.toIso8601String(),
      isGifted: userCoupon.isGifted,
      terms: null,
      // Not available in UserCouponDetailModel
      imageUrl: userCoupon.imageUrl,
      redemptionCode: userCoupon.uniqueCode,
    );
  }

  String _generateDiscountDisplay(String discountType, double discountValue) {
    switch (discountType.toLowerCase()) {
      case 'percentage':
        return '${discountValue.toInt()}% Off';
      case 'fixedamount':
        return '₹${discountValue.toInt()} Off';
      default:
        return '${discountValue.toInt()}% Off';
    }
  }
}

enum CouponConfirmationType { use, claim }
