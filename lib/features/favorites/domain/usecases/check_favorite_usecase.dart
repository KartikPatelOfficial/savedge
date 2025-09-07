import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/favorites/domain/repositories/favorites_repository.dart';

class CheckFavoriteUseCase extends UseCase<bool, CheckFavoriteParams> {
  final FavoritesRepository repository;

  CheckFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(CheckFavoriteParams params) {
    return repository.isFavorite(params.vendorId);
  }
}

class CheckFavoriteParams extends Equatable {
  final int vendorId;

  const CheckFavoriteParams({required this.vendorId});

  @override
  List<Object> get props => [vendorId];
}
