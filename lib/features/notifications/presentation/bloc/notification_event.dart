part of 'notification_bloc.dart';

/// Base class for notification events
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

/// Event to register device token
class RegisterDeviceToken extends NotificationEvent {
  final String? deviceId;
  final String? deviceName;
  final String? appVersion;

  const RegisterDeviceToken({
    this.deviceId,
    this.deviceName,
    this.appVersion,
  });

  @override
  List<Object?> get props => [deviceId, deviceName, appVersion];
}

/// Event to remove device token (on logout)
class RemoveDeviceToken extends NotificationEvent {
  const RemoveDeviceToken();
}

/// Event to load notifications
class LoadNotifications extends NotificationEvent {
  const LoadNotifications();
}

/// Event to load more notifications (pagination)
class LoadMoreNotifications extends NotificationEvent {
  const LoadMoreNotifications();
}

/// Event to refresh notifications
class RefreshNotifications extends NotificationEvent {
  const RefreshNotifications();
}

/// Event to load unread count
class LoadUnreadCount extends NotificationEvent {
  const LoadUnreadCount();
}

/// Event to mark a notification as read
class MarkAsRead extends NotificationEvent {
  final int notificationId;

  const MarkAsRead(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

/// Event to mark all notifications as read
class MarkAllAsRead extends NotificationEvent {
  const MarkAllAsRead();
}

/// Event to log user activity
/// ActivityType values: AppOpen=0, CouponViewed=1, CouponClaimed=2, CouponRedeemed=3,
/// ProfileUpdated=4, SubscriptionPurchased=5, SearchPerformed=6, VendorViewed=7
class LogUserActivity extends NotificationEvent {
  final int activityType;
  final String? entityType;
  final int? entityId;
  final String? details;

  const LogUserActivity({
    required this.activityType,
    this.entityType,
    this.entityId,
    this.details,
  });

  @override
  List<Object?> get props => [activityType, entityType, entityId, details];
}

/// Event to delete a notification
class DeleteNotification extends NotificationEvent {
  final int notificationId;

  const DeleteNotification(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}
