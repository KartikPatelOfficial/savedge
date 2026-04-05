part of 'gift_cards_bloc.dart';

abstract class GiftCardsEvent extends Equatable {
  const GiftCardsEvent();

  @override
  List<Object?> get props => [];
}

class LoadGiftCardCategories extends GiftCardsEvent {
  const LoadGiftCardCategories();
}

class LoadGiftCardProducts extends GiftCardsEvent {
  final int? categoryId;
  final String? searchTerm;

  const LoadGiftCardProducts({
    this.categoryId,
    this.searchTerm,
  });

  @override
  List<Object?> get props => [categoryId, searchTerm];
}

class LoadGiftCardProduct extends GiftCardsEvent {
  final int productId;

  const LoadGiftCardProduct({required this.productId});

  @override
  List<Object> get props => [productId];
}

class LoadPriceBreakdown extends GiftCardsEvent {
  final int productId;
  final double amount;
  final int pointsToUse;

  const LoadPriceBreakdown({
    required this.productId,
    required this.amount,
    this.pointsToUse = 0,
  });

  @override
  List<Object> get props => [productId, amount, pointsToUse];
}

class CreateGiftCardOrder extends GiftCardsEvent {
  final int giftCardProductId;
  final double amount;
  final GiftCardPaymentMethodEntity paymentMethod;
  final String? themeSku;

  const CreateGiftCardOrder({
    required this.giftCardProductId,
    required this.amount,
    required this.paymentMethod,
    this.themeSku,
  });

  @override
  List<Object?> get props => [giftCardProductId, amount, paymentMethod, themeSku];
}

class CreateGiftCardPaymentOrder extends GiftCardsEvent {
  final int giftCardProductId;
  final double amount;
  final int pointsToUse;
  final String? themeSku;

  const CreateGiftCardPaymentOrder({
    required this.giftCardProductId,
    required this.amount,
    this.pointsToUse = 0,
    this.themeSku,
  });

  @override
  List<Object?> get props => [giftCardProductId, amount, pointsToUse, themeSku];
}

class VerifyGiftCardPayment extends GiftCardsEvent {
  final int orderId;
  final String razorpayOrderId;
  final String razorpayPaymentId;
  final String razorpaySignature;

  const VerifyGiftCardPayment({
    required this.orderId,
    required this.razorpayOrderId,
    required this.razorpayPaymentId,
    required this.razorpaySignature,
  });

  @override
  List<Object> get props =>
      [orderId, razorpayOrderId, razorpayPaymentId, razorpaySignature];
}

class LoadGiftCardOrders extends GiftCardsEvent {
  final GiftCardOrderStatusEntity? status;
  final int pageNumber;
  final int pageSize;

  const LoadGiftCardOrders({
    this.status,
    this.pageNumber = 1,
    this.pageSize = 20,
  });

  @override
  List<Object?> get props => [status, pageNumber, pageSize];
}
