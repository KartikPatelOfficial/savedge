import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../domain/repositories/gift_card_repository.dart';
import '../models/gift_card_models.dart';
import '../services/gift_card_service.dart';

@LazySingleton(as: GiftCardRepository)
class GiftCardRepositoryImpl implements GiftCardRepository {
  final GiftCardService _service;

  GiftCardRepositoryImpl(this._service);

  @override
  Future<Either<Failure, List<GiftCardCategoryEntity>>> getCategories() async {
    try {
      final response = await _service.getCategories();
      final entities = response.map(_mapCategoryToEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GiftCardProductEntity>>> getProducts({
    int? categoryId,
    String? searchTerm,
    int pageNumber = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _service.getProducts(
        categoryId: categoryId,
        searchTerm: searchTerm,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      final entities = response.items.map(_mapProductToEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GiftCardProductEntity>> getProduct(int id) async {
    try {
      final response = await _service.getProduct(id);
      return Right(_mapProductToEntity(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GiftCardPriceBreakdown>> getPriceBreakdown({
    required int productId,
    required double amount,
  }) async {
    try {
      final response = await _service.getPriceBreakdown(
        productId: productId,
        amount: amount,
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GiftCardOrderEntity>> createOrder({
    required int giftCardProductId,
    required double amount,
    required GiftCardPaymentMethodEntity paymentMethod,
  }) async {
    try {
      final request = CreateGiftCardOrderRequest(
        giftCardProductId: giftCardProductId,
        amount: amount,
        paymentMethod: _mapPaymentMethodToModel(paymentMethod),
      );
      final response = await _service.createOrder(request);
      return Right(_mapOrderToEntity(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateGiftCardPaymentOrderResponse>>
      createPaymentOrder({
    required int giftCardProductId,
    required double amount,
  }) async {
    try {
      final request = CreateGiftCardPaymentOrderRequest(
        giftCardProductId: giftCardProductId,
        amount: amount,
      );
      final response = await _service.createPaymentOrder(request);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GiftCardOrderEntity>> verifyPayment({
    required int orderId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  }) async {
    try {
      final request = VerifyGiftCardPaymentRequest(
        orderId: orderId,
        razorpayOrderId: razorpayOrderId,
        razorpayPaymentId: razorpayPaymentId,
        razorpaySignature: razorpaySignature,
      );
      final response = await _service.verifyPayment(request);
      return Right(_mapOrderToEntity(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GiftCardOrderEntity>>> getOrders({
    GiftCardOrderStatusEntity? status,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _service.getOrders(
        status: status != null ? _mapStatusToInt(status) : null,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      final entities = response.items.map(_mapOrderToEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GiftCardOrderEntity>> getOrder(int id) async {
    try {
      final response = await _service.getOrder(id);
      return Right(_mapOrderToEntity(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // Mappers

  GiftCardCategoryEntity _mapCategoryToEntity(GiftCardCategory model) {
    return GiftCardCategoryEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      imageUrl: model.imageUrl,
      isActive: model.isActive,
      productCount: model.productCount,
      parentCategoryId: model.parentCategoryId,
      subCategories:
          model.subCategories.map(_mapCategoryToEntity).toList(),
    );
  }

  GiftCardProductEntity _mapProductToEntity(GiftCardProduct model) {
    return GiftCardProductEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      sku: model.sku,
      imageUrl: model.imageUrl,
      thumbnailUrl: model.thumbnailUrl,
      minPrice: model.minPrice,
      maxPrice: model.maxPrice,
      isActive: model.isActive,
      categoryName: model.categoryName,
      brandName: model.brandName,
      denominations: model.denominations,
      currencySymbol: model.currencySymbol,
      offerDescription: model.offerDescription,
      formatExpiry: model.formatExpiry,
      discountPercentage: model.discountPercentage,
    );
  }

  GiftCardOrderEntity _mapOrderToEntity(GiftCardOrder model) {
    return GiftCardOrderEntity(
      id: model.id,
      userId: model.userId,
      giftCardProductId: model.giftCardProductId,
      productName: model.productName,
      productImageUrl: model.productImageUrl,
      requestedAmount: model.requestedAmount,
      discountPercentage: model.discountPercentage,
      discountAmount: model.discountAmount,
      payableAmount: model.payableAmount,
      paymentMethod: _mapPaymentMethodToEntity(model.paymentMethod),
      paymentStatus: _mapPaymentStatusToEntity(model.paymentStatus),
      totalPointsUsed: model.totalPointsUsed,
      razorpayOrderId: model.razorpayOrderId,
      razorpayPaymentId: model.razorpayPaymentId,
      status: _mapOrderStatusToEntity(model.status),
      woohooCardNumber: model.woohooCardNumber,
      woohooCardPin: model.woohooCardPin,
      woohooActivationCode: model.woohooActivationCode,
      woohooActivationUrl: model.woohooActivationUrl,
      woohooActivatedAmount: model.woohooActivatedAmount,
      woohooCardExpiry: model.woohooCardExpiry,
      failureReason: model.failureReason,
      created: model.created,
    );
  }

  GiftCardOrderStatusEntity _mapOrderStatusToEntity(
      GiftCardOrderStatus status) {
    switch (status) {
      case GiftCardOrderStatus.pending:
        return GiftCardOrderStatusEntity.pending;
      case GiftCardOrderStatus.paymentCompleted:
        return GiftCardOrderStatusEntity.paymentCompleted;
      case GiftCardOrderStatus.issuing:
        return GiftCardOrderStatusEntity.issuing;
      case GiftCardOrderStatus.completed:
        return GiftCardOrderStatusEntity.completed;
      case GiftCardOrderStatus.failed:
        return GiftCardOrderStatusEntity.failed;
      case GiftCardOrderStatus.cancelled:
        return GiftCardOrderStatusEntity.cancelled;
      case GiftCardOrderStatus.refunded:
        return GiftCardOrderStatusEntity.refunded;
    }
  }

  GiftCardPaymentMethodEntity _mapPaymentMethodToEntity(
      GiftCardPaymentMethod method) {
    switch (method) {
      case GiftCardPaymentMethod.none:
        return GiftCardPaymentMethodEntity.none;
      case GiftCardPaymentMethod.points:
        return GiftCardPaymentMethodEntity.points;
      case GiftCardPaymentMethod.razorpay:
        return GiftCardPaymentMethodEntity.razorpay;
    }
  }

  GiftCardPaymentStatusEntity _mapPaymentStatusToEntity(
      GiftCardPaymentStatus status) {
    switch (status) {
      case GiftCardPaymentStatus.pending:
        return GiftCardPaymentStatusEntity.pending;
      case GiftCardPaymentStatus.completed:
        return GiftCardPaymentStatusEntity.completed;
      case GiftCardPaymentStatus.failed:
        return GiftCardPaymentStatusEntity.failed;
      case GiftCardPaymentStatus.refunded:
        return GiftCardPaymentStatusEntity.refunded;
    }
  }

  GiftCardPaymentMethod _mapPaymentMethodToModel(
      GiftCardPaymentMethodEntity method) {
    switch (method) {
      case GiftCardPaymentMethodEntity.none:
        return GiftCardPaymentMethod.none;
      case GiftCardPaymentMethodEntity.points:
        return GiftCardPaymentMethod.points;
      case GiftCardPaymentMethodEntity.razorpay:
        return GiftCardPaymentMethod.razorpay;
    }
  }

  int _mapStatusToInt(GiftCardOrderStatusEntity status) {
    switch (status) {
      case GiftCardOrderStatusEntity.pending:
        return 1;
      case GiftCardOrderStatusEntity.paymentCompleted:
        return 2;
      case GiftCardOrderStatusEntity.issuing:
        return 3;
      case GiftCardOrderStatusEntity.completed:
        return 4;
      case GiftCardOrderStatusEntity.failed:
        return 5;
      case GiftCardOrderStatusEntity.cancelled:
        return 6;
      case GiftCardOrderStatusEntity.refunded:
        return 7;
    }
  }
}
