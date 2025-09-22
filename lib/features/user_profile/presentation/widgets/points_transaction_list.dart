import 'package:flutter/material.dart';
import 'package:savedge/shared/domain/entities/points.dart';

/// Modern, compact transaction list with advanced filtering
class PointsTransactionList extends StatefulWidget {
  final List<PointTransaction> transactions;

  const PointsTransactionList({super.key, required this.transactions});

  @override
  State<PointsTransactionList> createState() => _PointsTransactionListState();
}

class _PointsTransactionListState extends State<PointsTransactionList> {
  String _selectedFilter = 'All';
  String _selectedTimeFilter = 'All Time';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<PointTransaction> get _filteredTransactions {
    var filtered = widget.transactions;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (t) =>
                t.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                t.transactionType.displayName.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    // Apply type filter
    switch (_selectedFilter) {
      case 'Earned':
        filtered = filtered.where((t) => t.isCredit).toList();
        break;
      case 'Spent':
        filtered = filtered.where((t) => !t.isCredit).toList();
        break;
      case 'Active':
        filtered = filtered
            .where((t) => t.status == TransactionStatus.active)
            .toList();
        break;
      case 'Expired':
        filtered = filtered
            .where((t) => t.status == TransactionStatus.expired)
            .toList();
        break;
    }

    // Apply time filter
    final now = DateTime.now();
    switch (_selectedTimeFilter) {
      case 'This Week':
        filtered = filtered
            .where((t) => now.difference(t.transactionDate).inDays <= 7)
            .toList();
        break;
      case 'This Month':
        filtered = filtered
            .where((t) => now.difference(t.transactionDate).inDays <= 30)
            .toList();
        break;
      case 'Last 3 Months':
        filtered = filtered
            .where((t) => now.difference(t.transactionDate).inDays <= 90)
            .toList();
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = _filteredTransactions;

    return Column(
      children: [
        // Search and Filter Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border(
              bottom: BorderSide(color: Colors.grey[200]!, width: 1),
            ),
          ),
          child: Column(
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!, width: 1),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search transactions...',
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[500],
                      size: 20,
                    ),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Filter Chips
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip('All', Icons.list_alt),
                          const SizedBox(width: 8),
                          _buildFilterChip('Earned', Icons.add_circle_outline),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            'Spent',
                            Icons.remove_circle_outline,
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip(
                            'Active',
                            Icons.check_circle_outline,
                          ),
                          const SizedBox(width: 8),
                          _buildFilterChip('Expired', Icons.schedule),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildTimeFilterDropdown(),
                ],
              ),
            ],
          ),
        ),

        // Results Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey[200]!, width: 1),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${filteredTransactions.length} transactions',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              if (filteredTransactions.isNotEmpty) _buildSortButton(),
            ],
          ),
        ),

        // Transaction List
        Expanded(
          child: filteredTransactions.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: () async {},
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = filteredTransactions[index];
                      return ModernTransactionTile(
                        transaction: transaction,
                        isFirst: index == 0,
                        isLast: index == filteredTransactions.length - 1,
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6366F1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFF6366F1) : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedTimeFilter,
          isDense: true,
          icon: Icon(Icons.expand_more, size: 16, color: Colors.grey[600]),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
          items: ['All Time', 'This Week', 'This Month', 'Last 3 Months']
              .map((time) => DropdownMenuItem(value: time, child: Text(time)))
              .toList(),
          onChanged: (value) => setState(() => _selectedTimeFilter = value!),
        ),
      ),
    );
  }

  Widget _buildSortButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.sort, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            'Sort',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 32,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No transactions found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters or search terms',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedFilter = 'All';
                  _selectedTimeFilter = 'All Time';
                  _searchQuery = '';
                  _searchController.clear();
                });
              },
              child: const Text(
                'Clear filters',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6366F1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

/// Modern compact transaction tile
class ModernTransactionTile extends StatelessWidget {
  final PointTransaction transaction;
  final bool isFirst;
  final bool isLast;

  const ModernTransactionTile({
    super.key,
    required this.transaction,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? const Radius.circular(12) : Radius.zero,
          bottom: isLast ? const Radius.circular(12) : Radius.zero,
        ),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showTransactionDetails(context),
          borderRadius: BorderRadius.vertical(
            top: isFirst ? const Radius.circular(12) : Radius.zero,
            bottom: isLast ? const Radius.circular(12) : Radius.zero,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Transaction Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getTransactionColor(
                      transaction,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _getTransactionColor(
                        transaction,
                      ).withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    _getTransactionIcon(transaction),
                    color: _getTransactionColor(transaction),
                    size: 20,
                  ),
                ),

                const SizedBox(width: 12),

                // Transaction Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              transaction.description,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            transaction.formattedPointsDelta,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _getTransactionColor(transaction),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    transaction.transactionType.displayName,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _formatDateTime(transaction.transactionDate),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (transaction.isCredit &&
                              transaction.status != null)
                            _buildStatusChip(transaction.status!),
                        ],
                      ),

                      if (transaction.expiryDate != null &&
                          transaction.isCredit) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 12,
                              color: _getExpiryColor(transaction),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Expires ${_formatDateTime(transaction.expiryDate!)}',
                              style: TextStyle(
                                fontSize: 11,
                                color: _getExpiryColor(transaction),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Arrow Icon
                Icon(Icons.chevron_right, size: 16, color: Colors.grey[400]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(TransactionStatus status) {
    final color = _getStatusColor(status);
    final text = _getStatusText(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Color _getTransactionColor(PointTransaction transaction) {
    return transaction.isCredit
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);
  }

  IconData _getTransactionIcon(PointTransaction transaction) {
    if (transaction.isCredit) {
      return Icons.add_circle;
    } else {
      return Icons.remove_circle;
    }
  }

  Color _getExpiryColor(PointTransaction transaction) {
    if (transaction.status == TransactionStatus.expired) {
      return const Color(0xFFEF4444);
    }
    final daysUntilExpiry =
        transaction.expiryDate?.difference(DateTime.now()).inDays ?? 0;
    if (daysUntilExpiry <= 7) {
      return const Color(0xFFF59E0B);
    }
    return Colors.grey[600]!;
  }

  Color _getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.active:
        return const Color(0xFF10B981);
      case TransactionStatus.expired:
        return const Color(0xFFEF4444);
      case TransactionStatus.completed:
        return const Color(0xFF6366F1);
    }
  }

  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.active:
        return 'Active';
      case TransactionStatus.expired:
        return 'Expired';
      case TransactionStatus.completed:
        return 'Used';
    }
  }

  String _formatDateTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showTransactionDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TransactionDetailsSheet(transaction: transaction),
    );
  }
}

