import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/notifications/domain/entities/notification_entity.dart';
import 'package:savedge/features/notifications/domain/repositories/notification_repository.dart';

/// Use case to get notification history
class GetNotificationsUseCase
    implements UseCase<List<NotificationEntity>, GetNotificationsParams> {
  final NotificationRepository repository;

  GetNotificationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(
    GetNotificationsParams params,
  ) {
    return repository.getNotifications(
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
    );
  }
}

/// Parameters for getting notifications
class GetNotificationsParams extends Equatable {
  final int pageNumber;
  final int pageSize;

  const GetNotificationsParams({
    this.pageNumber = 1,
    this.pageSize = 20,
  });

  @override
  List<Object?> get props => [pageNumber, pageSize];
}
