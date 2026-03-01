import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:savedge/features/coupons/data/models/coupon_redemption_models.dart';
import 'package:savedge/features/coupons/data/models/user_coupon_model.dart';

class RedeemedCouponPage extends StatefulWidget {
  const RedeemedCouponPage({
    super.key,
    this.userCoupon,
    this.redemptionResponse,
  });

  final UserCouponModel? userCoupon;
  final RedeemCouponResponse? redemptionResponse;

  @override
  State<RedeemedCouponPage> createState() => _RedeemedCouponPageState();
}

class _RedeemedCouponPageState extends State<RedeemedCouponPage>
    with TickerProviderStateMixin {
  late final AnimationController _confettiController;
  late final AnimationController _entryController;
  late final AnimationController _iconController;
  late final List<_ConfettiParticle> _particles;
  late final Animation<double> _entryFade;
  late final Animation<double> _entrySlide;
  late final Animation<double> _iconScale;

  static const _kConfettiColors = [
    Color(0xFF6F3FCC),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFF3B82F6),
    Color(0xFFEC4899),
    Color(0xFF8B5CF6),
    Color(0xFF14B8A6),
  ];

  @override
  void initState() {
    super.initState();
    final rng = Random();
    _particles = List.generate(80, (i) => _ConfettiParticle(
      x: rng.nextDouble(),
      startFraction: -rng.nextDouble() * 0.6,
      speed: 0.28 + rng.nextDouble() * 0.42,
      size: 5.0 + rng.nextDouble() * 9.0,
      color: _kConfettiColors[i % _kConfettiColors.length],
      rotationSpeed: (rng.nextDouble() - 0.5) * 16,
      amplitude: 12 + rng.nextDouble() * 40,
      phase: rng.nextDouble() * 2 * pi,
    ));

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..forward();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _entryFade = CurvedAnimation(parent: _entryController, curve: Curves.easeOut);
    _entrySlide = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutCubic),
    );
    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _entryController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String title =
        widget.redemptionResponse?.couponTitle ??
        widget.userCoupon?.title ??
        'Coupon Redeemed';
    final String vendorName =
        widget.redemptionResponse?.vendorName ??
        widget.userCoupon?.vendorName ??
        'Vendor';
    final String discountDisplay =
        widget.redemptionResponse?.discountDisplay ??
        widget.userCoupon?.discountDisplay ??
        '';
    final String? redemptionCode =
        widget.redemptionResponse?.uniqueCode ?? widget.userCoupon?.redemptionCode;
    final DateTime? redeemedAt =
        widget.redemptionResponse?.redeemedAt ??
        (widget.userCoupon?.usedAt != null
            ? DateTime.tryParse(widget.userCoupon!.usedAt!)
            : null);

    return Scaffold(
      backgroundColor: const Color(0xFF10B981),
      body: Stack(
        children: [
          // Main boarding pass layout
          SafeArea(
            child: AnimatedBuilder(
              animation: _entryController,
              builder: (context, child) => FadeTransition(
                opacity: _entryFade,
                child: Transform.translate(
                  offset: Offset(0, _entrySlide.value),
                  child: child,
                ),
              ),
              child: Column(
                children: [
                  // ── Green header section ─────────────────────────────────────
                  _buildHeader(context, vendorName, discountDisplay),

                  // ── Perforated tear line ─────────────────────────────────────
                  _buildTearLine(),

                  // ── White body section ───────────────────────────────────────
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1A202C),
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Present this to the vendor at checkout',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 28),

                            if (redemptionCode != null) ...[
                              _buildCodeSection(context, redemptionCode),
                              const SizedBox(height: 24),
                            ],

                            if (redeemedAt != null) ...[
                              _buildTimestampRow(redeemedAt),
                              const SizedBox(height: 20),
                            ],

                            if (widget.userCoupon?.terms != null &&
                                widget.userCoupon!.terms!.isNotEmpty) ...[
                              _buildTerms(context),
                              const SizedBox(height: 20),
                            ],

                            const SizedBox(height: 16),
                            _buildDoneButton(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Confetti overlay ───────────────────────────────────────────────
          IgnorePointer(
            child: AnimatedBuilder(
              animation: _confettiController,
              builder: (context, _) => CustomPaint(
                painter: _ConfettiPainter(_confettiController.value, _particles),
                child: const SizedBox.expand(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String vendorName, String discountDisplay) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF10B981),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Back button row
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Animated success circle
          AnimatedBuilder(
            animation: _iconScale,
            builder: (context, _) => Transform.scale(
              scale: _iconScale.value,
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF10B981),
                  size: 44,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          if (discountDisplay.isNotEmpty)
            Text(
              discountDisplay,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1.5,
                height: 1.0,
              ),
            ),

          const SizedBox(height: 8),

          Text(
            vendorName,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white.withOpacity(0.9),
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '✓  Redeemed Successfully',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTearLine() {
    return CustomPaint(
      painter: _TearLinePainter(),
      child: const SizedBox(height: 28, width: double.infinity),
    );
  }

  Widget _buildCodeSection(BuildContext context, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF10B981),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'REDEMPTION CODE',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF10B981),
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF10B981).withOpacity(0.3),
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  code,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1A202C),
                    letterSpacing: 5,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_rounded, color: Colors.white, size: 16),
                          SizedBox(width: 8),
                          Text('Code copied!'),
                        ],
                      ),
                      backgroundColor: const Color(0xFF10B981),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.copy_rounded,
                    size: 18,
                    color: Color(0xFF10B981),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Show this code or let the vendor scan your QR',
          style: TextStyle(fontSize: 12, color: Colors.grey[400]),
        ),
      ],
    );
  }

  Widget _buildTimestampRow(DateTime redeemedAt) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8FA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Icon(Icons.schedule_rounded, size: 18, color: Colors.grey[400]),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Redeemed at',
              style: TextStyle(fontSize: 11, color: Colors.grey[400]),
            ),
            const SizedBox(height: 2),
            Text(
              DateFormat("EEE, MMM dd · hh:mm a").format(redeemedAt),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A202C),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTerms(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Row(
          children: [
            Icon(Icons.info_outline_rounded, size: 16, color: Colors.grey[500]),
            const SizedBox(width: 8),
            Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        iconColor: Colors.grey[400],
        collapsedIconColor: Colors.grey[400],
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 8),
              child: Text(
                widget.userCoupon!.terms!,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                  height: 1.55,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: const Text(
          'Done',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

// ─── Tear line painter ──────────────────────────────────────────────────────

class _TearLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Green top half
    final greenPaint = Paint()
      ..color = const Color(0xFF10B981)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height / 2), greenPaint);

    // White bottom half
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH(0, size.height / 2, size.width, size.height / 2), whitePaint);

    // Left notch (background color circle cutting into the card)
    final notchPaint = Paint()
      ..color = const Color(0xFFF7F8FA)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, size.height / 2), 14, notchPaint);
    canvas.drawCircle(Offset(size.width, size.height / 2), 14, notchPaint);

    // Dashed center line
    final dashPaint = Paint()
      ..color = const Color(0xFFD1FAE5)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashW = 7.0;
    const dashGap = 5.0;
    double x = 18.0;
    final y = size.height / 2;
    while (x < size.width - 18) {
      canvas.drawLine(Offset(x, y), Offset(x + dashW, y), dashPaint);
      x += dashW + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Confetti ─────────────────────────────────────────────────────────────────

class _ConfettiParticle {
  final double x;
  final double startFraction;
  final double speed;
  final double size;
  final Color color;
  final double rotationSpeed;
  final double amplitude;
  final double phase;

  const _ConfettiParticle({
    required this.x,
    required this.startFraction,
    required this.speed,
    required this.size,
    required this.color,
    required this.rotationSpeed,
    required this.amplitude,
    required this.phase,
  });
}

class _ConfettiPainter extends CustomPainter {
  final double progress;
  final List<_ConfettiParticle> particles;

  _ConfettiPainter(this.progress, this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final traveled = progress * p.speed;
      final normalY = p.startFraction + traveled;
      final y = normalY * size.height;
      final x = p.x * size.width + sin(traveled * 7 + p.phase) * p.amplitude;

      if (y > size.height + 20 || y < -30) continue;

      final opacity = (1.0 - progress * 0.65).clamp(0.0, 1.0);
      final paint = Paint()..color = p.color.withOpacity(opacity);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(traveled * p.rotationSpeed);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
              center: Offset.zero, width: p.size, height: p.size * 0.45),
          const Radius.circular(2),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.progress != progress;
}
