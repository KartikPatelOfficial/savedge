import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/gift_card_entity.dart';
import '../theme/gc_tokens.dart';
import '../widgets/gc_how_to_redeem_sheet.dart';

/// Beautiful single-card view shown right after a successful purchase or
/// when the user taps an order from "My Gift Cards".
class GiftCardViewPage extends StatelessWidget {
  const GiftCardViewPage({super.key, required this.order});

  final GiftCardOrderEntity order;

  Color get _accent => GcTokens.accentFor(order.giftCardProductId);

  String get _maskedNumber {
    final n = order.woohooCardNumber ?? '';
    if (n.length <= 4) return n;
    final clean = n.replaceAll(RegExp(r'\s+'), '');
    final groups = <String>[];
    for (var i = 0; i < clean.length; i += 4) {
      groups.add(clean.substring(i, (i + 4).clamp(0, clean.length)));
    }
    return groups.join(' ');
  }

  void _copy(BuildContext context, String label, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label copied')),
    );
  }

  Future<void> _share() async {
    final buf = StringBuffer()
      ..writeln('${order.productName} gift card from SavEdge')
      ..writeln('Amount: ₹${order.requestedAmount.toStringAsFixed(0)}');
    if (order.woohooCardNumber != null) {
      buf.writeln('Card number: ${order.woohooCardNumber}');
    }
    if (order.woohooCardPin != null) {
      buf.writeln('PIN: ${order.woohooCardPin}');
    }
    if (order.woohooActivationUrl != null) {
      buf.writeln('Activate: ${order.woohooActivationUrl}');
    }
    await Share.share(buf.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAF7FE),
        surfaceTintColor: const Color(0xFFFAF7FE),
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: GcTokens.textPrimary,
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
          IconButton(
            onPressed: _share,
            icon: const Icon(
              Icons.ios_share_rounded,
              color: GcTokens.textPrimary,
              size: 20,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          _buildCard(),
          const SizedBox(height: 24),
          _buildDetails(context),
          const SizedBox(height: 16),
          _buildActions(context),
          const SizedBox(height: 24),
          _buildOrderMeta(context),
        ],
      ),
    );
  }

  // ── Card ───────────────────────────────────────────────────────────────

  Widget _buildCard() {
    return AspectRatio(
      aspectRatio: 0.78,
      child: Container(
        decoration: BoxDecoration(
          color: GcTokens.brandBlack,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.40),
              offset: const Offset(0, 22),
              blurRadius: 36,
            ),
            BoxShadow(
              color: GcTokens.brandLime.withValues(alpha: 0.10),
              offset: const Offset(0, 0),
              blurRadius: 28,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Purple radial glow bottom-left
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
                      GcTokens.primary.withValues(alpha: 0.55),
                      GcTokens.primary.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            // Lime arc top-right
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
                      GcTokens.brandLime.withValues(alpha: 0.30),
                      GcTokens.brandLime.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            // Diagonal grid lines
            Positioned.fill(child: CustomPaint(painter: _CardGridPainter())),

            // SavEdge wordmark — top right
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

            // EMV chip — top left
            Positioned(top: 22, left: 22, child: _emvChip()),

            // Vertical brand name on left side
            Positioned(
              left: 18,
              top: 70,
              bottom: 70,
              child: RotatedBox(
                quarterTurns: 3,
                child: Center(
                  child: Text(
                    order.productName.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withValues(alpha: 0.6),
                      letterSpacing: 3.5,
                    ),
                  ),
                ),
              ),
            ),

            // Center value
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 26),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    const SizedBox(height: 14),
                    Row(
                      mainAxisSize: MainAxisSize.min,
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
            ),

            // Footer: brand thumb + ACTIVE pill
            Positioned(
              left: 56,
              right: 22,
              bottom: 22,
              child: Row(
                children: [
                  if (order.productImageUrl != null &&
                      order.productImageUrl!.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: SizedBox(
                        width: 36,
                        height: 24,
                        child: CachedNetworkImage(
                          imageUrl: order.productImageUrl!,
                          fit: BoxFit.contain,
                          errorWidget: (_, __, ___) => Icon(
                            Icons.card_giftcard_rounded,
                            color: _accent,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: GcTokens.brandLime.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: GcTokens.brandLime.withValues(alpha: 0.55),
                      ),
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

  Widget _emvChip() {
    return Container(
      width: 44,
      height: 32,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            GcTokens.brandLime,
            GcTokens.brandLimeDark,
          ],
        ),
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: GcTokens.brandLime.withValues(alpha: 0.45),
            offset: const Offset(0, 6),
            blurRadius: 14,
          ),
        ],
      ),
      child: CustomPaint(painter: _CardChipPainter()),
    );
  }

  // ── Details (number / PIN) ─────────────────────────────────────────────

  Widget _buildDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        border: Border.all(color: const Color(0xFFEFEAFB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (order.woohooCardNumber != null)
            _detailRow(
              context,
              'CARD NUMBER',
              _maskedNumber,
              order.woohooCardNumber!,
            ),
          if (order.woohooCardPin != null) ...[
            const SizedBox(height: 14),
            _detailRow(
              context,
              'PIN',
              order.woohooCardPin!,
              order.woohooCardPin!,
            ),
          ],
          if (order.woohooActivationCode != null) ...[
            const SizedBox(height: 14),
            _detailRow(
              context,
              'ACTIVATION CODE',
              order.woohooActivationCode!,
              order.woohooActivationCode!,
            ),
          ],
          if (order.woohooCardExpiry != null) ...[
            const SizedBox(height: 14),
            const Divider(height: 1, color: Color(0xFFEFEAFB)),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(
                  Icons.event_rounded,
                  size: 14,
                  color: GcTokens.textTertiary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Valid till ${_fmt(order.woohooCardExpiry!)}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: GcTokens.textTertiary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _detailRow(
    BuildContext context,
    String label,
    String display,
    String copyValue,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1,
                  color: GcTokens.textTertiary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                display,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                  color: GcTokens.textPrimary,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        Material(
          color: _accent.withValues(alpha: 0.10),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => _copy(context, label.toLowerCase(), copyValue),
            child: Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              child: Icon(Icons.copy_rounded, size: 16, color: _accent),
            ),
          ),
        ),
      ],
    );
  }

  // ── Actions ────────────────────────────────────────────────────────────

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => GcHowToRedeemSheet.show(
              context,
              brandName: order.productName,
              brandUrl: order.woohooActivationUrl,
            ),
            icon: Icon(Icons.menu_book_rounded, size: 16, color: _accent),
            label: Text(
              'How to redeem',
              style: TextStyle(color: _accent, fontWeight: FontWeight.w900),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: _accent.withValues(alpha: 0.4)),
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
              icon: const Icon(Icons.open_in_new_rounded, size: 16),
              label: const Text(
                'Use now',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
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

  Widget _buildOrderMeta(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.receipt_long_rounded,
            size: 16,
            color: GcTokens.textTertiary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Order #${order.id}  ·  ${_fmt(order.created)}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: GcTokens.textTertiary,
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

class _CardChipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.45)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final h1 = size.height * 0.33;
    final h2 = size.height * 0.66;
    canvas.drawLine(Offset(2, h1), Offset(size.width - 2, h1), paint);
    canvas.drawLine(Offset(2, h2), Offset(size.width - 2, h2), paint);

    final v1 = size.width * 0.30;
    final v2 = size.width * 0.70;
    canvas.drawLine(Offset(v1, 2), Offset(v1, size.height - 2), paint);
    canvas.drawLine(Offset(v2, 2), Offset(v2, size.height - 2), paint);

    final center = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 9,
      height: 9,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(center, const Radius.circular(2)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
