import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/auth/data/models/user_profile_models.dart';
import 'package:savedge/features/auth/domain/repositories/auth_repository.dart';

import '../../data/services/gift_card_local_actions_service.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../bloc/gift_cards_bloc.dart';
import '../theme/gc_tokens.dart';
import '../widgets/gc_empty_state.dart';
import '../widgets/gc_skeleton.dart';
import '../widgets/gc_support_sheet.dart';

enum _OrdersTab { all, active, processing, failed }

extension on _OrdersTab {
  String get label {
    switch (this) {
      case _OrdersTab.all:
        return 'All';
      case _OrdersTab.active:
        return 'Active';
      case _OrdersTab.processing:
        return 'Processing';
      case _OrdersTab.failed:
        return 'Failed';
    }
  }

  bool match(GiftCardOrderStatusEntity s) {
    switch (this) {
      case _OrdersTab.all:
        return true;
      case _OrdersTab.active:
        return s == GiftCardOrderStatusEntity.completed;
      case _OrdersTab.processing:
        return s == GiftCardOrderStatusEntity.pending ||
            s == GiftCardOrderStatusEntity.paymentCompleted ||
            s == GiftCardOrderStatusEntity.issuing;
      case _OrdersTab.failed:
        return s == GiftCardOrderStatusEntity.failed ||
            s == GiftCardOrderStatusEntity.cancelled ||
            s == GiftCardOrderStatusEntity.refunded;
    }
  }
}

class GiftCardOrdersPage extends StatelessWidget {
  const GiftCardOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<GiftCardsBloc>()..add(const LoadGiftCardOrders()),
      child: const _OrdersView(),
    );
  }
}

class _OrdersView extends StatefulWidget {
  const _OrdersView();

