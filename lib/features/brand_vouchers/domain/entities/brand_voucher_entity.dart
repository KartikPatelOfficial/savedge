import 'package:equatable/equatable.dart';

class BrandVoucherEntity extends Equatable {
  final int id;
  final String brandName;
  final String brandDescription;
  final String brandImageUrl;
  final String brandWebsiteUrl;
  final double minimumAmount;
  final double maximumAmount;
  final double processingFeePercentage;
  final bool isActive;
  final String? terms;
  final String? instructions;
  final DateTime created;

  const BrandVoucherEntity({
    required this.id,
    required this.brandName,
    required this.brandDescription,
    required this.brandImageUrl,
    required this.brandWebsiteUrl,
    required this.minimumAmount,
    required this.maximumAmount,
    required this.processingFeePercentage,
    required this.isActive,
    this.terms,
    this.instructions,
    required this.created,
  });

  double calculateProcessingFee(double voucherAmount) {
    return (voucherAmount * processingFeePercentage / 100);
  }

  double calculateTotalCost(double voucherAmount) {
    return voucherAmount + calculateProcessingFee(voucherAmount);
  }

  @override
  List<Object?> get props => [
        id,
        brandName,
        brandDescription,
        brandImageUrl,
        brandWebsiteUrl,
        minimumAmount,
        maximumAmount,
        processingFeePercentage,
        isActive,
        terms,
        instructions,
        created,
      ];
}

class VoucherOrderEntity extends Equatable {
  final int id;
  final String userId;
  final int brandVoucherId;
  final String brandName;
  final String brandImageUrl;
  final double voucherAmount;
  final double processingFee;
  final double totalPointsUsed;
  final VoucherOrderStatusEntity status;
  final String? voucherCode;
  final String? voucherPin;
  final DateTime? fulfilledAt;
  final String? fulfilledBy;
  final String? rejectionReason;
  final DateTime? expiresAt;
  final String? notes;
  final DateTime created;

  const VoucherOrderEntity({
    required this.id,
    required this.userId,
    required this.brandVoucherId,
    required this.brandName,
    required this.brandImageUrl,
    required this.voucherAmount,
    required this.processingFee,
    required this.totalPointsUsed,
    required this.status,
    this.voucherCode,
    this.voucherPin,
    this.fulfilledAt,
    this.fulfilledBy,
    this.rejectionReason,
    this.expiresAt,
    this.notes,
    required this.created,
  });

  bool get isCompleted => status == VoucherOrderStatusEntity.fulfilled;
  bool get isPending => status == VoucherOrderStatusEntity.pending;
  bool get isRejected => status == VoucherOrderStatusEntity.rejected;
  bool get hasVoucherDetails => voucherCode != null && voucherCode!.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        userId,
        brandVoucherId,
        brandName,
        brandImageUrl,
        voucherAmount,
        processingFee,
        totalPointsUsed,
        status,
        voucherCode,
        voucherPin,
        fulfilledAt,
        fulfilledBy,
        rejectionReason,
        expiresAt,
        notes,
        created,
      ];
}

enum VoucherOrderStatusEntity {
  pending,
  processing,
  fulfilled,
  rejected,
  cancelled,
}

extension VoucherOrderStatusEntityExtension on VoucherOrderStatusEntity {
  String get displayName {
    switch (this) {
      case VoucherOrderStatusEntity.pending:
        return 'Pending';
      case VoucherOrderStatusEntity.processing:
        return 'Processing';
      case VoucherOrderStatusEntity.fulfilled:
        return 'Fulfilled';
      case VoucherOrderStatusEntity.rejected:
        return 'Rejected';
      case VoucherOrderStatusEntity.cancelled:
        return 'Cancelled';
    }
  }

  String get description {
    switch (this) {
      case VoucherOrderStatusEntity.pending:
        return 'Your order is waiting for admin review';
      case VoucherOrderStatusEntity.processing:
        return 'Your voucher is being prepared';
      case VoucherOrderStatusEntity.fulfilled:
        return 'Your voucher is ready to use';
      case VoucherOrderStatusEntity.rejected:
        return 'Your order was rejected';
      case VoucherOrderStatusEntity.cancelled:
        return 'Your order was cancelled';
    }
  }
}