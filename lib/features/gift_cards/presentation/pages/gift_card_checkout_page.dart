import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/core/storage/secure_storage_service.dart';
import 'package:savedge/core/widgets/login_prompt.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';
import 'package:savedge/features/gift_cards/data/models/gift_card_models.dart'
    show GiftCardPriceBreakdown;
import 'package:savedge/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:savedge/features/gift_cards/presentation/bloc/gift_cards_bloc.dart';

import '../theme/gc_tokens.dart';
import '../widgets/gc_payment_method_tile.dart';
import '../widgets/gc_price_breakdown_card.dart';

class GiftCardCheckoutPage extends StatelessWidget {
  const GiftCardCheckoutPage({
    super.key,
    required this.product,
    required this.amount,
    this.themeSku,
  });

  final GiftCardProductEntity product;
  final double amount;
  final String? themeSku;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GiftCardsBloc>(),
      child: _CheckoutView(
        product: product,
        amount: amount,
        themeSku: themeSku,
      ),
    );
  }
}

enum _PayMethod { points, online }

class _CheckoutView extends StatefulWidget {
  const _CheckoutView({
    required this.product,
    required this.amount,
    required this.themeSku,
  });

  final GiftCardProductEntity product;
  final double amount;
  final String? themeSku;

  @override
  State<_CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<_CheckoutView> {
  Razorpay? _razorpay;
  bool _loadingProfile = true;
  UserProfileResponse3? _profile;
  bool _isEmployee = false;
  GiftCardPriceBreakdown? _breakdown;
  _PayMethod _method = _PayMethod.online;
  int? _currentOrderId;

  @override
  void initState() {
    super.initState();
    _initRazorpay();
    _loadProfile();
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

  Future<void> _loadProfile() async {
    try {
      final repo = getIt<AuthRepository>();
      final profile = await repo.getCurrentUserProfile();
      setState(() {
        _profile = profile;
        _isEmployee = profile.isEmployee;
        _loadingProfile = false;
        if (_isEmployee && (profile.pointsBalance) > 0) {
          _method = _PayMethod.points;
        }
      });
      _fetchBreakdown();
    } catch (_) {
      setState(() => _loadingProfile = false);
      _fetchBreakdown();
    }
  }

  void _fetchBreakdown() {
    final usePoints = _method == _PayMethod.points;
    final pts = usePoints ? (_profile?.pointsBalance ?? 0) : 0;
    context.read<GiftCardsBloc>().add(
          LoadPriceBreakdown(
            productId: widget.product.id,
            amount: widget.amount,
            pointsToUse: pts,
          ),
        );
  }

  void _selectMethod(_PayMethod m) {
    if (_method == m) return;
    setState(() => _method = m);
    _fetchBreakdown();
  }

  // ── Razorpay handlers (preserved verbatim from original) ───────────────

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
        backgroundColor: GcTokens.danger,
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
        'contact': _profile?.phoneNumber ?? '',
        'email': _profile?.email ?? '',
      },
      'theme': {'color': '#6F3FCC'},
    };
    _razorpay?.open(options);
  }

  Future<void> _onPay() async {
    final secureStorage = getIt<SecureStorageService>();
    final isAuth = await secureStorage.isAuthenticated();
    if (!isAuth) {
      if (!mounted) return;
      LoginPrompt.show(context, message: 'Please sign in to purchase gift cards');
      return;
    }

    final usePoints = _method == _PayMethod.points;
    final pts = usePoints ? (_profile?.pointsBalance ?? 0) : 0;
    final breakdown = _breakdown;

    if (usePoints && breakdown != null && breakdown.finalPayableAmount <= 0) {
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
              pointsToUse: pts,
              themeSku: widget.themeSku,
            ),
          );
    }
  }

  // ── UI ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final currency = p.currencySymbol ?? '\u20B9';
    final pointsBalance = _profile?.pointsBalance ?? 0;
    final pointsAvailable = _isEmployee && pointsBalance > 0;

    return Scaffold(
      backgroundColor: GcTokens.background,
      appBar: AppBar(
        backgroundColor: GcTokens.background,
        surfaceTintColor: GcTokens.background,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: GcTokens.textPrimary,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: GcTokens.textPrimary,
          ),
        ),
      ),
      body: BlocConsumer<GiftCardsBloc, GiftCardsState>(
        listener: (context, state) {
          if (state is GiftCardOrderCreated) {
            _showSuccessDialog(context, state.order);
          } else if (state is GiftCardOrderError) {
            _showError(state.message);
          } else if (state is GiftCardRazorpayOrderCreated) {
            if (state.razorpayOrderId.isEmpty) {
              _showSuccessSimple();
            } else {
              _openRazorpayCheckout(state);
            }
          } else if (state is GiftCardRazorpayOrderError) {
            _showError(state.message);
          } else if (state is GiftCardPaymentVerified) {
            if (state.success) {
              _showSuccessSimple(message: state.message);
            } else {
              _showFailureDialog(state.message);
            }
          } else if (state is GiftCardPaymentError) {
            _showError(state.message);
          } else if (state is PriceBreakdownLoaded) {
            setState(() => _breakdown = state.breakdown);
          }
        },
        builder: (context, state) {
          if (_loadingProfile) {
            return const Center(
              child: CircularProgressIndicator(color: GcTokens.primary),
            );
          }

          final breakdown = _breakdown;
          final payable = breakdown?.finalPayableAmount ??
              widget.product.calculatePayable(widget.amount);
          final discount = breakdown?.discountAmount ??
              widget.product.calculateDiscount(widget.amount);
          final pointsDiscount = breakdown?.pointsDiscount ?? 0;
          final isLoading = state is GiftCardOrderCreating ||
              state is GiftCardRazorpayOrderCreating ||
              state is GiftCardPaymentVerifying;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  children: [
                    _buildOrderSummary(p, currency),
                    const SizedBox(height: 18),
                    if (pointsAvailable)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GcPaymentMethodTile(
                          icon: Icons.stars_rounded,
                          title: 'Pay with magicPoints',
                          subtitle: 'Balance: $pointsBalance pts',
                          selected: _method == _PayMethod.points,
                          onTap: () => _selectMethod(_PayMethod.points),
                        ),
                      ),
                    GcPaymentMethodTile(
                      icon: Icons.credit_card_rounded,
                      title: 'Pay online',
                      subtitle: 'Cards, UPI, Net banking, Wallets',
                      selected: _method == _PayMethod.online,
                      onTap: () => _selectMethod(_PayMethod.online),
                    ),
                    const SizedBox(height: 18),
                    GcPriceBreakdownCard(
                      amount: widget.amount,
                      discountPercentage: widget.product.discountPercentage ?? 0,
                      discountAmount: discount,
                      pointsDiscount: pointsDiscount,
                      totalPayable: payable,
                      currencySymbol: currency,
                    ),
                  ],
                ),
              ),
              _buildBottomBar(
                isLoading: isLoading,
                payable: payable,
                currency: currency,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOrderSummary(GiftCardProductEntity p, String currency) {
    final accent = GcTokens.accentFor(p.id);
    final bg = GcTokens.bgFor(p.id);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        border: Border.all(color: const Color(0xFFEFEAFB)),
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: p.imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: p.imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Container(color: bg),
                    )
                  : Container(color: bg),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.brandName ?? p.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: GcTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'E-Voucher · Instant delivery',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$currency${widget.amount.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: accent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar({
    required bool isLoading,
    required double payable,
    required String currency,
  }) {
    final isPointsOnly = _method == _PayMethod.points && payable <= 0;
    final label = isPointsOnly
        ? 'Pay with Points'
        : 'Pay $currency${payable.toStringAsFixed(0)}';

    return Material(
      color: Colors.white,
      elevation: 12,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _onPay,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GcTokens.primary,
                    disabledBackgroundColor:
                        GcTokens.primary.withValues(alpha: 0.45),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.4,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.lock_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              label,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified_user_rounded,
                    size: 12,
                    color: GcTokens.textTertiary.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '256-bit secure  ·  Powered by Razorpay',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: GcTokens.textTertiary.withValues(alpha: 0.85),
                      letterSpacing: 0.2,
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

  // ── Dialogs / errors ───────────────────────────────────────────────────

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: GcTokens.danger),
    );
  }

  void _showSuccessSimple({String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _SuccessDialog(message: message),
    );
  }

  void _showSuccessDialog(BuildContext context, GiftCardOrderEntity order) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _SuccessDialog(
        message: order.isCompleted
            ? 'Your gift card is ready. Check your orders to view the card details.'
            : 'Your gift card order #${order.id} is being processed.',
      ),
    );
  }

  void _showFailureDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: GcTokens.danger.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                color: GcTokens.danger,
                size: 36,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Order Failed',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: GcTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: GcTokens.textTertiary,
                fontSize: 13,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (r) => r.isFirst);
            },
            child: const Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (r) => r.isFirst);
              Navigator.pushNamed(context, '/gift-card-orders');
            },
            child: const Text('View Orders'),
          ),
        ],
      ),
    );
  }
}

class _SuccessDialog extends StatelessWidget {
  const _SuccessDialog({this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: GcTokens.success.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(36),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: GcTokens.success,
              size: 42,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Order placed!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: GcTokens.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message ??
                'Your gift card is being issued. Check your orders for details.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: GcTokens.textTertiary,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.popUntil(context, (r) => r.isFirst);
          },
          child: const Text('OK'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.popUntil(context, (r) => r.isFirst);
            Navigator.pushNamed(context, '/gift-card-orders');
          },
          child: const Text('View Orders'),
        ),
      ],
    );
  }
}