  @override
  State<_OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<_OrdersView> {
  _OrdersTab _tab = _OrdersTab.all;
  final GiftCardLocalActionsService _actions =
      getIt<GiftCardLocalActionsService>();

  String? _userName;

  bool _searching = false;
  final TextEditingController _searchCtrl = TextEditingController();
  String _searchQuery = '';

  // Tilt for the stats card
  StreamSubscription<GyroscopeEvent>? _gyroSub;
  double _tiltX = 0;
  double _tiltY = 0;

  @override
  void initState() {
    super.initState();
    _actions.addListener(_onActionsChanged);
    _actions.refreshTickets();
    _loadUser();
    _gyroSub = gyroscopeEventStream().listen((e) {
      if (!mounted) return;
      setState(() {
        _tiltX = (_tiltX + e.y * 0.03).clamp(-0.12, 0.12);
        _tiltY = (_tiltY + e.x * 0.03).clamp(-0.12, 0.12);
        _tiltX *= 0.92;
        _tiltY *= 0.92;
      });
    });
  }

  Future<void> _loadUser() async {
    try {
      final profile = await getIt<AuthRepository>().getCurrentUserProfile();
      if (!mounted) return;
      setState(() => _userName = profile.displayName);
    } catch (_) {
      // ignore — fall back to no name
    }
  }

  @override
  void dispose() {
    _gyroSub?.cancel();
    _actions.removeListener(_onActionsChanged);
    _searchCtrl.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _searching = !_searching;
      if (!_searching) {
        _searchCtrl.clear();
        _searchQuery = '';
      }
    });
  }

  void _onActionsChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<GiftCardsBloc, GiftCardsState>(
          buildWhen: (_, s) =>
              s is GiftCardOrdersLoading ||
              s is GiftCardOrdersLoaded ||
              s is GiftCardOrdersError,
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                _buildAppBar(),
                SliverToBoxAdapter(child: _buildStatsCard(state)),
                SliverToBoxAdapter(child: _buildTabs()),
                ..._buildBody(state),
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            );
          },
        ),
      ),
    );
  }

  // ── App bar ────────────────────────────────────────────────────────────

  Widget _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarHeight: 60,
      leading: IconButton(
        onPressed: () {
          if (_searching) {
            _toggleSearch();
          } else {
            Navigator.pop(context);
          }
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: GcTokens.textPrimary,
        ),
      ),
      title: _searching
          ? TextField(
              controller: _searchCtrl,
              autofocus: true,
              cursorColor: GcTokens.primary,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: GcTokens.textPrimary,
              ),
              decoration: const InputDecoration(
                hintText: 'Search by brand or order #',
                hintStyle: TextStyle(
                  color: GcTokens.textTertiary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: (v) => setState(() => _searchQuery = v.trim()),
            )
          : const Text(
              'My Gift Cards',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: GcTokens.textPrimary,
              ),
            ),
      titleSpacing: 0,
      actions: [
        IconButton(
          icon: Icon(
            _searching ? Icons.close_rounded : Icons.search_rounded,
            color: GcTokens.textPrimary,
            size: 22,
          ),
          onPressed: _toggleSearch,
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  // ── Stats card with gyroscope tilt ────────────────────────────────────

  Widget _buildStatsCard(GiftCardsState state) {
    int total = 0;
    int active = 0;
    double activeValue = 0;
    if (state is GiftCardOrdersLoaded) {
      final visible = state.orders
          .where((o) => !_actions.isHidden(o.id))
          .toList();
      total = visible.length;
      for (final o in visible) {
        if (o.status == GiftCardOrderStatusEntity.completed) {
          active++;
          activeValue += o.woohooActivatedAmount ?? o.requestedAmount;
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0012)
          ..rotateX(_tiltY)
          ..rotateY(_tiltX),
        child: AspectRatio(
          aspectRatio: 1.78,
          child: Container(
            decoration: BoxDecoration(
              color: GcTokens.brandBlack,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.30),
                  offset: const Offset(0, 16),
                  blurRadius: 28,
                ),
                BoxShadow(
                  color: GcTokens.brandLime.withValues(alpha: 0.10),
                  blurRadius: 24,
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                _radialGlows(),
                Positioned.fill(child: CustomPaint(painter: _GridPainter())),

                // SavEdge logo top-left, no background
                Positioned(
                  top: 18,
                  left: 20,
                  child: SizedBox(
                    width: 42,
                    height: 42,
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

                // Cardholder name top-right
                if (_userName != null && _userName!.isNotEmpty)
                  Positioned(
                    top: 22,
                    right: 22,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'CARDHOLDER',
                          style: TextStyle(
                            fontSize: 8.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.4,
                            color: GcTokens.brandLime
                                .withValues(alpha: 0.85),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _userName!.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Value block
                Positioned(
                  left: 20,
                  bottom: 50,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL ACTIVE VALUE',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.6,
                          color: GcTokens.brandLime.withValues(alpha: 0.85),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              '\u20B9',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white.withValues(alpha: 0.95),
                              ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            activeValue.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.0,
                              letterSpacing: -0.8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Footer pills
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 16,
                  child: Row(
                    children: [
                      _statBadge('$active ACTIVE'),
                      const SizedBox(width: 8),
                      _statBadge('$total TOTAL'),
                      const Spacer(),
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
                            'WALLET',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w900,
                              color: Colors.white.withValues(alpha: 0.6),
                              letterSpacing: 1.4,
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
        ),
      ),
    );
  }

  Widget _radialGlows() {
    return Stack(
      children: [
        Positioned(
          left: -60,
          bottom: -80,
          child: Container(
            width: 220,
            height: 220,
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
        Positioned(
          right: -40,
          top: -40,
          child: Container(
            width: 150,
            height: 150,
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
      ],
    );
  }

  Widget _statBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: GcTokens.brandLime.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: GcTokens.brandLime.withValues(alpha: 0.40),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w900,
          color: GcTokens.brandLime,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  // ── Tabs ───────────────────────────────────────────────────────────────

  Widget _buildTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final t in _OrdersTab.values) ...[
            _tabPill(t),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }

  Widget _tabPill(_OrdersTab tab) {
    final selected = _tab == tab;
    return GestureDetector(
      onTap: () => setState(() => _tab = tab),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? GcTokens.textPrimary : Colors.white,
          borderRadius: BorderRadius.circular(GcTokens.rPill),
          border: Border.all(
            color: selected
                ? GcTokens.textPrimary
                : const Color(0xFFEFEAFB),
          ),
        ),
        child: Text(
          tab.label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: selected ? Colors.white : GcTokens.textPrimary,
          ),
        ),
      ),
    );
  }

  // ── Body ───────────────────────────────────────────────────────────────

  List<Widget> _buildBody(GiftCardsState state) {
    if (state is GiftCardOrdersLoading) {
      return const [
        SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(child: GcListSkeleton(count: 5)),
      ];
    }
    if (state is GiftCardOrdersError) {
      return [
        SliverToBoxAdapter(
          child: GcEmptyState(
            icon: Icons.error_outline_rounded,
            title: 'Could not load your orders',
            message: state.message,
            actionLabel: 'Retry',
            onAction: () => context
                .read<GiftCardsBloc>()
                .add(const LoadGiftCardOrders()),
          ),
        ),
      ];
    }
    if (state is GiftCardOrdersLoaded) {
      final q = _searchQuery.toLowerCase();
      final filtered = state.orders
          .where((o) => !_actions.isHidden(o.id))
          .where((o) => _tab.match(o.status))
          .where((o) {
            if (q.isEmpty) return true;
            return o.productName.toLowerCase().contains(q) ||
                o.id.toString().contains(q);
          })
          .toList();
      if (filtered.isEmpty) {
        return [
          SliverToBoxAdapter(
            child: GcEmptyState(
              icon: Icons.card_giftcard_rounded,
              title: _emptyTitle(),
              message: _emptyMessage(),
              actionLabel: 'Browse gift cards',
              onAction: () => Navigator.pushReplacementNamed(
                context,
                '/gift-cards',
              ),
            ),
          ),
        ];
      }

      // Group by month
      final groups = <_Group>[];
      for (final o in filtered) {
        final key = _monthKey(o.created);
        var group = groups.firstWhere(
          (g) => g.key == key,
          orElse: () {
            final ng =
                _Group(key: key, label: _monthLabel(o.created), items: []);
            groups.add(ng);
            return ng;
          },
        );
        group.items.add(o);
      }

      final widgets = <Widget>[];
      for (final group in groups) {
        widgets.add(SliverToBoxAdapter(child: _groupHeader(group.label)));
        widgets.add(
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => _GcOrderTile(
                key: ValueKey('order-${group.items[i].id}'),
                order: group.items[i],
                actions: _actions,
                onTap: () => _openOrder(group.items[i]),
                onDelete: () => _confirmDelete(group.items[i]),
                onSupport: () => GcSupportSheet.show(
                  context,
                  order: group.items[i],
                  actions: _actions,
                ),
              ),
              childCount: group.items.length,
            ),
          ),
        );
      }
      return widgets;
    }
    return const [];
  }

  void _openOrder(GiftCardOrderEntity o) {
    if (o.hasCardDetails) {
      Navigator.pushNamed(context, '/gift-card-view', arguments: o);
    }
  }

  Future<void> _confirmDelete(GiftCardOrderEntity o) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: GcTokens.brandBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Delete pending order?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        content: Text(
          'This will remove order #${o.id} from your list. '
          'It is just a pending order, so no payment is involved. '
          'You can\'t undo this.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.75),
            fontSize: 13,
            height: 1.45,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white.withValues(alpha: 0.65),
            ),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: GcTokens.danger,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GcTokens.rPill),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
    if (ok == true) {
      await _actions.hide(o.id);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order #${o.id} removed.')),
      );
    }
  }

  String _emptyTitle() {
    switch (_tab) {
      case _OrdersTab.all:
        return 'No gift cards yet';
      case _OrdersTab.active:
        return 'No active gift cards';
      case _OrdersTab.processing:
        return 'Nothing in flight';
      case _OrdersTab.failed:
        return 'No failed orders';
    }
  }

  String _emptyMessage() {
    switch (_tab) {
      case _OrdersTab.all:
        return 'Your purchased gift cards will live here so you can grab the codes anytime.';
      case _OrdersTab.active:
        return 'Buy a gift card to get an instant code you can use right away.';
      case _OrdersTab.processing:
        return 'Orders being issued will show up here for a moment before becoming active.';
      case _OrdersTab.failed:
        return 'Cancelled and refunded orders will appear here.';
    }
  }

  Widget _groupHeader(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: Row(
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
              color: GcTokens.textTertiary,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Divider(color: Color(0xFFEFEAFB), height: 1),
          ),
        ],
      ),
    );
  }

  // ── Grouping helpers ──────────────────────────────────────────────────

  String _monthKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}';

  String _monthLabel(DateTime d) {
    final now = DateTime.now();
    if (d.year == now.year && d.month == now.month) return 'This month';
    if (d.year == now.year &&
        d.month == now.month - 1 &&
        now.month - 1 > 0) {
      return 'Last month';
    }
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return d.year == now.year
        ? months[d.month - 1]
        : '${months[d.month - 1]} ${d.year}';
  }
}

