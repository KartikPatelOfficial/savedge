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

  // Flip
  late final AnimationController _flipCtrl;
  late final Animation<double> _flipAnim;
  bool _showingBack = false;
  bool _showScrolledAppBar = false;

  GiftCardOrderEntity get order => widget.order;

  // Cardholder name
  String? _userName;

  @override
  void initState() {
    super.initState();

    _loadUser();

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

  void _updateScrolledAppBar(double offset) {
    final shouldShow = offset > 6;
    if (!mounted || shouldShow == _showScrolledAppBar) return;
    setState(() => _showScrolledAppBar = shouldShow);
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
      color: bgColor ?? const Color(0xFFE9ECF1),
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
            color: bgColor ?? const Color(0xFFE9ECF1),
            border: Border.all(color: borderColor ?? const Color(0xFFD6DCE5)),
          ),
          child: Icon(
            Icons.copy_rounded,
            size: 14,
            color: iconColor ?? const Color(0xFF6B7280),
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
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        flexibleSpace: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: _showScrolledAppBar
              ? ClipRect(
                  key: const ValueKey('scrolled-app-bar'),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.72),
                        border: Border(
                          bottom: BorderSide(
                            color: GcTokens.primary.withValues(alpha: 0.06),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(key: ValueKey('idle-app-bar')),
        ),
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
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification.metrics.axis == Axis.vertical) {
                _updateScrolledAppBar(notification.metrics.pixels);
              }
              return false;
            },
            child: ListView(
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
          ),
        ],
      ),
    );
  }

  Widget _buildPageBackground() {
    return IgnorePointer(child: Container(color: Colors.white));
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: const Color(0xFFFFFEFD),
      borderRadius: BorderRadius.circular(28),
      border: Border.all(
        color: Color.lerp(
          GcTokens.primary.withValues(alpha: 0.14),
          GcTokens.brandLimeDark.withValues(alpha: 0.18),
          0.5,
        )!,
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: GcTokens.primary.withValues(alpha: 0.34),
          offset: const Offset(0, 34),
          blurRadius: 82,
          spreadRadius: -6,
        ),
        BoxShadow(
          color: GcTokens.brandLime.withValues(alpha: 0.18),
          offset: const Offset(0, -20),
          blurRadius: 64,
          spreadRadius: 2,
        ),
        BoxShadow(
          color: GcTokens.primary.withValues(alpha: 0.16),
          offset: const Offset(0, 18),
          blurRadius: 92,
          spreadRadius: 16,
        ),
        BoxShadow(
          color: GcTokens.brandLimeDark.withValues(alpha: 0.05),
          offset: const Offset(0, -8),
          blurRadius: 54,
          spreadRadius: 2,
        ),
        BoxShadow(
          color: Colors.white.withValues(alpha: 0.78),
          offset: const Offset(0, -6),
          blurRadius: 18,
          spreadRadius: -12,
        ),
      ],
    );
  }

  List<Widget> _cardDecorativeLayers() {
    return [
      Positioned.fill(
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Color(0xFFFFFEFD)),
        ),
      ),
      Positioned(
        top: -74,
        left: -42,
        child: _softGlowBlob(
          width: 320,
          height: 220,
          color: GcTokens.brandLime.withValues(alpha: 0.15),
          blurRadius: 120,
          spreadRadius: 24,
        ),
      ),
      Positioned(
        top: 14,
        right: -34,
        child: _softGlowBlob(
          width: 220,
          height: 170,
          color: GcTokens.brandLime.withValues(alpha: 0.08),
          blurRadius: 92,
          spreadRadius: 12,
        ),
      ),
      Positioned(
        bottom: -88,
        left: -34,
        right: -34,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: _softGlowBlob(
            width: 460,
            height: 280,
            color: GcTokens.primary.withValues(alpha: 0.12),
            blurRadius: 132,
            spreadRadius: 30,
          ),
        ),
      ),
      Positioned(
        top: 76,
        right: 18,
        child: Icon(
          Icons.card_giftcard_rounded,
          size: 98,
          color: GcTokens.brandLimeDark.withValues(alpha: 0.10),
        ),
      ),
      Positioned(
        top: 170,
        left: 18,
        child: Transform.rotate(
          angle: -0.2,
          child: Icon(
            Icons.redeem_rounded,
            size: 78,
            color: GcTokens.brandLimeDark.withValues(alpha: 0.05),
          ),
        ),
      ),
      Positioned(
        bottom: 152,
        right: 34,
        child: Transform.rotate(
          angle: 0.22,
          child: Icon(
            Icons.local_offer_rounded,
            size: 54,
            color: GcTokens.primary.withValues(alpha: 0.10),
          ),
        ),
      ),
      Positioned(
        left: 22,
        right: 22,
        top: 142,
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                GcTokens.brandLimeDark.withValues(alpha: 0.20),
                GcTokens.primary.withValues(alpha: 0.18),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      Positioned(
        left: 22,
        right: 22,
        bottom: 116,
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                GcTokens.primary.withValues(alpha: 0.18),
                GcTokens.brandLimeDark.withValues(alpha: 0.18),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  Widget _softGlowBlob({
    required double width,
    required double height,
    required Color color,
    required double blurRadius,
    required double spreadRadius,
  }) {
    return IgnorePointer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(math.max(width, height)),
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: blurRadius,
              spreadRadius: spreadRadius,
            ),
          ],
        ),
      ),
    );
  }

  Widget _metaTile(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.74),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Color.lerp(
            GcTokens.brandLimeDark.withValues(alpha: 0.16),
            GcTokens.primary.withValues(alpha: 0.10),
            0.35,
          )!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 7.5,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.1,
              color: GcTokens.textTertiary.withValues(alpha: 0.74),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: GcTokens.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _currency(double value) => '₹${value.toStringAsFixed(0)}';

  String get _pointsUsedText {
    final points = order.totalPointsUsed;
    if (points <= 0) return 'Not used';
    return points % 1 == 0
        ? '${points.toStringAsFixed(0)} pts'
        : '${points.toStringAsFixed(1)} pts';
  }

  Widget _lightCircleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white.withValues(alpha: 0.66),
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
            color: Colors.white.withValues(alpha: 0.74),
            border: Border.all(
              color: Color.lerp(
                GcTokens.brandLimeDark.withValues(alpha: 0.40),
                GcTokens.primary.withValues(alpha: 0.18),
                0.35,
              )!,
            ),
            boxShadow: [
              BoxShadow(
                color: GcTokens.primary.withValues(alpha: 0.06),
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
        animation: _flipAnim,
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
            Positioned(
              top: 18,
              left: 22,
              right: 22,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
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
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'ORDER #${order.id}',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                          color: GcTokens.primary.withValues(alpha: 0.52),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _fmt(order.created),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: GcTokens.textSecondary.withValues(alpha: 0.82),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              top: 84,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: GcTokens.textPrimary,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Issued to ${(_userName ?? 'card holder').trim()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: GcTokens.textSecondary.withValues(alpha: 0.82),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              top: 176,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GIFT CARD VALUE',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.6,
                      color: GcTokens.primary.withValues(alpha: 0.56),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\u20B9',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: GcTokens.textPrimary.withValues(alpha: 0.78),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        (order.woohooActivatedAmount ?? order.requestedAmount)
                            .toStringAsFixed(0),
                        style: const TextStyle(
                          fontSize: 58,
                          fontWeight: FontWeight.w900,
                          color: GcTokens.textPrimary,
                          height: 1.0,
                          letterSpacing: -2,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            order.status.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.2,
                              color: GcTokens.brandLimeDark.withValues(
                                alpha: 0.86,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Ready to use',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: GcTokens.textSecondary.withValues(
                                alpha: 0.72,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Use this gift card online or in store where accepted.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 1.45,
                      color: GcTokens.textSecondary.withValues(alpha: 0.76),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              bottom: 22,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.94),
                  borderRadius: BorderRadius.circular(18),
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
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(height: 1, color: GcTokens.border),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'VALID THRU',
                                  style: TextStyle(
                                    fontSize: 7.5,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                    color: GcTokens.textTertiary.withValues(
                                      alpha: 0.70,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _validity,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    color: GcTokens.textPrimary,
                                    letterSpacing: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (order.woohooActivationCode != null &&
                            order.woohooActivationCode!.isNotEmpty) ...[
                          const SizedBox(width: 10),
                          Expanded(
                            child: _metaTile(
                              'Activation',
                              order.woohooActivationCode!,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
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
                color: const Color(0xFFCBD5E1).withValues(alpha: 0.82),
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
                      color: Colors.white.withValues(alpha: 0.90),
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
                                        color: const Color(0xFFE9ECF1),
                                        border: Border.all(
                                          color: const Color(0xFFD6DCE5),
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.copy_rounded,
                                        size: 15,
                                        color: const Color(0xFF6B7280),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Color.lerp(
            GcTokens.primary.withValues(alpha: 0.08),
            GcTokens.brandLimeDark.withValues(alpha: 0.18),
            0.30,
          )!,
        ),
        boxShadow: [
          BoxShadow(
            color: GcTokens.primary.withValues(alpha: 0.05),
            offset: const Offset(0, 14),
            blurRadius: 24,
            spreadRadius: -18,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _metaTile('You Save', _currency(order.discountAmount)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _metaTile('Payable', _currency(order.payableAmount)),
              ),
              const SizedBox(width: 10),
              Expanded(child: _metaTile('Points', _pointsUsedText)),
            ],
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: GcTokens.border),
          const SizedBox(height: 14),
          Row(
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
