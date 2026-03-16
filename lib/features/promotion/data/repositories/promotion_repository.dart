import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/features/promotion/data/models/promotion_models.dart';

abstract class PromotionRepository {
  Future<PromotionStatusResponse> getPromotionStatus();
  Future<EnrollPromotionResponse> enrollInPromotion();
}

@LazySingleton(as: PromotionRepository)
class PromotionRepositoryImpl implements PromotionRepository {
  final Dio _dio;

  PromotionRepositoryImpl(this._dio);

  @override
  Future<PromotionStatusResponse> getPromotionStatus() async {
    try {
      final response = await _dio.get('/api/promotion/status');
      return PromotionStatusResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<EnrollPromotionResponse> enrollInPromotion() async {
    try {
      final response = await _dio.post('/api/promotion/enroll');
      return EnrollPromotionResponse.fromJson(response.data);
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
