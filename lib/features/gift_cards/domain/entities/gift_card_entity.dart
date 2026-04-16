import 'package:equatable/equatable.dart';

class GiftCardCategoryEntity extends Equatable {
  final int id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String? blurHash;
  final bool isActive;
  final int productCount;
  final int? parentCategoryId;
  final List<GiftCardCategoryEntity> subCategories;

  const GiftCardCategoryEntity({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.blurHash,
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
        blurHash,
        isActive,
        productCount,
        parentCategoryId,
        subCategories,
      ];
}

class GiftCardThemeEntity extends Equatable {
  final String sku;
  final String? name;
  final String? price;
  final String? image;

  const GiftCardThemeEntity({
    required this.sku,
    this.name,
    this.price,
    this.image,
  });

  @override
  List<Object?> get props => [sku, name, price, image];
}

class GiftCardProductEntity extends Equatable {
  final int id;
  final String name;
  final String? description;
  final String sku;
  final String? imageUrl; // 450x158 main banner
  final String? thumbnailUrl; // 22x32 — too small, do not display
  final String? mobileImageUrl; // ~500x500 square
  final String? smallImageUrl; // 200x120 landscape
  final String? blurHash;
  final String priceType;
  final double minPrice;
  final double maxPrice;
  final bool isActive;
  final String? categoryName;
  final String? brandName;
  final String? denominations;
  final List<double> parsedDenominations;
  final String? currencySymbol;
  final String? offerDescription;
  final String? formatExpiry;
  final String? termsAndConditions;
  final String? termsAndConditionsUrl;
  final double? discountPercentage;
  final List<GiftCardThemeEntity> themes;
  final int redemptionMode;

  const GiftCardProductEntity({
    required this.id,
    required this.name,
    this.description,
    required this.sku,
    this.imageUrl,
    this.thumbnailUrl,
    this.mobileImageUrl,
    this.smallImageUrl,
    this.blurHash,
    required this.priceType,
    required this.minPrice,
    required this.maxPrice,
    required this.isActive,
    this.categoryName,
    this.brandName,
    this.denominations,
    this.parsedDenominations = const [],
    this.currencySymbol,
    this.offerDescription,
    this.formatExpiry,
    this.termsAndConditions,
    this.termsAndConditionsUrl,
    this.discountPercentage,
    this.themes = const [],
    this.redemptionMode = 3,
  });

  bool get hasDiscount =>
      discountPercentage != null && discountPercentage! > 0;

  /// Whether the product has any usable image at all (excludes the
  /// near-useless 22×32 thumbnail).
  bool get hasAnyImage =>
      _isUsable(imageUrl) ||
      _isUsable(mobileImageUrl) ||
      _isUsable(smallImageUrl);

  /// Best image for the **hero/banner** spot — large landscape areas.
  /// Prefers the wide main banner (450×158), falls back to the square
  /// mobile image, then the small landscape image.
  String? get heroImageUrl =>
      _firstUsable([imageUrl, mobileImageUrl, smallImageUrl]);

  /// Best image for **square card slots** (grid tiles, my-cards rail).
  /// Prefers the square mobile image (500×500), falls back to the wide
  /// main banner, then small.
  String? get squareImageUrl =>
      _firstUsable([mobileImageUrl, imageUrl, smallImageUrl]);

  /// Best image for **small list/row thumbnails** (e.g., trending tile).
  /// Prefers the small landscape image, falls back to mobile, then main.
  String? get listImageUrl =>
      _firstUsable([smallImageUrl, mobileImageUrl, imageUrl]);

  static String? _firstUsable(List<String?> candidates) {
    for (final c in candidates) {
      if (_isUsable(c)) return c;
    }
    return null;
  }

  static bool _isUsable(String? url) =>
      url != null && url.trim().isNotEmpty;

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
        mobileImageUrl,
        smallImageUrl,
        blurHash,
        priceType,
        minPrice,
        maxPrice,
        isActive,
        categoryName,
        brandName,
        denominations,
        parsedDenominations,
        currencySymbol,
        offerDescription,
        formatExpiry,
        termsAndConditions,
        termsAndConditionsUrl,
        discountPercentage,
        themes,
        redemptionMode,
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
  final String? razorpayRefundId;
  final double? refundAmount;
  final String? refundStatus;
  final DateTime? refundedAt;
  final int? pointsRefunded;
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
    this.razorpayRefundId,
    this.refundAmount,
    this.refundStatus,
    this.refundedAt,
    this.pointsRefunded,
    required this.created,
  });

  bool get isCompleted => status == GiftCardOrderStatusEntity.completed;
  bool get isPending => status == GiftCardOrderStatusEntity.pending;
  bool get isFailed => status == GiftCardOrderStatusEntity.failed;
  bool get hasCardDetails =>
      woohooCardNumber != null && woohooCardNumber!.isNotEmpty;
  bool get isRefunded => status == GiftCardOrderStatusEntity.refunded;
  bool get hasRefundDetails => razorpayRefundId != null || (pointsRefunded != null && pointsRefunded! > 0);

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
        razorpayRefundId,
        refundAmount,
        refundStatus,
        refundedAt,
        pointsRefunded,
        created,
      ];
}

class GiftCardRelatedProductEntity extends Equatable {
  final int id;
  final int giftCardProductId;
  final String relatedSku;
  final String relatedName;
  final String? relatedUrl;
  final String? minPrice;
  final String? maxPrice;
  final String? offerShortDesc;
  final String? thumbnailUrl;
  final String? mobileImageUrl;
  final String currencyCode;
  final bool hasPromo;

  const GiftCardRelatedProductEntity({
    required this.id,
    required this.giftCardProductId,
    required this.relatedSku,
    required this.relatedName,
    this.relatedUrl,
    this.minPrice,
    this.maxPrice,
    this.offerShortDesc,
    this.thumbnailUrl,
    this.mobileImageUrl,
    this.currencyCode = 'INR',
    this.hasPromo = false,
  });

  @override
  List<Object?> get props => [id, giftCardProductId, relatedSku, relatedName, relatedUrl, minPrice, maxPrice, offerShortDesc, thumbnailUrl, mobileImageUrl, currencyCode, hasPromo];
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
