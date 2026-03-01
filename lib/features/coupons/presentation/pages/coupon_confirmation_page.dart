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
  Widget build(BuildContext context) {
    final isUse = widget.confirmationType == CouponConfirmationType.use;
    final accentColor =
        isUse ? const Color(0xFF10B981) : const Color(0xFF6F3FCC);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: FadeTransition(
        opacity: _entryFade,
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildStatusIcon(accentColor),
                      const SizedBox(height: 20),
                      _buildTitleSection(isUse),
                      const SizedBox(height: 28),
                      _buildTicketCard(accentColor),
                      const SizedBox(height: 20),
                      _buildInfoSection(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(accentColor),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 15,
                color: Color(0xFF1A202C),
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'Confirm',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A202C),
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(Color color) {
    return AnimatedBuilder(
      animation: _iconScale,
      builder: (context, _) => Transform.scale(
        scale: _iconScale.value,
        child: Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(
            widget.confirmationType == CouponConfirmationType.use
                ? Icons.qr_code_scanner_rounded
                : Icons.redeem_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection(bool isUse) {
    return Column(
      children: [
        Text(
          isUse ? 'Ready to Use!' : 'Almost There!',
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A202C),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          isUse
              ? 'Scan the vendor QR code to verify'
              : 'Review and confirm your purchase',
          style: TextStyle(fontSize: 15, color: Colors.grey[500]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTicketCard(Color accentColor) {
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
        widget.userCoupon?.minCartValue ?? widget.claimCoupon?.minCartValue ?? 0;

    final split = _splitDisplay(discountDisplay);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Colored discount tab
              Container(
                width: 92,
                color: accentColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      split.$1,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.0,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.22),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        split.$2,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Dashed separator line
              SizedBox(
                width: 12,
                child: CustomPaint(
                  painter: _DashedLinePainter(accentColor),
                ),
              ),

              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 16, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A202C),
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.store_outlined,
                              size: 12, color: Colors.grey[500]),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              vendorName,
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[500]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      if (description.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (minCartValue > 0) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color:
                                const Color(0xFFF59E0B).withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.shopping_cart_outlined,
                                  size: 12, color: Color(0xFFF59E0B)),
                              const SizedBox(width: 5),
                              Text(
                                'Min. ₹${minCartValue.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF92400E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildInfoSection() {
    final items = _getInfoItems();
    if (items.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DETAILS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.grey[400],
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          ...items.asMap().entries.map((e) {
            final isLast = e.key == items.length - 1;
            return Column(
              children: [
                e.value,
                if (!isLast) ...[
                  const SizedBox(height: 14),
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 14),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }

  List<Widget> _getInfoItems() {
    final items = <Widget>[];

    switch (widget.confirmationType) {
      case CouponConfirmationType.use:
        items.add(_infoRow(
          icon: Icons.check_circle_outline,
          color: const Color(0xFF4CAF50),
          label: 'Action',
          value: _getCouponTypeText(),
        ));
        if (widget.userCoupon?.isGifted == true) {
          items.add(_infoRow(
            icon: Icons.card_giftcard,
            color: const Color(0xFFFF6B35),
            label: 'Type',
            value: 'Shared by a colleague',
          ));
        }
        if (_isSubscriptionCoupon()) {
          items.add(_infoRow(
            icon: Icons.repeat,
            color: const Color(0xFF6F3FCC),
            label: "What's Next",
            value: _getAfterUseText(),
          ));
        }
        break;

      case CouponConfirmationType.claim:
        items.add(_infoRow(
          icon: _getPaymentIcon(),
          color: _getPaymentColor(),
          label: 'Payment',
          value: _getPaymentMethodText(),
        ));
        if (widget.redemptionMethod == 'membership') {
          final remaining =
              widget.claimCoupon?.remainingSubscriptionClaims ??
              ((widget.claimCoupon?.userMaxRedemptions ?? 1) -
                  (widget.claimCoupon?.userUsedRedemptions ?? 0));
          items.add(_infoRow(
            icon: Icons.workspace_premium,
            color: const Color(0xFF6F3FCC),
            label: 'After This',
            value: '${remaining - 1} membership claims remaining',
          ));
        }
        if (widget.redemptionMethod == 'freeTrial') {
          final remaining =
              widget.claimCoupon?.remainingSubscriptionClaims ??
              ((widget.claimCoupon?.userMaxRedemptions ?? 1) -
                  (widget.claimCoupon?.userUsedRedemptions ?? 0));
          items.add(_infoRow(
            icon: Icons.celebration,
            color: const Color(0xFFFF6B35),
            label: 'After This',
            value: '${remaining - 1} trial claims remaining',
          ));
        }
        break;
    }

    return items;
  }

  Widget _infoRow({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 11, color: Colors.grey[400]),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A202C),
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.check_circle, color: color, size: 18),
      ],
    );
  }

  Widget _buildBottomBar(Color accentColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isConfirming ? null : _handleConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: _isConfirming
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.confirmationType ==
                                    CouponConfirmationType.use
                                ? 'Opening Scanner...'
                                : 'Processing...',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_getConfirmIcon(), size: 20),
                          const SizedBox(width: 8),
                          Text(
                            _getConfirmButtonText(),
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: TextButton(
                onPressed:
                    _isConfirming ? null : () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey[500],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Go Back',
                    style: TextStyle(fontSize: 15)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  (String, String) _splitDisplay(String display) {
    final parts = display.split(' ');
    if (parts.length >= 2) {
      return (
        parts.take(parts.length - 1).join(' '),
        parts.last.toUpperCase()
      );
    }
    return (display, 'OFF');
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
            widget.redemptionMethod == 'freeTrial') {
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
        isUse ? const Color(0xFF10B981) : const Color(0xFF6F3FCC);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
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
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: successColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isUse ? Icons.check_circle : Icons.celebration,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      isUse
                          ? 'Used Successfully! 🎉'
                          : 'Claimed Successfully! 🎉',
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
                    if (isUse) ...[
                      SizedBox(
                        width: double.infinity,
                        height: 56,
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
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 0,
                          ),
                          child: const Text(
                            'View Details',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ] else ...[
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                _navigateToUseNow();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: successColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                elevation: 0,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.redeem, size: 20),
                                  SizedBox(width: 8),
                                  Text(
                                    'Use Now',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
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
                                Navigator.of(context).pop();
                                Navigator.of(context).pop(true);
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
              // Confetti overlay clipped to dialog bounds
              IgnorePointer(child: _ConfettiWidget()),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToUseNow() async {
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
        if (mounted) {
          Navigator.of(context).pop(true);
        }
      }
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
        Paint()..color = Colors.white);

    // Semicircle notches
    final notch = Paint()
      ..color = const Color(0xFFF7F8FA)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, 0), 7, notch);
    canvas.drawCircle(Offset(size.width / 2, size.height), 7, notch);

    // Dashed line
    final dash = Paint()
      ..color = color.withOpacity(0.35)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const dashH = 5.0;
    const gapH = 4.0;
    double y = 10.0;
    while (y < size.height - 10) {
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
