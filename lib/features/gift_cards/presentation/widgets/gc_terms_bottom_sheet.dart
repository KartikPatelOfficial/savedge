import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/gc_tokens.dart';

class GcTermsBottomSheet extends StatelessWidget {
  const GcTermsBottomSheet({
    super.key,
    required this.brandName,
    this.terms,
    this.termsUrl,
  });

  final String brandName;
  final String? terms;
  final String? termsUrl;

  static Future<void> show(
    BuildContext context, {
    required String brandName,
    String? terms,
    String? termsUrl,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => GcTermsBottomSheet(
        brandName: brandName,
        terms: terms,
        termsUrl: termsUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasContent = (terms != null && terms!.trim().isNotEmpty);
    return DraggableScrollableSheet(
      initialChildSize: 0.78,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(GcTokens.rSheet),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E1F1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: GcTokens.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                children: [
                  Text(
                    brandName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: GcTokens.textTertiary,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (hasContent)
                    Text(
                      terms!,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.55,
                        color: GcTokens.textSecondary,
                      ),
                    )
                  else
                    const Text(
                      'Detailed terms are not available offline. Use the link '
                      'below to view the full terms on the brand site.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.55,
                        color: GcTokens.textTertiary,
                      ),
                    ),
                  if (termsUrl != null && termsUrl!.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    OutlinedButton.icon(
                      onPressed: () => launchUrl(
                        Uri.parse(termsUrl!),
                        mode: LaunchMode.externalApplication,
                      ),
                      icon: const Icon(Icons.open_in_new_rounded, size: 18),
                      label: const Text('View full T&C'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: GcTokens.primary,
                        side: const BorderSide(color: GcTokens.primary),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(GcTokens.rPill),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
