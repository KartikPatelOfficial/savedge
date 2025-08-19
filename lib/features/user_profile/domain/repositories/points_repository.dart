import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../shared/domain/entities/points.dart';

/// Repository interface for points management
abstract class PointsRepository {
  /// Get user's current points balance and expiry information
  Future<Either<Failure, Points>> getUserPoints();

  /// Get user's point transaction history/ledger
  Future<Either<Failure, List<PointTransaction>>> getPointsLedger();

  /// Get employee points details (for organization context)
  Future<Either<Failure, Map<String, dynamic>>> getEmployeePoints(
    int employeeId,
  );

  /// Allocate points to an employee (organization admin only)
  Future<Either<Failure, bool>> allocatePoints({
    required int employeeId,
    required int points,
    String? description,
    DateTime? customExpiryDate,
  });

  /// Get points expiring in specified number of days
  Future<Either<Failure, Map<String, dynamic>>> getPointsExpiringInDays(
    int days,
  );

  /// Get count of expired points
  Future<Either<Failure, int>> getExpiredPointsCount();

  /// Trigger points expiration process (admin only)
  Future<Either<Failure, bool>> expirePoints();
}
