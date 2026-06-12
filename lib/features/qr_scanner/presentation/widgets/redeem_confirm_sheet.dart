import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savedge/features/gift_cards/presentation/widgets/gift_card_coupon_clipper.dart';

// ─── Palette (matches the savedge brand used across the app) ──────────────────
const _brand = Color(0xFF6F3FCC);
const _ink = Color(0xFF0F172A);
const _inkSoft = Color(0xFF64748B);
const _mute = Color(0xFF94A3B8);
const _hairline = Color(0xFFE5E7EB);
const _fill = Color(0xFFF1F5F9);
const _ticketFill = Color(0xFFF3EEFB); // brand-tinted lavender
const _cautionInk = Color(0xFFB45309);
const _cautionFill = Color(0xFFFEF3E2);

/// Deliberate confirmation gate shown after a vendor QR validates but *before*
/// the coupon is redeemed. Redemption is irreversible, so the user must slide
/// to confirm — a plain tap (or a camera that merely glimpsed the QR) can never
/// trigger it.
///
/// Returns `true` only when the user completes the slide. A drag-down, a tap on
/// the scrim, or "Not now" all resolve to `false`/`null`.
class RedeemConfirmSheet extends StatelessWidget {
  const RedeemConfirmSheet({
    super.key,
    required this.vendorName,
    required this.couponTitle,
    required this.discountDisplay,
    this.code,
  });

  final String vendorName;
  final String couponTitle;
  final String discountDisplay;

  /// The redemption code about to be consumed. Null when the coupon is claimed
  /// and used in one step (no code exists yet) — the stub adapts in that case.
  final String? code;

