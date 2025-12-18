import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/city/data/datasources/city_remote_data_source.dart';
import 'package:savedge/features/city/domain/entities/city.dart';
import 'package:savedge/features/city/domain/repositories/city_repository.dart';

@Injectable(as: CityRepository)
class CityRepositoryImpl implements CityRepository {
  const CityRepositoryImpl({required this.remoteDataSource});

  final CityRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<City>>> getCities() async {
    try {
      final response = await remoteDataSource.getCities();
      final cities = response.data.map((model) => model.toEntity()).toList();
      return Right(cities);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 404) {
          return const NotFoundFailure('Cities not found');
        } else if (statusCode == 401) {
          return const AuthFailure('Unauthorized access');
        } else {
          return ServerFailure(
            'Server error: ${error.response?.statusMessage}',
          );
        }
      case DioExceptionType.cancel:
        return const NetworkFailure('Request cancelled');
      case DioExceptionType.unknown:
      default:
        return const NetworkFailure('Network error occurred');
    }
  }
}
