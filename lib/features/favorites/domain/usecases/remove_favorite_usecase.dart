import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savedge/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/favorites_repository.dart';

class RemoveFavoriteUseCase extends UseCase<void, RemoveFavoriteParams> {
  final FavoritesRepository repository;

  RemoveFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RemoveFavoriteParams params) {
    return repository.removeFavorite(params.vendorId);
  }
}

class RemoveFavoriteParams extends Equatable {
  final int vendorId;

  const RemoveFavoriteParams({required this.vendorId});

  @override
  List<Object> get props => [vendorId];
}
