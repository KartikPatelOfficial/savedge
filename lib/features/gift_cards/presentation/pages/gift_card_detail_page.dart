import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/injection/injection.dart';

import '../../data/services/gift_card_favorites_service.dart';
import '../../data/services/gift_card_recently_viewed_service.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../bloc/gift_cards_bloc.dart';
import '../theme/gc_tokens.dart';
import '../widgets/gc_amount_chip_picker.dart';
import '../widgets/gc_how_to_redeem_sheet.dart';
import '../widgets/gc_how_to_save_steps.dart';
import '../widgets/gc_palette_extractor.dart';
import '../widgets/gc_terms_bottom_sheet.dart';
import '../widgets/related_product_card.dart';

class GiftCardDetailPage extends StatefulWidget {
  const GiftCardDetailPage({super.key, required this.product});

  final GiftCardProductEntity product;

  @override
  State<GiftCardDetailPage> createState() => _GiftCardDetailPageState();
}

class _GiftCardDetailPageState extends State<GiftCardDetailPage> {
  late final GiftCardsBloc _bloc;
  late final TextEditingController _amountController;
  late double _selectedAmount;
  String? _selectedThemeSku;

  late final GiftCardFavoritesService _favorites;

  GiftCardProductEntity get _p => widget.product;
  Color _accent = GcTokens.primary;

  String get _currency => _p.currencySymbol ?? '\u20B9';
  String? get _heroImage => _p.heroImageUrl;
  bool get _hasImage =>
      _heroImage != null && _heroImage!.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _favorites = getIt<GiftCardFavoritesService>();
    _bloc = getIt<GiftCardsBloc>()..add(LoadRelatedProducts(productId: _p.id));

    final denoms = _denominations();
    _selectedAmount = denoms.isNotEmpty ? denoms.first : _p.minPrice;
    _amountController = TextEditingController(
      text: _selectedAmount.toStringAsFixed(0),
    );
    _selectedThemeSku = _p.themes.isNotEmpty ? _p.themes.first.sku : null;

    _accent = GcTokens.accentFor(_p.id);
    _resolvePalette();

