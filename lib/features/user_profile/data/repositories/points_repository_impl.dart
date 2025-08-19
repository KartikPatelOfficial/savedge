import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../shared/domain/entities/points.dart';
import '../../domain/repositories/points_repository.dart';
import '../datasources/points_remote_data_source.dart';
import '../models/points_models.dart';

/// Implementation of PointsRepository
class PointsRepositoryImpl implements PointsRepository {
  final PointsRemoteDataSource remoteDataSource;

  PointsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Points>> getUserPoints() async {
    try {
      final result = await remoteDataSource.getUserPoints();
      return Right(result.toDomain());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to get user points: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<PointTransaction>>> getPointsLedger() async {
    try {
      final result = await remoteDataSource.getPointsLedger();
      final transactions = result.map((model) => model.toDomain()).toList();
      return Right(transactions);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Failed to get points ledger: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getEmployeePoints(
    int employeeId,
  ) async {
    try {
      final result = await remoteDataSource.getEmployeePoints(employeeId);
      return Right({
        'employeeId': result.employeeId,
        'currentBalance': result.currentBalance,
        'totalAllocated': result.totalAllocated,
        'totalSpent': result.totalSpent,
        'nextExpiry': result.nextExpiry,
        'recentTransactions': result.recentTransactions
            .map((t) => t.toDomain())
            .toList(),
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Failed to get employee points: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> allocatePoints({
    required int employeeId,
    required int points,
    String? description,
    DateTime? customExpiryDate,
  }) async {
    try {
      final request = AllocatePointsRequestModel(
        employeeId: employeeId,
        points: points,
        description: description,
        customExpiryDate: customExpiryDate,
      );

      await remoteDataSource.allocatePoints(request);
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to allocate points: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getPointsExpiringInDays(
    int days,
  ) async {
    try {
      final result = await remoteDataSource.getPointsExpiringInDays(days);
      return Right({
        'days': result.days,
        'expiringPoints': result.expiringPoints,
      });
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Failed to get expiring points: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, int>> getExpiredPointsCount() async {
    try {
      final result = await remoteDataSource.getExpiredPointsCount();
      return Right(result.expiredPointsCount);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Failed to get expired points count: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> expirePoints() async {
    try {
      await remoteDataSource.expirePoints();
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to expire points: ${e.toString()}'));
    }
  }
}
