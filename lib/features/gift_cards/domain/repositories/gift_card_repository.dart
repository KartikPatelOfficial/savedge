import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/gift_card_models.dart'
    show
        CreateGiftCardPaymentOrderResponse,
        GiftCardPriceBreakdown,
        VerifyGiftCardPaymentResponse;
import '../entities/gift_card_entity.dart';

abstract class GiftCardRepository {
  Future<Either<Failure, List<GiftCardCategoryEntity>>> getCategories();

  Future<Either<Failure, List<GiftCardProductEntity>>> getHotDeals();

  Future<Either<Failure, List<GiftCardProductEntity>>> getProducts({
    int? categoryId,
    String? searchTerm,
    int pageNumber = 1,
    int pageSize = 20,
  });

  Future<Either<Failure, GiftCardProductEntity>> getProduct(int id);

  Future<Either<Failure, GiftCardPriceBreakdown>> getPriceBreakdown({
    required int productId,
    required double amount,
    int pointsToUse = 0,
  });

  Future<Either<Failure, GiftCardOrderEntity>> createOrder({
    required int giftCardProductId,
    required double amount,
    required GiftCardPaymentMethodEntity paymentMethod,
    String? themeSku,
  });

  Future<Either<Failure, CreateGiftCardPaymentOrderResponse>>
      createPaymentOrder({
    required int giftCardProductId,
    required double amount,
    int pointsToUse = 0,
    String? themeSku,
  });

  Future<Either<Failure, VerifyGiftCardPaymentResponse>> verifyPayment({
    required int orderId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  });

  Future<Either<Failure, List<GiftCardOrderEntity>>> getOrders({
    GiftCardOrderStatusEntity? status,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<Failure, GiftCardOrderEntity>> getOrder(int id);

  Future<Either<Failure, List<GiftCardRelatedProductEntity>>> getRelatedProducts(int productId);
}
