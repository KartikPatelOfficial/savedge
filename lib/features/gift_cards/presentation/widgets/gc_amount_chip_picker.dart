import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/gc_tokens.dart';

/// Amount selector. SLAB → chips only. RANGE → prominent amount display
/// with stepper, range caption, and quick-pick chips clamped to [min, max].
class GcAmountChipPicker extends StatelessWidget {
  const GcAmountChipPicker({
    super.key,
    required this.priceType,
    required this.minPrice,
    required this.maxPrice,
    required this.denominations,
    required this.selected,
    required this.onChanged,
    required this.controller,
    this.accent = GcTokens.primary,
    this.currencySymbol = '\u20B9',
    this.discountPercentage,
  });

  final String priceType;
  final double minPrice;
  final double maxPrice;
  final List<double> denominations;
  final double selected;
  final ValueChanged<double> onChanged;
  final TextEditingController controller;
  final Color accent;
  final String currencySymbol;
  final double? discountPercentage;

  bool get _hasDiscount =>
      discountPercentage != null && discountPercentage! > 0;
  double get _discountAmount =>
      _hasDiscount ? selected * discountPercentage! / 100 : 0;
  double get _payable => selected - _discountAmount;

  bool get _isSlab => priceType.toUpperCase() == 'SLAB';

  /// Conventional round amounts a real user would actually pick.
  static const _conventional = <double>[
    100,
    250,
    500,
    1000,
    2000,
    3000,
    5000,
    10000,
    15000,
    25000,
    50000,
  ];

  List<double> get _chips {
    if (_isSlab) return denominations;
    if (maxPrice <= minPrice) return [minPrice];
    final inRange =
        _conventional.where((v) => v >= minPrice && v <= maxPrice).toList();
    // Always anchor min and max so the user can reach the extremes in one tap.
    final set = <double>{minPrice, ...inRange, maxPrice}.toList()..sort();
    // Cap to 6 entries — keep the row compact.
    if (set.length <= 6) return set;
    final picked = <double>{set.first, set.last};
    final step = (set.length - 1) / 5;
    for (var i = 1; i < 5; i++) {
      picked.add(set[(i * step).round()]);
    }
    final out = picked.toList()..sort();
    return out;
  }

  @override
  Widget build(BuildContext context) {
    if (_isSlab) {
      return Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          for (final amt in _chips)
            _Chip(
              label: '$currencySymbol${amt.toStringAsFixed(0)}',
              selected: amt == selected,
              accent: accent,
              onTap: () => onChanged(amt),
            ),
        ],
      );
    }

    // RANGE — minimal display + editable input + chips.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                accent.withValues(alpha: 0.07),
                accent.withValues(alpha: 0.01),
              ],
            ),
            borderRadius: BorderRadius.circular(GcTokens.rCard),
          ),
          child: Column(
            children: [
              const Text(
                'YOU\'RE BUYING',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: GcTokens.textTertiary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      currencySymbol,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: accent,
                        height: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IntrinsicWidth(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 60,
                        maxWidth: 200,
                      ),
                      child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        cursorColor: accent,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w900,
                          color: GcTokens.textPrimary,
                          height: 1.0,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: '0',
                        ),
                        onChanged: (raw) {
                          final v = double.tryParse(raw) ?? 0;
                          onChanged(v);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'Between $currencySymbol${minPrice.toStringAsFixed(0)} and $currencySymbol${maxPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 11.5,
                  color: GcTokens.textTertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (_hasDiscount) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF059669).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(GcTokens.rPill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.savings_rounded,
                        size: 14,
                        color: Color(0xFF059669),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'You save $currencySymbol${_discountAmount.toStringAsFixed(0)}  ·  Pay $currencySymbol${_payable.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF059669),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'POPULAR AMOUNTS',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
            color: GcTokens.textTertiary,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final amt in _chips)
              _Chip(
                label: '$currencySymbol${amt.toStringAsFixed(0)}',
                selected: amt == selected,
                accent: accent,
                onTap: () {
                  onChanged(amt);
                  controller.text = amt.toStringAsFixed(0);
                },
              ),
          ],
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.accent,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(GcTokens.rPill),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          decoration: BoxDecoration(
            gradient: selected
                ? LinearGradient(colors: [accent, accent.withValues(alpha: 0.78)])
                : null,
            color: selected ? null : Colors.white,
            borderRadius: BorderRadius.circular(GcTokens.rPill),
            border: Border.all(
              color: selected ? accent : const Color(0xFFE5E1F1),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: selected ? Colors.white : GcTokens.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

