import 'package:dartz/dartz.dart';
import 'package:savedge/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/favorite_vendor.dart';
import '../repositories/favorites_repository.dart';

class GetFavoritesUseCase extends UseCase<List<FavoriteVendor>, NoParams> {
  final FavoritesRepository repository;

  GetFavoritesUseCase(this.repository);

  @override
  Future<Either<Failure, List<FavoriteVendor>>> call(NoParams params) {
    return repository.getFavorites();
  }
}
