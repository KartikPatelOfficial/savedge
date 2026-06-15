import 'dart:async';
import 'package:savedge/core/error/error_message_mapper.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:savedge/features/points_payment/data/models/points_payment_models.dart';
import 'package:savedge/features/points_payment/data/services/points_payment_service.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';

// ── Design tokens ───────────────────────────────────────────────────────────
// Restrained, iOS-inspired palette built around the SavEdge brand purple.
const Color _kBg = Color(0xFFF6F4FC); // soft lilac-white
const Color _kCard = Colors.white;
const Color _kLabel = Color(0xFF1A1430); // deep plum-black
const Color _kSecondary = Color(0xFF8A8398); // warm gray-violet
const Color _kHairline = Color(0xFFECE8F5); // faint violet separators
const Color _kTrack = Color(0xFFEBE7F4); // segmented control track
const Color _kAccent = Color(0xFF6D28D9); // deep violet
const Color _kAccentAlt = Color(0xFF9333EA); // gradient partner
const Color _kAccentSoft = Color(0xFFEFE9FB); // light violet tint
const Color _kField = Color(0xFFF1ECFA); // filled input surface
const Color _kGreen = Color(0xFF0E9F6E); // emerald (savings)
const Color _kGreenDeep = Color(0xFF0A7E57); // emerald text
const Color _kGreenSoft = Color(0xFFE7F6EF);
const Color _kRed = Color(0xFFEF4444); // red

