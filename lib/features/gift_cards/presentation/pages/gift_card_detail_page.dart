import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../domain/entities/gift_card_entity.dart';

class GiftCardDetailPage extends StatefulWidget {
  final GiftCardProductEntity product;

  const GiftCardDetailPage({super.key, required this.product});

  @override
  State<GiftCardDetailPage> createState() => _GiftCardDetailPageState();
}

class _GiftCardDetailPageState extends State<GiftCardDetailPage> {
  final _amountController = TextEditingController();
  double _selectedAmount = 0;
  bool _isAmountValid = false;

  @override
  void initState() {
    super.initState();
    _selectedAmount = widget.product.minPrice;
    _amountController.text = widget.product.minPrice.toStringAsFixed(0);
    _validateAmount();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _validateAmount() {
    setState(() {
      _isAmountValid = _selectedAmount >= widget.product.minPrice &&
          _selectedAmount <= widget.product.maxPrice;
    });
  }

  List<double> _getDenominations() {
    if (widget.product.denominations != null &&
        widget.product.denominations!.isNotEmpty) {
      return widget.product.denominations!
          .split(',')
          .map((d) => double.tryParse(d.trim()) ?? 0)
          .where((d) => d > 0)
          .toList()
        ..sort();
    }
    // Generate quick picks from min/max
    final min = widget.product.minPrice;
    final max = widget.product.maxPrice;
    final picks = <double>[min];
    if (max > min) {
      picks.add((min + max) / 2);
      picks.add(max);
    }
    return picks.toSet().toList()..sort();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final denominations = _getDenominations();
    final discountAmount = product.calculateDiscount(_selectedAmount);
    final payableAmount = product.calculatePayable(_selectedAmount);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Hero header with gradient
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFF6F3FCC),
            systemOverlayStyle: SystemUiOverlayStyle.light,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back_ios_rounded,
                    color: Colors.white, size: 16),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF7C3AED), Color(0xFF4C1D95)],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // Product image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: product.imageUrl != null
                            ? CachedNetworkImage(
                                imageUrl: product.imageUrl!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                                placeholder: (_, __) => Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.white.withOpacity(0.1),
                                  child: const Icon(Icons.card_giftcard,
                                      color: Colors.white54, size: 40),
                                ),
                                errorWidget: (_, __, ___) => Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.white.withOpacity(0.1),
                                  child: const Icon(Icons.card_giftcard,
                                      color: Colors.white54, size: 40),
                                ),
                              )
                            : Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(Icons.card_giftcard,
                                    color: Colors.white54, size: 40),
                              ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (product.hasDiscount) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF059669),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${product.discountPercentage!.toStringAsFixed(0)}% OFF',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount section
                  const Text(
                    'Create a custom voucher',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A202C),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${product.currencySymbol ?? '₹'}${product.minPrice.toStringAsFixed(0)} - ${product.currencySymbol ?? '₹'}${product.maxPrice.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 16),

                  // Denomination quick picks
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: denominations.take(6).map((amount) {
                      final isSelected = _selectedAmount == amount;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedAmount = amount;
                            _amountController.text =
                                amount.toStringAsFixed(0);
                          });
                          _validateAmount();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF6F3FCC)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF6F3FCC)
                                  : Colors.grey[300]!,
                            ),
                          ),
                          child: Text(
                            '${product.currencySymbol ?? '₹'}${amount.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF1A202C),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Custom amount input
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      setState(() {
                        _selectedAmount = double.tryParse(value) ?? 0;
                      });
                      _validateAmount();
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter custom amount',
                      prefixText: '${product.currencySymbol ?? '₹'} ',
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Color(0xFF6F3FCC)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Price breakdown card
                  if (_isAmountValid) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F3FF),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFDDD6FE)),
                      ),
                      child: Column(
                        children: [
                          _buildPriceRow(
                              'Gift Card Value',
                              '${product.currencySymbol ?? '₹'}${_selectedAmount.toStringAsFixed(0)}'),
                          if (product.hasDiscount) ...[
                            const SizedBox(height: 8),
                            _buildPriceRow(
                              'Discount (${product.discountPercentage!.toStringAsFixed(0)}%)',
                              '-${product.currencySymbol ?? '₹'}${discountAmount.toStringAsFixed(0)}',
                              valueColor: const Color(0xFF059669),
                            ),
                          ],
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Divider(color: Color(0xFFDDD6FE)),
                          ),
                          _buildPriceRow(
                            'You Pay',
                            '${product.currencySymbol ?? '₹'}${payableAmount.toStringAsFixed(0)}',
                            isBold: true,
                            valueColor: const Color(0xFF6F3FCC),
                          ),
                          if (product.hasDiscount) ...[
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECFDF5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'You save ${product.currencySymbol ?? '₹'}${discountAmount.toStringAsFixed(0)}!',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF059669),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Description
                  if (product.description != null) ...[
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Expiry info
                  if (product.formatExpiry != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9E6),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFFFE066)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline,
                              size: 16, color: Color(0xFFFF9800)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Valid for ${product.formatExpiry}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF92400E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom CTA
      bottomNavigationBar: SafeArea(
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
          child: ElevatedButton(
            onPressed: _isAmountValid
                ? () {
                    Navigator.pushNamed(
                      context,
                      '/gift-card-checkout',
                      arguments: {
                        'product': product,
                        'amount': _selectedAmount,
                      },
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6F3FCC),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
              disabledBackgroundColor: Colors.grey[300],
            ),
            child: Text(
              _isAmountValid
                  ? 'Create Gift Card - ${product.currencySymbol ?? '₹'}${payableAmount.toStringAsFixed(0)}'
                  : 'Enter Valid Amount',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value,
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
}
