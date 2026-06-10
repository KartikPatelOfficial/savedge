import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:savedge/features/points_payment/data/models/points_payment_models.dart';
import 'package:savedge/features/user_profile/presentation/theme/wallet_tokens.dart';
import 'package:savedge/shared/domain/entities/points.dart';

/// Premium ink hero card for the points wallet.
///
/// The front face carries the SavEdge balance with a one-line meal points
/// summary; tapping flips the card to a detailed per-bucket breakdown.
class WalletBalanceCard extends StatefulWidget {
  const WalletBalanceCard({
    super.key,
    required this.points,
    required this.monthEarned,
    required this.monthSpent,
    this.balance,
  });

  final Points points;
  final int monthEarned;
  final int monthSpent;

  /// Per-bucket balance detail (SavEdge + meal). When null the meal summary
  /// line is hidden and the back falls back to this month's movement.
  final UserPointsBalanceResponse? balance;

  @override
  State<WalletBalanceCard> createState() => _WalletBalanceCardState();
}

class _WalletBalanceCardState extends State<WalletBalanceCard>
    with SingleTickerProviderStateMixin {
  static const _flipDuration = Duration(milliseconds: 550);

  late final AnimationController _flip = AnimationController(
    vsync: this,
    duration: _flipDuration,
  );
  late final Animation<double> _angle = CurvedAnimation(
    parent: _flip,
    curve: Curves.easeInOutCubic,
  );

  @override
  void dispose() {
    _flip.dispose();
    super.dispose();
  }

  void _toggle() {
    _flip.duration = MediaQuery.of(context).disableAnimations
        ? Duration.zero
        : _flipDuration;
    if (_flip.status == AnimationStatus.forward ||
        _flip.status == AnimationStatus.completed) {
      _flip.reverse();
    } else {
      _flip.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final front = _CardShell(
      hint: 'Tap to see breakdown',
      child: _FrontFace(
        points: widget.points,
        monthEarned: widget.monthEarned,
        monthSpent: widget.monthSpent,
        mealPoints: widget.balance?.mealAvailablePoints ?? 0,
      ),
    );
    final back = _CardShell(
      hint: 'Tap to flip back',
      child: _BackFace(
        points: widget.points,
        balance: widget.balance,
        monthEarned: widget.monthEarned,
        monthSpent: widget.monthSpent,
      ),
    );

    return Semantics(
      button: true,
      label: 'Points card. Double tap to flip for the detailed breakdown.',
      child: GestureDetector(
        onTap: _toggle,
        child: AnimatedBuilder(
          animation: _angle,
          builder: (context, _) {
            final angle = _angle.value * math.pi;
            final showBack = angle > math.pi / 2;
            return Stack(
              children: [
                // Invisible copies of both faces size the Stack to the taller
                // one, so the card height never jumps mid-flip.
                ExcludeSemantics(
                  child: IgnorePointer(
                    child: Opacity(opacity: 0, child: front),
                  ),
                ),
                ExcludeSemantics(
                  child: IgnorePointer(child: Opacity(opacity: 0, child: back)),
                ),
                Positioned.fill(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0012)
                      ..rotateY(angle),
                    child: showBack
                        ? Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..rotateY(math.pi),
                            child: back,
                          )
                        : front,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Shared ink surface for both faces: gradient, glows and the flip hint
/// pinned to the bottom edge.
class _CardShell extends StatelessWidget {
  const _CardShell({required this.hint, required this.child});

  final String hint;
  final Widget child;

  @override
  Widget build(BuildContext context) {
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
                    colors: [
                      WalletTokens.glowPrimary,
                      WalletTokens.glowPrimaryEnd,
                    ],
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
                    colors: [
                      WalletTokens.glowSecondary,
                      WalletTokens.glowSecondaryEnd,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                WalletTokens.s6,
                WalletTokens.s6,
                WalletTokens.s6,
                WalletTokens.s6 + 18,
              ),
              child: child,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Text(
                hint,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                  color: WalletTokens.onInkFaint,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FrontFace extends StatelessWidget {
  const _FrontFace({
    required this.points,
    required this.monthEarned,
    required this.monthSpent,
    required this.mealPoints,
  });

  final Points points;
  final int monthEarned;
  final int monthSpent;
  final int mealPoints;

  /// Gift bucket derived from the displayed total so the equation under the
  /// hero number always adds up on screen.
  int get giftPoints => math.max(0, points.balance - mealPoints);

  static TextStyle _bucketValue(Color color) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.2,
    color: color,
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _LogoMark(),
            _ExpiryPill(points: points),
          ],
        ),
        const SizedBox(height: WalletTokens.s6),
        const Text(
          'SavEdge points',
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
        // Bucket equation — the hero number is the total, so spell out
        // what it's made of: meal + gift. Quiet text, not a second balance.
        if (mealPoints > 0) ...[
          const SizedBox(height: WalletTokens.s3),
          Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: WalletTokens.onInkFaint,
              ),
              children: [
                TextSpan(
                  text: WalletTokens.fmt(mealPoints),
                  style: _bucketValue(WalletTokens.mealOnInk),
                ),
                const TextSpan(text: ' Meal  +  '),
                TextSpan(
                  text: WalletTokens.fmt(giftPoints),
                  style: _bucketValue(WalletTokens.secondary),
                ),
                const TextSpan(text: ' Gift'),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(height: WalletTokens.s5),
        Container(height: 1, color: WalletTokens.inkHairline),
        const SizedBox(height: WalletTokens.s4),
        Row(
          children: [
            Expanded(
              child: _MonthStat(
                label: 'Earned this month',
                value: monthEarned,
                icon: Icons.arrow_upward_rounded,
                color: WalletTokens.creditOnInk,
              ),
            ),
            const SizedBox(width: WalletTokens.s4),
            Container(width: 1, height: 32, color: WalletTokens.inkHairline),
            const SizedBox(width: WalletTokens.s4),
            Expanded(
              child: _MonthStat(
                label: 'Spent this month',
                value: monthSpent,
                icon: Icons.arrow_downward_rounded,
                color: WalletTokens.debitOnInk,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Detailed per-bucket breakdown shown when the card is flipped.
class _BackFace extends StatelessWidget {
  const _BackFace({
    required this.points,
    required this.balance,
    required this.monthEarned,
    required this.monthSpent,
  });

  final Points points;
  final UserPointsBalanceResponse? balance;
  final int monthEarned;
  final int monthSpent;

  @override
  Widget build(BuildContext context) {
    final b = balance;
    final hasMeal =
        b != null &&
        (b.mealAvailablePoints > 0 ||
            b.mealUsedPoints > 0 ||
            b.mealExpiringPoints > 0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('POINTS BREAKDOWN', style: WalletTokens.eyebrow),
        const SizedBox(height: WalletTokens.s5),
        _BreakdownRow('Total available', points.balance),
        if (b != null) ...[
          const SizedBox(height: WalletTokens.s3),
          Container(height: 1, color: WalletTokens.inkHairline),
          const SizedBox(height: WalletTokens.s3),
          const _SectionLabel('Gift points', WalletTokens.secondary),
          const SizedBox(height: WalletTokens.s2),
          _BreakdownRow('Available', b.availablePoints),
          _BreakdownRow('Expiring in 30 days', b.expiringPoints),
          _BreakdownRow('Spent all-time', b.usedPoints),
        ] else ...[
          _BreakdownRow('Earned this month', monthEarned),
          _BreakdownRow('Spent this month', monthSpent),
        ],
        if (hasMeal) ...[
          const SizedBox(height: WalletTokens.s3),
          Container(height: 1, color: WalletTokens.inkHairline),
          const SizedBox(height: WalletTokens.s3),
          const _SectionLabel('Meal points', WalletTokens.mealOnInk),
          const SizedBox(height: WalletTokens.s2),
          _BreakdownRow('Available', b.mealAvailablePoints),
          _BreakdownRow('Expiring in 30 days', b.mealExpiringPoints),
          _BreakdownRow('Spent all-time', b.mealUsedPoints),
          const SizedBox(height: WalletTokens.s2),
          const Text(
            'Meal points can be spent only at participating vendors.',
            style: TextStyle(
              fontSize: 11,
              height: 1.4,
              color: WalletTokens.onInkFaint,
            ),
          ),
        ],
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text, this.color);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow(this.label, this.value);

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: WalletTokens.onInkMuted,
              ),
            ),
          ),
          const SizedBox(width: WalletTokens.s3),
          Text(
            '${WalletTokens.fmt(value)} pts',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.2,
              color: WalletTokens.onInk,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

/// SavEdge infinity mark rendered straight on the ink — the transparent
/// logo asset cropped to its top portion so the wordmark underneath is cut
/// away. The green mark carries enough contrast on the dark card; the
/// natural aspect ratio is preserved via [BoxFit.contain].
class _LogoMark extends StatelessWidget {
  const _LogoMark();

  static const double _height = 32;

  /// Fraction of the asset's height occupied by the mark; the wordmark
  /// below this line is clipped off.
  static const double _markFraction = 0.72;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: _markFraction,
          child: Image.asset(
            'assets/images/logo_transparant.png',
            height: _height / _markFraction,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => const Text(
              'SavEdge',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: WalletTokens.onInk,
              ),
            ),
          ),
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
        color: urgent ? WalletTokens.warnOnInk : WalletTokens.inkFrost,
        borderRadius: BorderRadius.circular(WalletTokens.rChip),
        border: urgent ? null : Border.all(color: WalletTokens.inkFrostBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            urgent ? Icons.hourglass_bottom_rounded : Icons.schedule_rounded,
            size: 12,
            color: urgent ? WalletTokens.onWarnPill : WalletTokens.onInkMuted,
          ),
          const SizedBox(width: WalletTokens.s1),
          Text(
            _label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: urgent ? WalletTokens.onWarnPill : WalletTokens.onInkMuted,
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
