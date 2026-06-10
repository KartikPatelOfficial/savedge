import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:savedge/core/injection/injection.dart';
import 'package:savedge/features/points_payment/data/models/points_payment_models.dart';
import 'package:savedge/features/points_payment/data/services/points_payment_service.dart';
import 'package:savedge/features/user_profile/presentation/bloc/points_bloc.dart';
import 'package:savedge/features/user_profile/presentation/theme/wallet_tokens.dart';
import 'package:savedge/features/user_profile/presentation/widgets/wallet_activity.dart';
import 'package:savedge/features/user_profile/presentation/widgets/wallet_balance_card.dart';
import 'package:savedge/features/user_profile/presentation/widgets/wallet_insight_cards.dart';
import 'package:savedge/shared/domain/entities/points.dart';
import 'package:savedge/shared/widgets/common_widgets.dart';

/// Points wallet: balance, expiry, monthly movement and the full ledger in
/// a single scroll.
class PointsWalletPage extends StatelessWidget {
  const PointsWalletPage({super.key});

  static const String routeName = '/points-wallet';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PointsBloc>()..add(const LoadUserPoints()),
      child: const _PointsWalletView(),
    );
  }
}

class _PointsWalletView extends StatefulWidget {
  const _PointsWalletView();

  @override
  State<_PointsWalletView> createState() => _PointsWalletViewState();
}

class _PointsWalletViewState extends State<_PointsWalletView> {
  WalletFilter _filter = WalletFilter.all;
  UserPointsBalanceResponse? _balance;

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  /// Per-bucket balances (incl. meal points) live behind a different
  /// endpoint; a failure here just hides the meal summary line and the
  /// card-back breakdown.
  Future<void> _loadBalance() async {
    try {
      final balance = await GetIt.I<PointsPaymentService>().getBalance();
      if (mounted) setState(() => _balance = balance);
    } catch (_) {}
  }

  Future<void> _refresh() async {
    final bloc = context.read<PointsBloc>();
    bloc.add(const RefreshPoints());
    _loadBalance();
    await bloc.stream
        .firstWhere(
          (s) => s is PointsError || (s is PointsLoaded && !s.isRefreshing),
        )
        .catchError((_) => bloc.state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WalletTokens.canvas,
      body: BlocBuilder<PointsBloc, PointsState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: _refresh,
            color: WalletTokens.primary,
            edgeOffset: MediaQuery.of(context).padding.top + kToolbarHeight,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                _buildAppBar(context, state),
                ..._buildBody(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, PointsState state) {
    final isRefreshing = state is PointsLoaded && state.isRefreshing;
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: WalletTokens.canvas,
      surfaceTintColor: Colors.transparent,
      foregroundColor: WalletTokens.textPrimary,
      centerTitle: false,
      title: const Text(
        'Wallet',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.4,
          color: WalletTokens.textPrimary,
        ),
      ),
      actions: [
        IconButton(
          tooltip: 'Refresh wallet',
          onPressed: isRefreshing
              ? null
              : () {
                  context.read<PointsBloc>().add(const RefreshPoints());
                  _loadBalance();
                },
          icon: isRefreshing
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: WalletTokens.primary,
                  ),
                )
              : const Icon(Icons.refresh_rounded, size: 22),
        ),
        const SizedBox(width: WalletTokens.s2),
      ],
    );
  }

  List<Widget> _buildBody(BuildContext context, PointsState state) {
    if (state is PointsError) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: AppErrorWidget(
            message: state.message,
            onRetry: () =>
                context.read<PointsBloc>().add(const LoadUserPoints()),
          ),
        ),
      ];
    }

    if (state is! PointsLoaded) {
      return const [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: _WalletSkeleton(),
          ),
        ),
      ];
    }

    final transactions = state.transactions ?? const <PointTransaction>[];
    final stats = _WalletStats.from(transactions);

    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: WalletTokens.gutter.copyWith(top: WalletTokens.s2),
          child: WalletBalanceCard(
            points: state.points,
            monthEarned: stats.monthEarned,
            monthSpent: stats.monthSpent,
            balance: _balance,
          ),
        ),
      ),
      if (state.points.isExpiringSoon && !state.points.hasExpired)
        SliverToBoxAdapter(
          child: Padding(
            padding: WalletTokens.gutter.copyWith(top: WalletTokens.s3),
            child: WalletExpiryBanner(points: state.points),
          ),
        ),
      if (transactions.isNotEmpty)
        SliverToBoxAdapter(
          child: Padding(
            padding: WalletTokens.gutter.copyWith(top: WalletTokens.s4),
            child: WalletSummaryCard(
              monthLabel: walletMonthLabel(DateTime.now()),
              monthEarned: stats.monthEarned,
              monthSpent: stats.monthSpent,
              lifetimeEarned: stats.lifetimeEarned,
              lifetimeSpent: stats.lifetimeSpent,
            ),
          ),
        ),
      ..._buildActivity(context, state, transactions),
      SliverToBoxAdapter(
        child: SizedBox(
          height: WalletTokens.s8 + MediaQuery.of(context).padding.bottom,
        ),
      ),
    ];
  }

  List<Widget> _buildActivity(
    BuildContext context,
    PointsLoaded state,
    List<PointTransaction> transactions,
  ) {
    final header = SliverToBoxAdapter(
      child: Padding(
        padding: WalletTokens.gutter.copyWith(
          top: WalletTokens.s6,
          bottom: WalletTokens.s3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Activity', style: WalletTokens.sectionTitle),
            if (transactions.isNotEmpty) ...[
              const SizedBox(height: WalletTokens.s3),
              WalletFilterChips(
                selected: _filter,
                onChanged: (f) => setState(() => _filter = f),
              ),
            ],
          ],
        ),
      ),
    );

    if (state.ledgerError != null && transactions.isEmpty) {
      return [
        header,
        SliverToBoxAdapter(
          child: Padding(
            padding: WalletTokens.gutter,
            child: _ActivityMessage(
              icon: Icons.cloud_off_rounded,
              title: 'Couldn\'t load activity',
              caption: state.ledgerError!,
              action: TextButton(
                onPressed: () =>
                    context.read<PointsBloc>().add(const LoadPointsLedger()),
                child: const Text('Try again'),
              ),
            ),
          ),
        ),
      ];
    }

    if (transactions.isEmpty) {
      return [
        header,
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: _ActivityMessage(
              icon: Icons.receipt_long_rounded,
              title: 'No activity yet',
              caption:
                  'Your points activity will appear here once you start '
                  'earning and redeeming.',
            ),
          ),
        ),
      ];
    }

    final groups = _groupByMonth(
      transactions.where(_filter.matches).toList()
        ..sort((a, b) => b.transactionDate.compareTo(a.transactionDate)),
    );

    if (groups.isEmpty) {
      return [
        header,
        SliverToBoxAdapter(
          child: Padding(
            padding: WalletTokens.gutter,
            child: _ActivityMessage(
              icon: Icons.filter_list_off_rounded,
              title: 'Nothing ${_filter.label.toLowerCase()} yet',
              caption: 'Switch the filter to see the rest of your activity.',
            ),
          ),
        ),
      ];
    }

    return [
      header,
      SliverPadding(
        padding: WalletTokens.gutter,
        sliver: SliverList.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) => WalletMonthGroup(
            label: groups[index].label,
            transactions: groups[index].items,
          ),
        ),
      ),
    ];
  }

  List<({String label, List<PointTransaction> items})> _groupByMonth(
    List<PointTransaction> sorted,
  ) {
    final groups = <({String label, List<PointTransaction> items})>[];
    for (final t in sorted) {
      final label = walletMonthLabel(t.transactionDate);
      if (groups.isEmpty || groups.last.label != label) {
        groups.add((label: label, items: [t]));
      } else {
        groups.last.items.add(t);
      }
    }
    return groups;
  }
}

