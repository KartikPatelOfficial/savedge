import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/injection/injection.dart';
import '../../../../shared/widgets/common_widgets.dart';
import '../../../../shared/domain/entities/points.dart';
import '../bloc/points_bloc.dart';
import '../widgets/points_balance_card.dart';
import '../widgets/points_transaction_list.dart';
import '../widgets/points_expiry_warning.dart';

/// Page for displaying user's points wallet and transaction history
class PointsWalletPage extends StatelessWidget {
  static const String routeName = '/points-wallet';

  const PointsWalletPage({super.key});

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

class _PointsWalletViewState extends State<_PointsWalletView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Points Wallet'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<PointsBloc>().add(const RefreshPoints());
            },
          ),
        ],
      ),
      body: BlocConsumer<PointsBloc, PointsState>(
        listener: (context, state) {
          if (state is PointsLoaded && state.points.isExpiringSoon) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Your points are expiring in ${state.points.daysUntilExpiry} days!',
                ),
                backgroundColor: Colors.orange,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PointsLoading) {
            return const LoadingWidget();
          }

          if (state is PointsError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<PointsBloc>().add(const LoadUserPoints()),
            );
          }

          if (state is PointsLoaded) {
            return Column(
              children: [
                // Points Balance Card
                PointsBalanceCard(points: state.points),

                // Expiry Warning
                if (state.points.isExpiringSoon)
                  PointsExpiryWarning(points: state.points),

                // Tab Bar
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Overview'),
                    Tab(text: 'Transactions'),
                  ],
                  onTap: (index) {
                    if (index == 1 &&
                        !state.hasTransactions &&
                        !state.isLoadingLedger) {
                      context.read<PointsBloc>().add(const LoadPointsLedger());
                    }
                  },
                ),

                // Tab View
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOverviewTab(context, state),
                      _buildTransactionsTab(context, state),
                    ],
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildOverviewTab(BuildContext context, PointsLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PointsBloc>().add(const RefreshPoints());
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Recent Transactions Preview
          if (state.hasTransactions) ...[
            const Text(
              'Recent Transactions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...state.recentTransactions
                .take(5)
                .map(
                  (transaction) => TransactionTile(transaction: transaction),
                ),
            TextButton(
              onPressed: () {
                _tabController.animateTo(1);
              },
              child: const Text('View All Transactions'),
            ),
          ],

          // Points Statistics
          const SizedBox(height: 24),
          _buildPointsStatistics(context, state),

          // Expiring Points Info
          const SizedBox(height: 24),
          _buildExpiringPointsCard(context, state),
        ],
      ),
    );
  }

  Widget _buildTransactionsTab(BuildContext context, PointsLoaded state) {
    if (state.isLoadingLedger) {
      return const LoadingWidget();
    }

    if (state.ledgerError != null) {
      return AppErrorWidget(
        message: state.ledgerError!,
        onRetry: () => context.read<PointsBloc>().add(const LoadPointsLedger()),
      );
    }

    if (!state.hasTransactions) {
      return const EmptyStateWidget(
        icon: Icons.account_balance_wallet,
        message: 'No Transactions\nYour points transactions will appear here',
      );
    }

    return PointsTransactionList(transactions: state.transactions!);
  }

  Widget _buildPointsStatistics(BuildContext context, PointsLoaded state) {
    if (!state.hasTransactions) return const SizedBox.shrink();

    final creditTransactions = state.creditTransactions;
    final debitTransactions = state.debitTransactions;
    final totalEarned = creditTransactions.fold<int>(
      0,
      (sum, t) => sum + t.pointsDelta.abs(),
    );
    final totalSpent = debitTransactions.fold<int>(
      0,
      (sum, t) => sum + t.pointsDelta.abs(),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Points Statistics',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: 'Total Earned',
                    value: totalEarned.toString(),
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    title: 'Total Spent',
                    value: totalSpent.toString(),
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: color.withOpacity(0.8)),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiringPointsCard(BuildContext context, PointsLoaded state) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.schedule, color: Colors.orange),
        title: const Text('Points Expiring Soon'),
        subtitle: const Text('Check points expiring in next 7 days'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          if (!state.hasExpiringPoints && !state.isLoadingExpiring) {
            context.read<PointsBloc>().add(const LoadPointsExpiring(days: 7));
          }
          _showExpiringPointsDialog(context, state);
        },
      ),
    );
  }

  void _showExpiringPointsDialog(BuildContext context, PointsLoaded state) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: context.read<PointsBloc>(),
        child: AlertDialog(
          title: const Text('Expiring Points'),
          content: BlocBuilder<PointsBloc, PointsState>(
            builder: (context, state) {
              if (state is PointsLoaded) {
                if (state.isLoadingExpiring) {
                  return const SizedBox(
                    height: 60,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (state.expiringError != null) {
                  return Text('Error: ${state.expiringError}');
                }

                if (state.hasExpiringPoints) {
                  final data = state.expiringPointsData!;
                  return Text(
                    '${data['expiringPoints']} points will expire in the next ${data['days']} days.',
                  );
                }

                return const Text('No points expiring in the next 7 days.');
              }
              return const SizedBox.shrink();
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
