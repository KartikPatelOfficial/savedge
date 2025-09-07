import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/favorites/domain/entities/favorite_vendor.dart';
import 'package:savedge/features/favorites/domain/repositories/favorites_repository.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';

class AddFavoriteUseCase extends UseCase<void, AddFavoriteParams> {
  final FavoritesRepository repository;

  AddFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(AddFavoriteParams params) {
    final favoriteVendor = FavoriteVendor(
      id: 'fav_${params.vendor.id}_${DateTime.now().millisecondsSinceEpoch}',
      vendorId: params.vendor.id,
      businessName: params.vendor.businessName,
      category: params.vendor.category,
      description: params.vendor.description,
      imageUrl: params.vendor.images.isNotEmpty
          ? params.vendor.images
                .firstWhere(
                  (img) => img.isPrimary,
                  orElse: () => params.vendor.images.first,
                )
                .imageUrl
          : null,
      address: params.vendor.address,
      city: params.vendor.city,
      state: params.vendor.state,
      addedAt: DateTime.now(),
    );

    return repository.addFavorite(favoriteVendor);
  }
}

class AddFavoriteParams extends Equatable {
  final Vendor vendor;

  const AddFavoriteParams({required this.vendor});

  @override
  List<Object> get props => [vendor];
}
