import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../shared/domain/entities/points.dart';
import '../repositories/points_repository.dart';

/// Use case for getting user's points balance and expiry information
class GetUserPointsUseCase implements UseCase<Points, NoParams> {
  final PointsRepository repository;

  GetUserPointsUseCase(this.repository);

  @override
  Future<Either<Failure, Points>> call(NoParams params) async {
    return await repository.getUserPoints();
  }
}

/// Use case for getting user's points transaction ledger
class GetPointsLedgerUseCase
    implements UseCase<List<PointTransaction>, NoParams> {
  final PointsRepository repository;

  GetPointsLedgerUseCase(this.repository);

  @override
  Future<Either<Failure, List<PointTransaction>>> call(NoParams params) async {
    return await repository.getPointsLedger();
  }
}

/// Use case for allocating points to an employee
class AllocatePointsUseCase implements UseCase<bool, AllocatePointsParams> {
  final PointsRepository repository;

  AllocatePointsUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(AllocatePointsParams params) async {
    return await repository.allocatePoints(
      employeeId: params.employeeId,
      points: params.points,
      description: params.description,
      customExpiryDate: params.customExpiryDate,
    );
  }
}

/// Use case for getting points expiring in specified days
class GetPointsExpiringUseCase
    implements UseCase<Map<String, dynamic>, GetPointsExpiringParams> {
  final PointsRepository repository;

  GetPointsExpiringUseCase(this.repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(
    GetPointsExpiringParams params,
  ) async {
    return await repository.getPointsExpiringInDays(params.days);
  }
}

/// Use case for getting expired points count
class GetExpiredPointsCountUseCase implements UseCase<int, NoParams> {
  final PointsRepository repository;

  GetExpiredPointsCountUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await repository.getExpiredPointsCount();
  }
}

/// Parameters for allocating points
class AllocatePointsParams extends Equatable {
  final int employeeId;
  final int points;
  final String? description;
  final DateTime? customExpiryDate;

  const AllocatePointsParams({
    required this.employeeId,
    required this.points,
    this.description,
    this.customExpiryDate,
  });

  @override
  List<Object?> get props => [
    employeeId,
    points,
    description,
    customExpiryDate,
  ];
}

/// Parameters for getting points expiring in days
class GetPointsExpiringParams extends Equatable {
  final int days;

  const GetPointsExpiringParams({required this.days});

  @override
  List<Object> get props => [days];
}
