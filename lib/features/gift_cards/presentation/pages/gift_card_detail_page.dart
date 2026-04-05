import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/injection/injection.dart';

import '../../domain/entities/gift_card_entity.dart';
import '../bloc/gift_cards_bloc.dart';
import '../widgets/related_product_card.dart';

class GiftCardDetailPage extends StatefulWidget {
  final GiftCardProductEntity product;

  const GiftCardDetailPage({super.key, required this.product});

  @override
  State<GiftCardDetailPage> createState() => _GiftCardDetailPageState();
}

class _GiftCardDetailPageState extends State<GiftCardDetailPage>
    with TickerProviderStateMixin {
  final _amountController = TextEditingController();
  double _selectedAmount = 0;
  bool _isAmountValid = false;
  bool _tcExpanded = false;
  String? _selectedThemeSku;
  late AnimationController _amountAnimCtrl;
  late Animation<double> _amountScaleAnim;

  // Per-product accent colour (same logic as card)
  static const _accents = [
    Color(0xFF7C3AED),
    Color(0xFFEA580C),
    Color(0xFF059669),
    Color(0xFF2563EB),
    Color(0xFFD97706),
    Color(0xFFDB2777),
  ];
  static const _bgs = [
    Color(0xFFF3EFFE),
    Color(0xFFFFF0E6),
    Color(0xFFE6F9F0),
    Color(0xFFE6F3FF),
    Color(0xFFFFF3E6),
    Color(0xFFFCE6F0),
  ];

  Color get _accent => _accents[widget.product.id % _accents.length];
  Color get _bg => _bgs[widget.product.id % _bgs.length];

  @override
  void initState() {
    super.initState();
    _selectedAmount = widget.product.minPrice;
    _amountController.text = widget.product.minPrice.toStringAsFixed(0);
    _validateAmount();

    _amountAnimCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _amountScaleAnim = Tween<double>(begin: 1.0, end: 1.12).animate(
        CurvedAnimation(parent: _amountAnimCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountAnimCtrl.dispose();
    super.dispose();
  }

  void _validateAmount() {
    setState(() {
      if (widget.product.priceType == 'SLAB') {
        // For SLAB, amount must match exactly one of the denominations
        final denoms = _denominations();
        _isAmountValid = denoms.contains(_selectedAmount);
      } else {
        _isAmountValid = _selectedAmount >= widget.product.minPrice &&
            _selectedAmount <= widget.product.maxPrice;
      }
    });
  }

  void _pickAmount(double amount) {
    setState(() {
      _selectedAmount = amount;
      _amountController.text = amount.toStringAsFixed(0);
    });
    _validateAmount();
    _amountAnimCtrl.forward().then((_) => _amountAnimCtrl.reverse());
  }

  void _step(int delta) {
    if (widget.product.priceType == 'SLAB') return;
    final next = (_selectedAmount + delta * 50)
        .clamp(widget.product.minPrice, widget.product.maxPrice);
    _pickAmount(next);
  }

  List<double> _denominations() {
    if (widget.product.denominations != null &&
        widget.product.denominations!.isNotEmpty) {
      // Try parsing as JSON array first (e.g., '["100","1000","2000"]')
      try {
        final raw = widget.product.denominations!.trim();
        if (raw.startsWith('[')) {
          final List<dynamic> parsed =
              List<dynamic>.from(jsonDecode(raw) as List);
          final result = parsed
              .map((v) => double.tryParse(v.toString()) ?? 0)
              .where((d) => d > 0)
              .toList()
            ..sort();
          if (result.isNotEmpty) return result;
        }
      } catch (_) {}
      // Fallback: comma-separated
      return widget.product.denominations!
          .replaceAll(RegExp(r'[\[\]"]'), '')
          .split(',')
          .map((d) => double.tryParse(d.trim()) ?? 0)
          .where((d) => d > 0)
          .toList()
        ..sort();
    }
    final min = widget.product.minPrice;
    final max = widget.product.maxPrice;
    if (min == max) return [min];
    final mid = ((min + max) / 2).roundToDouble();
    return {min, mid, max}.toList()..sort();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final denominations = _denominations();
    final discount = product.calculateDiscount(_selectedAmount);
    final payable = product.calculatePayable(_selectedAmount);
    final currency = product.currencySymbol ?? '₹';

    return BlocProvider(
      create: (_) => getIt<GiftCardsBloc>()
        ..add(LoadRelatedProducts(productId: widget.product.id)),
      child: Scaffold(
      backgroundColor: const Color(0xFFF8F7FC),
      body: Column(
        children: [
          // ── Top image hero (fixed, not a SliverAppBar) ────────────────────
          _buildHero(context, product),

          // ── Scrollable content ─────────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand name + discount badge
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (product.brandName != null) ...[
                              Text(
                                product.brandName!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _accent.withAlpha(180),
                                  letterSpacing: 0.3,
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF111827),
                                height: 1.2,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (product.hasDiscount) ...[
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: _accent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${product.discountPercentage!.toStringAsFixed(0)}% OFF',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ── Amount selector card ────────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color(0xFFF0F0F0), width: 1.5),
                    ),
                    child: Column(
                      children: [
                        // Label
                        Text(
                          product.priceType == 'SLAB'
                              ? 'Choose an Amount'
                              : 'Select or Enter Amount',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Big amount display with –/+ buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _StepButton(
                              icon: Icons.remove_rounded,
                              color: _accent,
                              onTap: () => _step(-1),
                              enabled: product.priceType != 'SLAB' &&
                                  _selectedAmount > product.minPrice,
                            ),
                            const SizedBox(width: 20),
                            ScaleTransition(
                              scale: _amountScaleAnim,
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: currency,
                                      style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w700,
                                        color: _accent,
                                      ),
                                    ),
                                    TextSpan(
                                      text: _selectedAmount.toStringAsFixed(0),
                                      style: const TextStyle(
                                        fontSize: 52,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF111827),
                                        letterSpacing: -2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            _StepButton(
                              icon: Icons.add_rounded,
                              color: _accent,
                              onTap: () => _step(1),
                              enabled: product.priceType != 'SLAB' &&
                                  _selectedAmount < product.maxPrice,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Denomination pills
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: denominations.take(6).map((amt) {
                            final isSelected = _selectedAmount == amt;
                            return GestureDetector(
                              onTap: () => _pickAmount(amt),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected ? _accent : _bg,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  '$currency${amt.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color:
                                        isSelected ? Colors.white : _accent,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        // Custom text input for RANGE type
                        if (product.priceType == 'RANGE') ...[
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: const Color(0xFFE5E7EB), width: 1.5),
                            ),
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (v) {
                                final parsed = double.tryParse(v) ?? 0;
                                setState(() => _selectedAmount = parsed);
                                _validateAmount();
                                if (_isAmountValid) {
                                  _amountAnimCtrl
                                      .forward()
                                      .then((_) => _amountAnimCtrl.reverse());
                                }
                              },
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF111827),
                              ),
                              decoration: InputDecoration(
                                hintText: 'Custom amount...',
                                hintStyle: const TextStyle(
                                    color: Color(0xFFBBC0C9),
                                    fontWeight: FontWeight.w400),
                                prefixText: '$currency  ',
                                prefixStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: _accent),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Min $currency${product.minPrice.toStringAsFixed(0)}  •  Max $currency${product.maxPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFFBBC0C9),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // ── Theme selector ──────────────────────────────────────────
                  if (product.themes.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    _SectionHeading(title: 'Choose a Theme'),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 90,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: product.themes.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final theme = product.themes[index];
                          final isSelected = _selectedThemeSku == theme.sku;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedThemeSku =
                                    isSelected ? null : theme.sku;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? _accent
                                      : const Color(0xFFE5E7EB),
                                  width: isSelected ? 2.5 : 1.5,
                                ),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: theme.image != null
                                        ? CachedNetworkImage(
                                            imageUrl: theme.image!,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            placeholder: (_, __) => Container(
                                              color: _bg,
                                              child: Icon(
                                                Icons.palette_rounded,
                                                color: _accent.withAlpha(80),
                                                size: 24,
                                              ),
                                            ),
                                            errorWidget: (_, __, ___) =>
                                                Container(
                                              color: _bg,
                                              child: Icon(
                                                Icons.palette_rounded,
                                                color: _accent.withAlpha(80),
                                                size: 24,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            color: _bg,
                                            child: Icon(
                                              Icons.palette_rounded,
                                              color: _accent.withAlpha(80),
                                              size: 24,
                                            ),
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text(
                                      theme.name ??
                                          theme.sku
                                              .replaceAll('_', ' ')
                                              .toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: isSelected
                                            ? _accent
                                            : const Color(0xFF6B7280),
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],

                  // ── Price breakdown ─────────────────────────────────────────
                  if (_isAmountValid) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _bg,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          _PriceRow(
                            label: 'Gift Card Value',
                            value: '$currency${_selectedAmount.toStringAsFixed(0)}',
                          ),
                          if (product.hasDiscount) ...[
                            const SizedBox(height: 8),
                            _PriceRow(
                              label:
                                  'Discount ${product.discountPercentage!.toStringAsFixed(0)}%',
                              value:
                                  '- $currency${discount.toStringAsFixed(0)}',
                              valueColor: const Color(0xFF059669),
                            ),
                          ],
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Divider(height: 1),
                          ),
                          _PriceRow(
                            label: 'You Pay',
                            value: '$currency${payable.toStringAsFixed(0)}',
                            isBold: true,
                            valueColor: _accent,
                          ),
                          if (product.hasDiscount) ...[
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1FAE5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '🎉  You save $currency${discount.toStringAsFixed(0)}!',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF065F46),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],

                  // ── About ───────────────────────────────────────────────────
                  if (product.description != null) ...[
                    const SizedBox(height: 24),
                    _SectionHeading(title: 'About'),
                    const SizedBox(height: 8),
                    Text(
                      product.description!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        height: 1.6,
                      ),
                    ),
                  ],

                  // ── Offer description ───────────────────────────────────────
                  if (product.offerDescription != null) ...[
                    const SizedBox(height: 20),
                    _SectionHeading(title: 'Offer Details'),
                    const SizedBox(height: 8),
                    Text(
                      product.offerDescription!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        height: 1.6,
                      ),
                    ),
                  ],

                  // ── Validity ────────────────────────────────────────────────
                  if (product.formatExpiry != null) ...[
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFFFDE68A), width: 1.5),
                      ),
                      child: Row(
                        children: [
                          const Text('⏳', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Valid for ${product.formatExpiry}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF92400E),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // ── Terms & Conditions ──────────────────────────────────────
                  if (product.termsAndConditions != null && product.termsAndConditions!.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    _buildTermsSection(product),
                  ],

                  // ── Related Products ──────────────────────────────────────
                  const SizedBox(height: 20),
                  BlocBuilder<GiftCardsBloc, GiftCardsState>(
                    buildWhen: (prev, curr) =>
                        curr is RelatedProductsLoading || curr is RelatedProductsLoaded,
                    builder: (context, state) {
                      if (state is RelatedProductsLoaded && state.products.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'You Might Also Like',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF111827),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 180,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.products.length,
                                separatorBuilder: (_, __) => const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final rp = state.products[index];
                                  return RelatedProductCard(
                                    name: rp.relatedName,
                                    imageUrl: rp.thumbnailUrl ?? rp.mobileImageUrl,
                                    minPrice: rp.minPrice,
                                    maxPrice: rp.maxPrice,
                                    offerShortDesc: rp.offerShortDesc,
                                    currencySymbol: '₹',
                                    index: index,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Fixed bottom CTA ────────────────────────────────────────────────────
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          child: GestureDetector(
            onTap: _isAmountValid
                ? () => Navigator.pushNamed(
                      context,
                      '/gift-card-checkout',
                      arguments: {
                        'product': product,
                        'amount': _selectedAmount,
                        'themeSku': _selectedThemeSku,
                      },
                    )
                : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 58,
              decoration: BoxDecoration(
                color: _isAmountValid ? _accent : const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                _isAmountValid
                    ? 'Continue  •  ${product.currencySymbol ?? '₹'}${payable.toStringAsFixed(0)}'
                    : 'Select a Valid Amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _isAmountValid
                      ? Colors.white
                      : const Color(0xFFBBC0C9),
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }

  // ── Terms & Conditions ────────────────────────────────────────────────────

  Widget _buildTermsSection(GiftCardProductEntity product) {
    return StatefulBuilder(
      builder: (context, setInnerState) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF0F0F0), width: 1.5),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => setInnerState(() => _tcExpanded = !_tcExpanded),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.shield_outlined,
                          size: 18, color: Color(0xFF6B7280)),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Terms & Conditions',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF374151),
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: _tcExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(Icons.keyboard_arrow_down_rounded,
                            size: 22, color: Color(0xFF9CA3AF)),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox(width: double.infinity),
                secondChild: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    product.termsAndConditions!
                        .replaceAll(RegExp(r'<[^>]*>'), '\n')
                        .replaceAll(RegExp(r'\n{2,}'), '\n')
                        .trim(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                      height: 1.6,
                    ),
                  ),
                ),
                crossFadeState: _tcExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Hero ──────────────────────────────────────────────────────────────────

  Widget _buildHero(BuildContext context, GiftCardProductEntity product) {
    final topPad = MediaQuery.of(context).padding.top;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Back / share bar
          Padding(
            padding: EdgeInsets.fromLTRB(16, topPad + 8, 16, 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new_rounded,
                        size: 18, color: Color(0xFF374151)),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.ios_share_rounded,
                      size: 18, color: Color(0xFF374151)),
                ),
              ],
            ),
          ),

          // Product image in accent-tinted container
          Container(
            width: double.infinity,
            height: 200,
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(24),
            ),
            clipBehavior: Clip.antiAlias,
            child: product.imageUrl != null
                ? CachedNetworkImage(
                    imageUrl: product.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Center(
                      child: Icon(Icons.card_giftcard_rounded,
                          size: 56, color: _accent.withAlpha(80)),
                    ),
                    errorWidget: (_, __, ___) => Center(
                      child: Icon(Icons.card_giftcard_rounded,
                          size: 56, color: _accent.withAlpha(80)),
                    ),
                  )
                : Center(
                    child: Icon(Icons.card_giftcard_rounded,
                        size: 56, color: _accent.withAlpha(80)),
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Helper widgets ─────────────────────────────────────────────────────────────

class _StepButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool enabled;

  const _StepButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: enabled ? color.withAlpha(20) : const Color(0xFFF3F4F6),
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled ? color.withAlpha(80) : const Color(0xFFE5E7EB),
            width: 1.5,
          ),
        ),
        child: Icon(icon,
            size: 20, color: enabled ? color : const Color(0xFFD1D5DB)),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 15 : 13,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color:
                isBold ? const Color(0xFF111827) : const Color(0xFF6B7280),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 16 : 13,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            color: valueColor ?? const Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String title;
  const _SectionHeading({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Color(0xFF111827),
      ),
    );
  }
}
