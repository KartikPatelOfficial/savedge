import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/gift_card_entity.dart';

// ── Palettes (same as product card) ──────────────────────────────────────────
const _palettes = [
  Color(0xFFF3EFFE),
  Color(0xFFFFF0E6),
  Color(0xFFE6F9F0),
  Color(0xFFE6F3FF),
  Color(0xFFFFF3E6),
  Color(0xFFFCE6F0),
];
const _accents = [
  Color(0xFF7C3AED),
  Color(0xFFEA580C),
  Color(0xFF059669),
  Color(0xFF2563EB),
  Color(0xFFD97706),
  Color(0xFFDB2777),
];

class GiftCardOrderCard extends StatelessWidget {
  final GiftCardOrderEntity order;

  const GiftCardOrderCard({super.key, required this.order});

  Color get _accent => _accents[order.giftCardProductId % _accents.length];
  Color get _paletteBg => _palettes[order.giftCardProductId % _palettes.length];

  Color _statusColor() {
    switch (order.status) {
      case GiftCardOrderStatusEntity.completed:
        return const Color(0xFF059669);
      case GiftCardOrderStatusEntity.failed:
        return const Color(0xFFDC2626);
      case GiftCardOrderStatusEntity.cancelled:
        return const Color(0xFF6B7280);
      case GiftCardOrderStatusEntity.refunded:
        return const Color(0xFFA855F7);
      case GiftCardOrderStatusEntity.issuing:
        return const Color(0xFF7C3AED);
      case GiftCardOrderStatusEntity.paymentCompleted:
        return const Color(0xFF2563EB);
      case GiftCardOrderStatusEntity.pending:
        return const Color(0xFFD97706);
    }
  }

