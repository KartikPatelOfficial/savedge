import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:savedge/features/vendors/data/models/vendor_models.dart';

part 'vendors_remote_data_source.g.dart';

@RestApi()
abstract class VendorsRemoteDataSource {
  factory VendorsRemoteDataSource(Dio dio, {String baseUrl}) =
      _VendorsRemoteDataSource;

  @GET('/api/Vendors')
  Future<HttpResponse<dynamic>> getVendors({
    @Query('pageNumber') int pageNumber = 1,
    @Query('pageSize') int pageSize = 10,
    @Query('searchTerm') String? searchTerm,
    @Query('category') String? category,
    @Query('businessType') String? businessType,
    @Query('isApproved') bool? isApproved = true,
    @Query('isActive') bool? isActive = true,
  });

  @GET('/api/Vendors/{id}')
  Future<HttpResponse<VendorResponse>> getVendor(@Path('id') int id);

  @GET('/api/vendors/{vendorId}/Images')
  Future<HttpResponse<List<VendorImageDto>>> getVendorImages(
    @Path('vendorId') int vendorId,
  );

  @GET('/api/Vendors/top-offers')
  Future<HttpResponse<dynamic>> getTopOfferVendors();
}
