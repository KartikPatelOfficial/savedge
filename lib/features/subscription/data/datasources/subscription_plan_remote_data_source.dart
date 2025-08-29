import 'package:dio/dio.dart';
import '../models/subscription_plan_model.dart';

/// Remote data source for subscription plans
abstract class SubscriptionPlanRemoteDataSource {
  Future<List<SubscriptionPlanModel>> getSubscriptionPlans();
  Future<SubscriptionPlanModel?> getSubscriptionPlan(int id);
}

/// Implementation of subscription plan remote data source
class SubscriptionPlanRemoteDataSourceImpl
    implements SubscriptionPlanRemoteDataSource {
  const SubscriptionPlanRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<SubscriptionPlanModel>> getSubscriptionPlans() async {
    try {
      final response = await _dio.get('/api/subscriptions');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map(
              (json) =>
                  SubscriptionPlanModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }

      throw Exception('Failed to fetch subscription plans');
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  @override
  Future<SubscriptionPlanModel?> getSubscriptionPlan(int id) async {
    try {
      final response = await _dio.get('/api/subscriptions/$id');

      if (response.statusCode == 200) {
        return SubscriptionPlanModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      }

      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }
}
