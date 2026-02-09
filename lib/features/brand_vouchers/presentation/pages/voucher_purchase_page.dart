import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get_it/get_it.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../core/injection/injection.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../auth/data/models/user_profile_models.dart';
import '../../domain/entities/brand_voucher_entity.dart';
import '../../data/models/brand_voucher_models.dart';
import '../bloc/brand_vouchers_bloc.dart';
import '../../../subscription/data/services/razorpay_payment_service.dart';

class VoucherPurchasePage extends StatelessWidget {
  final BrandVoucherEntity voucher;

  const VoucherPurchasePage({
    super.key,
    required this.voucher,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BrandVouchersBloc>(),
      child: VoucherPurchaseView(voucher: voucher),
    );
  }
}

class VoucherPurchaseView extends StatefulWidget {
  final BrandVoucherEntity voucher;

  const VoucherPurchaseView({
    super.key,
    required this.voucher,
  });

  @override
  State<VoucherPurchaseView> createState() => _VoucherPurchaseViewState();
}

class _VoucherPurchaseViewState extends State<VoucherPurchaseView> {
  final _amountController = TextEditingController();
  double _selectedAmount = 0;
  bool _isAmountValid = false;

  // Payment method selection
  VoucherPaymentMethod _selectedPaymentMethod = VoucherPaymentMethod.online;
  bool _isEmployee = false;
  bool _isLoadingProfile = true;
  UserProfileResponse3? _userProfile;

  // Razorpay payment
  Razorpay? _razorpay;
  int? _currentVoucherOrderId;

  @override
  void initState() {
    super.initState();
    _selectedAmount = widget.voucher.minimumAmount;
    _amountController.text = widget.voucher.minimumAmount.toStringAsFixed(0);
    _validateAmount();
    _loadUserProfile();
    _initRazorpay();
  }

