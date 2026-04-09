import 'package:flutter/material.dart';

import '../../data/services/gift_card_local_actions_service.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../theme/gc_tokens.dart';

class GcSupportSheet extends StatefulWidget {
  const GcSupportSheet({
    super.key,
    required this.order,
    required this.actions,
  });

  final GiftCardOrderEntity order;
  final GiftCardLocalActionsService actions;

  static Future<void> show(
    BuildContext context, {
    required GiftCardOrderEntity order,
    required GiftCardLocalActionsService actions,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => GcSupportSheet(order: order, actions: actions),
    );
  }

  @override
  State<GcSupportSheet> createState() => _GcSupportSheetState();
}

class _GcSupportSheetState extends State<GcSupportSheet> {
  static const _tags = <String>[
    'PAYMENT_FAILED',
    'CARD_NOT_RECEIVED',
    'WRONG_AMOUNT',
    'INVALID_CODE',
    'REFUND_REQUEST',
    'OTHER',
  ];

  String _tag = 'PAYMENT_FAILED';
  final _bodyCtrl = TextEditingController();
  bool _submitting = false;

  @override
  void initState() {
    super.initState();
    // Default tag based on status
    final s = widget.order.status;
    if (s == GiftCardOrderStatusEntity.refunded) {
      _tag = 'REFUND_REQUEST';
    } else if (s == GiftCardOrderStatusEntity.failed ||
        s == GiftCardOrderStatusEntity.cancelled) {
      _tag = 'PAYMENT_FAILED';
    }
  }

  @override
  void dispose() {
    _bodyCtrl.dispose();
    super.dispose();
  }

  String _prettyTag(String t) =>
      t.replaceAll('_', ' ').toLowerCase().replaceFirstMapped(
            RegExp(r'^.'),
            (m) => m.group(0)!.toUpperCase(),
          );

  Future<void> _submit() async {
    if (_bodyCtrl.text.trim().length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tell us a bit more (at least 10 characters).'),
        ),
      );
      return;
    }
    setState(() => _submitting = true);
    final ok = await widget.actions.createTicket(
      orderId: widget.order.id,
      tag: _tag,
      subject: '${_prettyTag(_tag)} · Order #${widget.order.id}',
      body: _bodyCtrl.text.trim(),
    );
    if (!mounted) return;
    setState(() => _submitting = false);
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Couldn't submit your ticket. Please try again.",
          ),
        ),
      );
      return;
    }
    Navigator.pop(context, true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: GcTokens.brandBlack,
        content: Row(
          children: const [
            Icon(Icons.check_circle_rounded, color: GcTokens.brandLime),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Ticket submitted. Our team will get back to you soon.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final existing = widget.actions.ticketFor(widget.order.id);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: GcTokens.brandBlack,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(GcTokens.rSheet),
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: GcTokens.brandLime.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                      color: GcTokens.brandLime.withValues(alpha: 0.40),
                    ),
                  ),
                  child: const Icon(
                    Icons.support_agent_rounded,
                    color: GcTokens.brandLime,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        existing != null
                            ? 'Ticket already open'
                            : 'Contact support',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Order #${widget.order.id}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.white.withValues(alpha: 0.55),
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            if (existing != null)
              _existingTicketBlock(existing)
            else
              _form(),
          ],
        ),
      ),
    );
  }

  Widget _existingTicketBlock(SupportTicket t) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: GcTokens.brandLime.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: GcTokens.brandLime.withValues(alpha: 0.30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: GcTokens.brandLime.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: GcTokens.brandLime.withValues(alpha: 0.45),
                      ),
                    ),
                    child: Text(
                      _prettyTag(t.tag).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w900,
                        color: GcTokens.brandLime,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    t.status,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withValues(alpha: 0.6),
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                t.body,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Submitted ${_fmtDate(t.createdAt)}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Colors.white.withValues(alpha: 0.55),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Our team will reach out shortly. You'll get a notification when there's an update.",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.65),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: BorderSide(
                color: Colors.white.withValues(alpha: 0.20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GcTokens.rPill),
              ),
            ),
            child: const Text(
              'Got it',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ),
      ],
    );
  }

  Widget _form() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WHAT WENT WRONG?',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
            color: GcTokens.brandLime.withValues(alpha: 0.85),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final tag in _tags)
              GestureDetector(
                onTap: () => setState(() => _tag = tag),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _tag == tag
                        ? GcTokens.brandLime.withValues(alpha: 0.18)
                        : Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(GcTokens.rPill),
                    border: Border.all(
                      color: _tag == tag
                          ? GcTokens.brandLime.withValues(alpha: 0.55)
                          : Colors.white.withValues(alpha: 0.10),
                    ),
                  ),
                  child: Text(
                    _prettyTag(tag),
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: _tag == tag
                          ? GcTokens.brandLime
                          : Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'DESCRIBE THE ISSUE',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
            color: GcTokens.brandLime.withValues(alpha: 0.85),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.10),
            ),
          ),
          child: TextField(
            controller: _bodyCtrl,
            maxLines: 4,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: const InputDecoration(
              hintText: 'Tell us what happened…',
              hintStyle: TextStyle(
                color: Colors.white38,
                fontSize: 13,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(14),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 14,
                color: Colors.white.withValues(alpha: 0.65),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'We\'ll attach order #${widget.order.id} (${widget.order.productName}) automatically.',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withValues(alpha: 0.65),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitting ? null : _submit,
            style: ElevatedButton.styleFrom(
              backgroundColor: GcTokens.brandLime,
              foregroundColor: GcTokens.brandBlack,
              disabledBackgroundColor:
                  GcTokens.brandLime.withValues(alpha: 0.35),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GcTokens.rPill),
              ),
            ),
            child: _submitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: GcTokens.brandBlack,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Submit ticket',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}