  static Future<bool?> show(
    BuildContext context, {
    required String vendorName,
    required String couponTitle,
    required String discountDisplay,
    String? code,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.62),
      builder: (_) => RedeemConfirmSheet(
        vendorName: vendorName,
        couponTitle: couponTitle,
        discountDisplay: discountDisplay,
        code: code,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Grabber(),
              const SizedBox(height: 20),
              const Text(
                'Ready at the counter?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: _ink,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "You're about to redeem this voucher at $vendorName.",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _inkSoft,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              _TicketCard(
                vendorName: vendorName,
                couponTitle: couponTitle,
                discountDisplay: discountDisplay,
                code: code,
              ),
              const SizedBox(height: 16),
              const _CautionRow(),
              const SizedBox(height: 20),
              _SlideToRedeem(
                onConfirmed: () => Navigator.of(context).pop(true),
              ),
              const SizedBox(height: 4),
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: TextButton.styleFrom(
                  foregroundColor: _inkSoft,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Not now',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Grabber extends StatelessWidget {
  const _Grabber();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: _hairline,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

/// A torn-ticket card: vendor + offer on top, perforation, redemption code on
/// the stub. Built from the app's existing notch clipper + dashed-line painter
/// so it reads as the same "voucher" object used elsewhere in the app.
class _TicketCard extends StatelessWidget {
  const _TicketCard({
    required this.vendorName,
    required this.couponTitle,
    required this.discountDisplay,
    this.code,
  });

  final String vendorName;
  final String couponTitle;
  final String discountDisplay;
  final String? code;

  static const double _notchRatio = 0.66;

  @override
  Widget build(BuildContext context) {
    final initial = vendorName.trim().isNotEmpty
        ? vendorName.trim()[0].toUpperCase()
        : '?';

    return ClipPath(
      clipper: GiftCardOrderShapeClipper(notchRatio: _notchRatio),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            color: _ticketFill,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Top: vendor + offer ───────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _brand,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              initial,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vendorName.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: _mute,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  couponTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: _ink,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        discountDisplay,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: _brand,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                // gap the perforation sits in
                const SizedBox(height: 10),
                // ── Stub: code ────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                  child: code != null ? _CodeStub(code: code!) : const _PendingStub(),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: HorizontalDashedLinePainter(
                  yRatio: _notchRatio,
                  color: _brand.withOpacity(0.28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeStub extends StatelessWidget {
  const _CodeStub({required this.code});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ONE-TIME CODE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: _mute,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  code,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: _ink,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        const Icon(Icons.confirmation_number_outlined, color: _brand, size: 26),
      ],
    );
  }
}

class _PendingStub extends StatelessWidget {
  const _PendingStub();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.lock_outline_rounded, color: _mute, size: 20),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            'Your code is revealed the moment you redeem.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _inkSoft,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}

class _CautionRow extends StatelessWidget {
  const _CautionRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _cautionFill,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.info_outline_rounded, color: _cautionInk, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Slide only when the staff is with you — redeeming can't be undone.",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _cautionInk,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Slide-to-confirm control. The thumb must be dragged ~90% across before the
/// action fires; anything short snaps back. This is the deliberate gesture that
/// replaces the old auto-redeem-on-scan behaviour.
class _SlideToRedeem extends StatefulWidget {
  const _SlideToRedeem({required this.onConfirmed});

  final VoidCallback onConfirmed;

  @override
  State<_SlideToRedeem> createState() => _SlideToRedeemState();
}

class _SlideToRedeemState extends State<_SlideToRedeem>
    with TickerProviderStateMixin {
  late final AnimationController _pos; // 0..1 thumb position
  late final AnimationController _hint; // idle arrow nudge
  bool _dragging = false;
  bool _done = false;

  static const double _thumb = 56;
  static const double _trackH = 64;
  static const double _pad = 4;

  @override
  void initState() {
    super.initState();
    _pos = AnimationController(vsync: this, duration: const Duration(milliseconds: 240));
    _hint = AnimationController(vsync: this, duration: const Duration(milliseconds: 1300))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pos.dispose();
    _hint.dispose();
    super.dispose();
  }

  void _onUpdate(DragUpdateDetails d, double maxX) {
    if (_done || maxX <= 0) return;
    _dragging = true;
    _pos.value = (_pos.value + d.primaryDelta! / maxX).clamp(0.0, 1.0);
  }

  Future<void> _onEnd(double maxX) async {
    if (_done) return;
    _dragging = false;
    if (_pos.value >= 0.9) {
      _done = true;
      await _pos.animateTo(1.0,
          duration: const Duration(milliseconds: 110), curve: Curves.easeOut);
      await HapticFeedback.mediumImpact();
      if (mounted) widget.onConfirmed();
    } else {
      _pos.animateBack(0.0,
          duration: const Duration(milliseconds: 220), curve: Curves.easeOutCubic);
    }
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    return LayoutBuilder(
      builder: (context, c) {
        final maxX = c.maxWidth - _thumb - _pad * 2;
        return AnimatedBuilder(
          animation: Listenable.merge([_pos, _hint]),
          builder: (context, _) {
            final p = _pos.value;
            final idle = !_dragging && !_done && p == 0;
            final nudge = (idle && !reduceMotion) ? _hint.value * 6.0 : 0.0;
            final left = _pad + p * maxX + nudge;
            final fillWidth = left + _thumb / 2;

            return Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Track + filling progress, clipped to the pill.
                ClipRRect(
                  borderRadius: BorderRadius.circular(_trackH / 2),
                  child: SizedBox(
                    height: _trackH,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        const ColoredBox(color: _fill),
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          width: fillWidth,
                          child: ColoredBox(color: _brand.withOpacity(0.12)),
                        ),
                        Center(
                          child: Opacity(
                            opacity: (1 - p * 1.8).clamp(0.0, 1.0),
                            child: const Text(
                              'Slide to redeem',
                              style: TextStyle(
                                color: _inkSoft,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Thumb.
                Positioned(
                  left: left,
                  child: Semantics(
                    button: true,
                    label: 'Slide to redeem coupon',
                    onTap: _done ? null : widget.onConfirmed,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (d) => _onUpdate(d, maxX),
                      onHorizontalDragEnd: (_) => _onEnd(maxX),
                      child: Container(
                        width: _thumb,
                        height: _thumb,
                        margin: const EdgeInsets.all(_pad),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _brand,
                          borderRadius: BorderRadius.circular((_thumb - _pad * 2) / 2),
                        ),
                        child: const Icon(
                          Icons.keyboard_double_arrow_right_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
