import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savedge/core/services/push_notification_service.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/notifications/domain/entities/notification_entity.dart';
import 'package:savedge/features/notifications/domain/repositories/notification_repository.dart';
import 'package:savedge/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:savedge/features/notifications/domain/usecases/get_unread_count_usecase.dart';
import 'package:savedge/features/notifications/domain/usecases/mark_notification_read_usecase.dart';
import 'package:savedge/features/notifications/domain/usecases/register_device_token_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

/// BLoC for managing notification state
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final RegisterDeviceTokenUseCase registerDeviceTokenUseCase;
  final GetNotificationsUseCase getNotificationsUseCase;
  final GetUnreadCountUseCase getUnreadCountUseCase;
  final MarkNotificationReadUseCase markNotificationReadUseCase;
  final NotificationRepository repository;

  NotificationBloc({
    required this.registerDeviceTokenUseCase,
    required this.getNotificationsUseCase,
    required this.getUnreadCountUseCase,
    required this.markNotificationReadUseCase,
    required this.repository,
  }) : super(const NotificationState()) {
    on<RegisterDeviceToken>(_onRegisterDeviceToken);
    on<RemoveDeviceToken>(_onRemoveDeviceToken);
    on<LoadNotifications>(_onLoadNotifications);
    on<LoadMoreNotifications>(_onLoadMoreNotifications);
    on<RefreshNotifications>(_onRefreshNotifications);
    on<LoadUnreadCount>(_onLoadUnreadCount);
    on<MarkAsRead>(_onMarkAsRead);
    on<MarkAllAsRead>(_onMarkAllAsRead);
    on<LogUserActivity>(_onLogUserActivity);
    on<DeleteNotification>(_onDeleteNotification);
  }

  Future<void> _onRegisterDeviceToken(
    RegisterDeviceToken event,
    Emitter<NotificationState> emit,
  ) async {
    final pushService = PushNotificationService.instance;
    final token = pushService.fcmToken;

    if (token == null) {
      emit(state.copyWith(
        tokenRegistrationStatus: TokenRegistrationStatus.failure,
        error: 'FCM token not available',
      ));
      return;
    }

    emit(state.copyWith(tokenRegistrationStatus: TokenRegistrationStatus.loading));

    final result = await registerDeviceTokenUseCase(
      RegisterDeviceTokenParams(
        token: token,
        platform: pushService.platform,
        deviceId: event.deviceId,
        deviceName: event.deviceName,
        appVersion: event.appVersion,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        tokenRegistrationStatus: TokenRegistrationStatus.failure,
        error: failure.message,
      )),
      (_) => emit(state.copyWith(
        tokenRegistrationStatus: TokenRegistrationStatus.success,
      )),
    );
  }

  Future<void> _onRemoveDeviceToken(
    RemoveDeviceToken event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await repository.removeDeviceToken();

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (_) => emit(state.copyWith(
        tokenRegistrationStatus: TokenRegistrationStatus.initial,
      )),
    );
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(state.copyWith(status: NotificationStatus.loading));

    final result = await getNotificationsUseCase(
      const GetNotificationsParams(pageNumber: 1),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: NotificationStatus.failure,
        error: failure.message,
      )),
      (notifications) => emit(state.copyWith(
        status: NotificationStatus.success,
        notifications: notifications,
        currentPage: 1,
        hasReachedMax: notifications.length < 20,
      )),
    );
  }

  Future<void> _onLoadMoreNotifications(
    LoadMoreNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    if (state.hasReachedMax || state.status == NotificationStatus.loadingMore) {
      return;
    }

    emit(state.copyWith(status: NotificationStatus.loadingMore));

    final nextPage = state.currentPage + 1;
    final result = await getNotificationsUseCase(
      GetNotificationsParams(pageNumber: nextPage),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: NotificationStatus.success,
        error: failure.message,
      )),
      (notifications) => emit(state.copyWith(
        status: NotificationStatus.success,
        notifications: [...state.notifications, ...notifications],
        currentPage: nextPage,
        hasReachedMax: notifications.length < 20,
      )),
    );
  }

  Future<void> _onRefreshNotifications(
    RefreshNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await getNotificationsUseCase(
      const GetNotificationsParams(pageNumber: 1),
    );

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (notifications) => emit(state.copyWith(
        status: NotificationStatus.success,
        notifications: notifications,
        currentPage: 1,
        hasReachedMax: notifications.length < 20,
      )),
    );
  }

  Future<void> _onLoadUnreadCount(
    LoadUnreadCount event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await getUnreadCountUseCase(NoParams());

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (count) => emit(state.copyWith(unreadCount: count)),
    );
  }

  Future<void> _onMarkAsRead(
    MarkAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await markNotificationReadUseCase(
      MarkNotificationReadParams(notificationId: event.notificationId),
    );

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (_) {
        // Update local state
        final updatedNotifications = state.notifications.map((n) {
          if (n.id == event.notificationId) {
            return NotificationEntity(
              id: n.id,
              title: n.title,
              body: n.body,
              type: n.type,
              imageUrl: n.imageUrl,
              data: n.data,
              sentAt: n.sentAt,
              readAt: DateTime.now(),
              isRead: true,
            );
          }
          return n;
        }).toList();

        emit(state.copyWith(
          notifications: updatedNotifications,
          unreadCount: state.unreadCount > 0 ? state.unreadCount - 1 : 0,
        ));
      },
    );
  }

  Future<void> _onMarkAllAsRead(
    MarkAllAsRead event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await repository.markAllAsRead();

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (_) {
        // Update local state
        final updatedNotifications = state.notifications.map((n) {
          return NotificationEntity(
            id: n.id,
            title: n.title,
            body: n.body,
            type: n.type,
            imageUrl: n.imageUrl,
            data: n.data,
            sentAt: n.sentAt,
            readAt: n.readAt ?? DateTime.now(),
            isRead: true,
          );
        }).toList();

        emit(state.copyWith(
          notifications: updatedNotifications,
          unreadCount: 0,
        ));
      },
    );
  }

  Future<void> _onLogUserActivity(
    LogUserActivity event,
    Emitter<NotificationState> emit,
  ) async {
    // Fire and forget - don't wait for response
    repository.logActivity(
      activityType: event.activityType,
      entityType: event.entityType,
      entityId: event.entityId,
      details: event.details,
    );
  }

  Future<void> _onDeleteNotification(
    DeleteNotification event,
    Emitter<NotificationState> emit,
  ) async {
    final result = await repository.deleteNotification(event.notificationId);

    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (_) {
        // Remove from local state
        final updatedNotifications = state.notifications
            .where((n) => n.id != event.notificationId)
            .toList();

        // Update unread count if notification was unread
        final deletedNotification = state.notifications
            .where((n) => n.id == event.notificationId)
            .firstOrNull;
        final newUnreadCount = deletedNotification != null && !deletedNotification.isRead
            ? (state.unreadCount > 0 ? state.unreadCount - 1 : 0)
            : state.unreadCount;

        emit(state.copyWith(
          notifications: updatedNotifications,
          unreadCount: newUnreadCount,
        ));
      },
    );
  }
}
