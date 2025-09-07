import 'package:dartz/dartz.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/favorites/data/datasources/favorites_local_datasource.dart';
import 'package:savedge/features/favorites/data/models/favorite_vendor_model.dart';
import 'package:savedge/features/favorites/domain/entities/favorite_vendor.dart';
import 'package:savedge/features/favorites/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<FavoriteVendor>>> getFavorites() async {
    try {
      final favoriteModels = await localDataSource.getFavorites();
      final favorites = favoriteModels
          .map((model) => model.toEntity())
          .toList();
      return Right(favorites);
    } catch (e) {
      return Left(CacheFailure('Failed to get favorites: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> addFavorite(FavoriteVendor vendor) async {
    try {
      final model = FavoriteVendorModel.fromEntity(vendor);
      await localDataSource.addFavorite(model);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to add favorite: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavorite(int vendorId) async {
    try {
      await localDataSource.removeFavorite(vendorId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to remove favorite: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(int vendorId) async {
    try {
      final isFav = await localDataSource.isFavorite(vendorId);
      return Right(isFav);
    } catch (e) {
      return Left(
        CacheFailure('Failed to check favorite status: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> clearAllFavorites() async {
    try {
      await localDataSource.clearAllFavorites();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to clear favorites: ${e.toString()}'));
    }
  }
}
