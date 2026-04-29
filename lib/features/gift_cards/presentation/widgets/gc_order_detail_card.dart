import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/gift_card_entity.dart';
import '../theme/gc_tokens.dart';
import 'gc_how_to_redeem_sheet.dart';

class GcOrderDetailCard extends StatefulWidget {
  const GcOrderDetailCard({super.key, required this.order});

  final GiftCardOrderEntity order;

  @override
  State<GcOrderDetailCard> createState() => _GcOrderDetailCardState();
}

class _GcOrderDetailCardState extends State<GcOrderDetailCard> {
  bool _expanded = false;

  Color get _statusColor {
    switch (widget.order.status) {
      case GiftCardOrderStatusEntity.completed:
        return GcTokens.success;
      case GiftCardOrderStatusEntity.failed:
      case GiftCardOrderStatusEntity.cancelled:
        return GcTokens.danger;
      case GiftCardOrderStatusEntity.refunded:
        return Colors.blueGrey;
      default:
        return GcTokens.warning;
    }
  }

  Color get _accent => GcTokens.accentFor(widget.order.giftCardProductId);
  Color get _bg => GcTokens.bgFor(widget.order.giftCardProductId);

  void _copy(String label, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$label copied')),
    );
  }

  Future<void> _share() async {
    final o = widget.order;
    final qtyLabel = o.quantity > 1 ? ' x ${o.quantity}' : '';
    final buf = StringBuffer()
      ..writeln('${o.productName} gift card from SavEdge')
      ..writeln('Amount: ₹${o.requestedAmount.toStringAsFixed(0)}$qtyLabel');
    if (o.woohooCardNumber != null) {
      buf.writeln('Card: ${o.woohooCardNumber}');
    }
    if (o.woohooCardPin != null) {
      buf.writeln('PIN: ${o.woohooCardPin}');
    }
    if (o.woohooActivationUrl != null) {
      buf.writeln('Activate: ${o.woohooActivationUrl}');
    }
    await Share.share(buf.toString());
  }

  @override
  Widget build(BuildContext context) {
    final o = widget.order;
    final canExpand = o.hasCardDetails;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        child: InkWell(
          onTap: canExpand ? () => setState(() => _expanded = !_expanded) : null,
          borderRadius: BorderRadius.circular(GcTokens.rCard),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GcTokens.rCard),
              border: Border.all(color: const Color(0xFFEFEAFB)),
              boxShadow: GcTokens.tinyShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _header(o),
                if (_expanded && canExpand) _details(o),
                if (!_expanded && canExpand)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: _accent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tap to reveal card details',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: _accent,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(GiftCardOrderEntity o) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: _bg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: o.productImageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: o.productImageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Icon(
                        Icons.card_giftcard_rounded,
                        color: _accent,
                      ),
                    )
                  : Icon(Icons.card_giftcard_rounded, color: _accent),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  o.productName,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w900,
                    color: GcTokens.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  o.quantity > 1
                      ? '₹${o.requestedAmount.toStringAsFixed(0)} x ${o.quantity} · #${o.id}'
                      : '₹${o.requestedAmount.toStringAsFixed(0)} · #${o.id}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: GcTokens.textTertiary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    o.status.displayName,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      color: _statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _details(GiftCardOrderEntity o) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_accent.withValues(alpha: 0.06), Colors.white],
        ),
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        border: Border.all(color: _accent.withValues(alpha: 0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (o.woohooCardNumber != null)
            _detailRow(
              'Card number',
              o.woohooCardNumber!,
              onCopy: () => _copy('Card number', o.woohooCardNumber!),
            ),
          if (o.woohooCardPin != null) ...[
            const SizedBox(height: 10),
            _detailRow(
              'PIN',
              o.woohooCardPin!,
              onCopy: () => _copy('PIN', o.woohooCardPin!),
            ),
          ],
          if (o.woohooActivationCode != null) ...[
            const SizedBox(height: 10),
            _detailRow(
              'Activation code',
              o.woohooActivationCode!,
              onCopy: () => _copy('Code', o.woohooActivationCode!),
            ),
          ],
          if (o.woohooCardExpiry != null) ...[
            const SizedBox(height: 10),
            Text(
              'Valid till ${_fmt(o.woohooCardExpiry!)}',
              style: const TextStyle(
                fontSize: 11.5,
                color: GcTokens.textTertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => GcHowToRedeemSheet.show(
                    context,
                    brandName: o.productName,
                    brandUrl: o.woohooActivationUrl,
                  ),
                  icon: const Icon(Icons.menu_book_rounded, size: 16),
                  label: const Text('How to redeem'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _accent,
                    side: BorderSide(color: _accent.withValues(alpha: 0.4)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(GcTokens.rPill),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _share,
                  icon: const Icon(Icons.share_rounded, size: 16),
                  label: const Text('Share'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(GcTokens.rPill),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (o.woohooActivationUrl != null) ...[
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => launchUrl(
                Uri.parse(o.woohooActivationUrl!),
                mode: LaunchMode.externalApplication,
              ),
              icon: const Icon(Icons.open_in_new_rounded, size: 16),
              label: const Text('Open activation link'),
              style: TextButton.styleFrom(foregroundColor: _accent),
            ),
          ],
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, {required VoidCallback onCopy}) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w900,
                  color: GcTokens.textTertiary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: GcTokens.textPrimary,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onCopy,
          icon: Icon(Icons.copy_rounded, size: 18, color: _accent),
          tooltip: 'Copy',
        ),
      ],
    );
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
