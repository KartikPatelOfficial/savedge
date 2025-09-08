part of 'points_bloc.dart';

/// Base class for all points states
abstract class PointsState extends Equatable {
  const PointsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class PointsInitial extends PointsState {
  const PointsInitial();
}

/// Loading state
class PointsLoading extends PointsState {
  const PointsLoading();
}

/// Loaded state with points data
class PointsLoaded extends PointsState {
  final Points points;
  final List<PointTransaction>? transactions;
  final Map<String, dynamic>? expiringPointsData;
  final int? expiredPointsCount;
  final bool isLoadingLedger;
  final bool isLoadingExpiring;
  final bool isLoadingExpiredCount;
  final bool isRefreshing;
  final String? ledgerError;
  final String? expiringError;
  final String? expiredCountError;

  const PointsLoaded({
    required this.points,
    this.transactions,
    this.expiringPointsData,
    this.expiredPointsCount,
    this.isLoadingLedger = false,
    this.isLoadingExpiring = false,
    this.isLoadingExpiredCount = false,
    this.isRefreshing = false,
    this.ledgerError,
    this.expiringError,
    this.expiredCountError,
  });

  /// Helper getters
  bool get hasTransactions => transactions != null && transactions!.isNotEmpty;
  bool get hasExpiringPoints => expiringPointsData != null;
  bool get hasExpiredPointsCount => expiredPointsCount != null;

  /// Get credit transactions (positive points)
  List<PointTransaction> get creditTransactions {
    if (transactions == null) return [];
    return transactions!.where((t) => t.isCredit).toList();
  }

  /// Get debit transactions (negative points)
  List<PointTransaction> get debitTransactions {
    if (transactions == null) return [];
    return transactions!.where((t) => t.isDebit).toList();
  }

  /// Get recent transactions (last 10)
  List<PointTransaction> get recentTransactions {
    if (transactions == null) return [];
    final sortedTransactions = List<PointTransaction>.from(transactions!)
      ..sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
    return sortedTransactions.take(10).toList();
  }

  PointsLoaded copyWith({
    Points? points,
    List<PointTransaction>? transactions,
    Map<String, dynamic>? expiringPointsData,
    int? expiredPointsCount,
    bool? isLoadingLedger,
    bool? isLoadingExpiring,
    bool? isLoadingExpiredCount,
    bool? isRefreshing,
    String? ledgerError,
    String? expiringError,
    String? expiredCountError,
  }) {
    return PointsLoaded(
      points: points ?? this.points,
      transactions: transactions ?? this.transactions,
      expiringPointsData: expiringPointsData ?? this.expiringPointsData,
      expiredPointsCount: expiredPointsCount ?? this.expiredPointsCount,
      isLoadingLedger: isLoadingLedger ?? this.isLoadingLedger,
      isLoadingExpiring: isLoadingExpiring ?? this.isLoadingExpiring,
      isLoadingExpiredCount:
          isLoadingExpiredCount ?? this.isLoadingExpiredCount,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      ledgerError: ledgerError,
      expiringError: expiringError,
      expiredCountError: expiredCountError,
    );
  }

  @override
  List<Object?> get props => [
    points,
    transactions,
    expiringPointsData,
    expiredPointsCount,
    isLoadingLedger,
    isLoadingExpiring,
    isLoadingExpiredCount,
    isRefreshing,
    ledgerError,
    expiringError,
    expiredCountError,
  ];
}

/// Error state
class PointsError extends PointsState {
  final String message;

  const PointsError({required this.message});

  @override
  List<Object> get props => [message];
}
