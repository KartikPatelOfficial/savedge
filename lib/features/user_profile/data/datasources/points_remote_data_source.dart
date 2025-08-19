import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/points_models.dart';

part 'points_remote_data_source.g.dart';

/// Remote data source for points management
@RestApi()
abstract class PointsRemoteDataSource {
  factory PointsRemoteDataSource(Dio dio, {String baseUrl}) =
      _PointsRemoteDataSource;

  /// Get user's current points balance and expiry
  @GET('/api/user/points')
  Future<UserPointsResponseModel> getUserPoints();

  /// Get user's point transaction ledger
  @GET('/api/user/ledger')
  Future<List<PointTransactionModel>> getPointsLedger();

  /// Get employee points details (for organization users)
  @GET('/api/EmployeePoints/{employeeId}')
  Future<EmployeePointsResponseModel> getEmployeePoints(
    @Path('employeeId') int employeeId,
  );

  /// Allocate points to an employee (for organization admins)
  @POST('/api/EmployeePoints/allocate')
  Future<void> allocatePoints(
    @Body() AllocatePointsRequestModel request,
  );

  /// Get points expiring in specified number of days
  @GET('/api/EmployeePoints/expiring/{days}')
  Future<PointsExpirationInfoModel> getPointsExpiringInDays(
    @Path('days') int days,
  );

  /// Get count of expired points
  @GET('/api/EmployeePoints/expired/count')
  Future<ExpiredPointsCountModel> getExpiredPointsCount();

  /// Manually trigger points expiration process (admin only)
  @POST('/api/EmployeePoints/expire')
  Future<void> expirePoints();
}
