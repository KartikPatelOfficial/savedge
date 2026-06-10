import 'package:flutter/material.dart';

import 'package:savedge/features/user_profile/presentation/theme/wallet_tokens.dart';
import 'package:savedge/shared/domain/entities/points.dart';

/// Amber call-out shown only when the balance is about to lapse.
class WalletExpiryBanner extends StatelessWidget {
  const WalletExpiryBanner({super.key, required this.points});

  final Points points;

  @override
  Widget build(BuildContext context) {
    final days = points.daysUntilExpiry;
    final when = days <= 0
        ? 'today'
        : days == 1
        ? 'tomorrow'
        : 'in $days days';

    return Container(
      padding: const EdgeInsets.all(WalletTokens.s4),
      decoration: BoxDecoration(
        color: WalletTokens.warnSoft,
        borderRadius: BorderRadius.circular(WalletTokens.rCard),
        border: Border.all(color: WalletTokens.warnBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.hourglass_bottom_rounded,
            color: WalletTokens.warn,
            size: 20,
          ),
          const SizedBox(width: WalletTokens.s3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Points expiring soon',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: WalletTokens.warn,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Your balance of ${WalletTokens.fmt(points.balance)} pts '
                  'expires $when. Redeem an offer before then.',
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: WalletTokens.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// "This month" earned-vs-spent summary with an all-time footer. Replaces
/// the old four-card stats grid.
class WalletSummaryCard extends StatelessWidget {
  const WalletSummaryCard({
    super.key,
    required this.monthLabel,
    required this.monthEarned,
    required this.monthSpent,
    required this.lifetimeEarned,
    required this.lifetimeSpent,
  });

  final String monthLabel;
  final int monthEarned;
  final int monthSpent;
  final int lifetimeEarned;
  final int lifetimeSpent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(WalletTokens.s5),
      decoration: BoxDecoration(
        color: WalletTokens.surface,
        borderRadius: BorderRadius.circular(WalletTokens.rCard),
        border: Border.all(color: WalletTokens.border),
        boxShadow: WalletTokens.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text('This month', style: WalletTokens.sectionTitle),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: WalletTokens.s3,
                  vertical: WalletTokens.s1,
                ),
                decoration: BoxDecoration(
                  color: WalletTokens.primarySoft,
                  borderRadius: BorderRadius.circular(WalletTokens.rChip),
                ),
                child: Text(
                  monthLabel,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: WalletTokens.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: WalletTokens.s4),
          Row(
            children: [
              Expanded(
                child: _SummaryStat(
                  label: 'Earned',
                  value: monthEarned,
                  color: WalletTokens.credit,
                  icon: Icons.north_east_rounded,
                ),
              ),
              Expanded(
                child: _SummaryStat(
                  label: 'Spent',
                  value: monthSpent,
                  color: WalletTokens.debit,
                  icon: Icons.south_west_rounded,
                ),
              ),
            ],
          ),
          if (monthEarned > 0 || monthSpent > 0) ...[
            const SizedBox(height: WalletTokens.s4),
            ClipRRect(
              borderRadius: BorderRadius.circular(WalletTokens.rChip),
              child: SizedBox(
                height: 6,
                child: Row(
                  children: [
                    if (monthEarned > 0)
                      Expanded(
                        flex: monthEarned,
                        child: const ColoredBox(color: WalletTokens.credit),
                      ),
                    if (monthEarned > 0 && monthSpent > 0)
                      const SizedBox(width: 2),
                    if (monthSpent > 0)
                      Expanded(
                        flex: monthSpent,
                        child: const ColoredBox(color: WalletTokens.debit),
                      ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: WalletTokens.s4),
          Container(height: 1, color: WalletTokens.divider),
          const SizedBox(height: WalletTokens.s3),
          Text(
            'All time  ·  ${WalletTokens.fmt(lifetimeEarned)} earned  ·  '
            '${WalletTokens.fmt(lifetimeSpent)} spent',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: WalletTokens.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  const _SummaryStat({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String label;
  final int value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: WalletTokens.s3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(WalletTokens.fmt(value), style: WalletTokens.statValue),
              Text(label, style: WalletTokens.statLabel),
            ],
          ),
        ),
      ],
    );
  }
}