  void _initRazorpay() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _razorpay?.clear();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    try {
      final authRepository = getIt<AuthRepository>();
      final profile = await authRepository.getCurrentUserProfile();
      setState(() {
        _userProfile = profile;
        _isEmployee = profile.isEmployee;
        // Set default payment method based on user type
        _selectedPaymentMethod = _isEmployee
            ? VoucherPaymentMethod.points
            : VoucherPaymentMethod.online;
        _isLoadingProfile = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingProfile = false;
      });
    }
  }

  void _validateAmount() {
    setState(() {
      _isAmountValid = _selectedAmount >= widget.voucher.minimumAmount &&
                     _selectedAmount <= widget.voucher.maximumAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1A202C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        title: const Text(
          'Purchase Voucher',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A202C),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<BrandVouchersBloc, BrandVouchersState>(
        listener: (context, state) {
          if (state is VoucherOrderCreated) {
            _showSuccessDialog(context, state.orderId);
          } else if (state is VoucherOrderError) {
            _showErrorSnackBar(context, state.message);
          } else if (state is RazorpayOrderCreated) {
            _openRazorpayCheckout(state);
          } else if (state is RazorpayOrderError) {
            _showErrorSnackBar(context, state.message);
          } else if (state is RazorpayPaymentVerified) {
            _showSuccessDialog(context, state.voucherOrderId);
          } else if (state is RazorpayPaymentError) {
            _showErrorSnackBar(context, state.message);
          }
        },
        child: _isLoadingProfile
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF6F3FCC)),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildVoucherHeader(),
                    _buildAmountSection(),
                    if (_isEmployee) _buildPaymentMethodSection(),
                    _buildCostBreakdown(),
                    _buildTermsSection(),
                    const SizedBox(height: 20),
                    _buildPurchaseButton(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
      ),
    );
  }

  void _openRazorpayCheckout(RazorpayOrderCreated state) {
    _currentVoucherOrderId = state.voucherOrderId;

    var options = {
      'key': state.razorpayKeyId,
      'amount': state.amount,
      'currency': state.currency,
      'order_id': state.orderId,
      'name': 'SavEdge',
      'description': '${state.brandName} Voucher - ₹${state.voucherAmount.toStringAsFixed(0)}',
      'prefill': {
        'contact': _userProfile?.phoneNumber ?? '',
        'email': _userProfile?.email ?? '',
      },
      'theme': {
        'color': '#6F3FCC',
      },
    };

    _razorpay?.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (_currentVoucherOrderId != null) {
      context.read<BrandVouchersBloc>().add(
        CheckRazorpayPaymentStatus(voucherOrderId: _currentVoucherOrderId!),
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    _showErrorSnackBar(
      context,
      response.message ?? 'Payment failed. Please try again.',
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // External wallet selected, payment will be processed
  }

  Widget _buildVoucherHeader() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: widget.voucher.brandImageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[200],
                child: const Icon(Icons.image, color: Colors.grey),
              ),
              errorWidget: (context, url, error) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.voucher.brandName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.voucher.brandDescription,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6F3FCC).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${widget.voucher.processingFeePercentage}% processing fee',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6F3FCC),
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

  Widget _buildAmountSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter Voucher Amount',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 16),

          // Quick amount buttons
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: _buildQuickAmountButtons(),
          ),

          const SizedBox(height: 16),

          // Custom amount input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Custom Amount',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A202C),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedAmount = double.tryParse(value) ?? 0;
                    });
                    _validateAmount();
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter amount',
                    prefixText: '₹ ',
                    suffixText: 'INR',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xFF6F3FCC)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Minimum: ₹${widget.voucher.minimumAmount.toStringAsFixed(0)} • Maximum: ₹${widget.voucher.maximumAmount.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildQuickAmountButtons() {
    final amounts = [
      widget.voucher.minimumAmount,
      (widget.voucher.minimumAmount * 2).clamp(widget.voucher.minimumAmount, widget.voucher.maximumAmount),
      (widget.voucher.minimumAmount * 5).clamp(widget.voucher.minimumAmount, widget.voucher.maximumAmount),
      widget.voucher.maximumAmount,
    ];

    return amounts.where((amount) => amount <= widget.voucher.maximumAmount).map((amount) {
      final isSelected = _selectedAmount == amount;
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedAmount = amount;
            _amountController.text = amount.toStringAsFixed(0);
          });
          _validateAmount();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6F3FCC) : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? const Color(0xFF6F3FCC) : Colors.grey[300]!,
            ),
          ),
          child: Text(
            '₹${amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF1A202C),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildPaymentMethodSection() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPaymentMethodCard(
                  method: VoucherPaymentMethod.points,
                  icon: Icons.stars_rounded,
                  title: 'Points',
                  subtitle: _userProfile != null
                      ? '${_userProfile!.pointsBalance} available'
                      : 'Pay with points',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildPaymentMethodCard(
                  method: VoucherPaymentMethod.online,
                  icon: Icons.payment_rounded,
                  title: 'Pay Online',
                  subtitle: 'Credit/Debit card',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard({
    required VoucherPaymentMethod method,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedPaymentMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6F3FCC).withOpacity(0.1) : const Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF6F3FCC) : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? const Color(0xFF6F3FCC) : Colors.grey[700],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFF6F3FCC) : const Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCostBreakdown() {
    final processingFee = widget.voucher.calculateProcessingFee(_selectedAmount);
    final totalCost = widget.voucher.calculateTotalCost(_selectedAmount);
    final isPointsPayment = _selectedPaymentMethod == VoucherPaymentMethod.points;

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cost Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A202C),
            ),
          ),
          const SizedBox(height: 12),
          _buildCostRow('Voucher Value', '₹${_selectedAmount.toStringAsFixed(2)}'),
          _buildCostRow('Processing Fee (${widget.voucher.processingFeePercentage}%)', '₹${processingFee.toStringAsFixed(2)}'),
          const Divider(),
          _buildCostRow(
            isPointsPayment ? 'Total Points Required' : 'Total Amount',
            isPointsPayment
                ? '${totalCost.toStringAsFixed(0)} Points'
                : '₹${totalCost.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCostRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 14 : 13,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
              color: isTotal ? const Color(0xFF1A202C) : Colors.grey[700],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 14 : 13,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
              color: isTotal ? const Color(0xFF6F3FCC) : const Color(0xFF1A202C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsSection() {
    if (widget.voucher.terms == null && widget.voucher.instructions == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE066)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                size: 16,
                color: Color(0xFFFF9800),
              ),
              const SizedBox(width: 8),
              const Text(
                'Important Information',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A202C),
                ),
              ),
            ],
          ),
          if (widget.voucher.terms != null) ...[
            const SizedBox(height: 12),
            Text(
              widget.voucher.terms!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ],
          if (widget.voucher.instructions != null) ...[
            const SizedBox(height: 12),
            Text(
              widget.voucher.instructions!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPurchaseButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: BlocBuilder<BrandVouchersBloc, BrandVouchersState>(
        builder: (context, state) {
          final isLoading = state is VoucherOrderCreating ||
                           state is RazorpayOrderCreating ||
                           state is RazorpayPaymentVerifying;

          final isPointsPayment = _selectedPaymentMethod == VoucherPaymentMethod.points;
          final totalCost = widget.voucher.calculateTotalCost(_selectedAmount);

          return ElevatedButton(
            onPressed: (!_isAmountValid || isLoading) ? null : () => _purchaseVoucher(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6F3FCC),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
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
                    _isAmountValid
                        ? isPointsPayment
                            ? 'Purchase for ${totalCost.toStringAsFixed(0)} Points'
                            : 'Pay ₹${totalCost.toStringAsFixed(2)}'
                        : 'Enter Valid Amount',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          );
        },
      ),
    );
  }

  void _purchaseVoucher(BuildContext context) {
    if (_userProfile == null) {
      _showErrorSnackBar(context, 'Unable to load user profile');
      return;
    }

    if (_selectedPaymentMethod == VoucherPaymentMethod.points) {
      // Use points payment method (existing flow)
      context.read<BrandVouchersBloc>().add(
        CreateVoucherOrder(
          userId: _userProfile!.id,
          brandVoucherId: widget.voucher.id,
          voucherAmount: _selectedAmount,
        ),
      );
    } else {
      // Use Razorpay payment method
      context.read<BrandVouchersBloc>().add(
        CreateRazorpayOrder(
          brandVoucherId: widget.voucher.id,
          voucherAmount: _selectedAmount,
        ),
      );
    }
  }

  void _showSuccessDialog(BuildContext context, int orderId) {
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
            const Text(
              'Order Placed Successfully!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your voucher order #$orderId has been submitted. You will receive your voucher details once it\'s processed by our team.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to vouchers page
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
      ),
    );
  }
}
