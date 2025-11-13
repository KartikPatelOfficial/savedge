import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_voucher_models.freezed.dart';
part 'brand_voucher_models.g.dart';

@freezed
abstract class BrandVoucher with _$BrandVoucher {
  const factory BrandVoucher({
    required int id,
    required String brandName,
    required String brandDescription,
    required String brandImageUrl,
    required String brandWebsiteUrl,
    required double minimumAmount,
    required double maximumAmount,
    required double processingFeePercentage,
    required bool isActive,
    String? terms,
    String? instructions,
    required DateTime created,
  }) = _BrandVoucher;

  factory BrandVoucher.fromJson(Map<String, dynamic> json) =>
      _$BrandVoucherFromJson(json);
}

@freezed
abstract class VoucherOrder with _$VoucherOrder {
  const factory VoucherOrder({
    required int id,
    required String userId,
    required int brandVoucherId,
    required String brandName,
    required String brandImageUrl,
    required double voucherAmount,
    required double processingFee,
    required double totalPointsUsed,
    required VoucherOrderStatus status,
    String? voucherCode,
    String? voucherPin,
    DateTime? fulfilledAt,
    String? fulfilledBy,
    String? rejectionReason,
    DateTime? expiresAt,
    String? notes,
    required DateTime created,
    // Payment information
    required VoucherPaymentMethod paymentMethod,
    String? razorpayOrderId,
    String? razorpayPaymentId,
    String? razorpaySignature,
    double? amountPaid,
  }) = _VoucherOrder;

  factory VoucherOrder.fromJson(Map<String, dynamic> json) =>
      _$VoucherOrderFromJson(json);
}

@freezed
abstract class CreateVoucherOrderRequest with _$CreateVoucherOrderRequest {
  const factory CreateVoucherOrderRequest({
    required String userId,
    required int brandVoucherId,
    required double voucherAmount,
    @Default(VoucherPaymentMethod.points) VoucherPaymentMethod paymentMethod,
  }) = _CreateVoucherOrderRequest;

  factory CreateVoucherOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateVoucherOrderRequestFromJson(json);
}

@freezed
abstract class PaginatedBrandVoucherResponse
    with _$PaginatedBrandVoucherResponse {
  const factory PaginatedBrandVoucherResponse({
    required List<BrandVoucher> items,
    required int pageNumber,
    required int totalPages,
    required int totalCount,
    required bool hasPreviousPage,
    required bool hasNextPage,
  }) = _PaginatedBrandVoucherResponse;

  factory PaginatedBrandVoucherResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedBrandVoucherResponseFromJson(json);
}

@freezed
abstract class PaginatedVoucherOrderResponse
    with _$PaginatedVoucherOrderResponse {
  const factory PaginatedVoucherOrderResponse({
    required List<VoucherOrder> items,
    required int pageNumber,
    required int totalPages,
    required int totalCount,
    required bool hasPreviousPage,
    required bool hasNextPage,
  }) = _PaginatedVoucherOrderResponse;

  factory PaginatedVoucherOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedVoucherOrderResponseFromJson(json);
}

enum VoucherOrderStatus {
  @JsonValue(1)
  pending,
  @JsonValue(2)
  processing,
  @JsonValue(3)
  fulfilled,
  @JsonValue(4)
  rejected,
  @JsonValue(5)
  cancelled,
}

enum VoucherPaymentMethod {
  @JsonValue(0)
  none,
  @JsonValue(1)
  points,
  @JsonValue(2)
  razorpay,
}

extension VoucherOrderStatusExtension on VoucherOrderStatus {
  String get displayName {
    switch (this) {
      case VoucherOrderStatus.pending:
        return 'Pending';
      case VoucherOrderStatus.processing:
        return 'Processing';
      case VoucherOrderStatus.fulfilled:
        return 'Fulfilled';
      case VoucherOrderStatus.rejected:
        return 'Rejected';
      case VoucherOrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get description {
    switch (this) {
      case VoucherOrderStatus.pending:
        return 'Your order is waiting for admin review';
      case VoucherOrderStatus.processing:
        return 'Your voucher is being prepared';
      case VoucherOrderStatus.fulfilled:
        return 'Your voucher is ready to use';
      case VoucherOrderStatus.rejected:
        return 'Your order was rejected';
      case VoucherOrderStatus.cancelled:
        return 'Your order was cancelled';
    }
  }
}

extension VoucherPaymentMethodExtension on VoucherPaymentMethod {
  String get displayName {
    switch (this) {
      case VoucherPaymentMethod.none:
        return 'Not Specified';
      case VoucherPaymentMethod.points:
        return 'Points';
      case VoucherPaymentMethod.razorpay:
        return 'Razorpay';
    }
  }
}

// Razorpay payment models
@freezed
abstract class CreateVoucherPaymentOrderRequest with _$CreateVoucherPaymentOrderRequest {
  const factory CreateVoucherPaymentOrderRequest({
    required int brandVoucherId,
    required double voucherAmount,
  }) = _CreateVoucherPaymentOrderRequest;

  factory CreateVoucherPaymentOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateVoucherPaymentOrderRequestFromJson(json);
}

@freezed
abstract class CreateVoucherPaymentOrderResponse with _$CreateVoucherPaymentOrderResponse {
  const factory CreateVoucherPaymentOrderResponse({
    required String orderId,
    required int amount,
    required String currency,
    required String receipt,
    required int voucherOrderId,
    required String brandName,
    required double voucherAmount,
    required double processingFee,
    required double totalAmount,
    required String razorpayKey,
  }) = _CreateVoucherPaymentOrderResponse;

  factory CreateVoucherPaymentOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateVoucherPaymentOrderResponseFromJson(json);
}

@freezed
abstract class VerifyVoucherPaymentRequest with _$VerifyVoucherPaymentRequest {
  const factory VerifyVoucherPaymentRequest({
    required int voucherOrderId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
  }) = _VerifyVoucherPaymentRequest;

  factory VerifyVoucherPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyVoucherPaymentRequestFromJson(json);
}

@freezed
abstract class VerifyVoucherPaymentResponse with _$VerifyVoucherPaymentResponse {
  const factory VerifyVoucherPaymentResponse({
    required bool success,
    required String message,
    required int voucherOrderId,
    required String brandName,
    required double voucherAmount,
    required String status,
  }) = _VerifyVoucherPaymentResponse;

  factory VerifyVoucherPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyVoucherPaymentResponseFromJson(json);
}
