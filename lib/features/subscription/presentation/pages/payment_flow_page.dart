import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../core/injection/injection.dart';
import '../../../../shared/widgets/common_widgets.dart';
import '../../../../shared/domain/entities/subscription.dart';
import '../bloc/subscription_bloc.dart';
import '../widgets/payment_summary_card.dart';
import '../../data/services/razorpay_service.dart';

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
  late RazorpayService _razorpayService;
  bool _isProcessingPayment = false;

  @override
  void initState() {
    super.initState();
    _razorpayService = RazorpayService();

    // Create payment order when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubscriptionBloc>().add(
        CreatePaymentOrderEvent(
          planId: widget.plan.id,
          autoRenew: widget.autoRenew,
        ),
      );
    });
  }

  @override
  void dispose() {
    _razorpayService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Payment'), elevation: 0),
      body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
        listener: (context, state) {
          if (state is SubscriptionLoaded) {
            // Handle payment order creation success
            if (state.paymentOrderData != null && !_isProcessingPayment) {
              _initiateRazorpayPayment(state.paymentOrderData!);
            }

            // Handle verification success
            if (state.verificationSuccess) {
              _showPaymentSuccessDialog();
            }

            // Handle errors
            if (state.paymentOrderError != null) {
              _showErrorDialog(
                'Payment Setup Failed',
                state.paymentOrderError!,
              );
            }

            if (state.verificationError != null) {
              _showErrorDialog(
                'Payment Verification Failed',
                state.verificationError!,
              );
            }
          }
        },
        builder: (context, state) {
          if (state is SubscriptionLoading ||
              (state is SubscriptionLoaded && state.isCreatingPaymentOrder)) {
            return const LoadingWidget(message: 'Setting up payment...');
          }

          if (state is SubscriptionError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () => Navigator.of(context).pop(),
            );
          }

          if (state is SubscriptionLoaded) {
            return SingleChildScrollView(
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
                  if (_isProcessingPayment) ...[
                    const LoadingWidget(message: 'Processing payment...'),
                  ] else if (state.paymentOrderError != null) ...[
                    _buildErrorCard(state.paymentOrderError!),
                  ] else if (state.paymentOrderData != null) ...[
                    _buildPaymentReadyCard(),
                  ],

                  const SizedBox(height: 24),

                  // Payment Information
                  _buildPaymentInfoCard(),

                  const SizedBox(height: 24),

                  // Security Information
                  _buildSecurityInfoCard(),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _initiateRazorpayPayment(Map<String, dynamic> orderData) {
    if (_isProcessingPayment) return;

    setState(() {
      _isProcessingPayment = true;
    });

    // TODO: Get user data from auth service
    const userEmail = 'user@example.com';
    const userPhone = '+919876543210';
    const userName = 'User Name';

    _razorpayService.openCheckout(
      orderId: orderData['orderId'],
      amount: orderData['amount'],
      receipt: orderData['receipt'],
      plan: widget.plan,
      userEmail: userEmail,
      userPhone: userPhone,
      userName: userName,
      onSuccess: _handlePaymentSuccess,
      onError: _handlePaymentError,
      onExternalWallet: _handleExternalWallet,
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      _isProcessingPayment = false;
    });

    // Verify payment with backend
    final state = context.read<SubscriptionBloc>().state;
    if (state is SubscriptionLoaded && state.paymentOrderData != null) {
      context.read<SubscriptionBloc>().add(
        VerifyPaymentEvent(
          transactionId: state.paymentOrderData!['transactionId'],
          razorpayOrderId: response.orderId ?? '',
          razorpayPaymentId: response.paymentId ?? '',
          razorpaySignature: response.signature ?? '',
          autoRenew: widget.autoRenew,
        ),
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _isProcessingPayment = false;
    });

    _showErrorDialog(
      'Payment Failed',
      response.message ?? 'Payment was cancelled or failed',
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() {
      _isProcessingPayment = false;
    });

    // Handle external wallet (like Paytm, etc.)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('External wallet selected: ${response.walletName}'),
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Card(
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.error, color: Colors.red[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Setup Failed',
                    style: TextStyle(
                      color: Colors.red[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(error, style: TextStyle(color: Colors.red[800])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentReadyCard() {
    return Card(
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Ready',
                    style: TextStyle(
                      color: Colors.green[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Your payment is being processed securely',
                    style: TextStyle(color: Colors.green[800]),
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
              'Powered by Razorpay - India\'s most trusted payment gateway',
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
              Navigator.pushReplacementNamed(context, '/subscription-plans');
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
