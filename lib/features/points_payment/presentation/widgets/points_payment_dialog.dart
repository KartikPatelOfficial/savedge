import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:savedge/features/points_payment/data/models/points_payment_models.dart';
import 'package:savedge/features/points_payment/data/services/points_payment_service.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';

enum PaymentStep { billDetails, otpVerification, success }

class PointsPaymentDialog extends StatefulWidget {
  const PointsPaymentDialog({
    super.key,
    required this.vendor,
    required this.availablePoints,
  });

  final Vendor vendor;
  final int availablePoints;

  @override
  State<PointsPaymentDialog> createState() => _PointsPaymentDialogState();
}

class _PointsPaymentDialogState extends State<PointsPaymentDialog> {
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
    _pointsToUse = widget.availablePoints;
    _pointsController.text = _pointsToUse.toString();
  }

  void _onBillAmountChanged() {
    final amount = double.tryParse(_billAmountController.text) ?? 0.0;
    setState(() {
      _billAmount = amount;
      if (_isFullPayment && amount > 0) {
        _pointsToUse = amount.toInt().clamp(0, widget.availablePoints);
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
        ? _billAmount.toInt().clamp(0, widget.availablePoints)
        : _pointsToUse;

    setState(() {
      _isValidInput =
          _billAmount > 0 &&
          pointsToUse > 0 &&
          pointsToUse <= widget.availablePoints;
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: _buildDialogContent(),
    );
  }

  Widget _buildDialogContent() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          Flexible(child: _buildStepContent()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary.withOpacity(0.1), cs.primary.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getStepColor(),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: _getStepColor().withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(_getStepIcon(), color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getStepTitle(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                    letterSpacing: -0.3,
                  ),
                ),
                if (_currentStep == PaymentStep.billDetails) ...[
                  const SizedBox(height: 4),
                  Text(
                    'at ${widget.vendor.businessName}',
                    style: TextStyle(
                      fontSize: 14,
                      color: cs.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          if (_currentStep != PaymentStep.success)
            Container(
              decoration: BoxDecoration(
                color: cs.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.close, color: cs.onSurfaceVariant, size: 20),
              ),
            ),
        ],
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case PaymentStep.billDetails:
        return 'Enter Bill Details';
      case PaymentStep.otpVerification:
        return 'Verify Payment';
      case PaymentStep.success:
        return 'Payment Successful!';
    }
  }

  IconData _getStepIcon() {
    switch (_currentStep) {
      case PaymentStep.billDetails:
        return Icons.receipt_long;
      case PaymentStep.otpVerification:
        return Icons.lock_outline;
      case PaymentStep.success:
        return Icons.check_circle;
    }
  }

  Color _getStepColor() {
    switch (_currentStep) {
      case PaymentStep.billDetails:
        return const Color(0xFF6366F1);
      case PaymentStep.otpVerification:
        return const Color(0xFF8B5CF6);
      case PaymentStep.success:
        return const Color(0xFF10B981);
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

  Widget _buildBillDetailsStep() {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPointsBalance(cs),
          const SizedBox(height: 20),
          _buildBillAmountField(cs),
          const SizedBox(height: 16),
          _buildPaymentModeSelector(cs),
          if (!_isFullPayment) ...[
            const SizedBox(height: 16),
            _buildPointsField(cs),
          ],
          if (_isValidInput) ...[
            const SizedBox(height: 20),
            _buildPaymentSummary(cs),
          ],
          const SizedBox(height: 20),
          _buildContinueButton(cs),
        ],
      ),
    );
  }

  Widget _buildPointsBalance(ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6366F1).withOpacity(0.1),
            const Color(0xFF8B5CF6).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF6366F1).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.stars_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Available Points',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${widget.availablePoints} points',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF6366F1),
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF10B981).withOpacity(0.3),
              ),
            ),
            child: const Text(
              '1 Point = ₹1',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF10B981),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillAmountField(ColorScheme cs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Bill Amount',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  _billFocusNode.hasFocus ||
                      _billAmountController.text.isNotEmpty
                  ? const Color(0xFF6366F1)
                  : cs.outline.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: TextField(
            controller: _billAmountController,
            focusNode: _billFocusNode,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
              letterSpacing: -0.3,
            ),
            decoration: InputDecoration(
              hintText: '0.00',
              hintStyle: TextStyle(
                color: cs.onSurfaceVariant.withOpacity(0.5),
                fontWeight: FontWeight.w600,
              ),
              prefixIcon: Container(
                width: 50,
                alignment: Alignment.center,
                child: Text(
                  '₹',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF6366F1),
                  ),
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentModeSelector(ColorScheme cs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Mode',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: cs.outline.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Expanded(child: _buildModeOption('Full Payment', true, cs)),
              Expanded(child: _buildModeOption('Partial Payment', false, cs)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModeOption(String label, bool isFullMode, ColorScheme cs) {
    final isSelected = _isFullPayment == isFullMode;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFullPayment = isFullMode;
          if (_isFullPayment && _billAmount > 0) {
            _pointsToUse = _billAmount.toInt().clamp(0, widget.availablePoints);
            _pointsController.text = _pointsToUse.toString();
          } else if (!_isFullPayment) {
            _pointsToUse = 0;
            _pointsController.clear();
          }
          _validateInput();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF6366F1).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildPointsField(ColorScheme cs) {
    final maxPoints = _billAmount > 0
        ? _billAmount.toInt().clamp(0, widget.availablePoints)
        : widget.availablePoints;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Points to Use',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              'Max: $maxPoints',
              style: TextStyle(color: cs.primary, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _pointsController,
                focusNode: _pointsFocusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter points',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                _pointsController.text = maxPoints.toString();
                setState(() {
                  _pointsToUse = maxPoints;
                  _validateInput();
                });
              },
              child: Text('Max'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentSummary(ColorScheme cs) {
    final pointsUsed = _isFullPayment
        ? _billAmount.toInt().clamp(0, widget.availablePoints)
        : _pointsToUse;
    final remaining = (_billAmount - pointsUsed).clamp(0, double.infinity);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cs.surfaceContainerLow,
            cs.surfaceContainer.withOpacity(0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outline.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long_rounded,
                color: const Color(0xFF6366F1),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Payment Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Bill Amount',
            '₹${_billAmount.toStringAsFixed(2)}',
            cs,
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Points Used',
            '$pointsUsed points',
            cs,
            valueColor: const Color(0xFF6366F1),
          ),
          if (remaining > 0) ...[
            const SizedBox(height: 8),
            Divider(color: cs.outline.withOpacity(0.3)),
            const SizedBox(height: 8),
            _buildSummaryRow(
              'Pay at Store',
              '₹${remaining.toStringAsFixed(2)}',
              cs,
              emphasize: true,
            ),
          ] else ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF10B981).withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    color: const Color(0xFF10B981),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Bill fully covered with points!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF10B981),
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

  Widget _buildSummaryRow(
    String label,
    String value,
    ColorScheme cs, {
    Color? valueColor,
    bool emphasize = false,
  }) {
    // Check if this is a transaction reference (long text that needs special handling)
    final isTransactionRef =
        label.toLowerCase().contains('transaction') &&
        label.toLowerCase().contains('ref');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: emphasize ? FontWeight.w600 : FontWeight.w500,
            color: cs.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: isTransactionRef ? 12 : (emphasize ? 16 : 14),
              fontWeight: emphasize ? FontWeight.w800 : FontWeight.w700,
              color: valueColor ?? cs.onSurface,
              fontFamily: isTransactionRef ? 'monospace' : null,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            maxLines: isTransactionRef ? 2 : 1,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(ColorScheme cs) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: _isValidInput
            ? const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: _isValidInput ? null : cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        boxShadow: _isValidInput
            ? [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isValidInput ? _proceedToOtp : null,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Continue to Payment',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _isValidInput ? Colors.white : cs.onSurfaceVariant,
                letterSpacing: -0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _proceedToOtp() async {
    setState(() {
      _currentStep = PaymentStep.otpVerification;
      _isInitiating = true;
      _errorMessage = null;
    });

    HapticFeedback.lightImpact();

    try {
      final pointsUsed = _isFullPayment
          ? _billAmount.toInt().clamp(0, widget.availablePoints)
          : _pointsToUse;

      final response = await _paymentService.initiatePayment(
        InitiatePointsPaymentRequest(
          vendorProfileId: widget.vendor.id,
          amount: _billAmount,
          pointsToUse: pointsUsed,
        ),
      );

      setState(() {
        _paymentId = response.paymentId;
        _transactionReference = response.transactionReference;
        _isInitiating = false;
      });

      _startResendTimer();
    } catch (e) {
      String errorMessage = 'Failed to initiate payment';
      setState(() {
        _errorMessage = errorMessage;
        _isInitiating = false;
      });
    }
  }

  Widget _buildOtpVerificationStep() {
    final cs = Theme.of(context).colorScheme;

    if (_isInitiating) {
      return _buildInitiatingView(cs);
    }

    if (_errorMessage != null) {
      return _buildErrorView(cs);
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Text(
            'Enter the 6-digit verification code',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "We've sent a secure code to your registered mobile number",
            style: TextStyle(
              fontSize: 14,
              color: cs.onSurfaceVariant,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          if (_transactionReference != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF8B5CF6).withOpacity(0.1),
                    const Color(0xFF8B5CF6).withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF8B5CF6).withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_rounded,
                    color: const Color(0xFF8B5CF6),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$_transactionReference',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF8B5CF6),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
          _buildOtpFields(cs),
          const SizedBox(height: 20),
          _buildResendSection(cs),
          const SizedBox(height: 24),
          _buildVerifyButton(cs),
        ],
      ),
    );
  }

  Widget _buildInitiatingView(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text('Sending OTP...', style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildErrorView(ColorScheme cs) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text(
            'Payment Failed',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage!,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentStep = PaymentStep.billDetails;
                  _errorMessage = null;
                });
              },
              child: Text('Try Again'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpFields(ColorScheme cs) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        final hasValue = _otpControllers[index].text.isNotEmpty;
        final hasFocus = _otpFocusNodes[index].hasFocus;

        return Container(
          width: 48,
          height: 60,
          child: TextField(
            controller: _otpControllers[index],
            focusNode: _otpFocusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              letterSpacing: -0.5,
            ),
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
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
              if (index == 5 && value.isNotEmpty) {
                _verifyOtp();
              }
              setState(() {});
            },
          ),
        );
      }),
    );
  }

  Widget _buildResendSection(ColorScheme cs) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Didn't receive code? ", style: TextStyle(fontSize: 12)),
        TextButton(
          onPressed: _resendTimer == 0 ? _resendOtp : null,
          child: Text(
            _resendTimer > 0 ? 'Resend in ${_resendTimer}s' : 'Resend',
          ),
        ),
      ],
    );
  }

  Widget _buildVerifyButton(ColorScheme cs) {
    final otp = _otpControllers.map((c) => c.text).join();
    final isComplete = otp.length == 6;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (_isVerifying || !isComplete) ? null : _verifyOtp,
        child: _isVerifying
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text('Verify & Pay'),
      ),
    );
  }

  void _startResendTimer() {
    _timer?.cancel();
    setState(() {
      _resendTimer = 30;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
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

    setState(() {
      _isVerifying = true;
    });

    try {
      final response = await _paymentService.verifyOtp(
        VerifyPointsPaymentOtpRequest(paymentId: _paymentId!, otpCode: otp),
      );

      HapticFeedback.heavyImpact();

      setState(() {
        _paymentResponse = response;
        _currentStep = PaymentStep.success;
        _isVerifying = false;
      });
    } catch (e) {
      setState(() {
        _isVerifying = false;
      });
      _showErrorSnackbar(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Widget _buildSuccessStep() {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF10B981), Color(0xFF059669)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF10B981).withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 44,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Payment Successful!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Your points payment has been processed successfully',
            style: TextStyle(
              fontSize: 14,
              color: cs.onSurfaceVariant,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          if (_paymentResponse != null) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF10B981).withOpacity(0.1),
                    const Color(0xFF10B981).withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF10B981).withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.receipt_long_rounded,
                        color: const Color(0xFF10B981),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Transaction Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildSummaryRow(
                    'Transaction Ref',
                    _paymentResponse!.transactionReference,
                    cs,
                    valueColor: const Color(0xFF10B981),
                  ),
                  const SizedBox(height: 6),
                  _buildSummaryRow(
                    'Points Used',
                    '${_paymentResponse!.pointsUsed} points',
                    cs,
                  ),
                  const SizedBox(height: 6),
                  _buildSummaryRow(
                    'Amount Paid',
                    '₹${_paymentResponse!.paidAmount.toStringAsFixed(2)}',
                    cs,
                    emphasize: true,
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF059669)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF10B981).withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  Navigator.of(context).pop();
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.onError,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
