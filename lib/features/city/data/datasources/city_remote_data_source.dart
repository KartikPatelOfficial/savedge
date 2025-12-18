import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:savedge/features/city/data/models/city_model.dart';

part 'city_remote_data_source.g.dart';

@RestApi()
abstract class CityRemoteDataSource {
  factory CityRemoteDataSource(Dio dio, {String baseUrl}) =
      _CityRemoteDataSource;

  /// Get list of active cities
  @GET('/api/cities')
  Future<HttpResponse<List<CityModel>>> getCities();
}
