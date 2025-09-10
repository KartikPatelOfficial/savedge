/// Subscription plan entity
class SubscriptionPlan {
  const SubscriptionPlan({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.durationMonths,
    this.features,
    this.imageUrl,
    required this.isActive,
  });

  final int id;
  final String name;
  final String? description;
  final double price;
  final int durationMonths;
  final String? features;
  final String? imageUrl;
  final bool isActive;

  /// Get formatted price display
  String get priceDisplay => '\$${price.toStringAsFixed(2)}';

  /// Get duration display
  String get durationDisplay {
    if (durationMonths == 1) {
      return '1 Month';
    } else if (durationMonths == 12) {
      return '1 Year';
    } else {
      return '$durationMonths Months';
    }
  }

  /// Check if plan has image
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;
}
