import 'package:flutter/material.dart';
import '../../../../shared/domain/entities/points.dart';

/// List widget for displaying point transactions
class PointsTransactionList extends StatelessWidget {
  final List<PointTransaction> transactions;

  const PointsTransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Handled by parent widget
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return TransactionTile(transaction: transaction);
        },
      ),
    );
  }
}

/// Individual transaction tile widget
class TransactionTile extends StatelessWidget {
  final PointTransaction transaction;

  const TransactionTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: transaction.isCredit
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            transaction.isCredit 
                ? Icons.add_circle_outline
                : Icons.remove_circle_outline,
            color: transaction.isCredit ? Colors.green : Colors.red,
            size: 24,
          ),
        ),
        title: Text(
          transaction.description,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              transaction.transactionType.displayName,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            const SizedBox(height: 2),
            Text(
              _formatDate(transaction.transactionDate),
              style: TextStyle(color: Colors.grey[500], fontSize: 11),
            ),
            if (transaction.expiryDate != null && transaction.isCredit) ...[
              const SizedBox(height: 2),
              Text(
                'Expires: ${_formatDate(transaction.expiryDate!)}',
                style: TextStyle(
                  color: transaction.status == TransactionStatus.expired
                      ? Colors.red
                      : Colors.orange[600],
                  fontSize: 11,
                ),
              ),
            ],
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              transaction.formattedPointsDelta,
              style: TextStyle(
                color: transaction.isCredit ? Colors.green : Colors.red,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            if (transaction.isCredit)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(transaction.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getStatusColor(transaction.status).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  _getStatusText(transaction.status),
                  style: TextStyle(
                    color: _getStatusColor(transaction.status),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        onTap: () => _showTransactionDetails(context),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getStatusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.active:
        return Colors.green;
      case TransactionStatus.expired:
        return Colors.red;
      case TransactionStatus.completed:
        return Colors.blue;
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

  void _showTransactionDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(transaction.transactionType.displayName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Amount', transaction.formattedPointsDelta),
            _buildDetailRow('Date', _formatDate(transaction.transactionDate)),
            _buildDetailRow('Description', transaction.description),
            if (transaction.expiryDate != null)
              _buildDetailRow('Expires', _formatDate(transaction.expiryDate!)),
            if (transaction.referenceId != null)
              _buildDetailRow('Reference', transaction.referenceId!),
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
