import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stateful registry for two gift-card-order actions:
///
/// 1. **Hidden orders** — frontend-only "delete" for pending orders. The
///    backend has no cancel endpoint yet, so we hide locally via
///    [SharedPreferences].
///
/// 2. **Support tickets** — backed by the real API at
///    `/api/gift-card-support/tickets`. We mirror the user's open tickets
///    in memory so [hasOpenTicket] / [ticketFor] are synchronous lookups.
///    Call [refreshTickets] on app start (or page mount) to hydrate.
class GiftCardLocalActionsService extends ChangeNotifier {
  GiftCardLocalActionsService(this._prefs, this._dio) {
    _loadHidden();
  }

  static const _hiddenKey = 'gift_card_hidden_order_ids';

  final SharedPreferences _prefs;
  final Dio _dio;
  final Set<int> _hidden = <int>{};
  final Map<int, SupportTicket> _tickets = {};
  bool _ticketsLoaded = false;

  Set<int> get hiddenOrderIds => Set.unmodifiable(_hidden);
  Map<int, SupportTicket> get tickets => Map.unmodifiable(_tickets);
  bool get ticketsLoaded => _ticketsLoaded;

  void _loadHidden() {
    final h = _prefs.getStringList(_hiddenKey) ?? const <String>[];
    _hidden
      ..clear()
      ..addAll(h.map(int.tryParse).whereType<int>());
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

  // ── Support tickets (backed by /api/gift-card-support/tickets) ────────

  bool hasOpenTicket(int orderId) => _tickets.containsKey(orderId);

  SupportTicket? ticketFor(int orderId) => _tickets[orderId];

  /// Hydrate the in-memory ticket cache from the backend. Safe to call
  /// repeatedly — only fetches once per app session unless [force] is true.
  Future<void> refreshTickets({bool force = false}) async {
    if (_ticketsLoaded && !force) return;
    try {
      final response = await _dio.get('/api/gift-card-support/tickets');
      final data = response.data;
      if (data is List) {
        _tickets.clear();
        for (final raw in data) {
          if (raw is Map<String, dynamic>) {
            final t = SupportTicket.fromBackendJson(raw);
            // Only mirror tickets the user can see as "open" in the UI
            if (t.status == 'Open' || t.status == 'InProgress') {
              _tickets[t.orderId] = t;
            }
          }
        }
        _ticketsLoaded = true;
        notifyListeners();
      }
    } catch (_) {
      // Silently ignore — tickets are non-critical for UI rendering.
    }
  }

  /// POST a new ticket to the backend. The server prevents duplicates by
  /// (user, order, open|inProgress) and may return an existing ticket id.
  Future<bool> createTicket({
    required int orderId,
    required String tag,
    required String subject,
    required String body,
  }) async {
    try {
      await _dio.post(
        '/api/gift-card-support/tickets',
        data: {
          'giftCardOrderId': orderId,
          'tag': tag,
          'subject': subject,
          'body': body,
        },
      );
      // Mirror locally so the UI updates instantly without a refetch.
      _tickets[orderId] = SupportTicket(
        orderId: orderId,
        tag: tag,
        subject: subject,
        body: body,
        createdAt: DateTime.now(),
      );
      notifyListeners();
      return true;
    } on DioException catch (e) {
      debugPrint('createTicket failed: ${e.message}');
      return false;
    } catch (_) {
      return false;
    }
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

  /// Backend DTO uses `giftCardOrderId` and a CamelCase status enum.
  factory SupportTicket.fromBackendJson(Map<String, dynamic> json) =>
      SupportTicket(
        orderId: (json['giftCardOrderId'] as num?)?.toInt() ?? 0,
        tag: json['tag'] as String? ?? 'OTHER',
        subject: json['subject'] as String? ?? '',
        body: json['body'] as String? ?? '',
        createdAt:
            DateTime.tryParse(json['createdAt'] as String? ?? '') ??
                DateTime.now(),
        status: json['status'] as String? ?? 'Open',
      );
}
