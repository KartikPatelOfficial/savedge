import 'package:equatable/equatable.dart';

/// Domain entity representing user points/rewards
class Points extends Equatable {
  const Points({
    required this.balance,
    required this.earnedTotal,
    required this.spentTotal,
    this.expiringAmount = 0,
    this.expirationDate,
  });

  final int balance;
  final int earnedTotal;
  final int spentTotal;
  final int expiringAmount;
  final DateTime? expirationDate;

  /// Check if user has sufficient points for a transaction
  bool hasSufficientPoints(int requiredPoints) {
    return balance >= requiredPoints;
  }

  /// Create new points instance after earning points
  Points earnPoints(int amount) {
    return Points(
      balance: balance + amount,
      earnedTotal: earnedTotal + amount,
      spentTotal: spentTotal,
      expiringAmount: expiringAmount,
      expirationDate: expirationDate,
    );
  }

  /// Create new points instance after spending points
  Points spendPoints(int amount) {
    if (!hasSufficientPoints(amount)) {
      throw InsufficientPointsException();
    }
    
    return Points(
      balance: balance - amount,
      earnedTotal: earnedTotal,
      spentTotal: spentTotal + amount,
      expiringAmount: expiringAmount,
      expirationDate: expirationDate,
    );
  }

  @override
  List<Object?> get props => [
        balance,
        earnedTotal,
        spentTotal,
        expiringAmount,
        expirationDate,
      ];
}

/// Exception thrown when trying to spend more points than available
class InsufficientPointsException implements Exception {
  const InsufficientPointsException();
  
  @override
  String toString() => 'Insufficient points for this transaction';
}