const LinearGradient _kAccentGradient = LinearGradient(
  colors: [_kAccent, _kAccentAlt],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const LinearGradient _kGreenGradient = LinearGradient(
  colors: [Color(0xFF0E9F6E), Color(0xFF13B981)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

enum PaymentStep { billDetails, otpVerification, success }

/// Full-screen, Apple-style flow for paying a bill with SavEdge / Meal points.
///
/// Present it as a modal page:
/// ```dart
/// Navigator.of(context).push(MaterialPageRoute(
///   fullscreenDialog: true,
///   builder: (_) => PointsPaymentPage(vendor: vendor, availablePoints: pts),
/// ));
/// ```
class PointsPaymentPage extends StatefulWidget {
  const PointsPaymentPage({
    super.key,
    required this.vendor,
    required this.availablePoints,
  });

  final Vendor vendor;
  final int availablePoints;

  @override
  State<PointsPaymentPage> createState() => _PointsPaymentPageState();
}

class _PointsPaymentPageState extends State<PointsPaymentPage> {
  // Payment Step Management
  PaymentStep _currentStep = PaymentStep.billDetails;

  // Bill Details Step
  final TextEditingController _billAmountController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final FocusNode _billFocusNode = FocusNode();
  final FocusNode _pointsFocusNode = FocusNode();

  double _billAmount = 0.0;
  int _pointsToUse = 0;
  bool _isFullPayment = true;
  bool _isValidInput = false;

  // Point type: 0 = SavEdge, 1 = Meal. Balances are loaded per type.
  int _pointType = 0;
  int _savEdgeAvailable = 0;
  int _mealAvailable = 0;

  /// Available points for the currently selected point type.
  int get _availablePoints =>
      _pointType == 1 ? _mealAvailable : _savEdgeAvailable;

  /// Points that will actually be applied to the bill given the current mode.
  int get _effectivePointsUsed => _isFullPayment
      ? _billAmount.toInt().clamp(0, _availablePoints)
      : _pointsToUse.clamp(0, _availablePoints);

  // OTP Step
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  bool _isInitiating = false;
  bool _isVerifying = false;
  String? _paymentId;
  String? _transactionReference;
  String? _errorMessage;
  int _resendTimer = 30;
  Timer? _timer;

  // Success Step
  VerifyPointsPaymentOtpResponse? _paymentResponse;

  PointsPaymentService get _paymentService => GetIt.I<PointsPaymentService>();

  @override
  void initState() {
    super.initState();
    _billAmountController.addListener(_onBillAmountChanged);
    _pointsController.addListener(_onPointsChanged);
    _billFocusNode.addListener(() => setState(() {}));
    // Seed SavEdge balance from the caller; refine both buckets from the API.
    _savEdgeAvailable = widget.availablePoints;
    _pointsToUse = widget.availablePoints;
    _pointsController.text = _pointsToUse.toString();
    _loadBalances();
  }

  Future<void> _loadBalances() async {
    try {
      final balance = await _paymentService.getBalance();
      if (!mounted) return;
      setState(() {
        _savEdgeAvailable = balance.availablePoints;
        _mealAvailable = balance.mealAvailablePoints;
        if (_isFullPayment) {
          _pointsToUse = _billAmount.toInt().clamp(0, _availablePoints);
          _pointsController.text = _pointsToUse.toString();
        }
        _validateInput();
      });
    } catch (_) {
      // Keep the seeded SavEdge balance on failure.
    }
  }

  void _onPointTypeChanged(int type) {
    if (type == _pointType) return;
    HapticFeedback.selectionClick();
    setState(() {
      _pointType = type;
      // Re-clamp the points to the newly selected bucket.
      if (_isFullPayment) {
        _pointsToUse = _billAmount.toInt().clamp(0, _availablePoints);
      } else {
        _pointsToUse = _pointsToUse.clamp(0, _availablePoints);
      }
      _pointsController.text = _pointsToUse.toString();
      _validateInput();
    });
  }

  void _onBillAmountChanged() {
    final amount = double.tryParse(_billAmountController.text) ?? 0.0;
    setState(() {
      _billAmount = amount;
      if (_isFullPayment && amount > 0) {
        _pointsToUse = amount.toInt().clamp(0, _availablePoints);
        _pointsController.text = _pointsToUse.toString();
      }
      _validateInput();
    });
  }

  void _onPointsChanged() {
    if (!_isFullPayment) {
      final points = int.tryParse(_pointsController.text) ?? 0;
      setState(() {
        _pointsToUse = points;
        _validateInput();
      });
    }
  }

  void _validateInput() {
    final pointsToUse = _isFullPayment
        ? _billAmount.toInt().clamp(0, _availablePoints)
        : _pointsToUse;

    setState(() {
      _isValidInput =
          _billAmount > 0 &&
          pointsToUse > 0 &&
          pointsToUse <= _availablePoints;
    });
  }

  void _onModeChanged(bool isFull) {
    HapticFeedback.selectionClick();
    setState(() {
      _isFullPayment = isFull;
      if (_isFullPayment && _billAmount > 0) {
        _pointsToUse = _billAmount.toInt().clamp(0, _availablePoints);
        _pointsController.text = _pointsToUse.toString();
      } else if (!_isFullPayment) {
        _pointsToUse = 0;
        _pointsController.clear();
      }
      _validateInput();
    });
  }

  @override
  void dispose() {
    _billAmountController.dispose();
    _pointsController.dispose();
    _billFocusNode.dispose();
    _pointsFocusNode.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  // ── Scaffolding ───────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildNavBar(),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  final offset = Tween<Offset>(
                    begin: const Offset(0.06, 0),
                    end: Offset.zero,
                  ).animate(animation);
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(position: offset, child: child),
                  );
                },
                child: KeyedSubtree(
                  key: ValueKey(_currentStep),
                  child: _buildStepContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBar() {
    final showClose = _currentStep != PaymentStep.success;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                if (showClose)
                  _CircleIconButton(
                    icon: Icons.close_rounded,
                    onTap: () => Navigator.of(context).maybePop(),
                  )
                else
                  const SizedBox(width: 36),
                const Spacer(),
                if (_currentStep != PaymentStep.success)
                  _StepProgress(
                    activeIndex:
                        _currentStep == PaymentStep.billDetails ? 0 : 1,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            _stepTitle,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: _kLabel,
              letterSpacing: -0.6,
              height: 1.1,
            ),
          ),
          if (_currentStep != PaymentStep.success) ...[
            const SizedBox(height: 4),
            Text(
              _currentStep == PaymentStep.billDetails
                  ? 'at ${widget.vendor.businessName}'
                  : widget.vendor.businessName,
              style: const TextStyle(
                fontSize: 15,
                color: _kSecondary,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }

  String get _stepTitle {
    switch (_currentStep) {
      case PaymentStep.billDetails:
        return 'Pay with points';
      case PaymentStep.otpVerification:
        return 'Verify payment';
      case PaymentStep.success:
        return 'All done';
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case PaymentStep.billDetails:
        return _buildBillDetailsStep();
      case PaymentStep.otpVerification:
        return _buildOtpVerificationStep();
      case PaymentStep.success:
        return _buildSuccessStep();
    }
  }

  // ── Step 1 · Bill details ───────────────────────────────────────────────────

  Widget _buildBillDetailsStep() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAmountHero(),
                const SizedBox(height: 28),
                _sectionHeader('Pay using', 'Choose which points to redeem'),
                const SizedBox(height: 10),
                _buildPointTypeSelector(),
                if (_pointType == 1) ...[
                  const SizedBox(height: 10),
                  _buildMealNote(),
                ],
                const SizedBox(height: 14),
                _buildPricingNote(),
                const SizedBox(height: 28),
                _sectionHeader(
                  'Payment mode',
                  'Full uses points up to your bill. Partial lets you pick.',
                ),
                const SizedBox(height: 10),
                _buildPaymentModeSelector(),
                if (!_isFullPayment) ...[
                  const SizedBox(height: 12),
                  _buildPointsField(),
                ],
                AnimatedSize(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOut,
                  alignment: Alignment.topCenter,
                  child: _isValidInput
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 28),
                            _sectionHeader(
                              'Summary',
                              'Review before you continue',
                            ),
                            const SizedBox(height: 10),
                            _buildPaymentSummary(),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
        _buildBottomBar(
          recap: _isValidInput
              ? _RecapLine(
                  label: "You'll use",
                  value: '$_effectivePointsUsed pts',
                )
              : const _RecapLine(
                  label: 'Available',
                  value: null,
                  placeholder: 'Enter a bill amount',
                ),
          button: _PrimaryButton(
            label: 'Continue',
            enabled: _isValidInput,
            gradient: _kAccentGradient,
            onTap: _proceedToOtp,
          ),
          note: 'Secured with a one-time code at checkout',
        ),
      ],
    );
  }

  Widget _buildAmountHero() {
    final hasFocus = _billFocusNode.hasFocus;
    final hasText = _billAmountController.text.isNotEmpty;
    final active = hasFocus || hasText;
    return GestureDetector(
      onTap: () => _billFocusNode.requestFocus(),
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TOTAL BILL AMOUNT',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _kSecondary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '₹',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: active ? _kAccent : _kSecondary,
                ),
              ),
              const SizedBox(width: 4),
              IntrinsicWidth(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 44),
                  child: TextField(
                    controller: _billAmountController,
                    focusNode: _billFocusNode,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textAlign: TextAlign.left,
                    cursorColor: _kAccent,
                    cursorWidth: 2.5,
                    style: const TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w800,
                      color: _kLabel,
                      letterSpacing: -1.5,
                      height: 1.0,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: false,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      hintText: '0',
                      hintStyle: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w800,
                        color: _kSecondary.withValues(alpha: 0.35),
                        letterSpacing: -1.5,
                        height: 1.0,
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _kGreenSoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '1 point = ₹1',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: _kGreenDeep,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Enter the total shown on your bill',
            style: TextStyle(fontSize: 12.5, color: _kSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildPointTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildPointTypeCard(
            label: 'SavEdge',
            subtitle: 'Reward points',
            available: _savEdgeAvailable,
            type: 0,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildPointTypeCard(
            label: 'Meal',
            subtitle: 'Meal points',
            available: _mealAvailable,
            type: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildPointTypeCard({
    required String label,
    required String subtitle,
    required int available,
    required int type,
  }) {
    final selected = _pointType == type;
    return GestureDetector(
      onTap: () => _onPointTypeChanged(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? _kAccentSoft : _kCard,
          borderRadius: BorderRadius.circular(20),
          border: selected
              ? Border.all(color: _kAccent, width: 1.6)
              : null,
          boxShadow: selected
              ? null
              : [
                  BoxShadow(
                    color: _kAccent.withValues(alpha: 0.05),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: selected ? _kAccent : _kLabel,
                    letterSpacing: -0.2,
                  ),
                ),
                _RadioDot(selected: selected),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12.5, color: _kSecondary),
            ),
            const SizedBox(height: 14),
            Text(
              _formatPts(available),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: selected ? _kAccent : _kLabel,
                letterSpacing: -0.5,
              ),
            ),
            const Text(
              'points available',
              style: TextStyle(fontSize: 11.5, color: _kSecondary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealNote() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4E5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.info_rounded, size: 16, color: Color(0xFFEA580C)),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Meal points are only accepted at participating vendors.',
              style: TextStyle(
                fontSize: 12.5,
                color: Color(0xFF9A4A12),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Fine-print disclaimer about how points payments are priced.
  Widget _buildPricingNote() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kField,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.info_outline_rounded, size: 16, color: _kSecondary),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Meal Points and Gift Points payments are charged at the '
              "vendor's regular menu price (MRP). No SavEdge offers or "
              'discounts apply.',
              style: TextStyle(
                fontSize: 12,
                color: _kSecondary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentModeSelector() {
    return _Segmented(
      labels: const ['Full payment', 'Partial payment'],
      index: _isFullPayment ? 0 : 1,
      onChanged: (i) => _onModeChanged(i == 0),
    );
  }

  Widget _buildPointsField() {
    final maxPoints = _billAmount > 0
        ? _billAmount.toInt().clamp(0, _availablePoints)
        : _availablePoints;
    final active = _pointsFocusNode.hasFocus || _pointsController.text.isNotEmpty;

    return _Card(
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Points to use',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _kLabel,
                ),
              ),
              Text(
                'Max $maxPoints',
                style: const TextStyle(fontSize: 12.5, color: _kSecondary),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.stars_rounded, size: 22, color: _kAccent),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _pointsController,
                  focusNode: _pointsFocusNode,
                  keyboardType: TextInputType.number,
                  cursorColor: _kAccent,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: _kLabel,
                    letterSpacing: -0.5,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    filled: false,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    hintText: '0',
                    hintStyle: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: _kSecondary.withValues(alpha: 0.35),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _MaxValueFormatter(maxPoints),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  _pointsController.text = maxPoints.toString();
                  _pointsController.selection = TextSelection.collapsed(
                    offset: _pointsController.text.length,
                  );
                  setState(() {
                    _pointsToUse = maxPoints;
                    _validateInput();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: active ? _kAccent : _kAccentSoft,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Max',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: active ? Colors.white : _kAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary() {
    final pointsUsed = _effectivePointsUsed;
    final remaining = (_billAmount - pointsUsed).clamp(0, double.infinity);

    return _Card(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          _summaryRow('Bill amount', '₹${_billAmount.toStringAsFixed(2)}'),
          const SizedBox(height: 12),
          _summaryRow(
            'Points applied',
            '– ₹${pointsUsed.toString()}',
            valueColor: _kGreen,
          ),
          const SizedBox(height: 14),
          if (remaining > 0) ...[
            const _DashedDivider(),
            const SizedBox(height: 14),
            _summaryRow(
              'Pay at store',
              '₹${remaining.toStringAsFixed(2)}',
              emphasize: true,
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _kGreenSoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.check_circle_rounded, color: _kGreen, size: 19),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Your bill is fully covered with points.',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: _kGreenDeep,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _proceedToOtp() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _currentStep = PaymentStep.otpVerification;
      _isInitiating = true;
      _errorMessage = null;
    });

    HapticFeedback.lightImpact();

    try {
      final pointsUsed = _effectivePointsUsed;

      final response = await _paymentService.initiatePayment(
        InitiatePointsPaymentRequest(
          vendorProfileId: widget.vendor.id,
          amount: _billAmount,
          pointsToUse: pointsUsed,
          pointType: _pointType,
        ),
      );

      if (!mounted) return;
      setState(() {
        _paymentId = response.paymentId;
        _transactionReference = response.transactionReference;
        _isInitiating = false;
      });

      _startResendTimer();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Failed to initiate payment';
        _isInitiating = false;
      });
    }
  }

  // ── Step 2 · OTP verification ───────────────────────────────────────────────

  Widget _buildOtpVerificationStep() {
    if (_isInitiating) return _buildInitiatingView();
    if (_errorMessage != null) return _buildErrorView();

    final otp = _otpControllers.map((c) => c.text).join();
    final isComplete = otp.length == 6;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: _kAccentSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_rounded,
                    color: _kAccent,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter verification code',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: _kLabel,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'We sent a 6-digit code to your registered mobile number.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.5,
                    color: _kSecondary,
                    height: 1.4,
                  ),
                ),
                if (_transactionReference != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _kAccentSoft,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.receipt_long_rounded,
                          size: 15,
                          color: _kAccent,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          'Ref $_transactionReference',
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: _kAccent,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 28),
                _buildOtpFields(),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.verified_user_rounded,
                      size: 14,
                      color: _kGreen,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Bank-grade verification keeps your points safe',
                      style: TextStyle(fontSize: 12.5, color: _kSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                _buildResendSection(),
              ],
            ),
          ),
        ),
        _buildBottomBar(
          button: _PrimaryButton(
            label: 'Verify & pay',
            enabled: isComplete && !_isVerifying,
            loading: _isVerifying,
            gradient: _kAccentGradient,
            onTap: _verifyOtp,
          ),
          note: 'Points are deducted only after verification',
        ),
      ],
    );
  }

  Widget _buildInitiatingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CupertinoActivityIndicator(radius: 16, color: _kAccent),
        SizedBox(height: 18),
        Text(
          'Sending verification code…',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _kSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: _kRed.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline_rounded,
                    color: _kRed,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Payment couldn’t start',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: _kLabel,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _errorMessage ?? 'Something went wrong. Please try again.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.5,
                    color: _kSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
        _buildBottomBar(
          button: _PrimaryButton(
            label: 'Try again',
            enabled: true,
            gradient: _kAccentGradient,
            onTap: () {
              setState(() {
                _currentStep = PaymentStep.billDetails;
                _errorMessage = null;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) {
        final hasValue = _otpControllers[index].text.isNotEmpty;
        final hasFocus = _otpFocusNodes[index].hasFocus;

        return Padding(
          padding: EdgeInsets.only(right: index == 5 ? 0 : 8),
          child: SizedBox(
            width: 48,
            height: 58,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: hasFocus
                    ? _kCard
                    : hasValue
                        ? _kAccentSoft
                        : _kField,
                borderRadius: BorderRadius.circular(16),
                boxShadow: hasFocus
                    ? [
                        BoxShadow(
                          color: _kAccent.withValues(alpha: 0.28),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: TextField(
                  controller: _otpControllers[index],
                  focusNode: _otpFocusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  cursorColor: _kAccent,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: _kLabel,
                  ),
                  decoration: const InputDecoration(
                    counterText: '',
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  onChanged: (value) {
                    if (value.isNotEmpty && index < 5) {
                      _otpFocusNodes[index + 1].requestFocus();
                    }
                    if (value.isEmpty && index > 0) {
                      _otpFocusNodes[index - 1].requestFocus();
                    }
                    if (index == 5 && value.isNotEmpty) {
                      _verifyOtp();
                    }
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildResendSection() {
    final canResend = _resendTimer == 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Didn't get the code? ",
          style: TextStyle(fontSize: 13.5, color: _kSecondary),
        ),
        GestureDetector(
          onTap: canResend ? _resendOtp : null,
          child: Text(
            canResend ? 'Resend' : 'Resend in ${_resendTimer}s',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: canResend ? _kAccent : _kSecondary.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }

  void _startResendTimer() {
    _timer?.cancel();
    setState(() => _resendTimer = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() => _resendTimer--);
      } else {
        timer.cancel();
      }
    });
  }

  void _resendOtp() {
    _proceedToOtp();
    for (var controller in _otpControllers) {
      controller.clear();
    }
    _otpFocusNodes[0].requestFocus();
  }

  Future<void> _verifyOtp() async {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length != 6) return;

    FocusScope.of(context).unfocus();
    setState(() => _isVerifying = true);

    try {
      final response = await _paymentService.verifyOtp(
        VerifyPointsPaymentOtpRequest(paymentId: _paymentId!, otpCode: otp),
      );

      HapticFeedback.heavyImpact();

      if (!mounted) return;
      setState(() {
        _paymentResponse = response;
        _currentStep = PaymentStep.success;
        _isVerifying = false;
      });
    } catch (e) {
      // The verify call can fail at the client (e.g. a connection timeout) even though
      // the server already completed the payment and deducted points. Reporting a plain
      // failure here would tempt the user to retry — which initiates a fresh payment and
      // double-charges. Reconcile the authoritative status with the server first.
      final reconciled = await _reconcilePaymentStatus();
      if (!mounted) return;
      if (reconciled != null) {
        HapticFeedback.heavyImpact();
        setState(() {
          _paymentResponse = reconciled;
          _currentStep = PaymentStep.success;
          _isVerifying = false;
        });
        return;
      }
      setState(() => _isVerifying = false);
      _showErrorSnackbar(ErrorMessageMapper.map(e));
    }
  }

  /// After a failed/timed-out verify call, ask the server for the authoritative payment
  /// status. Returns a success response to display if the payment actually completed, or
  /// null if it did not (or the status could not be determined).
  Future<VerifyPointsPaymentOtpResponse?> _reconcilePaymentStatus() async {
    final paymentId = _paymentId;
    if (paymentId == null) return null;
    try {
      final details = await _paymentService.getPaymentDetails(paymentId);
      if (details.status.toLowerCase() != 'completed') return null;
      return VerifyPointsPaymentOtpResponse(
        paymentId: details.paymentId,
        transactionReference: details.transactionReference,
        pointsUsed: details.pointsUsed,
        pointsValue: details.pointsValue,
        billAmount: details.billAmount,
        paidAmount: details.pointsValue,
        remainingAmount: details.remainingAmount,
        vendorName: details.vendorName,
        completedAt: details.completedAt ?? DateTime.now(),
      );
    } catch (_) {
      // Couldn't confirm — fall back to surfacing the original error.
      return null;
    }
  }

  // ── Step 3 · Success ────────────────────────────────────────────────────────

  Widget _buildSuccessStep() {
    final res = _paymentResponse;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              children: [
                const SizedBox(height: 16),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 650),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: _kGreen,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: _kGreen.withValues(alpha: 0.35),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Payment successful',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: _kLabel,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  res != null
                      ? 'Paid to ${res.vendorName}'
                      : 'Your points payment was processed.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.5,
                    color: _kSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _kGreenSoft,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Receipt saved to your account',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: _kGreenDeep,
                    ),
                  ),
                ),
                if (res != null) ...[
                  const SizedBox(height: 28),
                  _Card(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        _summaryRow(
                          'Amount paid',
                          '₹${res.paidAmount.toStringAsFixed(2)}',
                          emphasize: true,
                        ),
                        const SizedBox(height: 14),
                        const _DashedDivider(),
                        const SizedBox(height: 14),
                        _summaryRow('Bill amount',
                            '₹${res.billAmount.toStringAsFixed(2)}'),
                        const SizedBox(height: 12),
                        _summaryRow(
                          'Points used',
                          '${res.pointsUsed} pts',
                          valueColor: _kAccent,
                        ),
                        if (res.remainingAmount > 0) ...[
                          const SizedBox(height: 12),
                          _summaryRow(
                            'Paid at store',
                            '₹${res.remainingAmount.toStringAsFixed(2)}',
                          ),
                        ],
                        const SizedBox(height: 12),
                        _summaryRow(
                          'Date',
                          DateFormat('d MMM yyyy • h:mm a')
                              .format(res.completedAt.toLocal()),
                        ),
                        const SizedBox(height: 12),
                        _summaryRow(
                          'Reference',
                          res.transactionReference,
                          mono: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        _buildBottomBar(
          button: _PrimaryButton(
            label: 'Done',
            enabled: true,
            color: _kGreen,
            gradient: _kGreenGradient,
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.of(context).pop(true);
            },
          ),
        ),
      ],
    );
  }

  // ── Shared building blocks ──────────────────────────────────────────────────

  Widget _buildBottomBar({
    required Widget button,
    _RecapLine? recap,
    String? note,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _kBg,
        boxShadow: [
          BoxShadow(
            color: _kAccent.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (recap != null) ...[
                recap,
                const SizedBox(height: 12),
              ],
              button,
              if (note != null) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock_rounded,
                      size: 13,
                      color: _kSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      note,
                      style: const TextStyle(
                        fontSize: 12,
                        color: _kSecondary,
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

  Widget _sectionHeader(String text, [String? subtitle]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w700,
            color: _kLabel,
            letterSpacing: -0.2,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12.5,
              color: _kSecondary,
              height: 1.3,
            ),
          ),
        ],
      ],
    );
  }

  Widget _summaryRow(
    String label,
    String value, {
    Color? valueColor,
    bool emphasize = false,
    bool mono = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: emphasize ? 15 : 14,
            fontWeight: emphasize ? FontWeight.w600 : FontWeight.w500,
            color: _kSecondary,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            maxLines: mono ? 2 : 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: mono ? 12.5 : (emphasize ? 18 : 14.5),
              fontWeight: emphasize ? FontWeight.w800 : FontWeight.w700,
              color: valueColor ?? _kLabel,
              fontFamily: mono ? 'monospace' : null,
              letterSpacing: emphasize ? -0.3 : 0,
            ),
          ),
        ),
      ],
    );
  }

  String _formatPts(int v) {
    final s = v.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return buf.toString();
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: _kRed,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

// ── Reusable presentational widgets ───────────────────────────────────────────

/// White rounded card with a hairline border and a whisper of elevation.
class _Card extends StatelessWidget {
  const _Card({required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _kAccent.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: _kAccentSoft,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 19, color: _kAccent),
      ),
    );
  }
}

/// Three-segment progress indicator shown in the nav bar.
class _StepProgress extends StatelessWidget {
  const _StepProgress({required this.activeIndex});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(2, (i) {
        final active = i == activeIndex;
        final done = i < activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(left: 6),
          width: active ? 26 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: (active || done) ? _kAccent : _kHairline,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: selected ? _kAccent : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? _kAccent : _kHairline,
          width: 1.6,
        ),
      ),
      child: selected
          ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
          : null,
    );
  }
}

