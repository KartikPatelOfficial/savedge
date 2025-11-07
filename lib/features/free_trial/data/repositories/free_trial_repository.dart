import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../models/free_trial_models.dart';

abstract class FreeTrialRepository {
  Future<FreeTrialStatusResponse> getFreeTrialStatus();
  Future<ActivateFreeTrialResponse> activateFreeTrial();
}

@LazySingleton(as: FreeTrialRepository)
class FreeTrialRepositoryImpl implements FreeTrialRepository {
  final Dio _dio;

  FreeTrialRepositoryImpl(this._dio);

  @override
  Future<FreeTrialStatusResponse> getFreeTrialStatus() async {
    try {
      final response = await _dio.get('/api/free-trial/status');
      return FreeTrialStatusResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<ActivateFreeTrialResponse> activateFreeTrial() async {
    try {
      final response = await _dio.post('/api/free-trial/activate');
      return ActivateFreeTrialResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final message = e.response?.data['message'] ?? 'An error occurred';
      return Exception(message);
    }
    return Exception('Network error: ${e.message}');
  }
}
