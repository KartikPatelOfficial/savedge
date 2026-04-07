import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/gift_card_models.dart' show GiftCardPriceBreakdown;
import '../../domain/entities/gift_card_entity.dart';
import '../../domain/repositories/gift_card_repository.dart';
import '../../domain/usecases/get_gift_card_products_usecase.dart';
import '../../domain/usecases/create_gift_card_order_usecase.dart';
import '../../domain/usecases/get_gift_card_orders_usecase.dart';

part 'gift_cards_event.dart';
part 'gift_cards_state.dart';

@injectable
class GiftCardsBloc extends Bloc<GiftCardsEvent, GiftCardsState> {
  final GetGiftCardProductsUseCase getGiftCardProductsUseCase;
  final CreateGiftCardOrderUseCase createGiftCardOrderUseCase;
  final GetGiftCardOrdersUseCase getGiftCardOrdersUseCase;
  final GiftCardRepository giftCardRepository;

  GiftCardsBloc({
    required this.getGiftCardProductsUseCase,
    required this.createGiftCardOrderUseCase,
    required this.getGiftCardOrdersUseCase,
    required this.giftCardRepository,
  }) : super(GiftCardsInitial()) {
    on<LoadGiftCardCategories>(_onLoadCategories);
    on<LoadHotDeals>(_onLoadHotDeals);
    on<LoadGiftCardProducts>(_onLoadProducts);
    on<LoadGiftCardProduct>(_onLoadProduct);
    on<LoadPriceBreakdown>(_onLoadPriceBreakdown);
    on<CreateGiftCardOrder>(_onCreateOrder);
    on<CreateGiftCardPaymentOrder>(_onCreatePaymentOrder);
    on<VerifyGiftCardPayment>(_onVerifyPayment);
    on<LoadGiftCardOrders>(_onLoadOrders);
    on<LoadRelatedProducts>(_onLoadRelatedProducts);
  }

  Future<void> _onLoadCategories(
    LoadGiftCardCategories event,
    Emitter<GiftCardsState> emit,
  ) async {
    emit(GiftCardCategoriesLoading());

    final result = await giftCardRepository.getCategories();

    result.fold(
      (failure) => emit(GiftCardCategoriesError(failure.message ?? 'Failed to load categories')),
      (categories) => emit(GiftCardCategoriesLoaded(categories)),
    );
  }

  Future<void> _onLoadHotDeals(
    LoadHotDeals event,
    Emitter<GiftCardsState> emit,
  ) async {
    final result = await giftCardRepository.getHotDeals();
    result.fold(
      (failure) => {}, // Silently fail - hot deals are non-critical
      (hotDeals) => emit(HotDealsLoaded(hotDeals)),
    );
  }

  Future<void> _onLoadProducts(
    LoadGiftCardProducts event,
    Emitter<GiftCardsState> emit,
  ) async {
    emit(GiftCardProductsLoading());

    final result = await getGiftCardProductsUseCase(
      GetGiftCardProductsParams(
        categoryId: event.categoryId,
        searchTerm: event.searchTerm,
      ),
    );

    result.fold(
      (failure) => emit(GiftCardProductsError(failure.message ?? 'Failed to load products')),
      (products) => emit(GiftCardProductsLoaded(products)),
    );
  }

  Future<void> _onLoadProduct(
    LoadGiftCardProduct event,
    Emitter<GiftCardsState> emit,
  ) async {
    emit(GiftCardProductLoading());

    final result = await giftCardRepository.getProduct(event.productId);

    result.fold(
      (failure) => emit(GiftCardProductError(failure.message ?? 'Failed to load product')),
      (product) => emit(GiftCardProductLoaded(product)),
    );
  }

  Future<void> _onLoadPriceBreakdown(
    LoadPriceBreakdown event,
    Emitter<GiftCardsState> emit,
  ) async {
    emit(PriceBreakdownLoading());

    final result = await giftCardRepository.getPriceBreakdown(
      productId: event.productId,
      amount: event.amount,
      pointsToUse: event.pointsToUse,
    );

    result.fold(
      (failure) => emit(PriceBreakdownError(failure.message ?? 'Failed to load price breakdown')),
      (breakdown) => emit(PriceBreakdownLoaded(breakdown)),
    );
  }

  Future<void> _onCreateOrder(
    CreateGiftCardOrder event,
    Emitter<GiftCardsState> emit,
  ) async {
    emit(GiftCardOrderCreating());

    final result = await createGiftCardOrderUseCase(
      CreateGiftCardOrderParams(
        giftCardProductId: event.giftCardProductId,
        amount: event.amount,
        paymentMethod: event.paymentMethod,
        themeSku: event.themeSku,
      ),
    );

    result.fold(
      (failure) => emit(GiftCardOrderError(failure.message ?? 'Failed to create order')),
      (order) => emit(GiftCardOrderCreated(order)),
    );
  }

  Future<void> _onCreatePaymentOrder(
    CreateGiftCardPaymentOrder event,
    Emitter<GiftCardsState> emit,
  ) async {
    emit(GiftCardRazorpayOrderCreating());

    final result = await giftCardRepository.createPaymentOrder(
      giftCardProductId: event.giftCardProductId,
      amount: event.amount,
      pointsToUse: event.pointsToUse,
      themeSku: event.themeSku,
    );

    result.fold(
      (failure) => emit(GiftCardRazorpayOrderError(failure.message ?? 'Failed to create payment order')),
      (response) => emit(
        GiftCardRazorpayOrderCreated(
          razorpayOrderId: response.razorpayOrderId,
          razorpayAmountInPaise: response.razorpayAmountInPaise,
          currency: response.currency,
          razorpayKeyId: response.razorpayKeyId,
          orderId: response.orderId,
          productName: response.productName,
          requestedAmount: response.requestedAmount,
          discountPercentage: response.discountPercentage,
          discountAmount: response.discountAmount,
          payableAmount: response.payableAmount,
        ),
      ),
    );
  }

  Future<void> _onVerifyPayment(
    VerifyGiftCardPayment event,
    Emitter<GiftCardsState> emit,
  ) async {
    emit(GiftCardPaymentVerifying());

    final result = await giftCardRepository.verifyPayment(
      orderId: event.orderId,
      razorpayOrderId: event.razorpayOrderId,
      razorpayPaymentId: event.razorpayPaymentId,
      razorpaySignature: event.razorpaySignature,
    );

    result.fold(
      (failure) => emit(GiftCardPaymentError(failure.message ?? 'Payment verification failed')),
      (response) => emit(GiftCardPaymentVerified(
        success: response.success,
        message: response.message,
      )),
    );
  }

  Future<void> _onLoadOrders(
    LoadGiftCardOrders event,
    Emitter<GiftCardsState> emit,
  ) async {
    emit(GiftCardOrdersLoading());

    final result = await getGiftCardOrdersUseCase(
      GetGiftCardOrdersParams(
        status: event.status,
        pageNumber: event.pageNumber,
        pageSize: event.pageSize,
      ),
    );

    result.fold(
      (failure) => emit(GiftCardOrdersError(failure.message ?? 'Failed to load orders')),
      (orders) => emit(GiftCardOrdersLoaded(orders)),
    );
  }

  Future<void> _onLoadRelatedProducts(
    LoadRelatedProducts event,
    Emitter<GiftCardsState> emit,
  ) async {
    emit(RelatedProductsLoading());
    final result = await giftCardRepository.getRelatedProducts(event.productId);
    result.fold(
      (failure) => emit(RelatedProductsError(failure.message ?? 'Failed to load related products')),
      (products) => emit(RelatedProductsLoaded(products)),
    );
  }
}
