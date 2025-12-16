import 'package:dartz/dartz.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/notifications/domain/entities/notification_entity.dart';

/// Repository interface for notification operations
abstract class NotificationRepository {
  /// Register device token with the backend
  Future<Either<Failure, void>> registerDeviceToken({
    required String token,
    required int platform, // iOS = 0, Android = 1, Web = 2
    String? deviceId,
    String? deviceName,
    String? appVersion,
  });

  /// Remove device token from the backend (on logout)
  Future<Either<Failure, void>> removeDeviceToken();

  /// Get notification history with pagination
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    int pageNumber = 1,
    int pageSize = 20,
  });

  /// Get unread notification count
  Future<Either<Failure, int>> getUnreadCount();

  /// Mark a notification as read
  Future<Either<Failure, void>> markAsRead(int notificationId);

  /// Mark all notifications as read
  Future<Either<Failure, void>> markAllAsRead();

  /// Log user activity for engagement tracking
  /// ActivityType values: AppOpen=0, CouponViewed=1, CouponClaimed=2, CouponRedeemed=3,
  /// ProfileUpdated=4, SubscriptionPurchased=5, SearchPerformed=6, VendorViewed=7
  Future<Either<Failure, void>> logActivity({
    required int activityType,
    String? entityType,
    int? entityId,
    String? details,
  });

  /// Delete a notification
  Future<Either<Failure, void>> deleteNotification(int notificationId);
}
