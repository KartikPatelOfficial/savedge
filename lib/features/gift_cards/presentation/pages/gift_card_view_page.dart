import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

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

  // Glow pulse + slow ambient time
  late final AnimationController _glowCtrl;
  late final AnimationController _ambientCtrl;

  // Flip
  late final AnimationController _flipCtrl;
  late final Animation<double> _flipAnim;
  bool _showingBack = false;

  GiftCardOrderEntity get order => widget.order;

  // Cardholder name
  String? _userName;

  @override
  void initState() {
    super.initState();

    _loadUser();

    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _ambientCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat();

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
    _ambientCtrl.dispose();
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

  Future<void> _loadUser() async {
    try {
      final UserProfileResponse3 profile = await getIt<AuthRepository>()
          .getCurrentUserProfile();
      if (!mounted) return;
      setState(() => _userName = profile.displayName);
    } catch (_) {
      // ignore
    }
  }

  void _copy(String label, String value) {
    Clipboard.setData(ClipboardData(text: value));
    HapticFeedback.selectionClick();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: GcTokens.primary,
        duration: const Duration(milliseconds: 1500),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$label copied',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Subtle glass copy button (white-tinted) for the dark card front.
  Widget _copyChip({
    required VoidCallback onTap,
    Color? iconColor,
    Color? bgColor,
    Color? borderColor,
  }) {
    return Material(
      color: bgColor ?? Colors.white.withValues(alpha: 0.10),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor ?? Colors.white.withValues(alpha: 0.20),
            ),
          ),
          child: Icon(
            Icons.copy_rounded,
            size: 14,
            color: iconColor ?? Colors.white.withValues(alpha: 0.85),
          ),
        ),
      ),
    );
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
      final file = File('${dir.path}/savedge_gift_card_${order.id}.png');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      final caption = StringBuffer()
        ..writeln('${order.productName} gift card')
        ..writeln(
          'Value: ₹${(order.woohooActivatedAmount ?? order.requestedAmount).toStringAsFixed(0)}',
        );
      if (order.woohooCardNumber != null) {
        caption.writeln('Card: ${order.woohooCardNumber}');
      }
      if (order.woohooCardPin != null) {
        caption.writeln('PIN: ${order.woohooCardPin}');
      }
      if (order.woohooActivationUrl != null) {
        caption.writeln('Activate: ${order.woohooActivationUrl}');
      }

      await Share.shareXFiles([XFile(file.path)], text: caption.toString());
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not share card: $e')));
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: _lightCircleButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Your Gift Card',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: GcTokens.textPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _lightCircleButton(
              icon: Icons.ios_share_rounded,
              onTap: _share,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(child: _buildPageBackground()),
          ListView(
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
        ],
      ),
    );
  }

  Widget _buildPageBackground() {
    return IgnorePointer(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFFEFC),
                  Color(0xFFF8FCEC),
                  Color(0xFFF9F5FF),
                ],
                stops: [0.0, 0.54, 1.0],
              ),
            ),
          ),
          Positioned(
            top: -90,
            left: -86,
            child: _backgroundOrb(
              size: 260,
              colors: [
                GcTokens.brandLime.withValues(alpha: 0.18),
                GcTokens.brandLime.withValues(alpha: 0.0),
              ],
            ),
          ),
          Positioned(
            top: 120,
            right: -72,
            child: _backgroundOrb(
              size: 240,
              colors: [
                GcTokens.primary.withValues(alpha: 0.10),
                GcTokens.secondary.withValues(alpha: 0.0),
              ],
            ),
          ),
          Positioned(
            bottom: 120,
            left: -64,
            child: _backgroundOrb(
              size: 220,
              colors: [
                GcTokens.secondary.withValues(alpha: 0.09),
                GcTokens.secondary.withValues(alpha: 0.0),
              ],
            ),
          ),
          Positioned(
            bottom: -88,
            right: -44,
            child: _backgroundOrb(
              size: 280,
              colors: [
                GcTokens.brandLimeDark.withValues(alpha: 0.14),
                GcTokens.brandLimeDark.withValues(alpha: 0.0),
              ],
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _PageBackdropPainter(
                lime: GcTokens.brandLimeDark,
                purple: GcTokens.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backgroundOrb({required double size, required List<Color> colors}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: colors),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFFFFFEFD),
      borderRadius: BorderRadius.circular(28),
      border: Border.all(
        color: Color.lerp(
          GcTokens.primary.withValues(alpha: 0.08),
          GcTokens.brandLimeDark.withValues(alpha: 0.12),
          0.30,
        )!,
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: GcTokens.primary.withValues(alpha: 0.035),
          offset: const Offset(0, 18),
          blurRadius: 28,
          spreadRadius: -18,
        ),
      ],
    );
  }

  List<Widget> _cardDecorativeLayers() {
    return [
      Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.65),
                Colors.white.withValues(alpha: 0.0),
                GcTokens.brandLime.withValues(alpha: 0.02),
              ],
              stops: const [0.0, 0.42, 1.0],
            ),
          ),
        ),
      ),
      Positioned.fill(
        child: CustomPaint(
          painter: _AbstractCardWatermarkPainter(
            lime: GcTokens.brandLimeDark,
            purple: GcTokens.primary,
          ),
        ),
      ),
      _patternOverlay(),
    ];
  }

  Widget _lightCircleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white.withValues(alpha: 0.82),
      shape: const CircleBorder(),
      elevation: 0,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.86),
            border: Border.all(
              color: Color.lerp(
                GcTokens.brandLimeDark.withValues(alpha: 0.40),
                GcTokens.primary.withValues(alpha: 0.18),
                0.35,
              )!,
            ),
            boxShadow: [
              BoxShadow(
                color: GcTokens.brandLime.withValues(alpha: 0.10),
                offset: const Offset(0, 8),
                blurRadius: 16,
                spreadRadius: -10,
              ),
            ],
          ),
          child: Icon(icon, color: GcTokens.textPrimary, size: 17),
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
              color: GcTokens.primary.withValues(alpha: 0.70),
            ),
            const SizedBox(width: 6),
            Text(
              _showingBack ? 'TAP TO SHOW NUMBER' : 'TAP CARD TO REVEAL PIN',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.6,
                color: Color.lerp(
                  GcTokens.primary.withValues(alpha: 0.78),
                  GcTokens.brandLimeDark.withValues(alpha: 0.88),
                  0.18,
                )!,
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
        animation: Listenable.merge([_flipAnim, _glowCtrl, _ambientCtrl]),
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
      aspectRatio: 0.62,
      child: Container(
        decoration: _cardDecoration(),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            ..._cardDecorativeLayers(),

            // Cardholder name — top right
            Positioned(
              top: 22,
              right: 22,
              left: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'CARDHOLDER',
                    style: TextStyle(
                      fontSize: 8.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.4,
                      color: GcTokens.primaryDark.withValues(alpha: 0.42),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (_userName ?? 'CARD HOLDER').toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: GcTokens.textPrimary,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            // SavEdge logo top-left
            Positioned(
              top: 18,
              left: 22,
              child: SizedBox(
                width: 46,
                height: 46,
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
                      color: GcTokens.textTertiary.withValues(alpha: 0.45),
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
                      gradient: LinearGradient(
                        colors: [
                          GcTokens.brandLime.withValues(alpha: 0.44),
                          GcTokens.secondary.withValues(alpha: 0.12),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Color.lerp(
                          GcTokens.brandLimeDark.withValues(alpha: 0.58),
                          GcTokens.primary.withValues(alpha: 0.22),
                          0.35,
                        )!,
                      ),
                    ),
                    child: const Text(
                      'GIFT CARD VALUE',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.6,
                        color: GcTokens.brandInk,
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
                            color: GcTokens.textPrimary.withValues(alpha: 0.85),
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
                          color: GcTokens.textPrimary,
                          height: 1.0,
                          letterSpacing: -2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Card number + validity stacked together
            Positioned(
              left: 50,
              right: 22,
              bottom: 70,
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 10, 10, 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.78),
                      GcTokens.surfaceMuted.withValues(alpha: 0.96),
                      GcTokens.brandLime.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color.lerp(
                      GcTokens.primary.withValues(alpha: 0.12),
                      GcTokens.brandLimeDark.withValues(alpha: 0.24),
                      0.30,
                    )!,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'CARD NUMBER',
                      style: TextStyle(
                        fontSize: 8.5,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.4,
                        color: GcTokens.textTertiary.withValues(alpha: 0.70),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            _maskedNumber,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: GcTokens.textPrimary,
                              letterSpacing: 2.2,
                            ),
                          ),
                        ),
                        if (order.woohooCardNumber != null &&
                            order.woohooCardNumber!.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          _copyChip(
                            onTap: () =>
                                _copy('Card number', order.woohooCardNumber!),
                            iconColor: GcTokens.primary,
                            bgColor: GcTokens.primary.withValues(alpha: 0.08),
                            borderColor: GcTokens.primary.withValues(
                              alpha: 0.20,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(height: 1, color: GcTokens.border),
                    const SizedBox(height: 10),
                    Text(
                      'VALID THRU',
                      style: TextStyle(
                        fontSize: 7.5,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                        color: GcTokens.textTertiary.withValues(alpha: 0.70),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _validity,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        color: GcTokens.textPrimary,
                        letterSpacing: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer row — ACTIVE pill on the right
            Positioned(
              left: 22,
              right: 22,
              bottom: 22,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          GcTokens.brandLime.withValues(alpha: 0.42),
                          GcTokens.brandLimeDark.withValues(alpha: 0.18),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: GcTokens.brandLimeDark.withValues(alpha: 0.65),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: GcTokens.brandLimeDark,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'ACTIVE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: GcTokens.brandInk,
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
        decoration: _cardDecoration(),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            ..._cardDecorativeLayers(),

            // Magnetic stripe
            Positioned(
              left: 0,
              right: 0,
              top: 40,
              child: Container(
                height: 52,
                color: GcTokens.textPrimary.withValues(alpha: 0.08),
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
                      color: GcTokens.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.fromLTRB(18, 12, 12, 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withValues(alpha: 0.74),
                          GcTokens.surfaceMuted.withValues(alpha: 0.96),
                          GcTokens.secondary.withValues(alpha: 0.08),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color.lerp(
                          GcTokens.primary.withValues(alpha: 0.14),
                          GcTokens.brandLimeDark.withValues(alpha: 0.22),
                          0.28,
                        )!,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            order.woohooCardPin ?? '••••••',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: GcTokens.textPrimary,
                              letterSpacing: 6,
                            ),
                          ),
                        ),
                        if (order.woohooCardPin != null &&
                            order.woohooCardPin!.isNotEmpty)
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => _copy('PIN', order.woohooCardPin!),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 4,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            GcTokens.brandLime.withValues(
                                              alpha: 0.42,
                                            ),
                                            GcTokens.secondary.withValues(
                                              alpha: 0.12,
                                            ),
                                          ],
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.copy_rounded,
                                        size: 15,
                                        color: GcTokens.brandInk,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'COPY',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.8,
                                        color: GcTokens.textTertiary.withValues(
                                          alpha: 0.65,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
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
                        color: GcTokens.textTertiary.withValues(alpha: 0.65),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      order.woohooActivationCode!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: GcTokens.textPrimary,
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
                        color: GcTokens.textTertiary.withValues(alpha: 0.60),
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: Image.asset(
                      'assets/images/logo_transparant.png',
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
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

  Widget _animatedGlows() {
    return Positioned.fill(
      child: CustomPaint(
        painter: _AuroraPainter(
          time: _ambientCtrl.value,
          pulse: _glowCtrl.value,
        ),
      ),
    );
  }

  Widget _patternOverlay() {
    return Positioned.fill(
      child: Stack(
        children: [
          CustomPaint(
            painter: _ConstellationPainter(
              time: _ambientCtrl.value,
              color: GcTokens.primary,
            ),
          ),
          CustomPaint(
            painter: _ConstellationPainter(
              time: (_ambientCtrl.value + 0.16) % 1.0,
              color: GcTokens.brandLimeDark,
            ),
          ),
        ],
      ),
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
              color: GcTokens.primary,
            ),
            label: const Text(
              'How to redeem',
              style: TextStyle(
                color: GcTokens.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Color.lerp(
                  GcTokens.brandLimeDark.withValues(alpha: 0.42),
                  GcTokens.primary.withValues(alpha: 0.22),
                  0.36,
                )!,
              ),
              backgroundColor: Colors.white.withValues(alpha: 0.84),
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
                color: Colors.white,
              ),
              label: const Text(
                'Use now',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: GcTokens.primary,
                foregroundColor: Colors.white,
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
        color: Colors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Color.lerp(
            GcTokens.primary.withValues(alpha: 0.08),
            GcTokens.brandLimeDark.withValues(alpha: 0.18),
            0.30,
          )!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.receipt_long_rounded,
            size: 16,
            color: GcTokens.textTertiary.withValues(alpha: 0.65),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Order #${order.id}  ·  ${_fmt(order.created)}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: GcTokens.textSecondary,
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

/// Two compact corner glows in brand lime + purple, slowly drifting
/// inside their corners. Glows never reach the centre of the card so the
/// big text and number row stay perfectly readable.
class _AuroraPainter extends CustomPainter {
  _AuroraPainter({required this.time, required this.pulse});

  final double time; // 0..1, slow loop (~24s)
  final double pulse; // 0..1, fast pulse (~3s)

  @override
  void paint(Canvas canvas, Size size) {
    final twoPi = math.pi * 2;

    // Compact corner glows. Radius is small relative to card size so the
    // centre stays clean.
    final corners = [
      _CornerGlow(
        color: GcTokens.secondary,
        baseAlpha: 0.10,
        radius: size.width * 0.50,
        anchor: Offset(-size.width * 0.06, size.height * 1.04),
        driftX: 12,
        driftY: 12,
        speed: 0.6,
        phase: 0.0,
      ),
      _CornerGlow(
        color: GcTokens.brandLimeDark,
        baseAlpha: 0.08,
        radius: size.width * 0.46,
        anchor: Offset(size.width * 1.02, -size.height * 0.02),
        driftX: 12,
        driftY: 10,
        speed: -0.5,
        phase: math.pi / 2,
      ),
    ];

    for (final c in corners) {
      final angle = time * twoPi * c.speed + c.phase;
      final dx = c.anchor.dx + math.cos(angle) * c.driftX;
      final dy = c.anchor.dy + math.sin(angle) * c.driftY;
      final alpha = (c.baseAlpha + pulse * 0.10).clamp(0.0, 1.0);
      final paint = Paint()
        ..shader = ui.Gradient.radial(Offset(dx, dy), c.radius, [
          c.color.withValues(alpha: alpha),
          c.color.withValues(alpha: 0.0),
        ]);
      canvas.drawCircle(Offset(dx, dy), c.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _AuroraPainter old) =>
      old.time != time || old.pulse != pulse;
}

class _CornerGlow {
  const _CornerGlow({
    required this.color,
    required this.baseAlpha,
    required this.radius,
    required this.anchor,
    required this.driftX,
    required this.driftY,
    required this.speed,
    required this.phase,
  });
  final Color color;
  final double baseAlpha;
  final double radius;
  final Offset anchor;
  final double driftX;
  final double driftY;
  final double speed;
  final double phase;
}

/// Guilloché-inspired pattern — layered flowing sine waves that drift
/// slowly. Mimics the engraved security pattern of real banknotes and
/// premium credit cards. Driven by [time] (0..1) for slow horizontal flow.
class _ConstellationPainter extends CustomPainter {
  _ConstellationPainter({required this.time, required this.color});

  final double time; // 0..1
  final Color color;

  static const _layers = <List<double>>[
    // [verticalCenter, amplitude, frequency, speed, phase, alpha]
    [0.20, 0.040, 3.5, 0.6, 0.0, 0.035],
    [0.32, 0.055, 2.8, -0.5, 1.1, 0.030],
    [0.46, 0.035, 4.2, 0.7, 2.2, 0.035],
    [0.58, 0.060, 2.4, -0.4, 0.6, 0.025],
    [0.70, 0.040, 3.8, 0.55, 1.7, 0.030],
    [0.84, 0.050, 3.0, -0.65, 2.5, 0.025],
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final twoPi = math.pi * 2;
    final paint = Paint()
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final layer in _layers) {
      final centerY = layer[0] * size.height;
      final amp = layer[1] * size.height;
      final freq = layer[2];
      final speed = layer[3];
      final phase = layer[4];
      final alpha = layer[5];

      paint.color = color.withValues(alpha: alpha);

      final path = Path();
      const steps = 60;
      for (var i = 0; i <= steps; i++) {
        final t = i / steps;
        final x = t * size.width;
        // Two interfering sine waves give the engraved guilloché look
        final y =
            centerY +
            math.sin(t * twoPi * freq + time * twoPi * speed + phase) * amp +
            math.sin(
                  t * twoPi * (freq * 0.5) - time * twoPi * speed * 1.3 + phase,
                ) *
                amp *
                0.5;
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ConstellationPainter old) =>
      old.time != time || old.color != color;
}

class _AbstractCardWatermarkPainter extends CustomPainter {
  const _AbstractCardWatermarkPainter({
    required this.lime,
    required this.purple,
  });

  final Color lime;
  final Color purple;

  @override
  void paint(Canvas canvas, Size size) {
    final limeStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = lime.withValues(alpha: 0.09);
    final purpleStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = purple.withValues(alpha: 0.07);

    final limeFill = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.68, size.height * 0.16),
        Offset(size.width * 0.94, size.height * 0.34),
        [lime.withValues(alpha: 0.10), lime.withValues(alpha: 0.0)],
      );
    final purpleFill = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.04, size.height * 0.78),
        Offset(size.width * 0.28, size.height * 1.0),
        [purple.withValues(alpha: 0.08), purple.withValues(alpha: 0.0)],
      );

    final topArc = Path()
      ..moveTo(size.width * 0.58, size.height * 0.22)
      ..quadraticBezierTo(
        size.width * 0.74,
        size.height * 0.08,
        size.width * 0.90,
        size.height * 0.22,
      )
      ..quadraticBezierTo(
        size.width * 0.78,
        size.height * 0.32,
        size.width * 0.66,
        size.height * 0.24,
      );

    final bottomWave = Path()
      ..moveTo(size.width * 0.06, size.height * 0.90)
      ..quadraticBezierTo(
        size.width * 0.18,
        size.height * 0.78,
        size.width * 0.34,
        size.height * 0.88,
      )
      ..quadraticBezierTo(
        size.width * 0.48,
        size.height * 0.97,
        size.width * 0.62,
        size.height * 0.86,
      );

    final ringRect = Rect.fromCircle(
      center: Offset(size.width * 0.84, size.height * 0.68),
      radius: size.width * 0.14,
    );
    final secondaryRingRect = Rect.fromCircle(
      center: Offset(size.width * 0.20, size.height * 0.82),
      radius: size.width * 0.10,
    );

    canvas.drawPath(topArc, limeStroke);
    canvas.drawPath(bottomWave, purpleStroke);
    canvas.drawArc(ringRect, -0.4, math.pi * 1.45, false, limeStroke);
    canvas.drawArc(
      secondaryRingRect,
      math.pi * 0.1,
      math.pi * 1.2,
      false,
      purpleStroke,
    );

    canvas.drawCircle(
      Offset(size.width * 0.84, size.height * 0.68),
      size.width * 0.10,
      limeFill,
    );
    canvas.drawCircle(
      Offset(size.width * 0.18, size.height * 0.82),
      size.width * 0.09,
      purpleFill,
    );

    final dotPaint = Paint()..style = PaintingStyle.fill;
    for (final dot in [
      Offset(size.width * 0.74, size.height * 0.24),
      Offset(size.width * 0.80, size.height * 0.28),
      Offset(size.width * 0.86, size.height * 0.24),
      Offset(size.width * 0.28, size.height * 0.84),
      Offset(size.width * 0.34, size.height * 0.88),
    ]) {
      dotPaint.color = (dot.dx > size.width * 0.5 ? lime : purple).withValues(
        alpha: 0.10,
      );
      canvas.drawCircle(dot, 2.2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _AbstractCardWatermarkPainter oldDelegate) =>
      oldDelegate.lime != lime || oldDelegate.purple != purple;
}

class _PageBackdropPainter extends CustomPainter {
  _PageBackdropPainter({required this.lime, required this.purple});

  final Color lime;
  final Color purple;

  @override
  void paint(Canvas canvas, Size size) {
    final limePaint = Paint()
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = lime.withValues(alpha: 0.032);
    final purplePaint = Paint()
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = purple.withValues(alpha: 0.026);

    final topWave = Path()
      ..moveTo(0, size.height * 0.16)
      ..quadraticBezierTo(
        size.width * 0.22,
        size.height * 0.06,
        size.width * 0.48,
        size.height * 0.15,
      )
      ..quadraticBezierTo(
        size.width * 0.78,
        size.height * 0.26,
        size.width,
        size.height * 0.12,
      );

    final lowerWave = Path()
      ..moveTo(0, size.height * 0.78)
      ..quadraticBezierTo(
        size.width * 0.18,
        size.height * 0.68,
        size.width * 0.44,
        size.height * 0.76,
      )
      ..quadraticBezierTo(
        size.width * 0.74,
        size.height * 0.88,
        size.width,
        size.height * 0.74,
      );

    final sideCurve = Path()
      ..moveTo(size.width * 0.88, 0)
      ..quadraticBezierTo(
        size.width * 0.95,
        size.height * 0.18,
        size.width * 0.82,
        size.height * 0.38,
      )
      ..quadraticBezierTo(
        size.width * 0.70,
        size.height * 0.54,
        size.width * 0.84,
        size.height * 0.76,
      );

    canvas.drawPath(topWave, limePaint);
    canvas.drawPath(lowerWave, purplePaint);
    canvas.drawPath(sideCurve, limePaint);
  }

  @override
  bool shouldRepaint(covariant _PageBackdropPainter old) => false;
}
