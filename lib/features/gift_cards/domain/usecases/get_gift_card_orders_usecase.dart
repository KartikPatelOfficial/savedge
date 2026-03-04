import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/gift_card_entity.dart';
import '../repositories/gift_card_repository.dart';

@injectable
class GetGiftCardOrdersUseCase
    implements UseCase<List<GiftCardOrderEntity>, GetGiftCardOrdersParams> {
  final GiftCardRepository repository;

  GetGiftCardOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, List<GiftCardOrderEntity>>> call(
    GetGiftCardOrdersParams params,
  ) async {
    return await repository.getOrders(
      status: params.status,
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
    );
  }
}

class GetGiftCardOrdersParams extends Equatable {
  final GiftCardOrderStatusEntity? status;
  final int pageNumber;
  final int pageSize;

  const GetGiftCardOrdersParams({
    this.status,
    this.pageNumber = 1,
    this.pageSize = 20,
  });

  @override
  List<Object?> get props => [status, pageNumber, pageSize];
}
