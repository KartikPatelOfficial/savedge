import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:savedge/features/gift_cards/presentation/util/gc_html.dart';

import '../theme/gc_tokens.dart';

class GcHowToRedeemSheet extends StatelessWidget {
  const GcHowToRedeemSheet({
    super.key,
    required this.brandName,
    this.brandUrl,
    this.howToUse,
  });

  final String brandName;
  final String? brandUrl;

  /// Brand-specific redemption steps from Woohoo (may contain HTML).
  final String? howToUse;

  static Future<void> show(
    BuildContext context, {
    required String brandName,
    String? brandUrl,
    String? howToUse,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => GcHowToRedeemSheet(
        brandName: brandName,
        brandUrl: brandUrl,
        howToUse: howToUse,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // The card credentials always come from SavEdge the same way; only the
    // final "use it at the brand" part differs per card, so Woohoo's own
    // steps replace the generic last step when available.
    final brandLines =
        howToUse == null ? const <String>[] : gcHtmlToLines(howToUse!);

    final steps = <_RedeemStep>[
      const _RedeemStep(
        title: 'Buy the gift card',
        body: 'Pick an amount and pay with Points or any online method.',
      ),
      const _RedeemStep(
        title: 'Open My Gift Cards',
        body: 'Find your purchase under Account → My Gift Cards.',
      ),
      const _RedeemStep(
        title: 'Reveal the code & PIN',
        body: 'Tap the card to reveal the code, PIN, and activation link.',
      ),
      if (brandLines.isEmpty)
        _RedeemStep(
          title: 'Apply on the brand',
          body:
              'Enter the gift card code at checkout on $brandName to redeem your savings.',
        ),
    ];

    final maxHeight = MediaQuery.of(context).size.height * 0.85;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(GcTokens.rSheet),
        ),
        border: Border.all(
          color: GcTokens.border,
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
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
                      color: GcTokens.textTertiary.withValues(alpha: 0.25),
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
                    color: GcTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Quick steps to use your $brandName gift card.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: GcTokens.textTertiary,
                  ),
                ),
                const SizedBox(height: 22),
                for (var i = 0; i < steps.length; i++) ...[
                  _StepRow(index: i + 1, step: steps[i]),
                  if (i < steps.length - 1) const SizedBox(height: 16),
                ],
                if (brandLines.isNotEmpty) ...[
                  const SizedBox(height: 22),
                  Text(
                    'Redeem at $brandName',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: GcTokens.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Steps provided by the brand',
                    style: TextStyle(
                      fontSize: 12,
                      color: GcTokens.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (var i = 0; i < brandLines.length; i++) ...[
                    _BrandLine(text: brandLines[i]),
                    if (i < brandLines.length - 1) const SizedBox(height: 10),
                  ],
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
                        color: Colors.white,
                      ),
                      label: Text(
                        'Open $brandName',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
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
                    ),
                  ),
                ],
              ],
            ),
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
            color: GcTokens.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: GcTokens.primary.withValues(alpha: 0.22),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: GcTokens.primary,
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
                  color: GcTokens.textPrimary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                step.body,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.45,
                  color: GcTokens.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BrandLine extends StatelessWidget {
  const _BrandLine({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final content = text.replaceFirst(RegExp(r'^•\s*'), '');
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(top: 7, right: 12, left: 4),
          decoration: BoxDecoration(
            color: GcTokens.primary.withValues(alpha: 0.55),
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: GcTokens.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