/// Modern transaction details bottom sheet
class TransactionDetailsSheet extends StatelessWidget {
  final PointTransaction transaction;

  const TransactionDetailsSheet({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getTransactionColor(
                      transaction,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getTransactionColor(
                        transaction,
                      ).withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    _getTransactionIcon(transaction),
                    color: _getTransactionColor(transaction),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transaction Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        transaction.formattedPointsDelta,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: _getTransactionColor(transaction),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.grey[500]),
                ),
              ],
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                _buildDetailRow('Description', transaction.description),
                _buildDetailRow(
                  'Type',
                  transaction.transactionType.displayName,
                ),
                _buildDetailRow(
                  'Date',
                  _formatFullDate(transaction.transactionDate),
                ),
                if (transaction.expiryDate != null)
                  _buildDetailRow(
                    'Expires',
                    _formatFullDate(transaction.expiryDate!),
                  ),
                if (transaction.referenceId != null)
                  _buildDetailRow('Reference ID', transaction.referenceId!),
                if (transaction.relatedCouponId != null)
                  _buildDetailRow(
                    'Coupon ID',
                    transaction.relatedCouponId.toString(),
                  ),
                if (transaction.relatedSubscriptionId != null)
                  _buildDetailRow(
                    'Subscription ID',
                    transaction.relatedSubscriptionId.toString(),
                  ),
                if (transaction.isCredit && transaction.status != null)
                  _buildDetailRow(
                    'Status',
                    _getStatusText(transaction.status!),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getTransactionColor(PointTransaction transaction) {
    return transaction.isCredit
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);
  }

  IconData _getTransactionIcon(PointTransaction transaction) {
    if (transaction.isCredit) {
      return Icons.add_circle;
    } else {
      return Icons.remove_circle;
    }
  }

  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.active:
        return 'Active';
      case TransactionStatus.expired:
        return 'Expired';
      case TransactionStatus.completed:
        return 'Used';
    }
  }

  String _formatFullDate(DateTime date) {
    final months = [
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
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
