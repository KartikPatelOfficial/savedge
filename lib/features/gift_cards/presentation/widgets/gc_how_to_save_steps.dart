import 'package:flutter/material.dart';

import '../theme/gc_tokens.dart';

/// Two-step "How to save with SavEdge" card pair, modelled on the
/// reference design from competitor apps.
class GcHowToSaveSteps extends StatelessWidget {
  const GcHowToSaveSteps({super.key, this.accent = GcTokens.primary});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Step(
            number: '1',
            icon: Icons.local_offer_rounded,
            title: 'Buy voucher\nat a discount',
            accent: accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _Step(
            number: '2',
            icon: Icons.qr_code_scanner_rounded,
            title: "Apply on brand's\napp or website",
            accent: accent,
          ),
        ),
      ],
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({
    required this.number,
    required this.icon,
    required this.title,
    required this.accent,
  });

  final String number;
  final IconData icon;
  final String title;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        border: Border.all(color: accent.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Step $number',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: accent,
                  letterSpacing: 0.4,
                ),
              ),
              const Spacer(),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: accent),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: GcTokens.textPrimary,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
