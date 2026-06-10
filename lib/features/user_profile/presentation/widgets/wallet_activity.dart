import 'package:flutter/material.dart';

import 'package:savedge/features/user_profile/presentation/theme/wallet_tokens.dart';
import 'package:savedge/shared/domain/entities/points.dart';

/// Direction filter applied to the activity feed.
enum WalletFilter { all, earned, spent }

extension WalletFilterX on WalletFilter {
  String get label => switch (this) {
    WalletFilter.all => 'All',
    WalletFilter.earned => 'Earned',
    WalletFilter.spent => 'Spent',
  };

  bool matches(PointTransaction t) => switch (this) {
    WalletFilter.all => true,
    WalletFilter.earned => t.isCredit,
    WalletFilter.spent => t.isDebit,
  };
}

/// Pill segmented control for the activity feed.
class WalletFilterChips extends StatelessWidget {
  const WalletFilterChips({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final WalletFilter selected;
  final ValueChanged<WalletFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final filter in WalletFilter.values) ...[
          if (filter != WalletFilter.all) const SizedBox(width: WalletTokens.s2),
          _FilterPill(
            label: filter.label,
            isSelected: filter == selected,
            onTap: () => onChanged(filter),
          ),
        ],
      ],
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: 'Show $label activity',
      child: Material(
        color: isSelected ? WalletTokens.ink : WalletTokens.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WalletTokens.rChip),
          side: BorderSide(
            color: isSelected ? WalletTokens.ink : WalletTokens.border,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(WalletTokens.rChip),
          child: Container(
            constraints: const BoxConstraints(minHeight: 40),
            padding: const EdgeInsets.symmetric(
              horizontal: WalletTokens.s4,
              vertical: WalletTokens.s2,
            ),
            alignment: Alignment.center,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? WalletTokens.onInk
                    : WalletTokens.textSecondary,
              ),
              child: Text(label),
            ),
          ),
        ),
      ),
    );
  }
}

/// One calendar month of transactions: an eyebrow header followed by a
/// grouped white card with hairline dividers.
class WalletMonthGroup extends StatelessWidget {
  const WalletMonthGroup({
    super.key,
    required this.label,
    required this.transactions,
  });

