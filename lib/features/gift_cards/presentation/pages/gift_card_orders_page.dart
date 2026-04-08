import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/injection/injection.dart';

import '../../domain/entities/gift_card_entity.dart';
import '../bloc/gift_cards_bloc.dart';
import '../theme/gc_tokens.dart';
import '../widgets/gc_empty_state.dart';
import '../widgets/gc_skeleton.dart';

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
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: GcTokens.textPrimary,
        ),
      ),
      title: const Text(
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
          icon: const Icon(
            Icons.search_rounded,
            color: GcTokens.textPrimary,
            size: 22,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  // ── Stats card ─────────────────────────────────────────────────────────

  Widget _buildStatsCard(GiftCardsState state) {
    int total = 0;
    int active = 0;
    double activeValue = 0;
    if (state is GiftCardOrdersLoaded) {
      total = state.orders.length;
      for (final o in state.orders) {
        if (o.status == GiftCardOrderStatusEntity.completed) {
          active++;
          activeValue += o.woohooActivatedAmount ?? o.requestedAmount;
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
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
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Soft purple radial glow bottom-left
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
              // Lime arc top-right
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
                        GcTokens.brandLime.withValues(alpha: 0.32),
                        GcTokens.brandLime.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              // Diagonal grid lines
              Positioned.fill(
                child: CustomPaint(painter: _GridPainter()),
              ),
              // Brand wordmark + chip row
              Positioned(
                top: 18,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    _emvChip(),
                    const SizedBox(width: 10),
                    Container(
                      width: 18,
                      height: 14,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          color: GcTokens.brandLime.withValues(alpha: 0.45),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color:
                                GcTokens.brandLime.withValues(alpha: 0.45),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
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
              // Centered value block (left aligned)
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
    );
  }

  Widget _emvChip() {
    return Container(
      width: 38,
      height: 28,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            GcTokens.brandLime,
            GcTokens.brandLimeDark,
          ],
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: GcTokens.brandLime.withValues(alpha: 0.40),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: CustomPaint(painter: _ChipPainter()),
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
    return SizedBox(
      height: 42,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? GcTokens.textPrimary : Colors.white,
          borderRadius: BorderRadius.circular(GcTokens.rPill),
          border: Border.all(
            color: selected
                ? GcTokens.textPrimary
                : const Color(0xFFEFEAFB),
          ),
        ),
        child: Row(
          children: [
            Text(
              tab.label,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: selected ? Colors.white : GcTokens.textPrimary,
              ),
            ),
          ],
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
      final filtered =
          state.orders.where((o) => _tab.match(o.status)).toList();
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

      // Group by year+month
      final groups = <_Group>[];
      for (final o in filtered) {
        final key = _monthKey(o.created);
        var group = groups.firstWhere(
          (g) => g.key == key,
          orElse: () {
            final ng = _Group(key: key, label: _monthLabel(o.created), items: []);
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
              (_, i) => _orderTile(group.items[i]),
              childCount: group.items.length,
            ),
          ),
        );
      }
      return widgets;
    }
    return const [];
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

  // ── Order tile ─────────────────────────────────────────────────────────

  Widget _orderTile(GiftCardOrderEntity o) {
    final accent = GcTokens.accentFor(o.giftCardProductId);
    final bg = GcTokens.bgFor(o.giftCardProductId);
    final canShow = o.hasCardDetails;
    final statusColor = _statusColor(o.status);
    final statusLabel = _statusLabel(o);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(GcTokens.rCard),
        child: InkWell(
          borderRadius: BorderRadius.circular(GcTokens.rCard),
          onTap: () {
            if (canShow) {
              Navigator.pushNamed(
                context,
                '/gift-card-view',
                arguments: o,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    o.status == GiftCardOrderStatusEntity.refunded
                        ? 'This order was refunded.'
                        : 'This gift card isn\'t ready yet.',
                  ),
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GcTokens.rCard),
              border: Border.all(color: const Color(0xFFEFEAFB)),
            ),
            child: Row(
              children: [
                // Brand image well
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [bg, Color.lerp(bg, Colors.white, 0.4)!],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: o.productImageUrl != null &&
                          o.productImageUrl!.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: o.productImageUrl!,
                          fit: BoxFit.contain,
                          placeholder: (_, __) =>
                              Icon(Icons.card_giftcard_rounded, color: accent),
                          errorWidget: (_, __, ___) =>
                              Icon(Icons.card_giftcard_rounded, color: accent),
                        )
                      : Icon(Icons.card_giftcard_rounded, color: accent),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        o.productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w900,
                          color: GcTokens.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '\u20B9${(o.woohooActivatedAmount ?? o.requestedAmount).toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: accent,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 3,
                            height: 3,
                            decoration: const BoxDecoration(
                              color: GcTokens.textTertiary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Order #${o.id}',
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: GcTokens.textTertiary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: statusColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  statusLabel,
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w900,
                                    color: statusColor,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (canShow) ...[
                            const SizedBox(width: 8),
                            Text(
                              'Tap to reveal',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w800,
                                color: accent,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  canShow
                      ? Icons.arrow_forward_ios_rounded
                      : Icons.lock_outline_rounded,
                  size: 14,
                  color: canShow ? accent : GcTokens.textTertiary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _statusColor(GiftCardOrderStatusEntity s) {
    switch (s) {
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

  String _statusLabel(GiftCardOrderEntity o) {
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

class _ChipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.45)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Horizontal lines
    final h1 = size.height * 0.33;
    final h2 = size.height * 0.66;
    canvas.drawLine(Offset(2, h1), Offset(size.width - 2, h1), paint);
    canvas.drawLine(Offset(2, h2), Offset(size.width - 2, h2), paint);

    // Vertical lines
    final v1 = size.width * 0.30;
    final v2 = size.width * 0.70;
    canvas.drawLine(Offset(v1, 2), Offset(v1, size.height - 2), paint);
    canvas.drawLine(Offset(v2, 2), Offset(v2, size.height - 2), paint);

    // Center square
    final center = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 8,
      height: 8,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(center, const Radius.circular(2)),
      paint..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
