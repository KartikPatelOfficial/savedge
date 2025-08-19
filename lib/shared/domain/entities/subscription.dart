import 'package:equatable/equatable.dart';

/// Domain entity representing a subscription plan
class SubscriptionPlan extends Equatable {
  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.durationMonths,
    required this.bonusPoints,
    required this.maxCoupons,
    this.description,
    this.features,
    this.imageUrl,
    this.isActive = true,
  });

  final int id;
  final String name;
  final String? description;
  final double price;
  final int durationMonths;
  final int bonusPoints;
  final int maxCoupons;
  final String? features;
  final String? imageUrl;
  final bool isActive;

  /// Check if this plan has unlimited coupons
  bool get hasUnlimitedCoupons => maxCoupons == -1;

  /// Get features as a list
  List<String> get featuresList {
    if (features == null || features!.isEmpty) return [];
    return features!.split(',').map((f) => f.trim()).toList();
  }

  /// Get plan duration as formatted string
  String get durationText {
    if (durationMonths == 1) return '1 Month';
    if (durationMonths == 12) return '1 Year';
    if (durationMonths % 12 == 0) return '${durationMonths ~/ 12} Years';
    return '$durationMonths Months';
  }

  /// Calculate monthly price
  double get monthlyPrice => price / durationMonths;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    durationMonths,
    bonusPoints,
    maxCoupons,
    features,
    imageUrl,
    isActive,
  ];
}

/// Domain entity representing a user's subscription
class UserSubscription extends Equatable {
  const UserSubscription({
    required this.planId,
    required this.planName,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.autoRenew,
  });

  final int planId;
  final String planName;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final bool autoRenew;

  /// Check if subscription is currently active
  bool get isCurrentlyActive {
    final now = DateTime.now();
    return isActive && startDate.isBefore(now) && endDate.isAfter(now);
  }

  /// Get remaining days in subscription
  int get remainingDays {
    if (!isCurrentlyActive) return 0;
    final now = DateTime.now();
    return endDate.difference(now).inDays;
  }

  /// Check if subscription is expiring soon (within 7 days)
  bool get isExpiringSoon {
    return isCurrentlyActive && remainingDays <= 7;
  }

  /// Get subscription status text
  String get statusText {
    if (!isActive) return 'Inactive';
    if (!isCurrentlyActive) return 'Expired';
    if (isExpiringSoon) return 'Expiring Soon';
    return 'Active';
  }

  /// Get progress percentage (0.0 to 1.0)
  double get progressPercentage {
    if (!isCurrentlyActive) return 0.0;
    final totalDays = endDate.difference(startDate).inDays;
    final elapsedDays = DateTime.now().difference(startDate).inDays;
    return (elapsedDays / totalDays).clamp(0.0, 1.0);
  }

  @override
  List<Object?> get props => [
    planId,
    planName,
    startDate,
    endDate,
    isActive,
    autoRenew,
  ];
}

/// Domain entity representing a payment transaction
class PaymentTransaction extends Equatable {
  const PaymentTransaction({
    required this.id,
    required this.status,
    required this.amount,
    required this.createdAt,
    this.paymentReference,
    this.razorpayOrderId,
    this.failureReason,
    this.planName,
  });

  final int id;
  final String status;
  final double amount;
  final DateTime createdAt;
  final String? paymentReference;
  final String? razorpayOrderId;
  final String? failureReason;
  final String? planName;

  /// Check if payment was successful
  bool get isSuccessful => status.toLowerCase() == 'success';

  /// Check if payment is pending
  bool get isPending => status.toLowerCase() == 'pending';

  /// Check if payment failed
  bool get isFailed => status.toLowerCase() == 'failed';

  @override
  List<Object?> get props => [
    id,
    status,
    amount,
    createdAt,
    paymentReference,
    razorpayOrderId,
    failureReason,
    planName,
  ];
}
