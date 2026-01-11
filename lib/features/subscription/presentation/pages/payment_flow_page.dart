import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/injection/injection.dart';
import '../../../../shared/widgets/common_widgets.dart';
import '../../../../shared/domain/entities/subscription.dart';
import '../bloc/subscription_bloc.dart';
import '../widgets/payment_summary_card.dart';
import '../../data/services/pinelabs_payment_service.dart';

/// Page for handling the complete payment flow for subscriptions
class PaymentFlowPage extends StatelessWidget {
  static const String routeName = '/payment-flow';

  final SubscriptionPlan plan;
  final bool autoRenew;

  const PaymentFlowPage({
    super.key,
    required this.plan,
    this.autoRenew = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SubscriptionBloc>(),
      child: _PaymentFlowView(plan: plan, autoRenew: autoRenew),
    );
  }
}

class _PaymentFlowView extends StatefulWidget {
  final SubscriptionPlan plan;
  final bool autoRenew;

  const _PaymentFlowView({required this.plan, required this.autoRenew});

  @override
  State<_PaymentFlowView> createState() => _PaymentFlowViewState();
}

class _PaymentFlowViewState extends State<_PaymentFlowView> {
  bool _isProcessingPayment = false;
  bool _isPollingStatus = false;
  int? _currentTransactionId;

  PineLabsPaymentService get _paymentService =>
      GetIt.I<PineLabsPaymentService>();

  @override
  void initState() {
    super.initState();

    // Create payment order when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initiatePayment();
    });
  }

  @override
  void dispose() {
    _paymentService.dispose();
    super.dispose();
  }

  Future<void> _initiatePayment() async {
    if (_isProcessingPayment) return;

    setState(() {
      _isProcessingPayment = true;
    });

    try {
      // Create payment order and get redirect URL
      final result = await _paymentService.processSubscriptionPayment(
        planId: widget.plan.id,
        autoRenew: widget.autoRenew,
      );

      if (!mounted) return;

      if (result.success && result.transactionId != null) {
        _currentTransactionId = result.transactionId;
        setState(() {
          _isPollingStatus = true;
        });
        _pollPaymentStatus(result.transactionId!);
      } else {
        setState(() {
          _isProcessingPayment = false;
        });
        _showErrorDialog('Payment Setup Failed', result.message);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });
        _showErrorDialog('Payment Error', e.toString());
      }
    }
  }

  void _pollPaymentStatus(int transactionId) async {
    await for (final status in _paymentService.pollPaymentStatus(
      transactionId: transactionId,
      interval: const Duration(seconds: 3),
      timeout: const Duration(minutes: 5),
    )) {
      if (!mounted) return;

      if (status.status == 'Success') {
        setState(() {
          _isProcessingPayment = false;
          _isPollingStatus = false;
        });
        _showPaymentSuccessDialog();
        return;
      } else if (status.status == 'Failed') {
        setState(() {
          _isProcessingPayment = false;
          _isPollingStatus = false;
        });
        _showErrorDialog(
          'Payment Failed',
          status.failureReason ?? 'Payment was cancelled or failed',
        );
        return;
      }
    }

    // Timeout reached
    if (mounted) {
      setState(() {
        _isProcessingPayment = false;
        _isPollingStatus = false;
      });
    }
  }

  Future<void> _checkPaymentStatus() async {
    if (_currentTransactionId == null) return;

    setState(() {
      _isProcessingPayment = true;
    });

    try {
      final status =
          await _paymentService.checkPaymentStatus(_currentTransactionId!);

      if (!mounted) return;

      setState(() {
        _isProcessingPayment = false;
      });

      if (status.status == 'Success') {
        _showPaymentSuccessDialog();
      } else if (status.status == 'Failed') {
        _showErrorDialog(
          'Payment Failed',
          status.failureReason ?? 'Payment was cancelled or failed',
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment is still pending. Please complete the payment in your browser.'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessingPayment = false;
        });
        _showErrorDialog('Error', e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Payment'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Summary
            PaymentSummaryCard(
              plan: widget.plan,
              autoRenew: widget.autoRenew,
            ),

            const SizedBox(height: 24),

            // Payment Status
            if (_isProcessingPayment || _isPollingStatus) ...[
              _buildPollingCard(),
            ] else if (_currentTransactionId != null) ...[
              _buildPaymentPendingCard(),
            ] else ...[
              _buildInitiatingCard(),
            ],

            const SizedBox(height: 24),

            // Payment Information
            _buildPaymentInfoCard(),

            const SizedBox(height: 24),

            // Security Information
            _buildSecurityInfoCard(),

            const SizedBox(height: 24),

            // Action Buttons
            if (!_isProcessingPayment && _currentTransactionId != null) ...[
              _buildActionButtons(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPollingCard() {
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Waiting for Payment',
              style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete the payment in your browser.\nThis page will update automatically.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue[800]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentPendingCard() {
    return Card(
      color: Colors.orange[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.pending, color: Colors.orange[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Pending',
                    style: TextStyle(
                      color: Colors.orange[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Complete the payment in your browser or check status',
                    style: TextStyle(color: Colors.orange[800]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitiatingCard() {
    return Card(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Setting Up Payment',
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Please wait while we prepare your payment...',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              Icons.payment,
              'Secure Payment',
              'Secure online payment processing',
            ),
            _buildInfoRow(
              Icons.credit_card,
              'Multiple Options',
              'Pay via Credit Card, Debit Card, UPI, Net Banking, or Wallets',
            ),
            _buildInfoRow(
              Icons.autorenew,
              'Auto Renewal',
              widget.autoRenew
                  ? 'Your subscription will auto-renew'
                  : 'No auto-renewal - you control your subscription',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.security, color: Colors.green[700]),
                const SizedBox(width: 8),
                const Text(
                  'Secure & Safe',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '• Your payment information is encrypted and secure\n'
              '• We never store your card details\n'
              '• PCI DSS compliant payment processing\n'
              '• 256-bit SSL encryption for all transactions',
              style: TextStyle(color: Colors.grey[600], height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _checkPaymentStatus,
            icon: const Icon(Icons.refresh),
            label: const Text('Check Payment Status'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: _initiatePayment,
            child: const Text('Retry Payment'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blue[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Payment Successful!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Your ${widget.plan.name} subscription is now active.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close payment page
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
