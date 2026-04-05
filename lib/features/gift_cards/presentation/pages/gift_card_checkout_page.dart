import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/gift_cards/data/models/gift_card_models.dart'
    show GiftCardPriceBreakdown;
import 'package:savedge/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/features/gift_cards/presentation/bloc/gift_cards_bloc.dart';

class GiftCardCheckoutPage extends StatelessWidget {
  final GiftCardProductEntity product;
  final double amount;
  final String? themeSku;

  const GiftCardCheckoutPage({
    super.key,
    required this.product,
    required this.amount,
    this.themeSku,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GiftCardsBloc>(),
      child: GiftCardCheckoutView(product: product, amount: amount, themeSku: themeSku),
    );
  }
}

class GiftCardCheckoutView extends StatefulWidget {
  final GiftCardProductEntity product;
  final double amount;
  final String? themeSku;

  const GiftCardCheckoutView({
    super.key,
    required this.product,
    required this.amount,
    this.themeSku,
  });

  @override
  State<GiftCardCheckoutView> createState() => _GiftCardCheckoutViewState();
}

class _GiftCardCheckoutViewState extends State<GiftCardCheckoutView> {
  bool _isEmployee = false;
  bool _isLoadingProfile = true;
  UserProfileResponse3? _userProfile;
  bool _usePoints = false;
  Razorpay? _razorpay;
  int? _currentOrderId;
  GiftCardPriceBreakdown? _breakdown;

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
        _isLoadingProfile = false;
      });
      _fetchPriceBreakdown();
    } catch (e) {
      setState(() => _isLoadingProfile = false);
      _fetchPriceBreakdown();
    }
  }

  void _fetchPriceBreakdown() {
    final pointsToUse = _usePoints ? (_userProfile?.pointsBalance ?? 0) : 0;
    context.read<GiftCardsBloc>().add(
      LoadPriceBreakdown(
        productId: widget.product.id,
        amount: widget.amount,
        pointsToUse: pointsToUse,
      ),
    );
  }

  void _togglePoints(bool value) {
    setState(() => _usePoints = value);
    _fetchPriceBreakdown();
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
        content: Text(response.message ?? 'Payment failed. Please try again.'),
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
          '${state.productName} - \u20B9${state.requestedAmount.toStringAsFixed(0)}',
      'prefill': {
        'contact': _userProfile?.phoneNumber ?? '',
        'email': _userProfile?.email ?? '',
      },
      'theme': {'color': '#6F3FCC'},
    };

    _razorpay?.open(options);
  }

  Future<void> _handlePurchase() async {
    // Check authentication before proceeding
    final secureStorage = getIt<SecureStorageService>();
    final isAuthenticated = await secureStorage.isAuthenticated();
    if (!isAuthenticated) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to purchase gift cards'),
          backgroundColor: Color(0xFFF59E0B),
        ),
      );
      Navigator.pushNamed(context, '/login');
      return;
    }

    final pointsToUse = _usePoints ? (_userProfile?.pointsBalance ?? 0) : 0;
    final breakdown = _breakdown;

    // If points cover everything, use points payment
    if (_usePoints && breakdown != null && breakdown.finalPayableAmount <= 0) {
      context.read<GiftCardsBloc>().add(
        CreateGiftCardOrder(
          giftCardProductId: widget.product.id,
          amount: widget.amount,
          paymentMethod: GiftCardPaymentMethodEntity.points,
          themeSku: widget.themeSku,
        ),
      );
    } else {
      context.read<GiftCardsBloc>().add(
        CreateGiftCardPaymentOrder(
          giftCardProductId: widget.product.id,
          amount: widget.amount,
          pointsToUse: pointsToUse,
          themeSku: widget.themeSku,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF6F3FCC),
        surfaceTintColor: const Color(0xFF6F3FCC),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 18,
          ),
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
      body: BlocConsumer<GiftCardsBloc, GiftCardsState>(
        listener: (context, state) {
          if (state is GiftCardOrderCreated) {
            _showSuccessDialog(context, state.order);
          } else if (state is GiftCardOrderError) {
            _showError(context, state.message);
          } else if (state is GiftCardRazorpayOrderCreated) {
            if (state.razorpayOrderId.isEmpty) {
              // Points-only payment completed via createPaymentOrder
              _showSuccessDialogSimple(context);
            } else {
              _openRazorpayCheckout(state);
            }
          } else if (state is GiftCardRazorpayOrderError) {
            _showError(context, state.message);
          } else if (state is GiftCardPaymentVerified) {
            _showSuccessDialogSimple(context);
          } else if (state is GiftCardPaymentError) {
            _showError(context, state.message);
          } else if (state is PriceBreakdownLoaded) {
            setState(() => _breakdown = state.breakdown);
          }
        },
        builder: (context, state) {
          if (_isLoadingProfile) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
            );
          }

          final discountAmount = widget.product.calculateDiscount(
            widget.amount,
          );
          final breakdown = _breakdown;

          return Column(
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
                      '${widget.product.currencySymbol ?? '\u20B9'}${widget.amount.toStringAsFixed(0)}',
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
                    if (widget.product.hasDiscount ||
                        (breakdown != null &&
                            breakdown.pointsDiscount > 0)) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF059669),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Saved ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '\u20B9${((breakdown?.discountAmount ?? discountAmount) + (breakdown?.pointsDiscount ?? 0)).toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '\uD83C\uDF89',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
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
                      // Points toggle (for employees)
                      if (_isEmployee &&
                          (_userProfile?.pointsBalance ?? 0) > 0) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _usePoints
                                ? const Color(0xFFFFF7ED)
                                : const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: _usePoints
                                  ? const Color(0xFFF59E0B)
                                  : Colors.grey[200]!,
                              width: _usePoints ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFF59E0B,
                                  ).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.stars_rounded,
                                  color: Color(0xFFF59E0B),
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Save using magicPoints',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1A202C),
                                      ),
                                    ),
                                    Text(
                                      'You have: ${_userProfile?.pointsBalance ?? 0} points',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch.adaptive(
                                value: _usePoints,
                                onChanged: _togglePoints,
                                activeColor: const Color(0xFFF59E0B),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Payment Details breakdown
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
                              'Payment Details',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A202C),
                              ),
                            ),
                            if (breakdown != null &&
                                breakdown.availablePoints > 0) ...[
                              const SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'You have: ${breakdown.availablePoints}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(width: 3),
                                        const Icon(
                                          Icons.stars_rounded,
                                          size: 13,
                                          color: Color(0xFFF59E0B),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 12),
                            _buildRow(
                              'Bill amount',
                              '\u20B9${widget.amount.toStringAsFixed(0)}',
                            ),
                            if (_usePoints &&
                                breakdown != null &&
                                breakdown.pointsDiscount > 0) ...[
                              const SizedBox(height: 8),
                              _buildRow(
                                'Save using magicPoints',
                                '-\u20B9${breakdown.pointsDiscount.toStringAsFixed(0)}',
                                valueColor: const Color(0xFF059669),
                                labelColor: const Color(0xFF059669),
                              ),
                            ],
                            if (widget.product.hasDiscount) ...[
                              const SizedBox(height: 8),
                              _buildRow(
                                'Discount (${widget.product.discountPercentage!.toStringAsFixed(0)}%)',
                                '-\u20B9${(breakdown?.discountAmount ?? discountAmount).toStringAsFixed(0)}',
                                valueColor: const Color(0xFF059669),
                              ),
                            ],
                            const Divider(height: 20),
                            _buildRow(
                              'To Pay',
                              '\u20B9${(breakdown?.finalPayableAmount ?? widget.product.calculatePayable(widget.amount)).toStringAsFixed(1)}',
                              isBold: true,
                              valueColor: const Color(0xFF6F3FCC),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Payment method (only if there's an amount to pay online)
                      if (!_isEmployee ||
                          (breakdown != null &&
                              breakdown.finalPayableAmount > 0 &&
                              !_usePoints)) ...[
                        const Text(
                          'Payment Method',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A202C),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildPaymentOption(
                          isSelected: true,
                          icon: Icons.payment_rounded,
                          title: 'Pay Online',
                          subtitle: 'Credit/Debit/UPI',
                          onTap: () {},
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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Color(0xFFF3F4F6), width: 1.5),
                    ),
                  ),
                  child: BlocBuilder<GiftCardsBloc, GiftCardsState>(
                    builder: (context, state) {
                      final isLoading =
                          state is GiftCardOrderCreating ||
                          state is GiftCardRazorpayOrderCreating ||
                          state is GiftCardPaymentVerifying;

                      final payAmount =
                          breakdown?.finalPayableAmount ??
                          widget.product.calculatePayable(widget.amount);
                      final isFullyPoints = _usePoints && payAmount <= 0;

                      return ElevatedButton(
                        onPressed: isLoading ? null : _handlePurchase,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6F3FCC),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 52),
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
                                isFullyPoints
                                    ? 'Pay with Points'
                                    : 'Pay \u20B9${payAmount.toStringAsFixed(1)}',
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
          );
        },
      ),
    );
  }

  Widget _buildRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
    Color? labelColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 15 : 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color:
                labelColor ??
                (isBold ? const Color(0xFF1A202C) : Colors.grey[600]),
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
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? const Color(0xFF6F3FCC) : Colors.grey[600],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
              ],
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
              child: const Icon(
                Icons.check_circle_rounded,
                size: 40,
                color: Color(0xFF059669),
              ),
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
              Navigator.pop(context);
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

  void _showSuccessDialogSimple(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
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
              child: const Icon(
                Icons.check_circle_rounded,
                size: 40,
                color: Color(0xFF059669),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Order Placed!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your gift card is being issued. Check your orders for details.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
