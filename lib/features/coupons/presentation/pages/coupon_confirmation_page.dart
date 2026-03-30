import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/coupons/data/models/user_coupon_model.dart';
import 'package:savedge/features/subscription/data/services/razorpay_payment_service.dart';

import '../../../coupons/data/models/coupon_claim_models.dart';
import '../../../coupons/data/models/coupon_gifting_models.dart';
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
  late AnimationController _entryController;
  late AnimationController _iconController;
  late Animation<double> _entryFade;
  late Animation<double> _iconScale;

  bool _isConfirming = false;
  int? _claimedCouponId;
  final CouponService _couponService = GetIt.I<CouponService>();

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    _iconController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();

    _entryFade = CurvedAnimation(parent: _entryController, curve: Curves.easeOut);
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _entryController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final isUse = widget.confirmationType == CouponConfirmationType.use;
    final primaryColor = isUse ? const Color(0xFF22C55E) : const Color(0xFF8B5CF6);
    final bgColor = isUse ? const Color(0xFFF0FDF4) : const Color(0xFFF5F3FF);
    final title = widget.userCoupon?.title ?? widget.claimCoupon?.title ?? '';
    final vendorName = widget.userCoupon?.vendorName ?? widget.claimCoupon?.vendorName ?? '';
    final discountDisplay = widget.userCoupon?.discountDisplay ?? widget.claimCoupon?.discountDisplay ?? '';
    final minCartValue = widget.userCoupon?.minCartValue ?? widget.claimCoupon?.minCartValue ?? 0;

    return Scaffold(
      backgroundColor: bgColor,
      body: FadeTransition(
        opacity: _entryFade,
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Color(0xFF0F172A)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Text(
                        isUse ? 'REDEEM' : 'CLAIM',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: primaryColor,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Vector Illustration section
              const SizedBox(height: 20),
              _buildVectorIllustration(primaryColor, isUse),
              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  isUse ? 'Ready to\nUse!' : 'Almost\nThere!',
                  style: const TextStyle(
                    fontSize: 40,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                    letterSpacing: -1.0,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(28, 36, 28, 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    boxShadow: [
                      BoxShadow(color: Color(0x08000000), blurRadius: 20, offset: Offset(0, -5))
                    ],
                  ),
                  child: Column(
                    children: [
                      // Brand & Offer
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: primaryColor.withOpacity(0.3), width: 1.5),
                            ),
                            child: Icon(Icons.storefront_rounded, color: primaryColor, size: 26),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vendorName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF64748B),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF0F172A),
                                    letterSpacing: -0.5,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      
                      // Refined Discount Display
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: primaryColor.withOpacity(0.2), width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'DISCOUNT',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: primaryColor,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  discountDisplay.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    color: primaryColor,
                                    letterSpacing: -1.0,
                                  ),
                                ),
                              ],
                            ),
                            if (minCartValue > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(color: primaryColor.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'MINIMUM',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF94A3B8),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '₹${minCartValue.toInt()}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF0F172A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      // Info rows
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _getInfoItemsFlat(primaryColor),
                          ),
                        ),
                      ),
                      
                      // Main Action Button
                      SafeArea(
                        top: false,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: _isConfirming ? null : _handleConfirm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                                shadowColor: primaryColor.withOpacity(0.5),
                              ),
                              child: _isConfirming
                                  ? const SizedBox(
                                      height: 24, width: 24,
                                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _getConfirmButtonText(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.arrow_forward_rounded, size: 20),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVectorIllustration(Color primary, bool isUse) {
    return AnimatedBuilder(
      animation: _iconScale,
      builder: (context, _) => Transform.scale(
        scale: _iconScale.value,
        child: SizedBox(
          height: 140,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Background soft blob / circles
              Positioned(
                right: 20,
                top: 0,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                left: 30,
                bottom: 10,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Vector Card
              Transform.rotate(
                angle: -0.15,
                child: Container(
                  width: 150,
                  height: 90,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    gradient: LinearGradient(
                      colors: [primary.withOpacity(0.8), primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Vector dashed line
                      Positioned(
                        left: 100,
                        top: 0,
                        bottom: 0,
                        child: CustomPaint(
                          painter: _DashedLinePainterVertical(Colors.white.withOpacity(0.6)),
                          size: const Size(1, 90),
                        ),
                      ),
                      // Icon inside the card
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Icon(
                            isUse ? Icons.qr_code_2_rounded : Icons.card_giftcard_rounded,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      // Small cutouts on the card
                      Positioned(
                        left: 95,
                        top: -5,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 95,
                        bottom: -5,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Floating Sparkles
              const Positioned(
                right: 40,
                top: 10,
                child: Icon(Icons.auto_awesome_rounded, color: Color(0xFFF59E0B), size: 28),
              ),
              Positioned(
                left: 70,
                bottom: 0,
                child: Icon(Icons.auto_awesome_rounded, color: primary, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getInfoItemsFlat(Color primaryColor) {
    final items = <Widget>[];

    Widget buildRow(IconData icon, String label, String value, Color iconColor) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
                  const SizedBox(height: 2),
                  Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
                ],
              ),
            ),
          ],
        ),
      );
    }

    switch (widget.confirmationType) {
      case CouponConfirmationType.use:
        items.add(buildRow(Icons.check_circle_rounded, 'Action', _getCouponTypeText(), const Color(0xFF22C55E)));
        if (widget.userCoupon?.isGifted == true) {
          items.add(buildRow(Icons.card_giftcard_rounded, 'Type', 'Shared by a colleague', const Color(0xFFF59E0B)));
        }
        if (_isSubscriptionCoupon()) {
          items.add(buildRow(Icons.repeat_rounded, "What's Next", _getAfterUseText(), primaryColor));
        }
        break;

      case CouponConfirmationType.claim:
        items.add(buildRow(_getPaymentIcon(), 'Payment', _getPaymentMethodText(), _getPaymentColor()));
        if (widget.redemptionMethod == 'membership' || widget.redemptionMethod == 'freeTrial' || widget.redemptionMethod == 'promotion') {
          final remaining = widget.claimCoupon?.remainingSubscriptionClaims ?? 
              ((widget.claimCoupon?.userMaxRedemptions ?? 1) - (widget.claimCoupon?.userUsedRedemptions ?? 0));
          items.add(buildRow(Icons.workspace_premium_rounded, 'After This', '${remaining - 1} claims remaining', primaryColor));
        }
        break;
    }

    return items;
  }

  // ─── Logic methods (unchanged from original) ──────────────────────────────

  String _getCouponTypeText() {
    if (widget.userCoupon?.isGifted == true) {
      return 'Use your gifted coupon';
    }
    return 'Use your purchased coupon';
  }

  bool _isSubscriptionCoupon() {
    final title = widget.userCoupon?.title.toLowerCase() ?? '';
    return title.contains('subscription') ||
        title.contains('membership') ||
        title.contains('unlimited');
  }

  String _getAfterUseText() {
    if (_isSubscriptionCoupon()) {
      return 'You can use this coupon 2 more times this month';
    } else {
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
      case 'promotion':
        return 'Free via promotion';
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
      case 'promotion':
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
      case 'promotion':
        return const Color(0xFFFF6B35);
      default:
        return const Color(0xFF2196F3);
    }
  }

  Future<void> _handleConfirm() async {
    setState(() => _isConfirming = true);

    try {
      if (widget.confirmationType == CouponConfirmationType.use) {
        if (widget.userCoupon == null) {
          throw Exception(
            'Error: Owned coupon data is missing. Cannot proceed with redemption.',
          );
        }
        await _navigateToQRScanner();
      } else {
        if (widget.claimCoupon == null) {
          throw Exception(
            'Error: Coupon data is missing. Cannot proceed with claiming.',
          );
        }
        if (widget.redemptionMethod == 'membership' ||
            widget.redemptionMethod == 'freeTrial' ||
            widget.redemptionMethod == 'promotion') {
          await _claimNewCoupon();
          if (!mounted) return;
          _showSuccessDialog();
        } else if (widget.redemptionMethod == 'online') {
          await _handleOnlinePayment();
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

    if (result == true) {
      if (!mounted) return;
      _showSuccessDialog();
    }
    // If user backed out without scanning, stay on page (coupon not yet used)
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
        _claimedCouponId = response.userCouponId;
        break;
      case 'promotion':
        final response = await _couponService.claimCouponFromPromotion(
          widget.claimCoupon!.couponId,
        );
        _claimedCouponId = response.userCouponId;
        break;
      case 'online':
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
      final razorpayService = GetIt.I<RazorpayPaymentService>();

      final orderData = await razorpayService.createCouponPaymentOrder(
        couponId: widget.claimCoupon!.couponId,
      );

      final orderId = orderData['orderId'] as String;
      final amount = orderData['amount'] as int;
      final razorpayKeyId = orderData['razorpayKeyId'] as String;
      final transactionId = orderData['transactionId'] as int;
      final couponTitle =
          (orderData['couponDetails'] as Map<String, dynamic>?)?['title']
                  as String? ??
              'Coupon Purchase';

      final checkoutResult = await razorpayService.openCheckout(
        orderId: orderId,
        amount: amount,
        keyId: razorpayKeyId,
        description: couponTitle,
      );

      if (!checkoutResult.success) {
        throw Exception(checkoutResult.message);
      }

      final verifyResult = await razorpayService.verifyCouponPayment(
        transactionId: transactionId,
        razorpayOrderId: checkoutResult.razorpayOrderId!,
        razorpayPaymentId: checkoutResult.razorpayPaymentId!,
        razorpaySignature: checkoutResult.razorpaySignature!,
      );

      if (verifyResult['success'] == true) {
        _claimedCouponId = verifyResult['userCouponId'] as int?;
        if (!mounted) return;
        _showSuccessDialog();
      } else {
        throw Exception(
            verifyResult['message'] as String? ?? 'Payment verification failed');
      }
    } catch (e) {
      throw Exception('Failed to initialize payment: $e');
    }
  }

  void _showSuccessDialog() {
    final isUse = widget.confirmationType == CouponConfirmationType.use;
    final successColor =
        isUse ? const Color(0xFF22C55E) : const Color(0xFF8B5CF6);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        backgroundColor: Colors.white,
        elevation: 0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.elasticOut,
                      builder: (context, v, _) => Transform.scale(
                        scale: v,
                        child: Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: successColor.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isUse ? Icons.check_circle_rounded : Icons.celebration_rounded,
                            color: successColor,
                            size: 44,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      isUse
                          ? 'Used Successfully!'
                          : 'Claimed Successfully!',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      isUse
                          ? 'Show this to the vendor for your discount'
                          : 'Your coupon is ready to use!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (isUse) ...[
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
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
                                borderRadius: BorderRadius.circular(20)),
                            elevation: 0,
                          ),
                          child: const Text(
                            'View Details',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ] else ...[
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.of(context).pop(); // close dialog
                                await _navigateToUseNow();
                                // If user came back without redeeming, re-show the dialog
                                if (mounted && _claimedCouponId != null) {
                                  _showSuccessDialog();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: successColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 0,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.redeem_rounded, size: 22),
                                  SizedBox(width: 8),
                                  Text(
                                    'Use Now',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/home',
                                  (route) => false,
                                  arguments: 1, // Coupons tab index
                                );
                              },
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)
                                ),
                              ),
                              child: const Text(
                                'My Coupons',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF64748B),
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
              // Confetti overlay clipped to dialog bounds
              Positioned.fill(
                child: IgnorePointer(child: _ConfettiWidget()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToUseNow() async {
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
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (context) => QRScannerPage(
            couponId: widget.claimCoupon!.couponId,
            expectedVendorUid: widget.claimCoupon!.vendorUserId,
            expectedVendorName: widget.claimCoupon!.vendorName,
            userCouponId: _claimedCouponId,
          ),
        ),
      );

      if (result == true) {
        // QR scan and redemption successful - navigate to home
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home',
            (route) => false,
            arguments: 1, // Coupons tab
          );
        }
      }
      // If user backed out without scanning, do nothing - dialog will be re-shown
    } catch (e) {
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
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.error_outline_rounded, color: Colors.red.shade500, size: 40),
              ),
              const SizedBox(height: 24),
              const Text(
                'Oops!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                error.replaceAll('Exception: ', ''),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade500,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text('Try Again', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
      vendorId: userCoupon.vendorId,
      vendorUserId: userCoupon.vendorUserId,
      vendorName: userCoupon.vendorName,
      expiryDate: userCoupon.expiryDate.toIso8601String(),
      isUsed: true,
      usedAt: DateTime.now().toIso8601String(),
      claimedAt: userCoupon.acquiredDate.toIso8601String(),
      isGifted: userCoupon.isGifted,
      isGiftable: false,
      terms: null,
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

// ─── Dashed separator painter ──────────────────────────────────────────────

class _DashedLinePainter extends CustomPainter {
  final Color color;
  _DashedLinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    // Colored left + white right background
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width / 2, size.height),
        Paint()..color = color);
    canvas.drawRect(
        Rect.fromLTWH(size.width / 2, 0, size.width / 2, size.height),
        Paint()..color = const Color(0xFFF8FAFC));

    // Semicircle notches
    final notch = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, 0), 10, notch);
    canvas.drawCircle(Offset(size.width / 2, size.height), 10, notch);

    // Dashed line
    final dash = Paint()
      ..color = color.withOpacity(0.35)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashH = 6.0;
    const gapH = 4.0;
    double y = 14.0;
    while (y < size.height - 14) {
      canvas.drawLine(
          Offset(size.width / 2, y), Offset(size.width / 2, y + dashH), dash);
      y += dashH + gapH;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Confetti widget (dialog success celebration) ─────────────────────────────

class _ConfettiWidget extends StatefulWidget {
  @override
  State<_ConfettiWidget> createState() => _ConfettiWidgetState();
}

class _ConfettiWidgetState extends State<_ConfettiWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final List<_CParticle> _particles;

  static const _colors = [
    Color(0xFF6F3FCC),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFF3B82F6),
    Color(0xFFEC4899),
  ];

  @override
  void initState() {
    super.initState();
    final rng = Random();
    _particles = List.generate(
        50,
        (i) => _CParticle(
              x: rng.nextDouble(),
              startFraction: -rng.nextDouble() * 0.4,
              speed: 0.3 + rng.nextDouble() * 0.4,
              size: 5.0 + rng.nextDouble() * 7.0,
              color: _colors[i % _colors.length],
              rotationSpeed: (rng.nextDouble() - 0.5) * 12,
              amplitude: 12 + rng.nextDouble() * 30,
              phase: rng.nextDouble() * 2 * pi,
            ));
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) => CustomPaint(
        painter: _CPainter(_ctrl.value, _particles),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _CParticle {
  final double x, startFraction, speed, size, rotationSpeed, amplitude, phase;
  final Color color;
  const _CParticle({
    required this.x,
    required this.startFraction,
    required this.speed,
    required this.size,
    required this.color,
    required this.rotationSpeed,
    required this.amplitude,
    required this.phase,
  });
}

class _CPainter extends CustomPainter {
  final double progress;
  final List<_CParticle> particles;
  _CPainter(this.progress, this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final traveled = progress * p.speed;
      final y = (p.startFraction + traveled) * size.height;
      final x =
          p.x * size.width + sin(traveled * 7 + p.phase) * p.amplitude;
      if (y > size.height + 10 || y < -20) continue;
      final opacity = (1.0 - progress * 0.65).clamp(0.0, 1.0);
      final paint = Paint()..color = p.color.withOpacity(opacity);
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(traveled * p.rotationSpeed);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: Offset.zero, width: p.size, height: p.size * 0.45),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_CPainter old) => old.progress != progress;
}

// ─── Vertical dashed separator painter ─────────────────────────────────────

class _DashedLinePainterVertical extends CustomPainter {
  final Color color;
  _DashedLinePainterVertical(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final dash = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const dashH = 6.0;
    const gapH = 4.0;
    double y = 0.0;
    while (y < size.height) {
      canvas.drawLine(
          Offset(0, y), Offset(0, y + dashH), dash);
      y += dashH + gapH;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
