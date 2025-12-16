import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:savedge/core/error/exceptions.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:savedge/features/notifications/data/models/notification_model.dart';
import 'package:savedge/features/notifications/domain/entities/notification_entity.dart';
import 'package:savedge/features/notifications/domain/repositories/notification_repository.dart';

/// Implementation of NotificationRepository
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> registerDeviceToken({
    required String token,
    required int platform, // iOS = 0, Android = 1, Web = 2
    String? deviceId,
    String? deviceName,
    String? appVersion,
  }) async {
    try {
      await remoteDataSource.registerDeviceToken(
        RegisterDeviceTokenRequest(
          token: token,
          platform: platform,
          deviceId: deviceId,
          deviceName: deviceName,
          appVersion: appVersion,
        ),
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      debugPrint('Error registering device token: $e');
      return const Left(ServerFailure('Failed to register device token'));
    }
  }

  @override
  Future<Either<Failure, void>> removeDeviceToken() async {
    try {
      await remoteDataSource.removeDeviceToken();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      debugPrint('Error removing device token: $e');
      return const Left(ServerFailure('Failed to remove device token'));
    }
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await remoteDataSource.getNotifications(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      final notifications = response.items.map((m) => m.toEntity()).toList();
      return Right(notifications);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      debugPrint('Error getting notifications: $e');
      return const Left(ServerFailure('Failed to get notifications'));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    try {
      final count = await remoteDataSource.getUnreadCount();
      return Right(count);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      debugPrint('Error getting unread count: $e');
      return const Left(ServerFailure('Failed to get unread count'));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(int notificationId) async {
    try {
      await remoteDataSource.markAsRead(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
      return const Left(ServerFailure('Failed to mark notification as read'));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    try {
      await remoteDataSource.markAllAsRead();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      debugPrint('Error marking all notifications as read: $e');
      return const Left(ServerFailure('Failed to mark all notifications as read'));
    }
  }

  @override
  Future<Either<Failure, void>> logActivity({
    required int activityType,
    String? entityType,
    int? entityId,
    String? details,
  }) async {
    try {
      await remoteDataSource.logActivity(
        LogActivityRequest(
          activityType: activityType,
          entityType: entityType,
          entityId: entityId,
          details: details,
        ),
      );
      return const Right(null);
    } catch (e) {
      // Don't fail for activity logging - it's not critical
      debugPrint('Error logging activity: $e');
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(int notificationId) async {
    try {
      await remoteDataSource.deleteNotification(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      debugPrint('Error deleting notification: $e');
      return const Left(ServerFailure('Failed to delete notification'));
    }
  }
}
