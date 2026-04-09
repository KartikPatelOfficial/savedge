import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/gift_cards/data/models/gift_card_models.dart';
import 'package:savedge/features/gift_cards/data/services/gift_card_service.dart';
import 'package:savedge/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:savedge/features/gift_cards/domain/repositories/gift_card_repository.dart';

@LazySingleton(as: GiftCardRepository)
class GiftCardRepositoryImpl implements GiftCardRepository {
  final GiftCardService _service;

  GiftCardRepositoryImpl(this._service);

  /// Extracts a user-friendly error message from exceptions
  String _extractErrorMessage(Object e) {
    if (e is DioException) {
      // Try to extract server error message from response body
      final data = e.response?.data;
      if (data is Map<String, dynamic>) {
        // Backend returns { "message": "..." } via ErrorResponse
        if (data.containsKey('message') && data['message'] != null) {
          return data['message'].toString();
        }
        // Or it might return { "errors": [...] }
        if (data.containsKey('errors') && data['errors'] is List) {
          final errors = data['errors'] as List;
          if (errors.isNotEmpty) return errors.join('; ');
        }
      }
      // Handle specific DioException types
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Request timed out. Please try again.';
        case DioExceptionType.connectionError:
          return 'Unable to connect to server. Check your internet connection.';
        case DioExceptionType.badResponse:
          final statusCode = e.response?.statusCode;
          if (statusCode == 401) return 'Session expired. Please login again.';
          if (statusCode == 404) return 'The requested resource was not found.';
          if (statusCode == 500) return 'Server error. Please try again later.';
          return 'Something went wrong. Please try again.';
        default:
          return 'Something went wrong. Please try again.';
      }
    }
    return 'Something went wrong. Please try again.';
  }

  @override
  Future<Either<Failure, List<GiftCardCategoryEntity>>> getCategories() async {
    try {
      final response = await _service.getCategories();
      final entities = response.map(_mapCategoryToEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(_extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, List<GiftCardProductEntity>>> getHotDeals() async {
    try {
      final response = await _service.getHotDeals();
      final entities = response.map(_mapProductToEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(_extractErrorMessage(e)));
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
      return Left(ServerFailure(_extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, GiftCardProductEntity>> getProduct(int id) async {
    try {
      final response = await _service.getProduct(id);
      return Right(_mapProductToEntity(response));
    } catch (e) {
      return Left(ServerFailure(_extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, GiftCardPriceBreakdown>> getPriceBreakdown({
    required int productId,
    required double amount,
    int pointsToUse = 0,
  }) async {
    try {
      final response = await _service.getPriceBreakdown(
        productId: productId,
        amount: amount,
        pointsToUse: pointsToUse,
      );
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(_extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, GiftCardOrderEntity>> createOrder({
    required int giftCardProductId,
    required double amount,
    required GiftCardPaymentMethodEntity paymentMethod,
    String? themeSku,
  }) async {
    try {
      final request = CreateGiftCardOrderRequest(
        giftCardProductId: giftCardProductId,
        amount: amount,
        paymentMethod: _mapPaymentMethodToModel(paymentMethod),
        themeSku: themeSku,
      );
      final response = await _service.createOrder(request);
      return Right(_mapOrderToEntity(response));
    } catch (e) {
      return Left(ServerFailure(_extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, CreateGiftCardPaymentOrderResponse>>
  createPaymentOrder({
    required int giftCardProductId,
    required double amount,
    int pointsToUse = 0,
    String? themeSku,
  }) async {
    try {
      final request = CreateGiftCardPaymentOrderRequest(
        giftCardProductId: giftCardProductId,
        amount: amount,
        pointsToUse: pointsToUse,
        themeSku: themeSku,
      );
      final response = await _service.createPaymentOrder(request);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(_extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, VerifyGiftCardPaymentResponse>> verifyPayment({
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
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(_extractErrorMessage(e)));
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
      return Left(ServerFailure(_extractErrorMessage(e)));
    }
  }

  @override
  Future<Either<Failure, GiftCardOrderEntity>> getOrder(int id) async {
    try {
      final response = await _service.getOrder(id);
      return Right(_mapOrderToEntity(response));
    } catch (e) {
      return Left(ServerFailure(_extractErrorMessage(e)));
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
      subCategories: model.subCategories.map(_mapCategoryToEntity).toList(),
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
      mobileImageUrl: model.mobileImageUrl,
      smallImageUrl: model.smallImageUrl,
      priceType: model.priceType,
      minPrice: model.minPrice,
      maxPrice: model.maxPrice,
      isActive: model.isActive,
      categoryName: model.categoryName,
      brandName: model.brandName,
      denominations: model.denominations,
      parsedDenominations: model.parsedDenominations,
      currencySymbol: model.currencySymbol,
      offerDescription: model.offerDescription,
      formatExpiry: model.formatExpiry,
      termsAndConditions: model.termsAndConditions,
      termsAndConditionsUrl: model.termsAndConditionsUrl,
      discountPercentage: model.discountPercentage,
      themes: model.parsedThemes
          .map((t) => GiftCardThemeEntity(
                sku: t.sku,
                name: t.name,
                price: t.price,
                image: t.image,
              ))
          .toList(),
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
      razorpayRefundId: model.razorpayRefundId,
      refundAmount: model.refundAmount,
      refundStatus: model.refundStatus,
      refundedAt: model.refundedAt,
      pointsRefunded: model.pointsRefunded,
      created: model.created,
    );
  }

  GiftCardOrderStatusEntity _mapOrderStatusToEntity(
    GiftCardOrderStatus status,
  ) {
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
    GiftCardPaymentMethod method,
  ) {
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
    GiftCardPaymentStatus status,
  ) {
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
    GiftCardPaymentMethodEntity method,
  ) {
    switch (method) {
      case GiftCardPaymentMethodEntity.none:
        return GiftCardPaymentMethod.none;
      case GiftCardPaymentMethodEntity.points:
        return GiftCardPaymentMethod.points;
      case GiftCardPaymentMethodEntity.razorpay:
        return GiftCardPaymentMethod.razorpay;
    }
  }

  @override
  Future<Either<Failure, List<GiftCardRelatedProductEntity>>> getRelatedProducts(int productId) async {
    try {
      final response = await _service.getRelatedProducts(productId);
      final entities = response.map(_mapRelatedProductToEntity).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(_extractErrorMessage(e)));
    }
  }

  GiftCardRelatedProductEntity _mapRelatedProductToEntity(GiftCardRelatedProduct model) {
    return GiftCardRelatedProductEntity(
      id: model.id,
      giftCardProductId: model.giftCardProductId,
      relatedSku: model.relatedSku,
      relatedName: model.relatedName,
      relatedUrl: model.relatedUrl,
      minPrice: model.minPrice,
      maxPrice: model.maxPrice,
      offerShortDesc: model.offerShortDesc,
      thumbnailUrl: model.thumbnailUrl,
      mobileImageUrl: model.mobileImageUrl,
      currencyCode: model.currencyCode,
      hasPromo: model.hasPromo,
    );
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
