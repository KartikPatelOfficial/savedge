import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/notifications/domain/repositories/notification_repository.dart';

/// Use case to mark a notification as read
class MarkNotificationReadUseCase implements UseCase<void, MarkNotificationReadParams> {
  final NotificationRepository repository;

  MarkNotificationReadUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(MarkNotificationReadParams params) {
    return repository.markAsRead(params.notificationId);
  }
}

/// Parameters for marking a notification as read
class MarkNotificationReadParams extends Equatable {
  final int notificationId;

  const MarkNotificationReadParams({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];
}
