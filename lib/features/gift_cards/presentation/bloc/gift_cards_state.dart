part of 'gift_cards_bloc.dart';

abstract class GiftCardsState extends Equatable {
  const GiftCardsState();

  @override
  List<Object?> get props => [];
}

class GiftCardsInitial extends GiftCardsState {}

// Categories
class GiftCardCategoriesLoading extends GiftCardsState {}

class GiftCardCategoriesLoaded extends GiftCardsState {
  final List<GiftCardCategoryEntity> categories;

  const GiftCardCategoriesLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class GiftCardCategoriesError extends GiftCardsState {
  final String message;

  const GiftCardCategoriesError(this.message);

  @override
  List<Object> get props => [message];
}

// Products
class GiftCardProductsLoading extends GiftCardsState {}

class GiftCardProductsLoaded extends GiftCardsState {
  final List<GiftCardProductEntity> products;

  const GiftCardProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

class GiftCardProductsError extends GiftCardsState {
  final String message;

  const GiftCardProductsError(this.message);

  @override
  List<Object> get props => [message];
}

// Single Product
class GiftCardProductLoading extends GiftCardsState {}

class GiftCardProductLoaded extends GiftCardsState {
  final GiftCardProductEntity product;

  const GiftCardProductLoaded(this.product);

  @override
  List<Object> get props => [product];
}

class GiftCardProductError extends GiftCardsState {
  final String message;

  const GiftCardProductError(this.message);

  @override
  List<Object> get props => [message];
}

// Price Breakdown
class PriceBreakdownLoading extends GiftCardsState {}

class PriceBreakdownLoaded extends GiftCardsState {
  final GiftCardPriceBreakdown breakdown;

  const PriceBreakdownLoaded(this.breakdown);

  @override
  List<Object> get props => [breakdown];
}

class PriceBreakdownError extends GiftCardsState {
  final String message;

  const PriceBreakdownError(this.message);

  @override
  List<Object> get props => [message];
}

// Order creation (Points payment)
class GiftCardOrderCreating extends GiftCardsState {}

class GiftCardOrderCreated extends GiftCardsState {
  final GiftCardOrderEntity order;

  const GiftCardOrderCreated(this.order);

  @override
  List<Object> get props => [order];
}

class GiftCardOrderError extends GiftCardsState {
  final String message;

  const GiftCardOrderError(this.message);

  @override
  List<Object> get props => [message];
}

// Razorpay payment order
class GiftCardRazorpayOrderCreating extends GiftCardsState {}

class GiftCardRazorpayOrderCreated extends GiftCardsState {
  final String razorpayOrderId;
  final int razorpayAmountInPaise;
  final String currency;
  final String razorpayKeyId;
  final int orderId;
  final String productName;
  final double requestedAmount;
  final double discountPercentage;
  final double discountAmount;
  final double payableAmount;

  const GiftCardRazorpayOrderCreated({
    required this.razorpayOrderId,
    required this.razorpayAmountInPaise,
    required this.currency,
    required this.razorpayKeyId,
    required this.orderId,
    required this.productName,
    required this.requestedAmount,
    required this.discountPercentage,
    required this.discountAmount,
    required this.payableAmount,
  });

  @override
  List<Object> get props => [
        razorpayOrderId,
        razorpayAmountInPaise,
        currency,
        razorpayKeyId,
        orderId,
        productName,
        requestedAmount,
        discountPercentage,
        discountAmount,
        payableAmount,
      ];
}

class GiftCardRazorpayOrderError extends GiftCardsState {
  final String message;

  const GiftCardRazorpayOrderError(this.message);

  @override
  List<Object> get props => [message];
}

// Payment verification
class GiftCardPaymentVerifying extends GiftCardsState {}

class GiftCardPaymentVerified extends GiftCardsState {
  final bool success;

  const GiftCardPaymentVerified(this.success);

  @override
  List<Object> get props => [success];
}

class GiftCardPaymentError extends GiftCardsState {
  final String message;

  const GiftCardPaymentError(this.message);

  @override
  List<Object> get props => [message];
}

// Orders list
class GiftCardOrdersLoading extends GiftCardsState {}

class GiftCardOrdersLoaded extends GiftCardsState {
  final List<GiftCardOrderEntity> orders;

  const GiftCardOrdersLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}

class GiftCardOrdersError extends GiftCardsState {
  final String message;

  const GiftCardOrdersError(this.message);

  @override
  List<Object> get props => [message];
}
