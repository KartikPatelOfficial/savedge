import 'package:equatable/equatable.dart';
import 'package:savedge/core/utils/failure_message_mapper.dart';
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

  // ── Products pagination state ───────────────────────────────────────────
  // The products list is fetched one page at a time and accumulated here so
  // the UI can show the true catalog total while loading more on scroll.
  final List<GiftCardProductEntity> _loadedProducts = [];
  int _productsPage = 1;
  int _productsTotalCount = 0;
  bool _productsHasNextPage = false;
  bool _isLoadingMoreProducts = false;
  int? _productsCategoryId;
  String? _productsSearchTerm;

  // Bumped on every fresh load (search / category / refresh). An in-flight
  // page fetch captures the value and discards its result if it changed,
  // so a slow response can't clobber or append onto a newer list.
  int _productsRequestId = 0;

  GiftCardsBloc({
    required this.getGiftCardProductsUseCase,
    required this.createGiftCardOrderUseCase,
    required this.getGiftCardOrdersUseCase,
    required this.giftCardRepository,
  }) : super(GiftCardsInitial()) {
    on<LoadGiftCardCategories>(_onLoadCategories);
    on<LoadHotDeals>(_onLoadHotDeals);
    on<LoadGiftCardProducts>(_onLoadProducts);
    on<LoadMoreGiftCardProducts>(_onLoadMoreProducts);
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
      (failure) => emit(GiftCardCategoriesError(FailureMessageMapper.mapFailureToMessage(failure))),
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
    // Reset pagination — this is a fresh load for (possibly new) filters.
    final requestId = ++_productsRequestId;
    _productsCategoryId = event.categoryId;
    _productsSearchTerm = event.searchTerm;
    _productsPage = 1;
    _isLoadingMoreProducts = false;

    emit(GiftCardProductsLoading());

    final result = await getGiftCardProductsUseCase(
      GetGiftCardProductsParams(
        categoryId: event.categoryId,
        searchTerm: event.searchTerm,
        pageNumber: 1,
      ),
    );

    // A newer load started while we were fetching — let it own the state.
    if (requestId != _productsRequestId) return;

    result.fold(
      (failure) => emit(GiftCardProductsError(FailureMessageMapper.mapFailureToMessage(failure))),
      (page) {
        _loadedProducts
          ..clear()
          ..addAll(page.items);
        _productsPage = page.pageNumber;
        _productsTotalCount = page.totalCount;
        _productsHasNextPage = page.hasNextPage;
        emit(_buildProductsLoaded());
      },
    );
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreGiftCardProducts event,
    Emitter<GiftCardsState> emit,
  ) async {
    // Nothing more to fetch, or a fetch is already in flight. The synchronous
    // guard + flag (set before the first await) makes this re-entrancy safe.
    if (!_productsHasNextPage || _isLoadingMoreProducts) return;

    _isLoadingMoreProducts = true;
    final requestId = _productsRequestId;
    emit(_buildProductsLoaded()); // surfaces the load-more spinner

    final result = await getGiftCardProductsUseCase(
      GetGiftCardProductsParams(
        categoryId: _productsCategoryId,
        searchTerm: _productsSearchTerm,
        pageNumber: _productsPage + 1,
      ),
    );

    // A fresh load (new filters / refresh) superseded us mid-fetch — drop this
    // now-stale page instead of appending it to a different list.
    if (requestId != _productsRequestId) return;

    _isLoadingMoreProducts = false;

    result.fold(
      // Keep what we already have; just drop the spinner so the user can retry
      // by scrolling again.
      (failure) => emit(_buildProductsLoaded()),
      (page) {
        _loadedProducts.addAll(page.items);
        _productsPage = page.pageNumber;
        _productsTotalCount = page.totalCount;
        _productsHasNextPage = page.hasNextPage;
        emit(_buildProductsLoaded());
      },
    );
  }

  GiftCardProductsLoaded _buildProductsLoaded() {
    return GiftCardProductsLoaded(
      List<GiftCardProductEntity>.unmodifiable(_loadedProducts),
      totalCount: _productsTotalCount,
      hasNextPage: _productsHasNextPage,
      isLoadingMore: _isLoadingMoreProducts,
    );
  }

  Future<void> _onLoadProduct(
    LoadGiftCardProduct event,
    Emitter<GiftCardsState> emit,
  ) async {
    emit(GiftCardProductLoading());

    final result = await giftCardRepository.getProduct(event.productId);

    result.fold(
      (failure) => emit(GiftCardProductError(FailureMessageMapper.mapFailureToMessage(failure))),
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
      quantity: event.quantity,
      pointType: event.pointType,
    );

    result.fold(
      (failure) => emit(PriceBreakdownError(FailureMessageMapper.mapFailureToMessage(failure))),
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
        quantity: event.quantity,
        themeSku: event.themeSku,
        pointType: event.pointType,
      ),
    );

    result.fold(
      (failure) => emit(GiftCardOrderError(FailureMessageMapper.mapFailureToMessage(failure))),
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
      quantity: event.quantity,
      themeSku: event.themeSku,
    );

    result.fold(
      (failure) => emit(GiftCardRazorpayOrderError(FailureMessageMapper.mapFailureToMessage(failure))),
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
      (failure) => emit(GiftCardPaymentError(FailureMessageMapper.mapFailureToMessage(failure))),
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
      (failure) => emit(GiftCardOrdersError(FailureMessageMapper.mapFailureToMessage(failure))),
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
