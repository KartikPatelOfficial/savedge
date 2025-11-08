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
      final data = e.response!.data;
      final statusText =
          'Request failed with status ${e.response?.statusCode ?? 'unknown'}';

      if (data is Map<String, dynamic>) {
        final message = data['message'] ?? data['error'];
        if (message is String && message.isNotEmpty) {
          return Exception(message);
        }
      } else if (data is String && data.isNotEmpty) {
        return Exception(data);
      }

      return Exception(statusText);
    }

    return Exception('Network error: ${e.message}');
  }
}
