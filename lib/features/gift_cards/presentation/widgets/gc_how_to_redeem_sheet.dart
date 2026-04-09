import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/gc_tokens.dart';

class GcHowToRedeemSheet extends StatelessWidget {
  const GcHowToRedeemSheet({
    super.key,
    required this.brandName,
    this.brandUrl,
  });

  final String brandName;
  final String? brandUrl;

  static Future<void> show(
    BuildContext context, {
    required String brandName,
    String? brandUrl,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => GcHowToRedeemSheet(brandName: brandName, brandUrl: brandUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    final steps = <_RedeemStep>[
      _RedeemStep(
        title: 'Buy the gift card',
        body: 'Pick an amount and pay with Points or any online method.',
      ),
      _RedeemStep(
        title: 'Open My Gift Cards',
        body: 'Find your purchase under Account → My Gift Cards.',
      ),
      _RedeemStep(
        title: 'Reveal the code & PIN',
        body: 'Tap the card to reveal the code, PIN, and activation link.',
      ),
      _RedeemStep(
        title: 'Apply on the brand',
        body:
            'Enter the gift card code at checkout on $brandName to redeem your savings.',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: GcTokens.brandBlack,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(GcTokens.rSheet),
        ),
        border: Border.all(
          color: GcTokens.primary.withValues(alpha: 0.18),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'How to redeem your gift card',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Quick steps to use your $brandName gift card.',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.55),
                ),
              ),
              const SizedBox(height: 22),
              for (var i = 0; i < steps.length; i++) ...[
                _StepRow(index: i + 1, step: steps[i]),
                if (i < steps.length - 1) const SizedBox(height: 16),
              ],
              if (brandUrl != null && brandUrl!.isNotEmpty) ...[
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => launchUrl(
                      Uri.parse(brandUrl!),
                      mode: LaunchMode.externalApplication,
                    ),
                    icon: const Icon(
                      Icons.open_in_new_rounded,
                      size: 18,
                      color: GcTokens.brandBlack,
                    ),
                    label: Text(
                      'Open $brandName',
                      style: const TextStyle(
                        color: GcTokens.brandBlack,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GcTokens.brandLime,
                      foregroundColor: GcTokens.brandBlack,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(GcTokens.rPill),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _RedeemStep {
  const _RedeemStep({required this.title, required this.body});
  final String title;
  final String body;
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.index, required this.step});
  final int index;
  final _RedeemStep step;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: GcTokens.brandLime.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: GcTokens.brandLime.withValues(alpha: 0.45),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: GcTokens.brandLime,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                step.body,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: Colors.white.withValues(alpha: 0.65),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