class _Group {
  _Group({required this.key, required this.label, required this.items});
  final String key;
  final String label;
  final List<GiftCardOrderEntity> items;
}

// ────────────────────────────────────────────────────────────────────────
// Order tile — premium, polished, status-aware
// ────────────────────────────────────────────────────────────────────────

class _GcOrderTile extends StatefulWidget {
  const _GcOrderTile({
    super.key,
    required this.order,
    required this.actions,
    required this.onTap,
    required this.onDelete,
    required this.onSupport,
  });

  final GiftCardOrderEntity order;
  final GiftCardLocalActionsService actions;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onSupport;

  @override
  State<_GcOrderTile> createState() => _GcOrderTileState();
}

class _GcOrderTileState extends State<_GcOrderTile> {
  bool _expanded = false;

  GiftCardOrderEntity get o => widget.order;
  Color get _accent => GcTokens.accentFor(o.giftCardProductId);
  bool get _isCompleted => o.status == GiftCardOrderStatusEntity.completed;
  bool get _isRefunded => o.status == GiftCardOrderStatusEntity.refunded;
  bool get _isFailed =>
      o.status == GiftCardOrderStatusEntity.failed ||
      o.status == GiftCardOrderStatusEntity.cancelled;
  bool get _isPending =>
      o.status == GiftCardOrderStatusEntity.pending ||
      o.status == GiftCardOrderStatusEntity.paymentCompleted ||
      o.status == GiftCardOrderStatusEntity.issuing;
  bool get _hasExpandable => _isRefunded || _isFailed;

