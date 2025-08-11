import '../../../features/subscription/domain/entities/subscription_plan.dart';

/// Mock service to provide sample subscription plans
class SubscriptionPlanService {
  static List<SubscriptionPlan> getSamplePlans() {
    return [
      SubscriptionPlan(
        id: 1,
        name: 'Premium Monthly',
        description: 'Perfect for individuals who want to save more with monthly flexibility',
        price: 9.99,
        durationMonths: 1,
        bonusPoints: 100,
        maxCoupons: 5,
        features: 'Access to exclusive deals, priority support, early access to new offers',
        imageUrl: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        isActive: true,
      ),
      SubscriptionPlan(
        id: 2,
        name: 'Premium Annual',
        description: 'Best value for long-term savings with significant discounts',
        price: 99.99,
        durationMonths: 12,
        bonusPoints: 1500,
        maxCoupons: 10,
        features: 'All monthly benefits plus exclusive annual member perks, bonus rewards, VIP customer service',
        imageUrl: 'https://images.unsplash.com/photo-1559526324-4b87b5e36e44?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        isActive: true,
      ),
      SubscriptionPlan(
        id: 3,
        name: 'Family Plan',
        description: 'Share the savings with your family members',
        price: 149.99,
        durationMonths: 12,
        bonusPoints: 2000,
        maxCoupons: 20,
        features: 'Up to 5 family members, shared point pool, family-exclusive deals, bulk purchase discounts',
        imageUrl: 'https://images.unsplash.com/photo-1511895426328-dc8714191300?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
        isActive: true,
      ),
    ];
  }

  /// Get single sample plan for testing
  static SubscriptionPlan getSinglePlan() {
    return SubscriptionPlan(
      id: 1,
      name: 'SavEdge Premium',
      description: 'Unlock exclusive savings and premium features',
      price: 99.99,
      durationMonths: 12,
      bonusPoints: 1000,
      maxCoupons: 15,
      features: 'Access to all premium deals, priority support, monthly bonus points',
      imageUrl: 'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
      isActive: true,
    );
  }
}
