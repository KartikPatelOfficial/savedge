import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savedge/features/coupons/data/models/coupon_redemption_models.dart';
import 'package:savedge/features/coupons/data/models/user_coupon_model.dart';
import 'package:intl/intl.dart';

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
  late final List<_ConfettiParticle> _particles;
  late final Animation<double> _entryFade;
  late final Animation<double> _entrySlide;

  static const _kConfettiColors = [
    Color(0xFF6F3FCC), // Purple
    Color(0xFF10B981), // Emerald
    Color(0xFFF59E0B), // Amber
    Color(0xFFEF4444), // Red
    Color(0xFF3B82F6), // Blue
    Color(0xFFEC4899), // Pink
    Color(0xFF8B5CF6), // Violet
    Color(0xFF14B8A6), // Teal
  ];

  @override
  void initState() {
    super.initState();
    final rng = Random();
    _particles = List.generate(80, (i) => _ConfettiParticle(
      x: rng.nextDouble(),
      startFraction: -rng.nextDouble() * 0.6,
      speed: 0.28 + rng.nextDouble() * 0.42,
      size: 6.0 + rng.nextDouble() * 10.0,
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
      duration: const Duration(milliseconds: 800),
    )..forward();

    _entryFade = CurvedAnimation(parent: _entryController, curve: Curves.easeOut);
    _entrySlide = Tween<double>(begin: 40.0, end: 0.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vendorName = widget.redemptionResponse?.vendorName ?? widget.userCoupon?.vendorName ?? 'Vendor';
    final discountDisplay = widget.redemptionResponse?.discountDisplay ?? widget.userCoupon?.discountDisplay ?? '';
    final code = widget.redemptionResponse?.uniqueCode ?? widget.userCoupon?.redemptionCode;
    final redeemedAt = widget.redemptionResponse?.redeemedAt ??
        (widget.userCoupon?.usedAt != null
            ? DateTime.tryParse(widget.userCoupon!.usedAt!)
            : null);
    
    return Scaffold(
      backgroundColor: const Color(0xFF22C55E), // Vivid Green Always
      body: Stack(
        children: [
          SafeArea(
            child: AnimatedBuilder(
              animation: _entryController,
              builder: (context, child) => FadeTransition(
                opacity: _entryFade,
                child: Transform.translate(
                  offset: Offset(0, _entrySlide.value),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 48),
                        
                        // Massive Icon
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_rounded, size: 72, color: Color(0xFF22C55E)),
                        ),
                        const SizedBox(height: 32),
                        
                        // Joyful Text
                        const Text(
                          'WOOHOO!',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: -1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'You just redeemed\n$discountDisplay at $vendorName',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white70,
                            height: 1.3,
                          ),
                        ),
                        
                        const SizedBox(height: 48),
                        
                        // The Code Card
                        if (code != null) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'REDEMPTION CODE',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF94A3B8),
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  code,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF0F172A),
                                    letterSpacing: 4,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: code));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                                            SizedBox(width: 10),
                                            Text('Code copied!', style: TextStyle(fontWeight: FontWeight.w700)),
                                          ],
                                        ),
                                        backgroundColor: const Color(0xFF0F172A),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.copy_rounded, size: 20),
                                  label: const Text('COPY CODE', style: TextStyle(fontWeight: FontWeight.w800)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF1F5F9),
                                    foregroundColor: const Color(0xFF0F172A),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                        
                        const Spacer(),
                        
                        if (redeemedAt != null) ...[
                          Text(
                            'Redeemed ${DateFormat("EEE, MMM dd 'at' hh:mm a").format(redeemedAt)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                        
                        // Done
                        SizedBox(
                          width: double.infinity,
                          height: 64,
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF22C55E),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              elevation: 0,
                            ),
                            child: const Text('DONE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Confetti overlay
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
      )
    );
  }
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
          const Radius.circular(3),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.progress != progress;
}
