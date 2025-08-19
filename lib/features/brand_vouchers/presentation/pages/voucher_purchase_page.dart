import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/injection/injection.dart';
import '../../domain/entities/brand_voucher_entity.dart';
import '../bloc/brand_vouchers_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    _selectedAmount = widget.voucher.minimumAmount;
    _amountController.text = widget.voucher.minimumAmount.toStringAsFixed(0);
    _validateAmount();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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
          }
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVoucherHeader(),
              _buildAmountSection(),
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

  Widget _buildCostBreakdown() {
    final processingFee = widget.voucher.calculateProcessingFee(_selectedAmount);
    final totalCost = widget.voucher.calculateTotalCost(_selectedAmount);

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
            'Total Points Required', 
            '${totalCost.toStringAsFixed(0)} Points',
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
          final isLoading = state is VoucherOrderCreating;
          
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
                        ? 'Purchase for ${widget.voucher.calculateTotalCost(_selectedAmount).toStringAsFixed(0)} Points'
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
    // TODO: Get actual user ID from auth
    const userId = 'current-user-id';
    
    context.read<BrandVouchersBloc>().add(
      CreateVoucherOrder(
        userId: userId,
        brandVoucherId: widget.voucher.id,
        voucherAmount: _selectedAmount,
      ),
    );
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