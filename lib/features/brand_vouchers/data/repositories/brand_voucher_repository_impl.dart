import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/brand_voucher_entity.dart';
import '../../domain/repositories/brand_voucher_repository.dart';
import '../models/brand_voucher_models.dart';
import '../services/brand_voucher_service.dart';

@LazySingleton(as: BrandVoucherRepository)
class BrandVoucherRepositoryImpl implements BrandVoucherRepository {
  final BrandVoucherService _service;

  BrandVoucherRepositoryImpl(this._service);

  @override
  Future<Either<Failure, List<BrandVoucherEntity>>> getBrandVouchers({
    bool? isActive,
    String? searchTerm,
  }) async {
    try {
      final response = await _service.getBrandVouchers(
        pageNumber: 1,
        pageSize: 1000,
        isActive: isActive,
        searchTerm: searchTerm,
      );

      final entities = response.items
          .map((model) => _mapToEntity(model))
          .toList();

      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, BrandVoucherEntity>> getBrandVoucher(int id) async {
    try {
      final response = await _service.getBrandVoucher(id);
      return Right(_mapToEntity(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> createVoucherOrder({
    required String userId,
    required int brandVoucherId,
    required double voucherAmount,
  }) async {
    try {
      final request = CreateVoucherOrderRequest(
        userId: userId,
        brandVoucherId: brandVoucherId,
        voucherAmount: voucherAmount,
      );
      
      final orderId = await _service.createVoucherOrder(request);
      return Right(orderId);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VoucherOrderEntity>>> getVoucherOrders({
    VoucherOrderStatusEntity? status,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _service.getVoucherOrders(
        status: status != null ? _mapToModelStatus(status) : null,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      
      final entities = response.items
          .map((model) => _mapToOrderEntity(model))
          .toList();
          
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VoucherOrderEntity>> getVoucherOrder(int id) async {
    try {
      final response = await _service.getVoucherOrder(id);
      return Right(_mapToOrderEntity(response));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateVoucherPaymentOrderResponse>> createRazorpayOrder({
    required int brandVoucherId,
    required double voucherAmount,
  }) async {
    try {
      final request = CreateVoucherPaymentOrderRequest(
        brandVoucherId: brandVoucherId,
        voucherAmount: voucherAmount,
      );

      final response = await _service.createRazorpayOrder(request);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerifyVoucherPaymentResponse>> verifyRazorpayPayment({
    required int voucherOrderId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  }) async {
    try {
      final request = VerifyVoucherPaymentRequest(
        voucherOrderId: voucherOrderId,
        razorpayOrderId: razorpayOrderId,
        razorpayPaymentId: razorpayPaymentId,
        razorpaySignature: razorpaySignature,
      );

      final response = await _service.verifyRazorpayPayment(request);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  BrandVoucherEntity _mapToEntity(BrandVoucher model) {
    return BrandVoucherEntity(
      id: model.id,
      brandName: model.brandName,
      brandDescription: model.brandDescription,
      brandImageUrl: model.brandImageUrl,
      brandWebsiteUrl: model.brandWebsiteUrl,
      minimumAmount: model.minimumAmount,
      maximumAmount: model.maximumAmount,
      processingFeePercentage: model.processingFeePercentage,
      isActive: model.isActive,
      terms: model.terms,
      instructions: model.instructions,
      created: model.created,
    );
  }

  VoucherOrderEntity _mapToOrderEntity(VoucherOrder model) {
    return VoucherOrderEntity(
      id: model.id,
      userId: model.userId,
      brandVoucherId: model.brandVoucherId,
      brandName: model.brandName,
      brandImageUrl: model.brandImageUrl,
      voucherAmount: model.voucherAmount,
      processingFee: model.processingFee,
      totalPointsUsed: model.totalPointsUsed,
      status: _mapToEntityStatus(model.status),
      voucherCode: model.voucherCode,
      voucherPin: model.voucherPin,
      fulfilledAt: model.fulfilledAt,
      fulfilledBy: model.fulfilledBy,
      rejectionReason: model.rejectionReason,
      expiresAt: model.expiresAt,
      notes: model.notes,
      created: model.created,
      paymentMethod: _mapToEntityPaymentMethod(model.paymentMethod),
      razorpayOrderId: model.razorpayOrderId,
      razorpayPaymentId: model.razorpayPaymentId,
      amountPaid: model.amountPaid,
    );
  }

  VoucherOrderStatus _mapToModelStatus(VoucherOrderStatusEntity status) {
    switch (status) {
      case VoucherOrderStatusEntity.pending:
        return VoucherOrderStatus.pending;
      case VoucherOrderStatusEntity.processing:
        return VoucherOrderStatus.processing;
      case VoucherOrderStatusEntity.fulfilled:
        return VoucherOrderStatus.fulfilled;
      case VoucherOrderStatusEntity.rejected:
        return VoucherOrderStatus.rejected;
      case VoucherOrderStatusEntity.cancelled:
        return VoucherOrderStatus.cancelled;
    }
  }

  VoucherOrderStatusEntity _mapToEntityStatus(VoucherOrderStatus status) {
    switch (status) {
      case VoucherOrderStatus.pending:
        return VoucherOrderStatusEntity.pending;
      case VoucherOrderStatus.processing:
        return VoucherOrderStatusEntity.processing;
      case VoucherOrderStatus.fulfilled:
        return VoucherOrderStatusEntity.fulfilled;
      case VoucherOrderStatus.rejected:
        return VoucherOrderStatusEntity.rejected;
      case VoucherOrderStatus.cancelled:
        return VoucherOrderStatusEntity.cancelled;
    }
  }

  VoucherPaymentMethodEntity _mapToEntityPaymentMethod(VoucherPaymentMethod method) {
    switch (method) {
      case VoucherPaymentMethod.none:
        return VoucherPaymentMethodEntity.none;
      case VoucherPaymentMethod.points:
        return VoucherPaymentMethodEntity.points;
      case VoucherPaymentMethod.razorpay:
        return VoucherPaymentMethodEntity.razorpay;
    }
  }
}