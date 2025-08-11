import '../../domain/entities/subscription_plan.dart';
import '../../domain/repositories/subscription_plan_repository.dart';
import '../datasources/subscription_plan_remote_data_source.dart';

/// Implementation of subscription plan repository
class SubscriptionPlanRepositoryImpl implements SubscriptionPlanRepository {
  const SubscriptionPlanRepositoryImpl(this._remoteDataSource);

  final SubscriptionPlanRemoteDataSource _remoteDataSource;

  @override
  Future<List<SubscriptionPlan>> getSubscriptionPlans() async {
    try {
      final models = await _remoteDataSource.getSubscriptionPlans();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SubscriptionPlan?> getSubscriptionPlan(int id) async {
    try {
      final model = await _remoteDataSource.getSubscriptionPlan(id);
      return model?.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
