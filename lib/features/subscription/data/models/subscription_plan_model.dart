import '../../domain/entities/subscription_plan.dart';

class SubscriptionPlanModel {
  const SubscriptionPlanModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.durationMonths,
    this.features,
    this.imageUrl,
    this.isActive =
        true, // Default to true since API doesn't provide this field
  });

  final int id;
  final String name;
  final String? description;
  final double price;
  final int durationMonths;
  final String? features;
  final String? imageUrl;
  final bool isActive;

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      durationMonths: json['durationMonths'] as int,
      features: (json['features'] as String?)?.isEmpty == true
          ? null
          : json['features'] as String?,
      imageUrl: (json['imageUrl'] as String?)?.isEmpty == true
          ? null
          : json['imageUrl'] as String?,
      // Note: API doesn't provide isActive field, so we default to true
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'durationMonths': durationMonths,
      'features': features,
      'imageUrl': imageUrl,
      'isActive': isActive,
    };
  }

  SubscriptionPlan toEntity() => SubscriptionPlan(
    id: id,
    name: name,
    description: description,
    price: price,
    durationMonths: durationMonths,
    features: features,
    imageUrl: imageUrl,
    isActive: isActive,
  );
}
