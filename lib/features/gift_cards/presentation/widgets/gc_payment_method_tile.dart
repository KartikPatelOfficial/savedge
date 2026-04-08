import 'package:flutter/material.dart';

import '../theme/gc_tokens.dart';

class GcPaymentMethodTile extends StatelessWidget {
  const GcPaymentMethodTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
    this.disabled = false,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final bool disabled;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.55 : 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: disabled ? null : onTap,
          borderRadius: BorderRadius.circular(GcTokens.rCard),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
            decoration: BoxDecoration(
              color: selected
                  ? GcTokens.primary.withValues(alpha: 0.06)
                  : Colors.white,
              borderRadius: BorderRadius.circular(GcTokens.rCard),
              border: Border.all(
                color: selected
                    ? GcTokens.primary
                    : const Color(0xFFEFEAFB),
                width: selected ? 1.6 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: GcTokens.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: GcTokens.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                          color: GcTokens.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: GcTokens.textTertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (trailing != null)
                  trailing!
                else
                  Icon(
                    selected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: selected
                        ? GcTokens.primary
                        : GcTokens.textTertiary,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
