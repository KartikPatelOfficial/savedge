import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/gift_card_entity.dart';
import '../theme/gc_tokens.dart';
import '../widgets/gc_how_to_redeem_sheet.dart';

/// Premium single-card view shown after a successful purchase or when the
/// user opens an active card from "My Gift Cards".
///
/// Features:
/// - Black + lime + purple credit-card design with chip, brand mark, and value
/// - Tap to flip (front shows number, back shows PIN)
/// - Gyroscope-based tilt (subtle real-card feel)
/// - Animated radial glow
/// - Share as image + caption
class GiftCardViewPage extends StatefulWidget {
  const GiftCardViewPage({super.key, required this.order});

  final GiftCardOrderEntity order;

  @override
  State<GiftCardViewPage> createState() => _GiftCardViewPageState();
}

class _GiftCardViewPageState extends State<GiftCardViewPage>
    with TickerProviderStateMixin {
  // For RepaintBoundary → image when sharing
  final _cardKey = GlobalKey();

  // Tilt
  StreamSubscription<GyroscopeEvent>? _gyroSub;
  double _tiltX = 0;
  double _tiltY = 0;

  // Glow pulse
  late final AnimationController _glowCtrl;

  // Flip
  late final AnimationController _flipCtrl;
  late final Animation<double> _flipAnim;
  bool _showingBack = false;

  GiftCardOrderEntity get order => widget.order;
  Color get _accent => GcTokens.accentFor(order.giftCardProductId);

  @override
  void initState() {
    super.initState();

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _flipCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _flipAnim = CurvedAnimation(parent: _flipCtrl, curve: Curves.easeInOut);

    _gyroSub = gyroscopeEventStream().listen((e) {
      if (!mounted) return;
      setState(() {
        // Smooth easing — clamp so the card doesn't tilt too much
        _tiltX = (_tiltX + e.y * 0.04).clamp(-0.18, 0.18);
        _tiltY = (_tiltY + e.x * 0.04).clamp(-0.18, 0.18);
        // Decay back to neutral
        _tiltX *= 0.92;
        _tiltY *= 0.92;
      });
    });
  }

  @override
  void dispose() {
    _gyroSub?.cancel();
    _glowCtrl.dispose();
    _flipCtrl.dispose();
    super.dispose();
  }

  // ── Helpers ────────────────────────────────────────────────────────────

  String get _maskedNumber {
    final n = order.woohooCardNumber ?? '';
    final clean = n.replaceAll(RegExp(r'\s+'), '');
    if (clean.isEmpty) return '•••• •••• •••• ••••';
    final groups = <String>[];
    for (var i = 0; i < clean.length; i += 4) {
      groups.add(clean.substring(i, math.min(i + 4, clean.length)));
    }
    return groups.join(' ');
  }

  String get _validity {
    final d = order.woohooCardExpiry;
    if (d == null) return '••/••';
    return '${d.month.toString().padLeft(2, '0')}/${d.year % 100}';
  }

  void _toggleFlip() {
    if (_showingBack) {
      _flipCtrl.reverse();
    } else {
      _flipCtrl.forward();
    }
    _showingBack = !_showingBack;
    HapticFeedback.lightImpact();
  }

  Future<void> _share() async {
    try {
      final boundary =
          _cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;
      final dir = await getTemporaryDirectory();
      final file = File(
        '${dir.path}/savedge_gift_card_${order.id}.png',
      );
      await file.writeAsBytes(byteData.buffer.asUint8List());

      final caption = StringBuffer()
        ..writeln('${order.productName} gift card')
        ..writeln('Value: ₹${(order.woohooActivatedAmount ?? order.requestedAmount).toStringAsFixed(0)}');
      if (order.woohooCardNumber != null) {
        caption.writeln('Card: ${order.woohooCardNumber}');
      }
      if (order.woohooCardPin != null) {
        caption.writeln('PIN: ${order.woohooCardPin}');
      }
      if (order.woohooActivationUrl != null) {
        caption.writeln('Activate: ${order.woohooActivationUrl}');
      }

      await Share.shareXFiles(
        [XFile(file.path)],
        text: caption.toString(),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not share card: $e')),
      );
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GcTokens.brandBlack,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: _glassCircleButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Your Gift Card',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _glassCircleButton(
              icon: Icons.ios_share_rounded,
              onTap: _share,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          20,
          MediaQuery.of(context).padding.top + kToolbarHeight + 12,
          20,
          32,
        ),
        children: [
          _buildFlippableCard(),
          const SizedBox(height: 14),
          _buildFlipHint(),
          const SizedBox(height: 24),
          _buildActions(),
          const SizedBox(height: 18),
          _buildOrderMeta(),
        ],
      ),
    );
  }

  Widget _glassCircleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white.withValues(alpha: 0.08),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.16),
            ),
          ),
          child: Icon(icon, color: Colors.white, size: 17),
        ),
      ),
    );
  }

  Widget _buildFlipHint() {
    return Center(
      child: GestureDetector(
        onTap: _toggleFlip,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.touch_app_rounded,
              size: 13,
              color: GcTokens.brandLime.withValues(alpha: 0.85),
            ),
            const SizedBox(width: 6),
            Text(
              _showingBack
                  ? 'TAP TO SHOW NUMBER'
                  : 'TAP CARD TO REVEAL PIN',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.6,
                color: GcTokens.brandLime.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Flippable, gyroscope-tilted card ───────────────────────────────────

  Widget _buildFlippableCard() {
    return RepaintBoundary(
      key: _cardKey,
      child: AnimatedBuilder(
        animation: Listenable.merge([_flipAnim, _glowCtrl]),
        builder: (context, child) {
          final flip = _flipAnim.value * math.pi;
          final isBack = flip > math.pi / 2;
          return GestureDetector(
            onTap: _toggleFlip,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0012) // perspective
                ..rotateX(_tiltY) // gyroscope tilt
                ..rotateY(_tiltX + flip),
              child: isBack
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(math.pi),
                      child: _buildCardBack(),
                    )
                  : _buildCardFront(),
            ),
          );
        },
      ),
    );
  }

  // ── Front ──────────────────────────────────────────────────────────────

  Widget _buildCardFront() {
    return AspectRatio(
      aspectRatio: 0.62, // closer to a real vertical credit card
      child: Container(
        decoration: BoxDecoration(
          color: GcTokens.brandBlack,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.55),
              offset: const Offset(0, 24),
              blurRadius: 40,
            ),
            BoxShadow(
              color: GcTokens.brandLime
                  .withValues(alpha: 0.10 + _glowCtrl.value * 0.10),
              offset: const Offset(0, 0),
              blurRadius: 30,
              spreadRadius: 1,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            _animatedGlows(),
            Positioned.fill(child: CustomPaint(painter: _CardGridPainter())),

            // SAVEDGE wordmark — top right
            Positioned(
              top: 22,
              right: 22,
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: GcTokens.brandLime,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'SAVEDGE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: GcTokens.brandLime.withValues(alpha: 0.95),
                      letterSpacing: 2.4,
                    ),
                  ),
                ],
              ),
            ),

            // SavEdge logo top-left (replaces the chip)
            Positioned(
              top: 18,
              left: 22,
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: GcTokens.brandLime.withValues(alpha: 0.30),
                  ),
                ),
                padding: const EdgeInsets.all(6),
                child: Image.asset(
                  'assets/images/logo_transparant.png',
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // Vertical brand name on left side
            Positioned(
              left: 18,
              top: 78,
              bottom: 100,
              child: RotatedBox(
                quarterTurns: 3,
                child: Center(
                  child: Text(
                    order.productName.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withValues(alpha: 0.55),
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ),

            // Centered value block (label + amount)
            Positioned(
              left: 50,
              right: 22,
              top: 96,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: GcTokens.brandLime.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: GcTokens.brandLime.withValues(alpha: 0.40),
                      ),
                    ),
                    child: const Text(
                      'GIFT CARD VALUE',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.6,
                        color: GcTokens.brandLime,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          '\u20B9',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white.withValues(alpha: 0.95),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        (order.woohooActivatedAmount ?? order.requestedAmount)
                            .toStringAsFixed(0),
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.0,
                          letterSpacing: -2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Card number row
            Positioned(
              left: 50,
              right: 22,
              bottom: 122,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CARD NUMBER',
                    style: TextStyle(
                      fontSize: 8.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.4,
                      color: Colors.white.withValues(alpha: 0.45),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _maskedNumber,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2.4,
                    ),
                  ),
                ],
              ),
            ),

            // Validity row
            Positioned(
              left: 50,
              bottom: 78,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VALID THRU',
                    style: TextStyle(
                      fontSize: 7.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      color: Colors.white.withValues(alpha: 0.45),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _validity,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            // Footer: bigger brand thumb + ACTIVE pill
            Positioned(
              left: 22,
              right: 22,
              bottom: 22,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (order.productImageUrl != null &&
                      order.productImageUrl!.isNotEmpty)
                    Container(
                      width: 64,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.30),
                            offset: const Offset(0, 6),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(6),
                      child: CachedNetworkImage(
                        imageUrl: order.productImageUrl!,
                        fit: BoxFit.contain,
                        errorWidget: (_, __, ___) => Icon(
                          Icons.card_giftcard_rounded,
                          color: _accent,
                          size: 22,
                        ),
                      ),
                    ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: GcTokens.brandLime.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: GcTokens.brandLime.withValues(alpha: 0.55),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: GcTokens.brandLime.withValues(
                            alpha: 0.20 + _glowCtrl.value * 0.20,
                          ),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: GcTokens.brandLime,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'ACTIVE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: GcTokens.brandLime,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Back ───────────────────────────────────────────────────────────────

  Widget _buildCardBack() {
    return AspectRatio(
      aspectRatio: 0.62,
      child: Container(
        decoration: BoxDecoration(
          color: GcTokens.brandBlack,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.55),
              offset: const Offset(0, 24),
              blurRadius: 40,
            ),
            BoxShadow(
              color: GcTokens.primary.withValues(
                alpha: 0.18 + _glowCtrl.value * 0.10,
              ),
              blurRadius: 30,
              spreadRadius: 1,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            _animatedGlows(),
            Positioned.fill(child: CustomPaint(painter: _CardGridPainter())),

            // Magnetic stripe
            Positioned(
              left: 0,
              right: 0,
              top: 40,
              child: Container(
                height: 52,
                color: Colors.black,
              ),
            ),

            // PIN block
            Positioned(
              left: 22,
              right: 22,
              top: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PIN',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.6,
                      color: GcTokens.brandLime,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      order.woohooCardPin ?? '••••••',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: GcTokens.brandBlack,
                        letterSpacing: 6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  if (order.woohooActivationCode != null) ...[
                    Text(
                      'ACTIVATION CODE',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.4,
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.woohooActivationCode!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Disclaimer at bottom
            Positioned(
              left: 22,
              right: 22,
              bottom: 22,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      'Keep this PIN private. Do not share with anyone other than the merchant.',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.50),
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: GcTokens.brandLime,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'SAVEDGE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: GcTokens.brandLime.withValues(alpha: 0.85),
                          letterSpacing: 2,
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

  Widget _animatedGlows() {
    final t = _glowCtrl.value;
    return Stack(
      children: [
        Positioned(
          left: -100,
          bottom: -100,
          child: Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  GcTokens.primary.withValues(alpha: 0.45 + t * 0.20),
                  GcTokens.primary.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: -80,
          top: -100,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  GcTokens.brandLime.withValues(alpha: 0.22 + t * 0.18),
                  GcTokens.brandLime.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Actions ────────────────────────────────────────────────────────────

  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => GcHowToRedeemSheet.show(
              context,
              brandName: order.productName,
              brandUrl: order.woohooActivationUrl,
            ),
            icon: const Icon(
              Icons.menu_book_rounded,
              size: 16,
              color: GcTokens.brandLime,
            ),
            label: const Text(
              'How to redeem',
              style: TextStyle(
                color: GcTokens.brandLime,
                fontWeight: FontWeight.w900,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: GcTokens.brandLime.withValues(alpha: 0.45),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GcTokens.rPill),
              ),
            ),
          ),
        ),
        if (order.woohooActivationUrl != null &&
            order.woohooActivationUrl!.isNotEmpty) ...[
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => launchUrl(
                Uri.parse(order.woohooActivationUrl!),
                mode: LaunchMode.externalApplication,
              ),
              icon: const Icon(
                Icons.open_in_new_rounded,
                size: 16,
                color: GcTokens.brandBlack,
              ),
              label: const Text(
                'Use now',
                style: TextStyle(
                  color: GcTokens.brandBlack,
                  fontWeight: FontWeight.w900,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: GcTokens.brandLime,
                foregroundColor: GcTokens.brandBlack,
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
    );
  }

  Widget _buildOrderMeta() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.receipt_long_rounded,
            size: 16,
            color: Colors.white.withValues(alpha: 0.55),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Order #${order.id}  ·  ${_fmt(order.created)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Colors.white.withValues(alpha: 0.55),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

class _CardGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.035)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;
    const spacing = 26.0;
    for (var x = -size.height; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
