import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:savedge/core/utils/failure_message_mapper.dart';
import 'package:savedge/features/gift_cards/domain/entities/gift_card_entity.dart';
import 'package:savedge/features/gift_cards/domain/repositories/gift_card_repository.dart';

/// State for the paginated "all gift vouchers" catalog page.
///
/// Unlike [GiftCardProductsLoaded] on the landing page (which holds a single,
/// non-paginated batch), this state grows as the user scrolls and the cubit
/// appends additional pages.
class GiftCardCatalogState extends Equatable {
  const GiftCardCatalogState({
    this.products = const [],
    this.categories = const [],
    this.isInitialLoading = true,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.errorMessage,
    this.searchTerm,
    this.categoryId,
  });

  final List<GiftCardProductEntity> products;
  final List<GiftCardCategoryEntity> categories;
  final bool isInitialLoading;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final String? errorMessage;
  final String? searchTerm;
  final int? categoryId;

  bool get isEmpty => !isInitialLoading && products.isEmpty;

  static const Object _sentinel = Object();

  GiftCardCatalogState copyWith({
    List<GiftCardProductEntity>? products,
    List<GiftCardCategoryEntity>? categories,
    bool? isInitialLoading,
    bool? isLoadingMore,
    bool? hasReachedMax,
    Object? errorMessage = _sentinel,
    Object? searchTerm = _sentinel,
    Object? categoryId = _sentinel,
  }) {
    return GiftCardCatalogState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage:
          errorMessage == _sentinel ? this.errorMessage : errorMessage as String?,
      searchTerm: searchTerm == _sentinel ? this.searchTerm : searchTerm as String?,
      categoryId: categoryId == _sentinel ? this.categoryId : categoryId as int?,
    );
  }

  @override
  List<Object?> get props => [
        products,
        categories,
        isInitialLoading,
        isLoadingMore,
        hasReachedMax,
        errorMessage,
        searchTerm,
        categoryId,
      ];
}

/// Drives the infinite-scroll catalog: fetches one [_pageSize] page at a time
/// and appends results until the backend returns a short page (end reached).
class GiftCardCatalogCubit extends Cubit<GiftCardCatalogState> {
  GiftCardCatalogCubit(this._repository) : super(const GiftCardCatalogState());

  final GiftCardRepository _repository;

  static const int _pageSize = 20;
  int _nextPage = 1;
  bool _isFetching = false;

  /// Initial load. Categories are loaded in the background (non-critical).
  Future<void> start({int? categoryId}) async {
    emit(state.copyWith(categoryId: categoryId, isInitialLoading: true));
    _loadCategories();
    await _fetchFirstPage();
  }

  Future<void> setSearch(String? term) async {
    final normalized = (term ?? '').trim();
    final value = normalized.isEmpty ? null : normalized;
    if (value == state.searchTerm) return;
    emit(
      state.copyWith(
        searchTerm: value,
        products: const [],
        isInitialLoading: true,
        hasReachedMax: false,
        errorMessage: null,
      ),
    );
    await _fetchFirstPage();
  }

  Future<void> selectCategory(int? categoryId) async {
    if (categoryId == state.categoryId) return;
    emit(
      state.copyWith(
        categoryId: categoryId,
        products: const [],
        isInitialLoading: true,
        hasReachedMax: false,
        errorMessage: null,
      ),
    );
    await _fetchFirstPage();
  }

  Future<void> refresh() async {
    emit(state.copyWith(isInitialLoading: true, hasReachedMax: false));
    _loadCategories();
    await _fetchFirstPage();
  }

  Future<void> loadMore() async {
    if (_isFetching ||
        state.hasReachedMax ||
        state.isInitialLoading ||
        state.products.isEmpty) {
      return;
    }
    _isFetching = true;
    emit(state.copyWith(isLoadingMore: true));

    final result = await _repository.getProducts(
      categoryId: state.categoryId,
      searchTerm: state.searchTerm,
      pageNumber: _nextPage,
      pageSize: _pageSize,
    );

    result.fold(
      (failure) => emit(state.copyWith(isLoadingMore: false)),
      (products) {
        _nextPage += 1;
        emit(
          state.copyWith(
            products: [...state.products, ...products],
            isLoadingMore: false,
            hasReachedMax: products.length < _pageSize,
          ),
        );
      },
    );
    _isFetching = false;
  }

  Future<void> _fetchFirstPage() async {
    _isFetching = true;
    _nextPage = 1;

    final result = await _repository.getProducts(
      categoryId: state.categoryId,
      searchTerm: state.searchTerm,
      pageNumber: _nextPage,
      pageSize: _pageSize,
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isInitialLoading: false,
          isLoadingMore: false,
          errorMessage: FailureMessageMapper.mapFailureToMessage(failure),
        ),
      ),
      (products) {
        _nextPage = 2;
        emit(
          state.copyWith(
            products: products,
            isInitialLoading: false,
            isLoadingMore: false,
            hasReachedMax: products.length < _pageSize,
            errorMessage: null,
          ),
        );
      },
    );
    _isFetching = false;
  }

  Future<void> _loadCategories() async {
    final result = await _repository.getCategories();
    result.fold(
      (_) {},
      (categories) => emit(state.copyWith(categories: categories)),
    );
  }
}
