import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/auth/domain/entities/extended_user_profile.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/subscription/data/services/razorpay_payment_service.dart';
import 'package:savedge/features/subscription/domain/entities/subscription_plan.dart';

enum PaymentMethod {
  points('Pay with Points'),
  online('Pay Online');

  const PaymentMethod(this.displayName);
  final String displayName;
}

class SubscriptionPurchasePage extends StatefulWidget {
  const SubscriptionPurchasePage({super.key, required this.plan});
  final SubscriptionPlan plan;

  static Route<void> route(SubscriptionPlan plan) {
    return MaterialPageRoute(
      builder: (context) => SubscriptionPurchasePage(plan: plan),
    );
  }

  @override
  State<SubscriptionPurchasePage> createState() =>
      _SubscriptionPurchasePageState();
}

class _SubscriptionPurchasePageState extends State<SubscriptionPurchasePage>
    with SingleTickerProviderStateMixin {
  ExtendedUserProfile? _userProfile;
  bool _isLoading = true;
  bool _isProcessingPayment = false;
  String? _error;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.online;
  late final AnimationController _shimmerController;

  static const _purple = Color(0xFF6F3FCC);
  static const _purpleLight = Color(0xFFF5F0FF);
  static const _bg = Color(0xFFF8F7FC);
  static const _dark = Color(0xFF111827);
  static const _grey = Color(0xFF6B7280);

  AuthRepository get _authRepository => GetIt.I<AuthRepository>();
  RazorpayPaymentService get _paymentService =>
      GetIt.I<RazorpayPaymentService>();
  SubscriptionPlan get plan => widget.plan;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _loadUserProfile();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    _paymentService.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    try {
      final profile = await _authRepository.getUserProfileExtended();
      if (mounted) {
        setState(() {
          _userProfile = profile;
          if (profile.isEmployee &&
              profile.pointsBalance >= _calculatePointsCost()) {
            _selectedPaymentMethod = PaymentMethod.points;
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  int _calculatePointsCost() => plan.price.round();

  List<String> get _features {
    if (plan.features == null || plan.features!.isEmpty) return [];
    return plan.features!
        .split('\n')
        .map((f) => f.trim())
        .where((f) => f.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: _purple,
                  strokeWidth: 2.5,
                ),
              )
            : _error != null
                ? _buildError()
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _buildHeader(),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 24, 20, 24),
                                child: Column(
                                  children: [
                                    _buildPriceCard(),
                                    if (_features.isNotEmpty) ...[
                                      const SizedBox(height: 16),
                                      _buildFeatures(),
                                    ],
                                    if (_userProfile?.isEmployee == true) ...[
                                      const SizedBox(height: 16),
                                      _buildPointsBalance(),
                                    ],
                                    const SizedBox(height: 16),
                                    _buildPaymentMethods(),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildBottomBar(),
                    ],
                  ),
      ),
    );
  }

  // ── Header with gradient ────────────────────────────────────────────────

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7C4DFF), _purple, Color(0xFF5B21B6)],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -40,
            top: -20,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(18),
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(12),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Plan badge
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(25),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.workspace_premium_rounded,
                            color: Colors.amber, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          plan.durationDisplay.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Plan name
                  Text(
                    plan.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Unlock all premium benefits',
                    style: TextStyle(
                      color: Colors.white.withAlpha(180),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Price card ──────────────────────────────────────────────────────────

  Widget _buildPriceCard() {
    final gstRate = 18;
    final total = plan.price;
    final base = (total / (1 + gstRate / 100));
    final gst = total - base;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _purple.withAlpha(15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              children: [
                _priceRow('Subscription', plan.name),
                const SizedBox(height: 10),
                _priceRow('Duration', plan.durationDisplay),
                const SizedBox(height: 10),
                _priceRow('Base Price', '₹${base.toStringAsFixed(2)}'),
                const SizedBox(height: 10),
                _priceRow('GST ($gstRate%)', '₹${gst.toStringAsFixed(2)}'),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
              color: _purpleLight,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _dark,
                  ),
                ),
                Text(
                  plan.priceDisplay,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: _purple,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: _grey)),
        Text(value,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: _dark)),
      ],
    );
  }

  // ── Features ───────────────────────────────────────────────────────────

  Widget _buildFeatures() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _purple.withAlpha(10),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome_rounded, size: 18, color: _purple),
              SizedBox(width: 8),
              Text(
                'What you get',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _dark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ..._features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withAlpha(25),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.check_rounded,
                          size: 14, color: Color(0xFF10B981)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        f,
                        style: const TextStyle(
                          fontSize: 13,
                          color: _dark,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // ── Points balance ─────────────────────────────────────────────────────

  Widget _buildPointsBalance() {
    if (_userProfile == null) return const SizedBox.shrink();
    final enough = _userProfile!.pointsBalance >= _calculatePointsCost();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: enough
            ? const Color(0xFFFFF7ED)
            : const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: enough
              ? const Color(0xFFFED7AA)
              : const Color(0xFFFECACA),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.stars_rounded,
                color: enough ? Colors.orange : Colors.red[400], size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your Points',
                    style: TextStyle(
                        fontSize: 12, color: _grey, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(
                  '${_userProfile!.pointsBalance} pts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color:
                        enough ? Colors.orange[700] : Colors.red[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: enough
                  ? const Color(0xFF10B981).withAlpha(20)
                  : Colors.red[50],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              enough ? 'Sufficient' : 'Low Balance',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: enough
                    ? const Color(0xFF10B981)
                    : Colors.red[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Payment methods ────────────────────────────────────────────────────

  Widget _buildPaymentMethods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'Pay with',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _dark,
            ),
          ),
        ),
        if (_userProfile?.isEmployee == true) ...[
          _paymentTile(
            method: PaymentMethod.points,
            icon: Icons.stars_rounded,
            title: 'Points',
            subtitle: '${_calculatePointsCost()} points required',
            color: Colors.orange,
            enabled: _userProfile!.pointsBalance >= _calculatePointsCost(),
          ),
          const SizedBox(height: 10),
        ],
        _paymentTile(
          method: PaymentMethod.online,
          icon: Icons.account_balance_wallet_rounded,
          title: 'UPI / Net Banking / Wallet',
          subtitle: 'Powered by Razorpay',
          color: const Color(0xFF3B82F6),
          enabled: true,
        ),
      ],
    );
  }

  Widget _paymentTile({
    required PaymentMethod method,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required bool enabled,
  }) {
    final selected = _selectedPaymentMethod == method;

    return GestureDetector(
      onTap: enabled
          ? () {
              HapticFeedback.lightImpact();
              setState(() => _selectedPaymentMethod = method);
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? color.withAlpha(15) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? color.withAlpha(100) : const Color(0xFFE5E7EB),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: enabled
                    ? (selected ? color.withAlpha(30) : const Color(0xFFF3F4F6))
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon,
                  size: 20,
                  color: enabled
                      ? (selected ? color : _grey)
                      : const Color(0xFFD1D5DB)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: enabled ? _dark : const Color(0xFFD1D5DB),
                      )),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: enabled ? _grey : const Color(0xFFD1D5DB),
                      )),
                ],
              ),
            ),
            // Radio indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? color : Colors.transparent,
                border: Border.all(
                  color: enabled
                      ? (selected ? color : const Color(0xFFD1D5DB))
                      : const Color(0xFFE5E7EB),
                  width: 2,
                ),
              ),
              child: selected
                  ? const Icon(Icons.check_rounded,
                      size: 14, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // ── Bottom bar ─────────────────────────────────────────────────────────

  Widget _buildBottomBar() {
    final isPoints = _selectedPaymentMethod == PaymentMethod.points;
    final canPay = !isPoints ||
        (_userProfile?.pointsBalance ?? 0) >= _calculatePointsCost();

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Price recap
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total',
                      style: TextStyle(fontSize: 12, color: _grey)),
                  Text(
                    isPoints
                        ? '${_calculatePointsCost()} pts'
                        : plan.priceDisplay,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: _dark,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            // Pay button
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed:
                    canPay && !_isProcessingPayment ? _handlePurchase : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _purple,
                  disabledBackgroundColor: const Color(0xFFD1D5DB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isProcessingPayment
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isPoints
                                ? Icons.stars_rounded
                                : Icons.lock_rounded,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isPoints ? 'Pay with Points' : 'Pay Now',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Error ──────────────────────────────────────────────────────────────

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red[50],
                shape: BoxShape.circle,
              ),
              child:
                  Icon(Icons.error_outline_rounded, color: Colors.red[400], size: 40),
            ),
            const SizedBox(height: 20),
            const Text('Something went wrong',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w700, color: _dark)),
            const SizedBox(height: 8),
            Text(_error!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: _grey, height: 1.5)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadUserProfile,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Business logic (unchanged) ─────────────────────────────────────────

  void _handlePurchase() {
    HapticFeedback.mediumImpact();
    if (_selectedPaymentMethod == PaymentMethod.points) {
      _showPointsConfirmation();
    } else {
      _handleOnlinePayment();
    }
  }

  void _showPointsConfirmation() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.withAlpha(25),
                  borderRadius: BorderRadius.circular(16),
                ),
                child:
                    const Icon(Icons.stars_rounded, color: Colors.orange, size: 32),
              ),
              const SizedBox(height: 16),
              const Text(
                'Confirm Points Payment',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w800, color: _dark),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  children: [
                    _confirmRow('Plan', plan.name, bold: true),
                    const SizedBox(height: 10),
                    _confirmRow('Cost', '${_calculatePointsCost()} pts',
                        color: Colors.orange),
                    const Divider(height: 20),
                    _confirmRow(
                        'Balance', '${_userProfile?.pointsBalance ?? 0} pts'),
                    const SizedBox(height: 8),
                    _confirmRow(
                      'After',
                      '${(_userProfile?.pointsBalance ?? 0) - _calculatePointsCost()} pts',
                      color: const Color(0xFF10B981),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Color(0xFFE5E7EB)),
                        ),
                      ),
                      child: const Text('Cancel',
                          style: TextStyle(
                              color: _grey, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _processPointsPayment();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Confirm',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _confirmRow(String label, String value,
      {bool bold = false, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: _grey)),
        Text(value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
              color: color ?? _dark,
            )),
      ],
    );
  }

  void _processPointsPayment() async {
    if (_isProcessingPayment) return;
    setState(() => _isProcessingPayment = true);
    try {
      final result = await _paymentService.purchaseWithPoints(
        planId: plan.id,
        autoRenew: false,
      );
      if (mounted) {
        setState(() => _isProcessingPayment = false);
        if (result.success) {
          _showSuccessDialog('Subscription purchased with points!');
        } else {
          _showErrorDialog(result.message);
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isProcessingPayment = false);
        _showErrorDialog('Failed to purchase: $e');
      }
    }
  }

  void _handleOnlinePayment() async {
    if (_isProcessingPayment) return;
    setState(() => _isProcessingPayment = true);
    try {
      final userName = [_userProfile?.firstName, _userProfile?.lastName]
          .where((s) => s != null && s.isNotEmpty)
          .join(' ');
      final result = await _paymentService.processSubscriptionPayment(
        planId: plan.id,
        autoRenew: false,
        userPhone: _userProfile?.phoneNumber,
        userEmail: _userProfile?.email,
        userName: userName.isNotEmpty ? userName : null,
      );
      if (!mounted) return;
      setState(() => _isProcessingPayment = false);
      if (result.success) {
        _showSuccessDialog('Payment completed! Your subscription is now active.');
      } else {
        _showErrorDialog(result.message);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isProcessingPayment = false);
        _showErrorDialog('Failed to initiate payment: $e');
      }
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded,
                    color: Color(0xFF10B981), size: 44),
              ),
              const SizedBox(height: 20),
              const Text('You\'re all set!',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w800, color: _dark)),
              const SizedBox(height: 8),
              Text(message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14, color: _grey, height: 1.5)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Continue',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.error_outline_rounded,
                    color: Colors.red[400], size: 44),
              ),
              const SizedBox(height: 20),
              const Text('Payment Failed',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w800, color: _dark)),
              const SizedBox(height: 8),
              Text(error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14, color: _grey, height: 1.5)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                    ),
                  ),
                  child: const Text('Try Again',
                      style:
                          TextStyle(color: _grey, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
