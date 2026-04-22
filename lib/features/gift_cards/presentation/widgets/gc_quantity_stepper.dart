import 'package:flutter/material.dart';

import '../theme/gc_tokens.dart';

class GcQuantityStepper extends StatelessWidget {
  const GcQuantityStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 5,
    this.accent = GcTokens.primary,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final canDec = value > min;
    final canInc = value < max;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        border: Border.all(color: const Color(0xFFEFEAFB)),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quantity',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: GcTokens.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Up to 5 per order',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: GcTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          _IconBtn(
            icon: Icons.remove_rounded,
            enabled: canDec,
            accent: accent,
            onTap: canDec ? () => onChanged(value - 1) : null,
          ),
          SizedBox(
            width: 40,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: GcTokens.textPrimary,
              ),
            ),
          ),
          _IconBtn(
            icon: Icons.add_rounded,
            enabled: canInc,
            accent: accent,
            onTap: canInc ? () => onChanged(value + 1) : null,
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  const _IconBtn({
    required this.icon,
    required this.enabled,
    required this.accent,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final Color accent;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = enabled ? accent.withValues(alpha: 0.12) : const Color(0xFFF2F0F8);
    final fg = enabled ? accent : const Color(0xFFB9B4C9);

    return Material(
      color: bg,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, size: 20, color: fg),
        ),
      ),
    );
  }
}
