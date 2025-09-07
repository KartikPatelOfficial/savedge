import 'package:dartz/dartz.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/favorites/domain/entities/favorite_vendor.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<FavoriteVendor>>> getFavorites();

  Future<Either<Failure, void>> addFavorite(FavoriteVendor vendor);

  Future<Either<Failure, void>> removeFavorite(int vendorId);

  Future<Either<Failure, bool>> isFavorite(int vendorId);

  Future<Either<Failure, void>> clearAllFavorites();
}
