import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/gift_card_models.dart';

part 'gift_card_service.g.dart';

@RestApi()
@injectable
abstract class GiftCardService {
  @factoryMethod
  factory GiftCardService(Dio dio) = _GiftCardService;

  @GET('/api/gift-cards/categories')
  Future<List<GiftCardCategory>> getCategories();

  @GET('/api/gift-cards/products')
  Future<PaginatedGiftCardProductResponse> getProducts({
    @Query('categoryId') int? categoryId,
    @Query('searchTerm') String? searchTerm,
    @Query('pageNumber') int pageNumber = 1,
    @Query('pageSize') int pageSize = 20,
  });

  @GET('/api/gift-cards/products/{id}')
  Future<GiftCardProduct> getProduct(@Path('id') int id);

  @GET('/api/gift-cards/products/{id}/related')
  Future<List<GiftCardRelatedProduct>> getRelatedProducts(@Path('id') int id);

  @GET('/api/gift-card-orders/price-breakdown')
  Future<GiftCardPriceBreakdown> getPriceBreakdown({
    @Query('productId') required int productId,
    @Query('amount') required double amount,
    @Query('pointsToUse') int pointsToUse = 0,
  });

  @POST('/api/gift-card-orders')
  Future<GiftCardOrder> createOrder(
    @Body() CreateGiftCardOrderRequest request,
  );

  @POST('/api/gift-card-orders/create-payment-order')
  Future<CreateGiftCardPaymentOrderResponse> createPaymentOrder(
    @Body() CreateGiftCardPaymentOrderRequest request,
  );

  @POST('/api/gift-card-orders/verify-payment')
  Future<VerifyGiftCardPaymentResponse> verifyPayment(
    @Body() VerifyGiftCardPaymentRequest request,
  );

  @GET('/api/gift-card-orders')
  Future<PaginatedGiftCardOrderResponse> getOrders({
    @Query('status') int? status,
    @Query('pageNumber') int pageNumber = 1,
    @Query('pageSize') int pageSize = 10,
  });

  @GET('/api/gift-card-orders/{id}')
  Future<GiftCardOrder> getOrder(@Path('id') int id);
}