/// iOS-style sliding segmented control.
class _Segmented extends StatelessWidget {
  const _Segmented({
    required this.labels,
    required this.index,
    required this.onChanged,
  });

  final List<String> labels;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final n = labels.length;
        const pad = 3.0;
        final thumbW = (constraints.maxWidth - pad * 2) / n;
        return Container(
          height: 44,
          padding: const EdgeInsets.all(pad),
          decoration: BoxDecoration(
            color: _kTrack,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
                left: index * thumbW,
                top: 0,
                bottom: 0,
                width: thumbW,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: List.generate(n, (i) {
                  final selected = i == index;
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onChanged(i),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight:
                                selected ? FontWeight.w700 : FontWeight.w500,
                            color: selected ? _kLabel : _kSecondary,
                          ),
                          child: Text(labels[i]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Full-width pill CTA with pressed-scale feedback and a loading state.
class _PrimaryButton extends StatefulWidget {
  const _PrimaryButton({
    required this.label,
    required this.enabled,
    required this.onTap,
    this.loading = false,
    this.color = _kAccent,
    this.gradient,
  });

  final String label;
  final bool enabled;
  final bool loading;
  final Color color;
  final Gradient? gradient;
  final VoidCallback onTap;

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.enabled && !widget.loading;
    return GestureDetector(
      onTapDown: active ? (_) => setState(() => _pressed = true) : null,
      onTapUp: active ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: active ? () => setState(() => _pressed = false) : null,
      onTap: active
          ? () {
              HapticFeedback.lightImpact();
              widget.onTap();
            }
          : null,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 54,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: active ? widget.gradient : null,
            color: active
                ? (widget.gradient == null ? widget.color : null)
                : const Color(0xFFE4E0EC),
            borderRadius: BorderRadius.circular(16),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: 0.34),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: widget.loading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                    color: active ? Colors.white : _kSecondary,
                    letterSpacing: -0.2,
                  ),
                ),
        ),
      ),
    );
  }
}

/// Small "label · value" recap shown above the CTA.
class _RecapLine extends StatelessWidget {
  const _RecapLine({required this.label, this.value, this.placeholder});

  final String label;
  final String? value;
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: _kSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value ?? placeholder ?? '',
          style: TextStyle(
            fontSize: 15,
            fontWeight: value != null ? FontWeight.w800 : FontWeight.w500,
            color: value != null ? _kLabel : _kSecondary,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}

/// Thin dashed separator used inside summary cards.
class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const dashW = 5.0;
          const gapW = 4.0;
          final count = (constraints.maxWidth / (dashW + gapW)).floor();
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              count,
              (_) => Container(width: dashW, height: 1, color: _kHairline),
            ),
          );
        },
      ),
    );
  }
}

/// Clamps numeric input to [maxValue]; mirrors the old inline formatter.
class _MaxValueFormatter extends TextInputFormatter {
  _MaxValueFormatter(this.maxValue);

  final int maxValue;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    final value = int.tryParse(newValue.text);
    if (value == null) return oldValue;
    if (value > maxValue) {
      return TextEditingValue(
        text: maxValue.toString(),
        selection: TextSelection.collapsed(offset: maxValue.toString().length),
      );
    }
    return newValue;
  }
}
