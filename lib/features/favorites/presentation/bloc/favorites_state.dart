import 'package:equatable/equatable.dart';
import '../../domain/entities/favorite_vendor.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<FavoriteVendor> favorites;
  final Set<int> favoriteIds;

  const FavoritesLoaded({
    required this.favorites,
    required this.favoriteIds,
  });

  @override
  List<Object?> get props => [favorites, favoriteIds];

  bool isFavorite(int vendorId) => favoriteIds.contains(vendorId);
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoriteStatusChecked extends FavoritesState {
  final int vendorId;
  final bool isFavorite;

  const FavoriteStatusChecked({
    required this.vendorId,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [vendorId, isFavorite];
}