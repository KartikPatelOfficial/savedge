import 'package:flutter/material.dart';

import '../theme/gc_tokens.dart';

enum GcSort { relevance, discountDesc, priceAsc }

class GcSortFilterResult {
  const GcSortFilterResult({required this.sort, required this.minDiscount});
  final GcSort sort;
  final double minDiscount;
}

class GcSortFilterSheet extends StatefulWidget {
  const GcSortFilterSheet({
    super.key,
    required this.initialSort,
    required this.initialMinDiscount,
  });

  final GcSort initialSort;
  final double initialMinDiscount;

  static Future<GcSortFilterResult?> show(
    BuildContext context, {
    required GcSort sort,
    required double minDiscount,
  }) {
    return showModalBottomSheet<GcSortFilterResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => GcSortFilterSheet(
        initialSort: sort,
        initialMinDiscount: minDiscount,
      ),
    );
  }

  @override
  State<GcSortFilterSheet> createState() => _GcSortFilterSheetState();
}

class _GcSortFilterSheetState extends State<GcSortFilterSheet> {
  late GcSort _sort = widget.initialSort;
  late double _minDiscount = widget.initialMinDiscount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(GcTokens.rSheet),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E1F1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Sort',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: GcTokens.textTertiary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              _radio(GcSort.relevance, 'Relevance'),
              _radio(GcSort.discountDesc, 'Discount: High to Low'),
              _radio(GcSort.priceAsc, 'Price: Low to High'),
              const SizedBox(height: 18),
              const Text(
                'Minimum discount',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: GcTokens.textTertiary,
                  letterSpacing: 0.5,
                ),
              ),
              Slider(
                value: _minDiscount,
                onChanged: (v) => setState(() => _minDiscount = v),
                min: 0,
                max: 50,
                divisions: 10,
                label: '${_minDiscount.toStringAsFixed(0)}%+',
                activeColor: GcTokens.primary,
              ),
              Text(
                _minDiscount == 0
                    ? 'Show all gift cards'
                    : 'Only show ${_minDiscount.toStringAsFixed(0)}%+ off',
                style: const TextStyle(
                  fontSize: 12,
                  color: GcTokens.textSecondary,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          const GcSortFilterResult(
                            sort: GcSort.relevance,
                            minDiscount: 0,
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: GcTokens.textPrimary,
                        side: const BorderSide(color: Color(0xFFE5E1F1)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(GcTokens.rPill),
                        ),
                      ),
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(
                        context,
                        GcSortFilterResult(
                          sort: _sort,
                          minDiscount: _minDiscount,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: GcTokens.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(GcTokens.rPill),
                        ),
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
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

  Widget _radio(GcSort value, String label) {
    return RadioListTile<GcSort>(
      contentPadding: EdgeInsets.zero,
      dense: true,
      value: value,
      groupValue: _sort,
      activeColor: GcTokens.primary,
      onChanged: (v) => setState(() => _sort = v ?? GcSort.relevance),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: GcTokens.textPrimary,
        ),
      ),
    );
  }
}
