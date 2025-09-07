import 'package:equatable/equatable.dart';
import '../../../vendors/domain/entities/vendor.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {}

class AddToFavorites extends FavoritesEvent {
  final Vendor vendor;

  const AddToFavorites(this.vendor);

  @override
  List<Object?> get props => [vendor];
}

class RemoveFromFavorites extends FavoritesEvent {
  final int vendorId;

  const RemoveFromFavorites(this.vendorId);

  @override
  List<Object?> get props => [vendorId];
}

class CheckFavoriteStatus extends FavoritesEvent {
  final int vendorId;

  const CheckFavoriteStatus(this.vendorId);

  @override
  List<Object?> get props => [vendorId];
}

class ToggleFavorite extends FavoritesEvent {
  final Vendor vendor;

  const ToggleFavorite(this.vendor);

  @override
  List<Object?> get props => [vendor];
}

class ClearAllFavorites extends FavoritesEvent {}