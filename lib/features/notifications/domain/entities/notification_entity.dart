import 'package:equatable/equatable.dart';

/// Notification type enum
enum NotificationType {
  welcome,
  reEngagement,
  newDeal,
  expiringCoupon,
  abandonedCoupon,
  birthday,
  anniversary,
  milestoneReward,
  weeklyDigest,
  pointsExpiring,
  custom,
}

/// Extension to convert notification type to/from string and int
extension NotificationTypeX on NotificationType {
  /// Get the integer value matching the backend enum
  int get intValue {
    switch (this) {
      case NotificationType.welcome:
        return 0;
      case NotificationType.reEngagement:
        return 1;
      case NotificationType.newDeal:
        return 2;
      case NotificationType.expiringCoupon:
        return 3;
      case NotificationType.abandonedCoupon:
        return 4;
      case NotificationType.birthday:
        return 5;
      case NotificationType.anniversary:
        return 6;
      case NotificationType.milestoneReward:
        return 7;
      case NotificationType.weeklyDigest:
        return 8;
      case NotificationType.pointsExpiring:
        return 9;
      case NotificationType.custom:
        return 10;
    }
  }

  String get value {
    switch (this) {
      case NotificationType.welcome:
        return 'Welcome';
      case NotificationType.reEngagement:
        return 'ReEngagement';
      case NotificationType.newDeal:
        return 'NewDeal';
      case NotificationType.expiringCoupon:
        return 'ExpiringCoupon';
      case NotificationType.abandonedCoupon:
        return 'AbandonedCoupon';
      case NotificationType.birthday:
        return 'Birthday';
      case NotificationType.anniversary:
        return 'Anniversary';
      case NotificationType.milestoneReward:
        return 'MilestoneReward';
      case NotificationType.weeklyDigest:
        return 'WeeklyDigest';
      case NotificationType.pointsExpiring:
        return 'PointsExpiring';
      case NotificationType.custom:
        return 'Custom';
    }
  }

  /// Convert from integer value (backend enum)
  static NotificationType fromInt(int value) {
    switch (value) {
      case 0:
        return NotificationType.welcome;
      case 1:
        return NotificationType.reEngagement;
      case 2:
        return NotificationType.newDeal;
      case 3:
        return NotificationType.expiringCoupon;
      case 4:
        return NotificationType.abandonedCoupon;
      case 5:
        return NotificationType.birthday;
      case 6:
        return NotificationType.anniversary;
      case 7:
        return NotificationType.milestoneReward;
      case 8:
        return NotificationType.weeklyDigest;
      case 9:
        return NotificationType.pointsExpiring;
      case 10:
      default:
        return NotificationType.custom;
    }
  }

  static NotificationType fromString(String value) {
    switch (value) {
      case 'Welcome':
        return NotificationType.welcome;
      case 'ReEngagement':
        return NotificationType.reEngagement;
      case 'NewDeal':
        return NotificationType.newDeal;
      case 'ExpiringCoupon':
        return NotificationType.expiringCoupon;
      case 'AbandonedCoupon':
        return NotificationType.abandonedCoupon;
      case 'Birthday':
        return NotificationType.birthday;
      case 'Anniversary':
        return NotificationType.anniversary;
      case 'MilestoneReward':
        return NotificationType.milestoneReward;
      case 'WeeklyDigest':
        return NotificationType.weeklyDigest;
      case 'PointsExpiring':
        return NotificationType.pointsExpiring;
      case 'Custom':
      default:
        return NotificationType.custom;
    }
  }
}

/// Notification entity representing a push notification
class NotificationEntity extends Equatable {
  final int id;
  final String title;
  final String body;
  final NotificationType type;
  final String? imageUrl;
  final String? data;
  final DateTime sentAt;
  final DateTime? readAt;
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    this.imageUrl,
    this.data,
    required this.sentAt,
    this.readAt,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        type,
        imageUrl,
        data,
        sentAt,
        readAt,
        isRead,
      ];
}