  Color _bottomBg() {
    switch (order.status) {
      case GiftCardOrderStatusEntity.completed:
        return const Color(0xFFF0FDF4);
      case GiftCardOrderStatusEntity.failed:
        return const Color(0xFFFEF2F2);
      case GiftCardOrderStatusEntity.refunded:
        return const Color(0xFFF5F3FF);
      case GiftCardOrderStatusEntity.pending:
        return const Color(0xFFFFFBEB);
      case GiftCardOrderStatusEntity.issuing:
      case GiftCardOrderStatusEntity.paymentCompleted:
        return const Color(0xFFEFF6FF);
      case GiftCardOrderStatusEntity.cancelled:
        return const Color(0xFFF9FAFB);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: ClipPath(
        clipper: _OrderCardClipper(),
        child: CustomPaint(
          foregroundPainter: _DashedDividerPainter(
            color: _statusColor().withAlpha(40),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF0F0F0), width: 1.5),
            ),
            child: Column(
              children: [
                // ── Top section: product info + amounts ──
                _buildTopSection(context),

                // ── Bottom section: status-specific content ──
                _buildBottomSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // TOP SECTION
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildTopSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        children: [
          // Row 1: image + name + status
          Row(
            children: [
              // Product thumbnail
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _paletteBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: order.productImageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: order.productImageUrl!,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Icon(
                          Icons.card_giftcard_rounded,
                          color: _accent.withAlpha(120),
                          size: 22,
                        ),
                        errorWidget: (_, __, ___) => Icon(
                          Icons.card_giftcard_rounded,
                          color: _accent.withAlpha(120),
                          size: 22,
                        ),
                      )
                    : Icon(
                        Icons.card_giftcard_rounded,
                        color: _accent.withAlpha(120),
                        size: 22,
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            order.productName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111827),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (order.quantity > 1) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _accent.withAlpha(30),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'x${order.quantity}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: _accent,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Order #${order.id} · ${_formatDate(order.created)}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Status badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor().withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _statusColor().withAlpha(60),
                    width: 1,
                  ),
                ),
                child: Text(
                  order.status.displayName,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _statusColor(),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Row 2: amounts
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _AmountChip(
                  label: 'Card Value',
                  value: '₹${order.requestedAmount.toStringAsFixed(0)}',
                ),
                if (order.discountAmount > 0)
                  _AmountChip(
                    label: 'Saved',
                    value: '₹${order.discountAmount.toStringAsFixed(0)}',
                    valueColor: const Color(0xFF059669),
                  ),
                _AmountChip(
                  label: 'Paid',
                  value:
                      order.paymentMethod == GiftCardPaymentMethodEntity.points
                          ? '${order.payableAmount.toStringAsFixed(0)} pts'
                          : '₹${order.payableAmount.toStringAsFixed(0)}',
                  valueColor: const Color(0xFF6F3FCC),
                  isBold: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // BOTTOM SECTION (status-specific)
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildBottomSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: _bottomBg(),
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: _buildStatusContent(context),
    );
  }

  Widget _buildStatusContent(BuildContext context) {
    switch (order.status) {
      case GiftCardOrderStatusEntity.completed:
        return _buildCompletedContent(context);
      case GiftCardOrderStatusEntity.failed:
        return _buildFailedContent(context);
      case GiftCardOrderStatusEntity.refunded:
        return _buildRefundedContent();
      case GiftCardOrderStatusEntity.pending:
      case GiftCardOrderStatusEntity.issuing:
      case GiftCardOrderStatusEntity.paymentCompleted:
        return _buildProcessingContent();
      case GiftCardOrderStatusEntity.cancelled:
        return _buildCancelledContent();
    }
  }

  // ── Completed: show card details ──────────────────────────────────────────
  Widget _buildCompletedContent(BuildContext context) {
    final hasCardNumber =
        order.woohooCardNumber != null && order.woohooCardNumber!.isNotEmpty;
    final hasActivationUrl = order.woohooActivationUrl != null &&
        order.woohooActivationUrl!.isNotEmpty;

    if (!hasCardNumber && !hasActivationUrl) {
      return Row(
        children: [
          Icon(Icons.check_circle_rounded,
              size: 18, color: _statusColor()),
          const SizedBox(width: 8),
          const Text(
            'Gift card issued successfully',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF059669),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.credit_card_rounded,
                size: 16, color: Color(0xFF059669)),
            const SizedBox(width: 6),
            const Text(
              'Gift Card Details',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF059669),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Card number - prominent
        if (order.woohooCardNumber != null)
          _CardDetailRow(
            label: 'Card Number',
            value: order.woohooCardNumber!,
            isMonospace: true,
            isLarge: true,
            context: context,
          ),
        if (order.woohooCardPin != null)
          _CardDetailRow(
            label: 'PIN',
            value: order.woohooCardPin!,
            isMonospace: true,
            context: context,
          ),
        if (order.woohooActivationCode != null)
          _CardDetailRow(
            label: 'Code',
            value: order.woohooActivationCode!,
            isMonospace: true,
            context: context,
          ),
        if (order.woohooCardExpiry != null)
          _CardDetailRow(
            label: 'Expires',
            value: _formatDate(order.woohooCardExpiry!),
            copyable: false,
            context: context,
          ),
        if (hasActivationUrl) ...[
          const SizedBox(height: 4),
          _ActivationUrlButton(url: order.woohooActivationUrl!),
        ],
      ],
    );
  }

  // ── Failed: failure reason + optional refund info ─────────────────────────
  Widget _buildFailedContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (order.failureReason != null) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.error_outline_rounded,
                  size: 16, color: Color(0xFFDC2626)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  order.failureReason!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFDC2626),
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
        if (order.hasRefundDetails) ...[
          const SizedBox(height: 10),
          _buildRefundDetails(),
        ],
      ],
    );
  }

