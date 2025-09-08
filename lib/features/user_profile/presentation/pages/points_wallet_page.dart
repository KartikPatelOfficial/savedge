import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/injection/injection.dart';
import '../../../../shared/domain/entities/points.dart';
import '../../../../shared/widgets/common_widgets.dart';
import '../bloc/points_bloc.dart';
import '../widgets/points_balance_card.dart';
import '../widgets/points_expiry_warning.dart';
import '../widgets/points_transaction_list.dart';

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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Points Wallet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            Text(
              'Track your rewards & earnings',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        toolbarHeight: 70,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.refresh_rounded, size: 22),
              color: Colors.black87,
              onPressed: () {
                context.read<PointsBloc>().add(const RefreshPoints());
              },
            ),
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
                // Animated Points Balance Card
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: PointsBalanceCard(points: state.points),
                ),

                // Expiry Warning with modern design
                if (state.points.isExpiringSoon)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: PointsExpiryWarning(points: state.points),
                  ),

                // Modern Tab Bar
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    indicatorPadding: const EdgeInsets.all(4),
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey[600],
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: const [
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.dashboard_rounded, size: 18),
                            SizedBox(width: 8),
                            Text('Overview'),
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.receipt_long_rounded, size: 18),
                            SizedBox(width: 8),
                            Text('History'),
                          ],
                        ),
                      ),
                    ],
                    onTap: (index) {
                      // Ledger is now loaded on initialization
                    },
                  ),
                ),

                // Tab View with modern spacing
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
          // Quick Stats Grid
          _buildQuickStatsGrid(context, state),

          // Recent Activity Section
          if (state.hasTransactions) ...[
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _tabController.animateTo(1);
                  },
                  icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                  label: const Text('View All'),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF6366F1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...state.recentTransactions
                .take(3)
                .map(
                  (transaction) => _buildCompactTransactionTile(transaction),
                ),
          ],

          // Points Analytics
          const SizedBox(height: 24),
          _buildPointsAnalytics(context, state),

          const SizedBox(height: 24),
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

  Widget _buildQuickStatsGrid(BuildContext context, PointsLoaded state) {
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
    final activePoints = state.points.balance;
    final savingsRate = totalEarned > 0
        ? ((totalEarned - totalSpent) / totalEarned * 100).toStringAsFixed(0)
        : '0';

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _buildModernStatCard(
          icon: Icons.account_balance_wallet_rounded,
          title: 'Active Points',
          value: activePoints.toString(),
          subtitle: 'Available now',
          gradient: const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
          ),
        ),
        _buildModernStatCard(
          icon: Icons.trending_up_rounded,
          title: 'Total Earned',
          value: totalEarned.toString(),
          subtitle: 'Lifetime earnings',
          gradient: const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF34D399)],
          ),
        ),
        _buildModernStatCard(
          icon: Icons.shopping_bag_rounded,
          title: 'Total Spent',
          value: totalSpent.toString(),
          subtitle: 'Points redeemed',
          gradient: const LinearGradient(
            colors: [Color(0xFFEF4444), Color(0xFFF87171)],
          ),
        ),
        _buildModernStatCard(
          icon: Icons.savings_rounded,
          title: 'Savings Rate',
          value: '$savingsRate%',
          subtitle: 'Points retained',
          gradient: const LinearGradient(
            colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
          ),
        ),
      ],
    );
  }

  Widget _buildModernStatCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Gradient gradient,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 20, color: Colors.white),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactTransactionTile(PointTransaction transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: transaction.isCredit
                  ? const Color(0xFF10B981).withOpacity(0.1)
                  : const Color(0xFFEF4444).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              transaction.isCredit ? Icons.add_rounded : Icons.remove_rounded,
              color: transaction.isCredit
                  ? const Color(0xFF10B981)
                  : const Color(0xFFEF4444),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  _formatDateTime(transaction.transactionDate),
                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          Text(
            transaction.formattedPointsDelta,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: transaction.isCredit
                  ? const Color(0xFF10B981)
                  : const Color(0xFFEF4444),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildPointsAnalytics(BuildContext context, PointsLoaded state) {
    if (!state.hasTransactions) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Points Analytics',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Last 30 days',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAnalyticsRow(
            'Average Transaction',
            '${(state.transactions!.fold<int>(0, (sum, t) => sum + t.pointsDelta.abs()) / state.transactions!.length).toStringAsFixed(0)} pts',
            Icons.analytics_rounded,
            Colors.purple,
          ),
          const SizedBox(height: 12),
          _buildAnalyticsRow(
            'Transaction Count',
            '${state.transactions!.length} total',
            Icons.receipt_rounded,
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildAnalyticsRow(
            'Points Expiring Soon',
            state.points.isExpiringSoon
                ? '${state.points.balance} pts'
                : 'None',
            Icons.timer_rounded,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsRow(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey[400],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
