import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:savedge/features/notifications/domain/entities/notification_entity.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

/// Model for notification data from API
@freezed
abstract class NotificationModel with _$NotificationModel {
  const NotificationModel._();

  const factory NotificationModel({
    required int id,
    required String title,
    required String body,
    required int type, // NotificationType enum value from backend
    String? imageUrl,
    String? data,
    required DateTime sentAt,
    DateTime? readAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  /// Convert to domain entity
  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      type: NotificationTypeX.fromInt(type),
      imageUrl: imageUrl,
      data: data,
      sentAt: sentAt,
      readAt: readAt,
      isRead: readAt != null,
    );
  }
}

/// Request model for registering device token
@freezed
abstract class RegisterDeviceTokenRequest with _$RegisterDeviceTokenRequest {
  const factory RegisterDeviceTokenRequest({
    required String token,
    required int platform, // iOS = 0, Android = 1, Web = 2
    String? deviceId,
    String? deviceName,
    String? appVersion,
  }) = _RegisterDeviceTokenRequest;

  factory RegisterDeviceTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterDeviceTokenRequestFromJson(json);
}

/// Request model for logging user activity
/// ActivityType values: AppOpen=0, CouponViewed=1, CouponClaimed=2, CouponRedeemed=3,
/// ProfileUpdated=4, SubscriptionPurchased=5, SearchPerformed=6, VendorViewed=7
@freezed
abstract class LogActivityRequest with _$LogActivityRequest {
  const factory LogActivityRequest({
    required int activityType,
    String? entityType,
    int? entityId,
    String? details,
  }) = _LogActivityRequest;

  factory LogActivityRequest.fromJson(Map<String, dynamic> json) =>
      _$LogActivityRequestFromJson(json);
}

/// Response model for notification list
@freezed
abstract class NotificationListResponse with _$NotificationListResponse {
  const factory NotificationListResponse({
    required List<NotificationModel> items,
    required int pageNumber,
    required int totalPages,
    required int totalCount,
    required bool hasPreviousPage,
    required bool hasNextPage,
  }) = _NotificationListResponse;

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationListResponseFromJson(json);
}

/// Response model for unread count
@freezed
abstract class UnreadCountResponse with _$UnreadCountResponse {
  const factory UnreadCountResponse({required int count}) =
      _UnreadCountResponse;

  factory UnreadCountResponse.fromJson(Map<String, dynamic> json) =>
      _$UnreadCountResponseFromJson(json);
}