  Color get _statusColor {
    if (_isCompleted) return GcTokens.success;
    if (_isFailed) return GcTokens.danger;
    if (_isRefunded) return Colors.blueGrey;
    return GcTokens.warning;
  }

  String get _statusLabel {
    switch (o.status) {
      case GiftCardOrderStatusEntity.completed:
        return 'ACTIVE';
      case GiftCardOrderStatusEntity.failed:
        return 'FAILED';
      case GiftCardOrderStatusEntity.cancelled:
        return 'CANCELLED';
      case GiftCardOrderStatusEntity.refunded:
        return 'REFUNDED';
      case GiftCardOrderStatusEntity.pending:
        return 'PENDING';
      case GiftCardOrderStatusEntity.paymentCompleted:
        return 'PROCESSING';
      case GiftCardOrderStatusEntity.issuing:
        return 'ISSUING';
    }
  }

  @override
  Widget build(BuildContext context) {
    final clipper = _TicketClipper(notchOffset: 0.66);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      child: Stack(
        children: [
          ClipPath(
            clipper: clipper,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              color: Colors.white,
              child: Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _isCompleted
                          ? widget.onTap
                          : (_hasExpandable
                              ? () => setState(() => _expanded = !_expanded)
                              : null),
                      child: _buildTicketBody(),
                    ),
                  ),
                  if (_expanded && _hasExpandable) _buildExpanded(),
                  if (_isPending) _buildPendingActions(),
                ],
              ),
            ),
          ),
          // Border that follows the same clipper path
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _TicketBorderPainter(
                  notchOffset: 0.66,
                  color: const Color(0xFFE6E1F0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketBody() {
    return IntrinsicHeight(
      child: Stack(
        children: [
          // Subtle accent gradient washing the whole tile
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    GcTokens.bgFor(o.giftCardProductId).withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // INFO SECTION (left, ~66%)
              Expanded(
                flex: 66,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                  child: Row(
                    children: [
                      _buildThumb(),
                      const SizedBox(width: 14),
                      Expanded(child: _buildInfo()),
                    ],
                  ),
                ),
              ),
              // Dashed divider between sections
              CustomPaint(
                size: const Size(1, double.infinity),
                painter: _DashedDividerPainter(
                  color: _accent.withValues(alpha: 0.30),
                ),
              ),
              // VALUE SECTION (right, ~34%) — bold amount + status
              Expanded(
                flex: 34,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 14, 14, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'VALUE',
                        style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                          color: GcTokens.textTertiary
                              .withValues(alpha: 0.85),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              '\u20B9',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: _accent,
                              ),
                            ),
                          ),
                          const SizedBox(width: 1),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                (o.woohooActivatedAmount ??
                                        o.requestedAmount)
                                    .toStringAsFixed(0),
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  color: _accent,
                                  height: 1.0,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _trailingChip(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThumb() {
    final bg = GcTokens.bgFor(o.giftCardProductId);
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: bg.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(13),
      ),
      padding: const EdgeInsets.all(8),
      child: o.productImageUrl != null && o.productImageUrl!.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: o.productImageUrl!,
              fit: BoxFit.contain,
              placeholder: (_, __) =>
                  Icon(Icons.card_giftcard_rounded, color: _accent),
              errorWidget: (_, __, ___) =>
                  Icon(Icons.card_giftcard_rounded, color: _accent),
            )
          : Icon(Icons.card_giftcard_rounded, color: _accent),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          o.productName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: GcTokens.textPrimary,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: GcTokens.brandBlack,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '#${o.id}',
                style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                _shortDate(o.created),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: GcTokens.textTertiary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          children: [
            _statusPill(),
            if (widget.actions.hasOpenTicket(o.id)) _ticketBadge(),
          ],
        ),
      ],
    );
  }

  String _shortDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[d.month - 1]} ${d.day}';
  }

  Widget _trailingChip() {
    if (_isCompleted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: GcTokens.brandBlack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.touch_app_rounded,
              size: 11,
              color: GcTokens.brandLime,
            ),
            SizedBox(width: 4),
            Text(
              'REVEAL',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: GcTokens.brandLime,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      );
    }
    if (_hasExpandable) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          color: _statusColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: _expanded ? 0.5 : 0,
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 13,
                color: _statusColor,
              ),
            ),
            const SizedBox(width: 2),
            Text(
              _expanded ? 'HIDE' : 'INFO',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: _statusColor,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: GcTokens.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.hourglass_top_rounded,
            size: 11,
            color: GcTokens.warning,
          ),
          SizedBox(width: 3),
          Text(
            'WAIT',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: GcTokens.warning,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _statusColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            _statusLabel,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w900,
              color: _statusColor,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ticketBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: GcTokens.brandBlack,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.support_agent_rounded,
            size: 11,
            color: GcTokens.brandLime,
          ),
          SizedBox(width: 4),
          Text(
            'TICKET OPEN',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w900,
              color: GcTokens.brandLime,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  // ── Expanded section (refunded / failed) ──────────────────────────────

  Widget _buildExpanded() {
    return Container(
      decoration: BoxDecoration(
        color: _statusColor.withValues(alpha: 0.05),
        border: Border(
          top: BorderSide(color: _statusColor.withValues(alpha: 0.15)),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isRefunded) _buildRefundDetails(),
          if (_isFailed) _buildFailureDetails(),
          const SizedBox(height: 12),
          _buildSupportRow(),
        ],
      ),
    );
  }

  Widget _buildRefundDetails() {
    final hasAmount = o.refundAmount != null && o.refundAmount! > 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REFUND DETAILS',
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
            color: _statusColor,
          ),
        ),
        const SizedBox(height: 10),
        if (hasAmount)
          _kvRow('Amount refunded', '\u20B9${o.refundAmount!.toStringAsFixed(0)}'),
        if (o.pointsRefunded != null && o.pointsRefunded! > 0) ...[
          const SizedBox(height: 6),
          _kvRow('Points refunded', '${o.pointsRefunded} pts'),
        ],
        if (o.refundedAt != null) ...[
          const SizedBox(height: 6),
          _kvRow('Refunded on', _fmt(o.refundedAt!)),
        ],
        if (o.refundStatus != null) ...[
          const SizedBox(height: 6),
          _kvRow('Status', o.refundStatus!),
        ],
        if (o.razorpayRefundId != null) ...[
          const SizedBox(height: 6),
          _kvRow('Razorpay ref', o.razorpayRefundId!, mono: true),
        ],
        if (!hasAmount &&
            o.pointsRefunded == null &&
            o.refundedAt == null) ...[
          Text(
            'A refund has been initiated for this order. It may take 3-5 business days to reflect in your account.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: GcTokens.textSecondary.withValues(alpha: 0.85),
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFailureDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          o.status == GiftCardOrderStatusEntity.cancelled
              ? 'CANCELLATION DETAILS'
              : 'FAILURE DETAILS',
          style: TextStyle(
            fontSize: 9.5,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
            color: _statusColor,
          ),
        ),
        const SizedBox(height: 10),
        _kvRow('Order amount', '\u20B9${o.requestedAmount.toStringAsFixed(0)}'),
        const SizedBox(height: 6),
        _kvRow('Created', _fmt(o.created)),
        if (o.failureReason != null && o.failureReason!.isNotEmpty) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _statusColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _statusColor.withValues(alpha: 0.25),
              ),
            ),
            child: Text(
              o.failureReason!,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: GcTokens.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ] else
          Text(
            'We weren\'t able to issue this gift card. If money was deducted, it will be auto-refunded within 3-5 business days.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: GcTokens.textSecondary.withValues(alpha: 0.85),
              height: 1.4,
            ),
          ),
      ],
    );
  }

  Widget _kvRow(String k, String v, {bool mono = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            k,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: GcTokens.textTertiary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: GcTokens.textPrimary,
              letterSpacing: mono ? 0.4 : 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupportRow() {
    final hasTicket = widget.actions.hasOpenTicket(o.id);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: widget.onSupport,
        icon: Icon(
          hasTicket
              ? Icons.mark_chat_read_rounded
              : Icons.support_agent_rounded,
          size: 16,
          color: hasTicket ? GcTokens.brandLime : GcTokens.brandBlack,
        ),
        label: Text(
          hasTicket ? 'Ticket open · view' : 'Contact support',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            color: hasTicket ? GcTokens.brandLime : GcTokens.brandBlack,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              hasTicket ? GcTokens.brandBlack : GcTokens.brandLime,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GcTokens.rPill),
          ),
        ),
      ),
    );
  }

  // ── Pending order actions (delete + support) ──────────────────────────

  Widget _buildPendingActions() {
    return Container(
      decoration: BoxDecoration(
        color: GcTokens.warning.withValues(alpha: 0.05),
        border: const Border(
          top: BorderSide(color: Color(0xFFFFF1D6)),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: widget.onDelete,
              icon: const Icon(
                Icons.delete_outline_rounded,
                size: 16,
                color: GcTokens.danger,
              ),
              label: const Text(
                'Delete',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w900,
                  color: GcTokens.danger,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: GcTokens.danger.withValues(alpha: 0.40),
                ),
                padding: const EdgeInsets.symmetric(vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(GcTokens.rPill),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: widget.onSupport,
              icon: Icon(
                Icons.support_agent_rounded,
                size: 16,
                color: widget.actions.hasOpenTicket(o.id)
                    ? GcTokens.brandLime
                    : GcTokens.brandBlack,
              ),
              label: Text(
                widget.actions.hasOpenTicket(o.id) ? 'Ticket open' : 'Support',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w900,
                  color: widget.actions.hasOpenTicket(o.id)
                      ? GcTokens.brandLime
                      : GcTokens.brandBlack,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.actions.hasOpenTicket(o.id)
                    ? GcTokens.brandBlack
                    : GcTokens.brandLime,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 11),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(GcTokens.rPill),
                ),
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

// ────────────────────────────────────────────────────────────────────────
// Painters
// ────────────────────────────────────────────────────────────────────────

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 0.6
      ..style = PaintingStyle.stroke;
    const spacing = 22.0;
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

Path _buildTicketPath(Size size, double notchOffset) {
  const r = 18.0;
  const notchRadius = 9.0;
  final notchX = size.width * notchOffset;
  final path = Path();

  path.moveTo(r, 0);
  path.lineTo(notchX - notchRadius, 0);
  path.arcToPoint(
    Offset(notchX + notchRadius, 0),
    radius: const Radius.circular(notchRadius),
    clockwise: false,
  );
  path.lineTo(size.width - r, 0);
  path.arcToPoint(
    Offset(size.width, r),
    radius: const Radius.circular(r),
  );
  path.lineTo(size.width, size.height - r);
  path.arcToPoint(
    Offset(size.width - r, size.height),
    radius: const Radius.circular(r),
  );
  path.lineTo(notchX + notchRadius, size.height);
  path.arcToPoint(
    Offset(notchX - notchRadius, size.height),
    radius: const Radius.circular(notchRadius),
    clockwise: false,
  );
  path.lineTo(r, size.height);
  path.arcToPoint(
    Offset(0, size.height - r),
    radius: const Radius.circular(r),
  );
  path.lineTo(0, r);
  path.arcToPoint(
    Offset(r, 0),
    radius: const Radius.circular(r),
  );
  path.close();
  return path;
}

/// Boarding-pass / ticket-style clipper.
class _TicketClipper extends CustomClipper<Path> {
  _TicketClipper({this.notchOffset = 0.66});
  final double notchOffset;

  @override
  Path getClip(Size size) => _buildTicketPath(size, notchOffset);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// Strokes the same ticket path so the border perfectly traces the cutouts.
class _TicketBorderPainter extends CustomPainter {
  _TicketBorderPainter({required this.notchOffset, required this.color});
  final double notchOffset;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(_buildTicketPath(size, notchOffset), paint);
  }

  @override
  bool shouldRepaint(covariant _TicketBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.notchOffset != notchOffset;
}

class _DashedDividerPainter extends CustomPainter {
  _DashedDividerPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    const dashHeight = 4.0;
    const dashSpace = 4.0;
    var y = 6.0;
    while (y < size.height - 6) {
      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, y + dashHeight),
        paint,
      );
      y += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedDividerPainter oldDelegate) =>
      oldDelegate.color != color;
}
