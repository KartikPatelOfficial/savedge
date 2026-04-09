import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Frontend-only registry for two pending features that the backend does
/// not yet expose:
///
/// 1. **Hidden orders** — a user can "delete" a pending gift card order from
///    their list. Until the backend ships a real cancel endpoint, we just
///    hide it locally and the deletion is reversible by reinstalling.
///
/// 2. **Open support tickets** — a user can raise a support query for a
///    failed order. We track which orders already have an open ticket so we
///    don't create duplicates. The actual ticket payload is stashed locally;
///    when the backend ships the real endpoint, swap [_persistTicket] for
///    a network call.
class GiftCardLocalActionsService extends ChangeNotifier {
  GiftCardLocalActionsService(this._prefs) {
    _load();
  }

  static const _hiddenKey = 'gift_card_hidden_order_ids';
  static const _ticketsKey = 'gift_card_support_tickets';

  final SharedPreferences _prefs;
  final Set<int> _hidden = <int>{};
  final Map<int, SupportTicket> _tickets = {};

  Set<int> get hiddenOrderIds => Set.unmodifiable(_hidden);
  Map<int, SupportTicket> get tickets => Map.unmodifiable(_tickets);

  void _load() {
    final h = _prefs.getStringList(_hiddenKey) ?? const <String>[];
    _hidden
      ..clear()
      ..addAll(h.map(int.tryParse).whereType<int>());

    final raw = _prefs.getString(_ticketsKey);
    if (raw != null && raw.isNotEmpty) {
      try {
        final list = jsonDecode(raw) as List<dynamic>;
        for (final j in list) {
          final t = SupportTicket.fromJson(j as Map<String, dynamic>);
          _tickets[t.orderId] = t;
        }
      } catch (_) {}
    }
  }

  // ── Hide / unhide orders ──────────────────────────────────────────────

  bool isHidden(int orderId) => _hidden.contains(orderId);

  Future<void> hide(int orderId) async {
    if (_hidden.add(orderId)) {
      await _prefs.setStringList(
        _hiddenKey,
        _hidden.map((e) => e.toString()).toList(growable: false),
      );
      notifyListeners();
    }
  }

  Future<void> unhide(int orderId) async {
    if (_hidden.remove(orderId)) {
      await _prefs.setStringList(
        _hiddenKey,
        _hidden.map((e) => e.toString()).toList(growable: false),
      );
      notifyListeners();
    }
  }

  // ── Support tickets ───────────────────────────────────────────────────

  bool hasOpenTicket(int orderId) => _tickets.containsKey(orderId);

  SupportTicket? ticketFor(int orderId) => _tickets[orderId];

  Future<void> createTicket(SupportTicket ticket) async {
    _tickets[ticket.orderId] = ticket;
    await _persistTickets();
    notifyListeners();
  }

  Future<void> _persistTickets() async {
    final list = _tickets.values.map((t) => t.toJson()).toList();
    await _prefs.setString(_ticketsKey, jsonEncode(list));
  }
}

class SupportTicket {
  const SupportTicket({
    required this.orderId,
    required this.tag,
    required this.subject,
    required this.body,
    required this.createdAt,
    this.status = 'OPEN',
  });

  final int orderId;
  final String tag;
  final String subject;
  final String body;
  final DateTime createdAt;
  final String status;

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'tag': tag,
        'subject': subject,
        'body': body,
        'createdAt': createdAt.toIso8601String(),
        'status': status,
      };

  factory SupportTicket.fromJson(Map<String, dynamic> json) => SupportTicket(
        orderId: json['orderId'] as int,
        tag: json['tag'] as String? ?? 'GENERAL',
        subject: json['subject'] as String? ?? '',
        body: json['body'] as String? ?? '',
        createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ??
            DateTime.now(),
        status: json['status'] as String? ?? 'OPEN',
      );
}
