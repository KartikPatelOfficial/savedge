import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/brand_voucher_models.dart';

part 'brand_voucher_service.g.dart';

@RestApi()
@injectable
abstract class BrandVoucherService {
  @factoryMethod
  factory BrandVoucherService(Dio dio) = _BrandVoucherService;

  @GET('/api/BrandVouchers')
  Future<PaginatedBrandVoucherResponse> getBrandVouchers({
    @Query('PageNumber') int pageNumber = 1,
    @Query('PageSize') int pageSize = 1000,
    @Query('IsActive') bool? isActive,
    @Query('SearchTerm') String? searchTerm,
  });

  @GET('/api/BrandVouchers/{id}')
  Future<BrandVoucher> getBrandVoucher(@Path('id') int id);

  @POST('/api/VoucherOrders')
  Future<int> createVoucherOrder(@Body() CreateVoucherOrderRequest request);

  @GET('/api/VoucherOrders')
  Future<PaginatedVoucherOrderResponse> getVoucherOrders({
    @Query('status') VoucherOrderStatus? status,
    @Query('pageNumber') int pageNumber = 1,
    @Query('pageSize') int pageSize = 10,
  });

  @GET('/api/VoucherOrders/{id}')
  Future<VoucherOrder> getVoucherOrder(@Path('id') int id);

  // Razorpay payment endpoints
  @POST('/api/VoucherOrders/create-razorpay-order')
  Future<CreateVoucherPaymentOrderResponse> createRazorpayOrder(
    @Body() CreateVoucherPaymentOrderRequest request,
  );

  @POST('/api/VoucherOrders/verify-razorpay-payment')
  Future<VerifyVoucherPaymentResponse> verifyRazorpayPayment(
    @Body() VerifyVoucherPaymentRequest request,
  );
}