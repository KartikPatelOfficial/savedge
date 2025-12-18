import 'package:dartz/dartz.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/city/domain/entities/city.dart';

/// Repository interface for city operations
abstract class CityRepository {
  /// Get list of active cities from API
  Future<Either<Failure, List<City>>> getCities();
}
