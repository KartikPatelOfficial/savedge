import 'package:flutter/material.dart';

import '../theme/gc_tokens.dart';

class GcPriceBreakdownCard extends StatelessWidget {
  const GcPriceBreakdownCard({
    super.key,
    required this.amount,
    required this.discountPercentage,
    required this.discountAmount,
    required this.pointsDiscount,
    required this.totalPayable,
    required this.currencySymbol,
    this.quantity = 1,
    this.accent = GcTokens.primary,
  });

  final double amount;
  final double discountPercentage;
  final double discountAmount;
  final double pointsDiscount;
  final double totalPayable;
  final String currencySymbol;
  final int quantity;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        border: Border.all(color: const Color(0xFFEFEAFB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bill summary',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: GcTokens.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          _row(
            quantity > 1
                ? 'Voucher value ($currencySymbol${amount.toStringAsFixed(0)} × $quantity)'
                : 'Voucher value',
            '$currencySymbol${(amount * quantity).toStringAsFixed(0)}',
          ),
          if (discountAmount > 0) ...[
            const SizedBox(height: 8),
            _row(
              'Discount (${discountPercentage.toStringAsFixed(0)}%)',
              '-$currencySymbol${discountAmount.toStringAsFixed(0)}',
              valueColor: GcTokens.success,
            ),
          ],
          if (pointsDiscount > 0) ...[
            const SizedBox(height: 8),
            _row(
              'Saved with Points',
              '-$currencySymbol${pointsDiscount.toStringAsFixed(0)}',
              valueColor: GcTokens.success,
            ),
          ],
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: DashedDivider(),
          ),
          _row(
            'Total to pay',
            '$currencySymbol${totalPayable.toStringAsFixed(0)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _row(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 15 : 13.5,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w600,
            color: isBold ? GcTokens.textPrimary : GcTokens.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 16 : 13.5,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w800,
            color: valueColor ??
                (isBold ? accent : GcTokens.textPrimary),
          ),
        ),
      ],
    );
  }
}

class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        const dashWidth = 4.0;
        const dashSpace = 4.0;
        final count = (c.constrainWidth() / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            count,
            (_) => const SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFFE5E1F1)),
              ),
            ),
          ).expand((d) => [d, const SizedBox(width: dashSpace)]).toList(),
        );
      },
    );
  }
}