  // ── Refunded: show refund details prominently ─────────────────────────────
  Widget _buildRefundedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.replay_rounded,
                size: 16, color: Color(0xFFA855F7)),
            const SizedBox(width: 6),
            const Text(
              'Payment Refunded',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFFA855F7),
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _buildRefundDetails(),
      ],
    );
  }

  // ── Processing: animated indicator ────────────────────────────────────────
  Widget _buildProcessingContent() {
    return Row(
      children: [
        SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: _statusColor(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            order.status.description,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _statusColor(),
            ),
          ),
        ),
      ],
    );
  }

  // ── Cancelled ─────────────────────────────────────────────────────────────
  Widget _buildCancelledContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.block_rounded,
                size: 16, color: Color(0xFF6B7280)),
            const SizedBox(width: 6),
            const Text(
              'This order was cancelled',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
        if (order.hasRefundDetails) ...[
          const SizedBox(height: 10),
          _buildRefundDetails(),
        ],
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // REFUND DETAILS
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildRefundDetails() {
    final refundColor = order.refundStatus == 'processed'
        ? const Color(0xFF059669)
        : order.refundStatus == 'pending'
            ? const Color(0xFFD97706)
            : const Color(0xFFA855F7);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(180),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF0ABFC).withAlpha(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (order.refundAmount != null && order.refundAmount! > 0)
            _RefundRow(
              label: 'Refund Amount',
              child: Text(
                '₹${order.refundAmount!.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: refundColor,
                ),
              ),
            ),
          if (order.pointsRefunded != null && order.pointsRefunded! > 0)
            _RefundRow(
              label: 'Points Refunded',
              child: Text(
                '${order.pointsRefunded} pts',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFA855F7),
                ),
              ),
            ),
          if (order.refundStatus != null)
            _RefundRow(
              label: 'Status',
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: refundColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  order.refundStatus!.split(':').first.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: refundColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          if (order.razorpayRefundId != null)
            _RefundRow(
              label: 'Refund ID',
              child: Text(
                order.razorpayRefundId!,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'monospace',
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
          if (order.refundedAt != null)
            _RefundRow(
              label: 'Refunded',
              child: Text(
                _formatDate(order.refundedAt!),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.day}/${date.month}/${date.year}';
}

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

class _AmountChip extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const _AmountChip({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Color(0xFF9CA3AF),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 15 : 13,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            color: valueColor ?? const Color(0xFF111827),
          ),
        ),
      ],
    );
  }
}

class _CardDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isMonospace;
  final bool isLarge;
  final bool copyable;
  final BuildContext context;

  const _CardDetailRow({
    required this.label,
    required this.value,
    this.isMonospace = false,
    this.isLarge = false,
    this.copyable = true,
    required this.context,
  });

  @override
  Widget build(BuildContext _) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: isLarge ? 15 : 13,
                fontWeight: isLarge ? FontWeight.w800 : FontWeight.w600,
                fontFamily: isMonospace ? 'monospace' : null,
                color: const Color(0xFF111827),
                letterSpacing: isMonospace ? 0.5 : 0,
              ),
            ),
          ),
          if (copyable)
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$label copied'),
                    duration: const Duration(seconds: 1),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: const Color(0xFF6F3FCC),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF059669).withAlpha(15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.copy_rounded,
                    size: 14, color: Color(0xFF059669)),
              ),
            ),
        ],
      ),
    );
  }
}

class _RefundRow extends StatelessWidget {
  final String label;
  final Widget child;

  const _RefundRow({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _ActivationUrlButton extends StatelessWidget {
  final String url;

  const _ActivationUrlButton({required this.url});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        ),
        icon: const Icon(Icons.open_in_new_rounded, size: 16),
        label: const Text(
          'Redeem on brand site',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF059669),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// COUPON-SHAPE CLIPPER + DASHED LINE
// ═══════════════════════════════════════════════════════════════════════════════

class _OrderCardClipper extends CustomClipper<Path> {
  static const double _notchRadius = 10.0;
  static const double _cornerRadius = 16.0;
  static const double _notchRatio = 0.52; // where the "tear" sits

  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRRect(RRect.fromLTRBR(
        0, 0, size.width, size.height,
        const Radius.circular(_cornerRadius),
      ));

    final yPos = size.height * _notchRatio;

    final leftNotch = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(0, yPos), radius: _notchRadius));
    final rightNotch = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width, yPos), radius: _notchRadius));

    return Path.combine(
      PathOperation.difference,
      Path.combine(PathOperation.difference, path, leftNotch),
      rightNotch,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _DashedDividerPainter extends CustomPainter {
  final Color color;

  _DashedDividerPainter({this.color = const Color(0xFFE5E7EB)});

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height * _OrderCardClipper._notchRatio;
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    double startX = 14.0; // past the notch
    final endX = size.width - 14.0;

    while (startX < endX) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
