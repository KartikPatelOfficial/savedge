import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/gift_card_entity.dart';
import '../repositories/gift_card_repository.dart';

@injectable
class GetGiftCardProductsUseCase
    implements UseCase<List<GiftCardProductEntity>, GetGiftCardProductsParams> {
  final GiftCardRepository repository;

  GetGiftCardProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<GiftCardProductEntity>>> call(
    GetGiftCardProductsParams params,
  ) async {
    return await repository.getProducts(
      categoryId: params.categoryId,
      searchTerm: params.searchTerm,
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
    );
  }
}

class GetGiftCardProductsParams extends Equatable {
  final int? categoryId;
  final String? searchTerm;
  final int pageNumber;
  final int pageSize;

  const GetGiftCardProductsParams({
    this.categoryId,
    this.searchTerm,
    this.pageNumber = 1,
    this.pageSize = 20,
  });

  @override
  List<Object?> get props => [categoryId, searchTerm, pageNumber, pageSize];
}
