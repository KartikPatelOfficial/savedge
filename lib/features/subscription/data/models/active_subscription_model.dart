import 'package:savedge/features/subscription/domain/entities/active_subscription.dart';

/// Manual data model (no code generation) for ActiveSubscription JSON parsing
class ActiveSubscriptionModel extends ActiveSubscription {
  const ActiveSubscriptionModel({
    required super.planId,
    required super.planName,
    super.description,
    required super.price,
    required super.startDate,
    required super.endDate,
    required super.isActive,
    required super.autoRenew,
    required super.daysRemaining,
    required super.bonusPoints,
    required super.maxCoupons,
  });

  factory ActiveSubscriptionModel.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      throw ArgumentError('Empty JSON for ActiveSubscriptionModel');
    }
    return ActiveSubscriptionModel(
      planId: (json['planId'] as num).toInt(),
      planName: json['planName'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
      autoRenew: json['autoRenew'] as bool? ?? false,
      daysRemaining: (json['daysRemaining'] as num?)?.toInt() ?? 0,
      bonusPoints: (json['bonusPoints'] as num?)?.toInt() ?? 0,
      maxCoupons: (json['maxCoupons'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'planId': planId,
    'planName': planName,
    'description': description,
    'price': price,
    'startDate': startDate.toIso8601String(),
    'endDate': endDate.toIso8601String(),
    'isActive': isActive,
    'autoRenew': autoRenew,
    'daysRemaining': daysRemaining,
    'bonusPoints': bonusPoints,
    'maxCoupons': maxCoupons,
  };

  ActiveSubscription toDomain() => this;
}