/// Earned/spent totals for the current calendar month and all time.
class _WalletStats {
  const _WalletStats({
    required this.monthEarned,
    required this.monthSpent,
    required this.lifetimeEarned,
    required this.lifetimeSpent,
  });

  factory _WalletStats.from(List<PointTransaction> transactions) {
    final now = DateTime.now();
    var monthEarned = 0;
    var monthSpent = 0;
    var lifetimeEarned = 0;
    var lifetimeSpent = 0;
    for (final t in transactions) {
      final amount = t.pointsDelta.abs();
      final inMonth =
          t.transactionDate.year == now.year &&
          t.transactionDate.month == now.month;
      if (t.isCredit) {
        lifetimeEarned += amount;
        if (inMonth) monthEarned += amount;
      } else {
        lifetimeSpent += amount;
        if (inMonth) monthSpent += amount;
      }
    }
    return _WalletStats(
      monthEarned: monthEarned,
      monthSpent: monthSpent,
      lifetimeEarned: lifetimeEarned,
      lifetimeSpent: lifetimeSpent,
    );
  }

  final int monthEarned;
  final int monthSpent;
  final int lifetimeEarned;
  final int lifetimeSpent;
}

/// Soft placeholder shown while the wallet loads — mirrors the loaded layout
/// so content doesn't jump.
class _WalletSkeleton extends StatefulWidget {
  const _WalletSkeleton();

  @override
  State<_WalletSkeleton> createState() => _WalletSkeletonState();
}

class _WalletSkeletonState extends State<_WalletSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _pulse.stop();
    } else if (!_pulse.isAnimating) {
      _pulse.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 1.0, end: 0.45).animate(_pulse),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _block(height: 220, radius: WalletTokens.rHero),
          const SizedBox(height: WalletTokens.s4),
          _block(height: 150, radius: WalletTokens.rCard),
          const SizedBox(height: WalletTokens.s6),
          _block(height: 18, width: 100, radius: 6),
          const SizedBox(height: WalletTokens.s4),
          for (var i = 0; i < 3; i++) ...[
            _block(height: 68, radius: WalletTokens.rCard),
            const SizedBox(height: WalletTokens.s3),
          ],
        ],
      ),
    );
  }

  Widget _block({
    required double height,
    double? width,
    required double radius,
  }) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: WalletTokens.skeleton,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// Centered icon + title + caption used for empty and inline-error states.
class _ActivityMessage extends StatelessWidget {
  const _ActivityMessage({
    required this.icon,
    required this.title,
    required this.caption,
    this.action,
  });

  final IconData icon;
  final String title;
  final String caption;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: WalletTokens.s6,
        vertical: WalletTokens.s8,
      ),
      decoration: BoxDecoration(
        color: WalletTokens.surface,
        borderRadius: BorderRadius.circular(WalletTokens.rCard),
        border: Border.all(color: WalletTokens.border),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: WalletTokens.canvas,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 26, color: WalletTokens.textTertiary),
          ),
          const SizedBox(height: WalletTokens.s4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: WalletTokens.textPrimary,
            ),
          ),
          const SizedBox(height: WalletTokens.s2),
          Text(
            caption,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              height: 1.5,
              color: WalletTokens.textTertiary,
            ),
          ),
          if (action != null) ...[
            const SizedBox(height: WalletTokens.s2),
            action!,
          ],
        ],
      ),
    );
  }
}
