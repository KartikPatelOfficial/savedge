part of 'notification_bloc.dart';

/// Status for notification operations
enum NotificationStatus {
  initial,
  loading,
  loadingMore,
  success,
  failure,
}

/// Status for token registration
enum TokenRegistrationStatus {
  initial,
  loading,
  success,
  failure,
}

/// State for notifications
class NotificationState extends Equatable {
  final NotificationStatus status;
  final TokenRegistrationStatus tokenRegistrationStatus;
  final List<NotificationEntity> notifications;
  final int unreadCount;
  final int currentPage;
  final bool hasReachedMax;
  final String? error;

  const NotificationState({
    this.status = NotificationStatus.initial,
    this.tokenRegistrationStatus = TokenRegistrationStatus.initial,
    this.notifications = const [],
    this.unreadCount = 0,
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.error,
  });

  NotificationState copyWith({
    NotificationStatus? status,
    TokenRegistrationStatus? tokenRegistrationStatus,
    List<NotificationEntity>? notifications,
    int? unreadCount,
    int? currentPage,
    bool? hasReachedMax,
    String? error,
  }) {
    return NotificationState(
      status: status ?? this.status,
      tokenRegistrationStatus: tokenRegistrationStatus ?? this.tokenRegistrationStatus,
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        tokenRegistrationStatus,
        notifications,
        unreadCount,
        currentPage,
        hasReachedMax,
        error,
      ];
}
