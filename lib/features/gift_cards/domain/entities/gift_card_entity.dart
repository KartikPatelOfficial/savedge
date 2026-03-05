import 'package:equatable/equatable.dart';

class GiftCardCategoryEntity extends Equatable {
  final int id;
  final String name;
  final String? description;
  final String? imageUrl;
  final bool isActive;
  final int productCount;
  final int? parentCategoryId;
  final List<GiftCardCategoryEntity> subCategories;

  const GiftCardCategoryEntity({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.isActive,
    required this.productCount,
    this.parentCategoryId,
    this.subCategories = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        isActive,
        productCount,
        parentCategoryId,
        subCategories,
      ];
}

class GiftCardProductEntity extends Equatable {
  final int id;
  final String name;
  final String? description;
  final String sku;
  final String? imageUrl;
  final String? thumbnailUrl;
  final String priceType;
  final double minPrice;
  final double maxPrice;
  final bool isActive;
  final String? categoryName;
  final String? brandName;
  final String? denominations;
  final String? currencySymbol;
  final String? offerDescription;
  final String? formatExpiry;
  final double? discountPercentage;

  const GiftCardProductEntity({
    required this.id,
    required this.name,
    this.description,
    required this.sku,
    this.imageUrl,
    this.thumbnailUrl,
    required this.priceType,
    required this.minPrice,
    required this.maxPrice,
    required this.isActive,
    this.categoryName,
    this.brandName,
    this.denominations,
    this.currencySymbol,
    this.offerDescription,
    this.formatExpiry,
    this.discountPercentage,
  });

  bool get hasDiscount =>
      discountPercentage != null && discountPercentage! > 0;

  double calculatePayable(double amount) {
    if (!hasDiscount) return amount;
    return amount - (amount * discountPercentage! / 100);
  }

  double calculateDiscount(double amount) {
    if (!hasDiscount) return 0;
    return amount * discountPercentage! / 100;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        sku,
        imageUrl,
        thumbnailUrl,
        priceType,
        minPrice,
        maxPrice,
        isActive,
        categoryName,
        brandName,
        denominations,
        currencySymbol,
        offerDescription,
        formatExpiry,
        discountPercentage,
      ];
}

class GiftCardOrderEntity extends Equatable {
  final int id;
  final String userId;
  final int giftCardProductId;
  final String productName;
  final String? productImageUrl;
  final double requestedAmount;
  final double discountPercentage;
  final double discountAmount;
  final double payableAmount;
  final GiftCardPaymentMethodEntity paymentMethod;
  final GiftCardPaymentStatusEntity paymentStatus;
  final double totalPointsUsed;
  final String? razorpayOrderId;
  final String? razorpayPaymentId;
  final GiftCardOrderStatusEntity status;
  final String? woohooCardNumber;
  final String? woohooCardPin;
  final String? woohooActivationCode;
  final String? woohooActivationUrl;
  final double? woohooActivatedAmount;
  final DateTime? woohooCardExpiry;
  final String? failureReason;
  final DateTime created;

  const GiftCardOrderEntity({
    required this.id,
    required this.userId,
    required this.giftCardProductId,
    required this.productName,
    this.productImageUrl,
    required this.requestedAmount,
    required this.discountPercentage,
    required this.discountAmount,
    required this.payableAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.totalPointsUsed,
    this.razorpayOrderId,
    this.razorpayPaymentId,
    required this.status,
    this.woohooCardNumber,
    this.woohooCardPin,
    this.woohooActivationCode,
    this.woohooActivationUrl,
    this.woohooActivatedAmount,
    this.woohooCardExpiry,
    this.failureReason,
    required this.created,
  });

  bool get isCompleted => status == GiftCardOrderStatusEntity.completed;
  bool get isPending => status == GiftCardOrderStatusEntity.pending;
  bool get isFailed => status == GiftCardOrderStatusEntity.failed;
  bool get hasCardDetails =>
      woohooCardNumber != null && woohooCardNumber!.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        userId,
        giftCardProductId,
        productName,
        productImageUrl,
        requestedAmount,
        discountPercentage,
        discountAmount,
        payableAmount,
        paymentMethod,
        paymentStatus,
        totalPointsUsed,
        razorpayOrderId,
        razorpayPaymentId,
        status,
        woohooCardNumber,
        woohooCardPin,
        woohooActivationCode,
        woohooActivationUrl,
        woohooActivatedAmount,
        woohooCardExpiry,
        failureReason,
        created,
      ];
}

enum GiftCardOrderStatusEntity {
  pending,
  paymentCompleted,
  issuing,
  completed,
  failed,
  cancelled,
  refunded,
}

extension GiftCardOrderStatusEntityExtension on GiftCardOrderStatusEntity {
  String get displayName {
    switch (this) {
      case GiftCardOrderStatusEntity.pending:
        return 'Pending';
      case GiftCardOrderStatusEntity.paymentCompleted:
        return 'Payment Completed';
      case GiftCardOrderStatusEntity.issuing:
        return 'Issuing';
      case GiftCardOrderStatusEntity.completed:
        return 'Completed';
      case GiftCardOrderStatusEntity.failed:
        return 'Failed';
      case GiftCardOrderStatusEntity.cancelled:
        return 'Cancelled';
      case GiftCardOrderStatusEntity.refunded:
        return 'Refunded';
    }
  }

  String get description {
    switch (this) {
      case GiftCardOrderStatusEntity.pending:
        return 'Waiting for payment';
      case GiftCardOrderStatusEntity.paymentCompleted:
        return 'Payment received, issuing gift card';
      case GiftCardOrderStatusEntity.issuing:
        return 'Gift card is being issued';
      case GiftCardOrderStatusEntity.completed:
        return 'Gift card is ready to use';
      case GiftCardOrderStatusEntity.failed:
        return 'Order failed';
      case GiftCardOrderStatusEntity.cancelled:
        return 'Order was cancelled';
      case GiftCardOrderStatusEntity.refunded:
        return 'Order was refunded';
    }
  }
}

enum GiftCardPaymentMethodEntity {
  none,
  points,
  razorpay,
}

extension GiftCardPaymentMethodEntityExtension on GiftCardPaymentMethodEntity {
  String get displayName {
    switch (this) {
      case GiftCardPaymentMethodEntity.none:
        return 'Not Specified';
      case GiftCardPaymentMethodEntity.points:
        return 'Points';
      case GiftCardPaymentMethodEntity.razorpay:
        return 'Online Payment';
    }
  }

  String get icon {
    switch (this) {
      case GiftCardPaymentMethodEntity.none:
        return '❓';
      case GiftCardPaymentMethodEntity.points:
        return '⭐';
      case GiftCardPaymentMethodEntity.razorpay:
        return '💳';
    }
  }
}

enum GiftCardPaymentStatusEntity {
  pending,
  completed,
  failed,
  refunded,
}
