import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:savedge/core/error/exceptions.dart';
import 'package:savedge/features/notifications/data/models/notification_model.dart';

/// Remote data source for notification API calls
class NotificationRemoteDataSource {
  final Dio _dio;

  NotificationRemoteDataSource(this._dio);

  /// Register device token with the backend
  Future<void> registerDeviceToken(RegisterDeviceTokenRequest request) async {
    try {
      await _dio.post(
        '/api/notifications/device-token',
        data: request.toJson(),
      );
    } on DioException catch (e) {
      debugPrint('Error registering device token: ${e.message}');
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to register device token',
        statusCode: e.response?.statusCode,
      );
    }
  }

  /// Remove device token from the backend
  Future<void> removeDeviceToken() async {
    try {
      await _dio.delete('/api/notifications/device-token');
    } on DioException catch (e) {
      debugPrint('Error removing device token: ${e.message}');
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to remove device token',
        statusCode: e.response?.statusCode,
      );
    }
  }

  /// Get notification history with pagination
  Future<NotificationListResponse> getNotifications({
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _dio.get(
        '/api/notifications/history',
        queryParameters: {
          'pageNumber': pageNumber,
          'pageSize': pageSize,
        },
      );
      return NotificationListResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Error getting notifications: ${e.message}');
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get notifications',
        statusCode: e.response?.statusCode,
      );
    }
  }

  /// Get unread notification count
  Future<int> getUnreadCount() async {
    try {
      final response = await _dio.get('/api/notifications/unread-count');
      // Handle both direct int response and wrapped response
      if (response.data is int) {
        return response.data;
      }
      if (response.data is Map<String, dynamic>) {
        return UnreadCountResponse.fromJson(response.data).count;
      }
      return 0;
    } on DioException catch (e) {
      debugPrint('Error getting unread count: ${e.message}');
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to get unread count',
        statusCode: e.response?.statusCode,
      );
    }
  }

  /// Mark a notification as read
  Future<void> markAsRead(int notificationId) async {
    try {
      await _dio.post('/api/notifications/$notificationId/mark-read');
    } on DioException catch (e) {
      debugPrint('Error marking notification as read: ${e.message}');
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to mark notification as read',
        statusCode: e.response?.statusCode,
      );
    }
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    try {
      await _dio.post('/api/notifications/mark-all-read');
    } on DioException catch (e) {
      debugPrint('Error marking all notifications as read: ${e.message}');
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to mark all notifications as read',
        statusCode: e.response?.statusCode,
      );
    }
  }

  /// Log user activity for engagement tracking
  Future<void> logActivity(LogActivityRequest request) async {
    try {
      await _dio.post(
        '/api/notifications/activity',
        data: request.toJson(),
      );
    } on DioException catch (e) {
      debugPrint('Error logging activity: ${e.message}');
      // Don't throw for activity logging - it's not critical
    }
  }

  /// Delete a notification
  Future<void> deleteNotification(int notificationId) async {
    try {
      await _dio.delete('/api/notifications/$notificationId');
    } on DioException catch (e) {
      debugPrint('Error deleting notification: ${e.message}');
      throw ServerException(
        message: e.response?.data?['message'] ?? 'Failed to delete notification',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
