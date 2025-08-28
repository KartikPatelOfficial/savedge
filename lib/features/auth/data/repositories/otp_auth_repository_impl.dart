import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/core/error/exceptions.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/auth/data/datasources/otp_auth_remote_data_source.dart';
import 'package:savedge/features/auth/data/models/otp_auth_models.dart';
import 'package:savedge/features/auth/domain/repositories/otp_auth_repository.dart';

@LazySingleton(as: OtpAuthRepository)
class OtpAuthRepositoryImpl implements OtpAuthRepository {
  final OtpAuthRemoteDataSource remoteDataSource;

  OtpAuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> sendOtp(String phoneNumber) async {
    try {
      final request = SendOtpRequest(phoneNumber: phoneNumber);
      final response = await remoteDataSource.sendOtp(request);

      if (response.succeeded) {
        return const Right(null);
      } else {
        return Left(ServerFailure(response.errors.join(', ')));
      }
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, UserVerificationResult>> verifyOtp(
    String phoneNumber,
    String otp,
  ) async {
    try {
      final request = VerifyOtpRequest(phoneNumber: phoneNumber, otp: otp);
      final response = await remoteDataSource.verifyOtp(request);

      if (response.succeeded && response.value != null) {
        return Right(response.value!);
      } else {
        return Left(ServerFailure(response.errors.join(', ')));
      }
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, IndividualRegistrationResult>> registerIndividual(
    String phoneNumber,
    String email,
    String firstName,
    String lastName,
    DateTime? dateOfBirth,
  ) async {
    try {
      final request = RegisterIndividualRequest(
        phoneNumber: phoneNumber,
        email: email,
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
      );
      final response = await remoteDataSource.registerIndividual(request);

      if (response.succeeded && response.value != null) {
        return Right(response.value!);
      } else {
        return Left(ServerFailure(response.errors.join(', ')));
      }
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred'));
    }
  }

  Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 400) {
          final errorMessage =
              e.response?.data?['errors']?.join(', ') ?? 'Bad request';
          return ServerFailure(errorMessage);
        } else if (statusCode == 429) {
          return const ServerFailure(
            'Too many requests. Please try again later.',
          );
        } else {
          return ServerFailure('Server error: $statusCode');
        }
      default:
        return const ServerFailure('An unexpected error occurred');
    }
  }
}
