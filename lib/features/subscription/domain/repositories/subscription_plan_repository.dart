import '../entities/subscription_plan.dart';

/// Repository interface for subscription plans
abstract class SubscriptionPlanRepository {
  /// Get all available subscription plans
  Future<List<SubscriptionPlan>> getSubscriptionPlans();
  
  /// Get subscription plan by ID
  Future<SubscriptionPlan?> getSubscriptionPlan(int id);
}
