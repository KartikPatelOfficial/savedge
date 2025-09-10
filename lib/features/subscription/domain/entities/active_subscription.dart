/// Active subscription entity representing user's current subscription
class ActiveSubscription {
  const ActiveSubscription({
    required this.planId,
    required this.planName,
    this.description,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.autoRenew,
    required this.daysRemaining,
  });

  final int planId;
  final String planName;
  final String? description;
  final double price;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final bool autoRenew;
  final int daysRemaining;

  /// Get formatted price display
  String get priceDisplay => '\$${price.toStringAsFixed(2)}';

  /// Get subscription status display
  String get statusDisplay {
    if (!isActive) return 'Inactive';
    if (daysRemaining <= 0) return 'Expired';
    if (daysRemaining <= 7) return 'Expiring Soon';
    return 'Active';
  }

  /// Get status color based on subscription state
  String get statusColor {
    if (!isActive || daysRemaining <= 0) return 'red';
    if (daysRemaining <= 7) return 'orange';
    return 'green';
  }

  /// Check if subscription is expiring soon (within 7 days)
  bool get isExpiringSoon =>
      isActive && daysRemaining <= 7 && daysRemaining > 0;

  /// Check if subscription has expired
  bool get hasExpired => daysRemaining <= 0;

  /// Get formatted date range display
  String get dateRangeDisplay {
    final startFormatted =
        '${startDate.day}/${startDate.month}/${startDate.year}';
    final endFormatted = '${endDate.day}/${endDate.month}/${endDate.year}';
    return '$startFormatted - $endFormatted';
  }

  /// Get remaining time display
  String get remainingTimeDisplay {
    if (daysRemaining <= 0) return 'Expired';
    if (daysRemaining == 1) return '1 day left';
    if (daysRemaining <= 30) return '$daysRemaining days left';

    final months = (daysRemaining / 30).floor();
    final remainingDays = daysRemaining % 30;

    if (months == 1) {
      return remainingDays == 0
          ? '1 month left'
          : '1 month, $remainingDays days left';
    }

    return remainingDays == 0
        ? '$months months left'
        : '$months months, $remainingDays days left';
  }
}