  final String label;
  final List<PointTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            WalletTokens.s1,
            WalletTokens.s5,
            0,
            WalletTokens.s3,
          ),
          child: Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: WalletTokens.textTertiary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: WalletTokens.surface,
            borderRadius: BorderRadius.circular(WalletTokens.rCard),
            border: Border.all(color: WalletTokens.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var i = 0; i < transactions.length; i++) ...[
                if (i > 0)
                  const Padding(
                    padding: EdgeInsets.only(left: 72),
                    child: Divider(height: 1),
                  ),
                WalletTransactionTile(transaction: transactions[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// A single ledger entry row. Icon is keyed to the transaction type, the
/// amount to its direction.
class WalletTransactionTile extends StatelessWidget {
  const WalletTransactionTile({super.key, required this.transaction});

  final PointTransaction transaction;

  @override
  Widget build(BuildContext context) {
    final style = _TxStyle.of(transaction);

    return InkWell(
      onTap: () => WalletTransactionSheet.show(context, transaction),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: WalletTokens.s4,
          vertical: WalletTokens.s3,
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: style.background,
                borderRadius: BorderRadius.circular(WalletTokens.rTile),
              ),
              child: Icon(style.icon, size: 21, color: style.foreground),
            ),
            const SizedBox(width: WalletTokens.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: WalletTokens.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${walletRelativeDate(transaction.transactionDate)}'
                    '  ·  ${transaction.transactionType.displayName}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: WalletTokens.textTertiary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: WalletTokens.s3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transaction.isCredit ? '+' : '−'}'
                  '${WalletTokens.fmt(transaction.pointsDelta.abs())}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                    color: transaction.isCredit
                        ? WalletTokens.credit
                        : WalletTokens.textPrimary,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                if (transaction.isCredit) ...[
                  const SizedBox(height: 3),
                  Text(
                    _statusLabel(transaction.status),
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: _statusColor(transaction.status),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  static String _statusLabel(TransactionStatus status) => switch (status) {
    TransactionStatus.active => 'Active',
    TransactionStatus.expired => 'Expired',
    TransactionStatus.completed => 'Used',
  };

  static Color _statusColor(TransactionStatus status) => switch (status) {
    TransactionStatus.active => WalletTokens.credit,
    TransactionStatus.expired => WalletTokens.debit,
    TransactionStatus.completed => WalletTokens.textTertiary,
  };
}

/// Icon + tint pairing for a ledger entry, keyed by transaction type.
class _TxStyle {
  const _TxStyle(this.icon, this.foreground, this.background);

  final IconData icon;
  final Color foreground;
  final Color background;

  static _TxStyle of(PointTransaction t) => switch (t.transactionType) {
    TransactionType.pointsAllocation => const _TxStyle(
      Icons.add_card_rounded,
      WalletTokens.credit,
      WalletTokens.creditSoft,
    ),
    TransactionType.refund => const _TxStyle(
      Icons.undo_rounded,
      WalletTokens.credit,
      WalletTokens.creditSoft,
    ),
    TransactionType.couponRedemption => const _TxStyle(
      Icons.local_activity_rounded,
      WalletTokens.primary,
      WalletTokens.primarySoft,
    ),
    TransactionType.subscriptionPurchase => const _TxStyle(
      Icons.autorenew_rounded,
      WalletTokens.primary,
      WalletTokens.primarySoft,
    ),
    TransactionType.pointsExpiration => const _TxStyle(
      Icons.hourglass_disabled_rounded,
      WalletTokens.warn,
      WalletTokens.warnSoft,
    ),
    TransactionType.other => const _TxStyle(
      Icons.swap_horiz_rounded,
      WalletTokens.textSecondary,
      WalletTokens.canvas,
    ),
  };
}

/// Bottom sheet with the full detail of one ledger entry.
class WalletTransactionSheet extends StatelessWidget {
  const WalletTransactionSheet({super.key, required this.transaction});

  final PointTransaction transaction;

  static Future<void> show(BuildContext context, PointTransaction t) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: WalletTokens.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(WalletTokens.rSheet),
        ),
      ),
      builder: (_) => WalletTransactionSheet(transaction: t),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = _TxStyle.of(transaction);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          WalletTokens.s5,
          WalletTokens.s3,
          WalletTokens.s5,
          WalletTokens.s5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: WalletTokens.border,
                borderRadius: BorderRadius.circular(WalletTokens.rChip),
              ),
            ),
            const SizedBox(height: WalletTokens.s5),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: style.background,
                borderRadius: BorderRadius.circular(WalletTokens.rCard),
              ),
              child: Icon(style.icon, size: 26, color: style.foreground),
            ),
            const SizedBox(height: WalletTokens.s3),
            Text(
              '${transaction.isCredit ? '+' : '−'}'
              '${WalletTokens.fmt(transaction.pointsDelta.abs())} pts',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.8,
                color: transaction.isCredit
                    ? WalletTokens.credit
                    : WalletTokens.textPrimary,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: WalletTokens.s1),
            Text(
              transaction.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.4,
                color: WalletTokens.textSecondary,
              ),
            ),
            const SizedBox(height: WalletTokens.s5),
            Container(
              padding: const EdgeInsets.all(WalletTokens.s4),
              decoration: BoxDecoration(
                color: WalletTokens.canvas,
                borderRadius: BorderRadius.circular(WalletTokens.rCard),
              ),
              child: Column(
                children: [
                  _DetailRow(
                    label: 'Type',
                    value: transaction.transactionType.displayName,
                  ),
                  _DetailRow(
                    label: 'Date',
                    value: walletFullDate(transaction.transactionDate),
                  ),
                  if (transaction.expiryDate != null)
                    _DetailRow(
                      label: 'Expires',
                      value: walletFullDate(transaction.expiryDate!),
                    ),
                  if (transaction.isCredit)
                    _DetailRow(
                      label: 'Status',
                      value: WalletTransactionTile._statusLabel(
                        transaction.status,
                      ),
                    ),
                  if (transaction.referenceId != null)
                    _DetailRow(
                      label: 'Reference',
                      value: transaction.referenceId!,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: WalletTokens.textTertiary,
            ),
          ),
          const SizedBox(width: WalletTokens.s4),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: WalletTokens.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> _months = [
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

/// "Today", "Yesterday", "3d ago", then "12 Jun".
String walletRelativeDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(date.year, date.month, date.day);
  final days = today.difference(day).inDays;

  if (days <= 0) return 'Today';
  if (days == 1) return 'Yesterday';
  if (days < 7) return '${days}d ago';
  final month = _months[date.month - 1].substring(0, 3);
  return date.year == now.year
      ? '${date.day} $month'
      : '${date.day} $month ${date.year}';
}

/// "12 June 2026".
String walletFullDate(DateTime date) =>
    '${date.day} ${_months[date.month - 1]} ${date.year}';

/// "June 2026" — month-group label.
String walletMonthLabel(DateTime date) =>
    '${_months[date.month - 1]} ${date.year}';
