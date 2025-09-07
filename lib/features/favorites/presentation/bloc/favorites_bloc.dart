import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/add_favorite_usecase.dart';
import '../../domain/usecases/check_favorite_usecase.dart';
import '../../domain/usecases/get_favorites_usecase.dart';
import '../../domain/usecases/remove_favorite_usecase.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  final AddFavoriteUseCase addFavoriteUseCase;
  final RemoveFavoriteUseCase removeFavoriteUseCase;
  final CheckFavoriteUseCase checkFavoriteUseCase;

  FavoritesBloc({
    required this.getFavoritesUseCase,
    required this.addFavoriteUseCase,
    required this.removeFavoriteUseCase,
    required this.checkFavoriteUseCase,
  }) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<CheckFavoriteStatus>(_onCheckFavoriteStatus);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    
    final result = await getFavoritesUseCase(NoParams());
    
    result.fold(
      (failure) => emit(FavoritesError(failure.toString())),
      (favorites) {
        final favoriteIds = favorites.map((f) => f.vendorId).toSet();
        emit(FavoritesLoaded(
          favorites: favorites,
          favoriteIds: favoriteIds,
        ));
      },
    );
  }

  Future<void> _onAddToFavorites(
    AddToFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final result = await addFavoriteUseCase(
      AddFavoriteParams(vendor: event.vendor),
    );
    
    result.fold(
      (failure) => emit(FavoritesError(failure.toString())),
      (_) => add(LoadFavorites()),
    );
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final result = await removeFavoriteUseCase(
      RemoveFavoriteParams(vendorId: event.vendorId),
    );
    
    result.fold(
      (failure) => emit(FavoritesError(failure.toString())),
      (_) => add(LoadFavorites()),
    );
  }

  Future<void> _onCheckFavoriteStatus(
    CheckFavoriteStatus event,
    Emitter<FavoritesState> emit,
  ) async {
    final result = await checkFavoriteUseCase(
      CheckFavoriteParams(vendorId: event.vendorId),
    );
    
    result.fold(
      (failure) => emit(FavoritesError(failure.toString())),
      (isFavorite) => emit(FavoriteStatusChecked(
        vendorId: event.vendorId,
        isFavorite: isFavorite,
      )),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    // Check current status
    final checkResult = await checkFavoriteUseCase(
      CheckFavoriteParams(vendorId: event.vendor.id),
    );
    
    await checkResult.fold(
      (failure) async => emit(FavoritesError(failure.toString())),
      (isFavorite) async {
        if (isFavorite) {
          // Remove from favorites
          final removeResult = await removeFavoriteUseCase(
            RemoveFavoriteParams(vendorId: event.vendor.id),
          );
          removeResult.fold(
            (failure) => emit(FavoritesError(failure.toString())),
            (_) => add(LoadFavorites()),
          );
        } else {
          // Add to favorites
          final addResult = await addFavoriteUseCase(
            AddFavoriteParams(vendor: event.vendor),
          );
          addResult.fold(
            (failure) => emit(FavoritesError(failure.toString())),
            (_) => add(LoadFavorites()),
          );
        }
      },
    );
  }
}