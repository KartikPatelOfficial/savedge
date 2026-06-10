import 'package:flutter/material.dart';

import 'package:savedge/features/user_profile/presentation/theme/wallet_tokens.dart';
import 'package:savedge/shared/domain/entities/points.dart';

/// Premium ink hero card showing the SavEdge points balance, expiry status
/// and this month's earned/spent movement.
class WalletBalanceCard extends StatelessWidget {
  const WalletBalanceCard({
    super.key,
    required this.points,
    required this.monthEarned,
    required this.monthSpent,
  });

  final Points points;
  final int monthEarned;
  final int monthSpent;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WalletTokens.rHero),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [WalletTokens.ink, WalletTokens.inkDeep],
        ),
        boxShadow: WalletTokens.heroShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(WalletTokens.rHero),
        child: Stack(
          children: [
            // Violet glow, top-right — the single brand accent on the ink.
            Positioned(
              top: -90,
              right: -60,
              child: Container(
                width: 240,
                height: 240,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0x596F3FCC), Color(0x006F3FCC)],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -110,
              left: -80,
              child: Container(
                width: 260,
                height: 260,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0x269F7AEA), Color(0x009F7AEA)],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(WalletTokens.s6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: const Color(0x1AFFFFFF),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0x1FFFFFFF)),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: WalletTokens.onInk,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: WalletTokens.s3),
                      const Expanded(
                        child: Text(
                          'SAVEDGE POINTS',
                          style: WalletTokens.eyebrow,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _ExpiryPill(points: points),
                    ],
                  ),
                  const SizedBox(height: WalletTokens.s6),
                  const Text(
                    'Available balance',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: WalletTokens.onInkFaint,
                    ),
                  ),
                  const SizedBox(height: WalletTokens.s2),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: points.balance.toDouble()),
                    duration: reduceMotion
                        ? Duration.zero
                        : const Duration(milliseconds: 900),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) => Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Flexible(
                          child: Text(
                            WalletTokens.fmt(value.round()),
                            style: WalletTokens.balance,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: WalletTokens.s2),
                        const Text(
                          'pts',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: WalletTokens.onInkMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: WalletTokens.s5),
                  Container(height: 1, color: const Color(0x14FFFFFF)),
                  const SizedBox(height: WalletTokens.s4),
                  Row(
                    children: [
                      Expanded(
                        child: _MonthStat(
                          label: 'Earned this month',
                          value: monthEarned,
                          icon: Icons.arrow_upward_rounded,
                          // Light tints keep 4.5:1 contrast on the ink.
                          color: const Color(0xFF6EE7B7),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 32,
                        color: const Color(0x14FFFFFF),
                      ),
                      const SizedBox(width: WalletTokens.s4),
                      Expanded(
                        child: _MonthStat(
                          label: 'Spent this month',
                          value: monthSpent,
                          icon: Icons.arrow_downward_rounded,
                          color: const Color(0xFFFDA4AF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthStat extends StatelessWidget {
  const _MonthStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final int value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: WalletTokens.s1),
            Text(
              WalletTokens.fmt(value),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
                color: color,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: WalletTokens.onInkFaint,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _ExpiryPill extends StatelessWidget {
  const _ExpiryPill({required this.points});

  final Points points;

  @override
  Widget build(BuildContext context) {
    final urgent = points.isExpiringSoon;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: WalletTokens.s3,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: urgent ? const Color(0xFFFBBF24) : const Color(0x14FFFFFF),
        borderRadius: BorderRadius.circular(WalletTokens.rChip),
        border: urgent ? null : Border.all(color: const Color(0x1FFFFFFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            urgent ? Icons.hourglass_bottom_rounded : Icons.schedule_rounded,
            size: 12,
            color: urgent ? const Color(0xFF451A03) : WalletTokens.onInkMuted,
          ),
          const SizedBox(width: WalletTokens.s1),
          Text(
            _label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: urgent ? const Color(0xFF451A03) : WalletTokens.onInkMuted,
            ),
          ),
        ],
      ),
    );
  }

  String get _label {
    if (points.expirationDate == null) return 'No expiry';
    if (points.hasExpired) return 'Expired';
    final days = points.daysUntilExpiry;
    if (days == 0) return 'Expires today';
    if (days == 1) return 'Expires tomorrow';
    if (days <= 30) return 'Expires in ${days}d';
    final months = (days / 30).round();
    return 'Valid ~$months mo';
  }
}
