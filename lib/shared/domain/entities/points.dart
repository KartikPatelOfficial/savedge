import 'package:equatable/equatable.dart';

/// Domain entity representing user points/rewards
class Points extends Equatable {
  const Points({required this.balance, this.expirationDate});

  final int balance;
  final DateTime? expirationDate;

  /// Check if user has sufficient points for a transaction
  bool hasSufficientPoints(int requiredPoints) {
    return balance >= requiredPoints;
  }

  /// Check if points are expiring soon (within 7 days)
  bool get isExpiringSoon {
    if (expirationDate == null) return false;
    final now = DateTime.now();
    final daysUntilExpiry = expirationDate!.difference(now).inDays;
    return daysUntilExpiry <= 7 && daysUntilExpiry >= 0;
  }

  /// Get days until expiration
  int get daysUntilExpiry {
    if (expirationDate == null) return -1;
    final now = DateTime.now();
    return expirationDate!.difference(now).inDays;
  }

  /// Check if points have expired
  bool get hasExpired {
    if (expirationDate == null) return false;
    return DateTime.now().isAfter(expirationDate!);
  }

  @override
  List<Object?> get props => [balance, expirationDate];
}

/// Domain entity representing a point transaction in the ledger
class PointTransaction extends Equatable {
  const PointTransaction({
    required this.id,
    required this.pointsDelta,
    required this.type,
    required this.description,
    required this.transactionDate,
    this.expiryDate,
    this.relatedCouponId,
    this.relatedSubscriptionId,
    this.referenceId,
  });

  final int id;
  final int pointsDelta;
  final String type;
  final String description;
  final DateTime transactionDate;
  final DateTime? expiryDate;
  final int? relatedCouponId;
  final int? relatedSubscriptionId;
  final String? referenceId;

  /// Check if this is a credit transaction (positive points)
  bool get isCredit => pointsDelta > 0;

  /// Check if this is a debit transaction (negative points)
  bool get isDebit => pointsDelta < 0;

  /// Get transaction type as enum
  TransactionType get transactionType {
    switch (type.toLowerCase()) {
      case 'pointsallocation':
        return TransactionType.pointsAllocation;
      case 'couponredemption':
        return TransactionType.couponRedemption;
      case 'subscriptionpurchase':
        return TransactionType.subscriptionPurchase;
      case 'pointsexpiration':
        return TransactionType.pointsExpiration;
      case 'refund':
        return TransactionType.refund;
      default:
        return TransactionType.other;
    }
  }

  /// Get transaction status based on expiry
  TransactionStatus get status {
    if (isDebit) return TransactionStatus.completed;
    if (expiryDate == null) return TransactionStatus.active;
    if (DateTime.now().isAfter(expiryDate!)) return TransactionStatus.expired;
    return TransactionStatus.active;
  }

  /// Get formatted points display
  String get formattedPointsDelta {
    if (isCredit) return '+${pointsDelta.abs()}';
    return '-${pointsDelta.abs()}';
  }

  @override
  List<Object?> get props => [
    id,
    pointsDelta,
    type,
    description,
    transactionDate,
    expiryDate,
    relatedCouponId,
    relatedSubscriptionId,
    referenceId,
  ];
}

/// Enum representing different transaction types
enum TransactionType {
  pointsAllocation,
  couponRedemption,
  subscriptionPurchase,
  pointsExpiration,
  refund,
  other,
}

/// Enum representing transaction status
enum TransactionStatus { active, expired, completed }

/// Extension methods for TransactionType
extension TransactionTypeExtension on TransactionType {
  String get displayName {
    switch (this) {
      case TransactionType.pointsAllocation:
        return 'Points Allocation';
      case TransactionType.couponRedemption:
        return 'Coupon Redemption';
      case TransactionType.subscriptionPurchase:
        return 'Subscription Purchase';
      case TransactionType.pointsExpiration:
        return 'Points Expiration';
      case TransactionType.refund:
        return 'Refund';
      case TransactionType.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case TransactionType.pointsAllocation:
        return '💰';
      case TransactionType.couponRedemption:
        return '🎫';
      case TransactionType.subscriptionPurchase:
        return '📱';
      case TransactionType.pointsExpiration:
        return '⏰';
      case TransactionType.refund:
        return '↩️';
      case TransactionType.other:
        return '📄';
    }
  }
}

/// Exception thrown when trying to spend more points than available
class InsufficientPointsException implements Exception {
  const InsufficientPointsException();

  @override
  String toString() => 'Insufficient points for this transaction';
}