    getIt<GiftCardRecentlyViewedService>().record(_p.id);
  }

  Future<void> _resolvePalette() async {
    final picked = await GcPaletteExtractor.resolve(_heroImage, _accent);
    if (mounted && picked != _accent) setState(() => _accent = picked);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _bloc.close();
    super.dispose();
  }

  List<double> _denominations() {
    if (_p.parsedDenominations.isNotEmpty) return _p.parsedDenominations;
    final raw = _p.denominations?.trim();
    if (raw == null || raw.isEmpty) return const [];
    try {
      if (raw.startsWith('[')) {
        final list = List<dynamic>.from(jsonDecode(raw) as List);
        final out = list
            .map((v) => double.tryParse(v.toString()) ?? 0)
            .where((d) => d > 0)
            .toList()
          ..sort();
        return out;
      }
    } catch (_) {}
    return raw
        .split(RegExp('[,\\s]+'))
        .map((s) => double.tryParse(s) ?? 0)
        .where((d) => d > 0)
        .toList()
      ..sort();
  }

  bool get _isAmountValid {
    if (_p.priceType.toUpperCase() == 'SLAB') {
      return _denominations().contains(_selectedAmount);
    }
    return _selectedAmount >= _p.minPrice && _selectedAmount <= _p.maxPrice;
  }

  void _onPickAmount(double v) {
    setState(() {
      _selectedAmount = v;
      _amountController.text = v.toStringAsFixed(0);
    });
  }

  void _proceed() {
    if (!_isAmountValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please pick a valid amount')),
      );
      return;
    }
    Navigator.pushNamed(
      context,
      '/gift-card-checkout',
      arguments: <String, dynamic>{
        'product': _p,
        'amount': _selectedAmount,
        'themeSku': _selectedThemeSku,
      },
    );
  }

  void _shareProduct() {
    Clipboard.setData(
      ClipboardData(
        text: 'Check out the ${_p.brandName ?? _p.name} gift card on SavEdge!',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link copied to clipboard')),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: SafeArea(
          top: false,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              _heroBox(),
              _brandCard(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                child: GcHowToSaveSteps(accent: _accent),
              ),
              _amountSection(),
              if (_p.themes.length > 1) _themesSection(),
              _infoButtons(),
              _relatedSection(),
              _issuedByFooter(),
            ],
          ),
        ),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleSpacing: 0,
      title: const SizedBox.shrink(),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: GcTokens.textPrimary,
        ),
      ),
      actions: [
        AnimatedBuilder(
          animation: _favorites,
          builder: (context, _) {
            final fav = _favorites.isFavorite(_p.id);
            return IconButton(
              onPressed: () => _favorites.toggle(_p.id),
              icon: Icon(
                fav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: fav ? Colors.redAccent : GcTokens.textPrimary,
                size: 20,
              ),
            );
          },
        ),
        IconButton(
          onPressed: _shareProduct,
          icon: const Icon(
            Icons.share_rounded,
            color: GcTokens.textPrimary,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _heroBox() {
    return Container(
      height: 220,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_accent, _accent.withValues(alpha: 0.70)],
        ),
        borderRadius: BorderRadius.circular(GcTokens.rHero),
      ),
      padding: const EdgeInsets.all(28),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(GcTokens.rCard),
          ),
          padding: const EdgeInsets.all(18),
          alignment: Alignment.center,
          child: _hasImage
              ? CachedNetworkImage(
                  imageUrl: _heroImage!,
                  fit: BoxFit.contain,
                  placeholder: (_, __) => _p.blurHash != null
                      ? BlurHash(hash: _p.blurHash!)
                      : _heroFallback(),
                  errorWidget: (_, __, ___) => _heroFallback(),
                )
              : _heroFallback(),
        ),
      ),
    );
  }

  Widget _heroFallback() {
    return Center(
      child: Text(
        _p.brandName ?? _p.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: _accent,
          fontWeight: FontWeight.w900,
          fontSize: 22,
        ),
      ),
    );
  }

  Widget _brandCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + discount badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  _p.brandName ?? _p.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: GcTokens.textPrimary,
                    height: 1.2,
                  ),
                ),
              ),
              if (_p.hasDiscount) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF059669), Color(0xFF10B981)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${(_p.discountPercentage ?? 0).toStringAsFixed(0)}%',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          // Expiry
          if (_p.formatExpiry != null && _p.formatExpiry!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.schedule_rounded,
                  size: 13,
                  color: GcTokens.textTertiary,
                ),
                const SizedBox(width: 5),
                Text(
                  _p.formatExpiry!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: GcTokens.textTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
          // Offer description chip
          if (_p.offerDescription != null &&
              _p.offerDescription!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.local_offer_rounded, size: 16, color: _accent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _p.offerDescription!,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          // Description (inline, no separate card)
          if (_p.description != null && _p.description!.trim().isNotEmpty) ...[
            const SizedBox(height: 14),
            Text(
              _p.description!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                color: GcTokens.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _amountSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        border: Border.all(color: const Color(0xFFEFEAFB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose amount',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: GcTokens.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          GcAmountChipPicker(
            priceType: _p.priceType,
            minPrice: _p.minPrice,
            maxPrice: _p.maxPrice,
            denominations: _denominations(),
            selected: _selectedAmount,
            onChanged: _onPickAmount,
            controller: _amountController,
            accent: _accent,
            currencySymbol: _currency,
            discountPercentage: _p.discountPercentage,
          ),
        ],
      ),
    );
  }

  Widget _themesSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        border: Border.all(color: const Color(0xFFEFEAFB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Card design',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: GcTokens.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 88,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _p.themes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, i) {
                final t = _p.themes[i];
                final selected = t.sku == _selectedThemeSku;
                final hasImg = t.image != null && t.image!.isNotEmpty;
                return GestureDetector(
                  onTap: () => setState(() => _selectedThemeSku = t.sku),
                  child: Container(
                    width: 132,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected ? _accent : const Color(0xFFE5E1F1),
                        width: selected ? 2 : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(11),
                      child: hasImg
                          ? CachedNetworkImage(
                              imageUrl: t.image!,
                              fit: BoxFit.cover,
                              placeholder: (_, __) => _themeFallback(t),
                              errorWidget: (_, __, ___) => _themeFallback(t),
                            )
                          : _themeFallback(t),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _themeFallback(GiftCardThemeEntity t) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _accent.withValues(alpha: 0.18),
            _accent.withValues(alpha: 0.06),
          ],
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.card_giftcard_rounded, size: 24, color: _accent),
          const SizedBox(height: 4),
          Text(
            t.name ?? t.sku,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: _accent,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoButtons() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _infoTile(
                icon: Icons.menu_book_rounded,
                label: 'How to redeem',
                onTap: () => GcHowToRedeemSheet.show(
                  context,
                  brandName: _p.brandName ?? _p.name,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _infoTile(
                icon: Icons.gavel_rounded,
                label: 'Terms & Conditions',
                onTap: () => GcTermsBottomSheet.show(
                  context,
                  brandName: _p.brandName ?? _p.name,
                  terms: _p.termsAndConditions,
                  termsUrl: _p.termsAndConditionsUrl,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(GcTokens.rCard),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(GcTokens.rCard),
            border: Border.all(color: const Color(0xFFEFEAFB)),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: _accent),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: GcTokens.textPrimary,
                    height: 1.2,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: GcTokens.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _relatedSection() {
    return BlocBuilder<GiftCardsBloc, GiftCardsState>(
      buildWhen: (_, s) =>
          s is RelatedProductsLoaded ||
          s is RelatedProductsLoading ||
          s is RelatedProductsError,
      builder: (context, state) {
        if (state is! RelatedProductsLoaded || state.products.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.only(top: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  'You might also like',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: GcTokens.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.products.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (_, i) {
                    final r = state.products[i];
                    return SizedBox(
                      width: 150,
                      child: RelatedProductCard(
                        name: r.relatedName,
                        imageUrl: r.mobileImageUrl ?? r.thumbnailUrl,
                        minPrice: r.minPrice,
                        maxPrice: r.maxPrice,
                        offerShortDesc: r.offerShortDesc,
                        currencySymbol: r.currencyCode == 'INR'
                            ? '\u20B9'
                            : r.currencyCode,
                        index: i,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _issuedByFooter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.verified_rounded,
            size: 14,
            color: GcTokens.textTertiary.withValues(alpha: 0.6),
          ),
          const SizedBox(width: 6),
          Text(
            'Issued by Qwikcilver Solutions Pvt. Ltd.',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: GcTokens.textTertiary.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomBar() {
    final discount = _p.calculateDiscount(_selectedAmount);
    final payable = _p.calculatePayable(_selectedAmount);
    return Material(
      color: Colors.white,
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.10),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_p.hasDiscount)
                      Text(
                        'You save $_currency${discount.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF059669),
                        ),
                      ),
                    Text(
                      '$_currency${payable.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: GcTokens.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _isAmountValid ? _proceed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  disabledBackgroundColor: const Color(0xFFE5E1F1),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(GcTokens.rPill),
                  ),
                ),
                child: const Text(
                  'Proceed to Pay',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
