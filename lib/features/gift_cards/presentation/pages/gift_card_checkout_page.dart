import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../core/injection/injection.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../auth/data/models/user_profile_models.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../bloc/gift_cards_bloc.dart';

class GiftCardCheckoutPage extends StatelessWidget {
  final GiftCardProductEntity product;
  final double amount;

  const GiftCardCheckoutPage({
    super.key,
    required this.product,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GiftCardsBloc>(),
      child: GiftCardCheckoutView(product: product, amount: amount),
    );
  }
}

class GiftCardCheckoutView extends StatefulWidget {
  final GiftCardProductEntity product;
  final double amount;

  const GiftCardCheckoutView({
    super.key,
    required this.product,
    required this.amount,
  });

  @override
  State<GiftCardCheckoutView> createState() => _GiftCardCheckoutViewState();
}

class _GiftCardCheckoutViewState extends State<GiftCardCheckoutView> {
  bool _isEmployee = false;
  bool _isLoadingProfile = true;
  UserProfileResponse3? _userProfile;
  bool _payWithPoints = false;
  Razorpay? _razorpay;
  int? _currentOrderId;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
    _initRazorpay();
  }

  @override
  void dispose() {
    _razorpay?.clear();
    super.dispose();
  }

  void _initRazorpay() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> _loadUserProfile() async {
    try {
      final authRepository = getIt<AuthRepository>();
      final profile = await authRepository.getCurrentUserProfile();
      setState(() {
        _userProfile = profile;
        _isEmployee = profile.isEmployee;
        _payWithPoints = _isEmployee;
        _isLoadingProfile = false;
      });
    } catch (e) {
      setState(() => _isLoadingProfile = false);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (_currentOrderId != null &&
        response.paymentId != null &&
        response.orderId != null &&
        response.signature != null) {
      context.read<GiftCardsBloc>().add(
            VerifyGiftCardPayment(
              orderId: _currentOrderId!,
              razorpayOrderId: response.orderId!,
              razorpayPaymentId: response.paymentId!,
              razorpaySignature: response.signature!,
            ),
          );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(response.message ?? 'Payment failed. Please try again.'),
        backgroundColor: const Color(0xFFEF4444),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  void _openRazorpayCheckout(GiftCardRazorpayOrderCreated state) {
    _currentOrderId = state.orderId;

    final options = {
      'key': state.razorpayKeyId,
      'amount': state.razorpayAmountInPaise,
      'currency': state.currency,
      'order_id': state.razorpayOrderId,
      'name': 'SavEdge',
      'description':
          '${state.productName} - ₹${state.requestedAmount.toStringAsFixed(0)}',
      'prefill': {
        'contact': _userProfile?.phoneNumber ?? '',
        'email': _userProfile?.email ?? '',
      },
      'theme': {'color': '#6F3FCC'},
    };

    _razorpay?.open(options);
  }

  void _handlePurchase() {
    if (_payWithPoints) {
      context.read<GiftCardsBloc>().add(
            CreateGiftCardOrder(
              giftCardProductId: widget.product.id,
              amount: widget.amount,
              paymentMethod: GiftCardPaymentMethodEntity.points,
            ),
          );
    } else {
      context.read<GiftCardsBloc>().add(
            CreateGiftCardPaymentOrder(
              giftCardProductId: widget.product.id,
              amount: widget.amount,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final discountAmount = widget.product.calculateDiscount(widget.amount);
    final payableAmount = widget.product.calculatePayable(widget.amount);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF6F3FCC),
        surfaceTintColor: const Color(0xFF6F3FCC),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Colors.white, size: 18),
        ),
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<GiftCardsBloc, GiftCardsState>(
        listener: (context, state) {
          if (state is GiftCardOrderCreated) {
            _showSuccessDialog(context, state.order);
          } else if (state is GiftCardOrderError) {
            _showError(context, state.message);
          } else if (state is GiftCardRazorpayOrderCreated) {
            _openRazorpayCheckout(state);
          } else if (state is GiftCardRazorpayOrderError) {
            _showError(context, state.message);
          } else if (state is GiftCardPaymentVerified) {
            _showSuccessDialog(context, state.order);
          } else if (state is GiftCardPaymentError) {
            _showError(context, state.message);
          }
        },
        child: _isLoadingProfile
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF6F3FCC)))
            : Column(
                children: [
                  // Purple header summary
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF6F3FCC), Color(0xFF5B21B6)],
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${widget.product.currencySymbol ?? '₹'}${widget.amount.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.product.name,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        if (widget.product.hasDiscount) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF059669),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Save ₹${discountAmount.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Price breakdown
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAFAFA),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Price Breakdown',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1A202C),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _buildRow('Gift Card Value',
                                    '₹${widget.amount.toStringAsFixed(0)}'),
                                if (widget.product.hasDiscount) ...[
                                  const SizedBox(height: 6),
                                  _buildRow(
                                    'Discount (${widget.product.discountPercentage!.toStringAsFixed(0)}%)',
                                    '-₹${discountAmount.toStringAsFixed(0)}',
                                    valueColor: const Color(0xFF059669),
                                  ),
                                ],
                                const Divider(height: 20),
                                _buildRow(
                                  'Total',
                                  '₹${payableAmount.toStringAsFixed(0)}',
                                  isBold: true,
                                  valueColor: const Color(0xFF6F3FCC),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Payment method
                          if (_isEmployee) ...[
                            const Text(
                              'Payment Method',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A202C),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildPaymentOption(
                                    isSelected: _payWithPoints,
                                    icon: Icons.stars_rounded,
                                    title: 'Points',
                                    subtitle: _userProfile != null
                                        ? '${_userProfile!.pointsBalance} available'
                                        : '',
                                    onTap: () =>
                                        setState(() => _payWithPoints = true),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildPaymentOption(
                                    isSelected: !_payWithPoints,
                                    icon: Icons.payment_rounded,
                                    title: 'Pay Online',
                                    subtitle: 'Credit/Debit/UPI',
                                    onTap: () =>
                                        setState(() => _payWithPoints = false),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  // Bottom CTA
                  SafeArea(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: BlocBuilder<GiftCardsBloc, GiftCardsState>(
                        builder: (context, state) {
                          final isLoading = state is GiftCardOrderCreating ||
                              state is GiftCardRazorpayOrderCreating ||
                              state is GiftCardPaymentVerifying;

                          return ElevatedButton(
                            onPressed: isLoading ? null : _handlePurchase,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6F3FCC),
                              foregroundColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                              minimumSize:
                                  const Size(double.infinity, 52),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    _payWithPoints
                                        ? 'Pay ${payableAmount.toStringAsFixed(0)} Points'
                                        : 'Pay ₹${payableAmount.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildRow(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 15 : 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: isBold ? const Color(0xFF1A202C) : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: valueColor ?? const Color(0xFF1A202C),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required bool isSelected,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6F3FCC).withOpacity(0.08)
              : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF6F3FCC) : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon,
                size: 28,
                color: isSelected
                    ? const Color(0xFF6F3FCC)
                    : Colors.grey[600]),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF6F3FCC)
                    : const Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, GiftCardOrderEntity order) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF059669).withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(Icons.check_circle_rounded,
                  size: 40, color: Color(0xFF059669)),
            ),
            const SizedBox(height: 16),
            Text(
              order.isCompleted
                  ? 'Gift Card Issued!'
                  : 'Order Placed Successfully!',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              order.isCompleted
                  ? 'Your gift card is ready. Check your orders to view the card details.'
                  : 'Your gift card order #${order.id} is being processed.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushNamed(context, '/gift-card-orders');
            },
            child: const Text('View Orders'),
          ),
        ],
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
      ),
    );
  }
}
