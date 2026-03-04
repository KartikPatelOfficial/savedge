import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/gift_card_entity.dart';
import '../repositories/gift_card_repository.dart';

@injectable
class CreateGiftCardOrderUseCase
    implements UseCase<GiftCardOrderEntity, CreateGiftCardOrderParams> {
  final GiftCardRepository repository;

  CreateGiftCardOrderUseCase(this.repository);

  @override
  Future<Either<Failure, GiftCardOrderEntity>> call(
    CreateGiftCardOrderParams params,
  ) async {
    return await repository.createOrder(
      giftCardProductId: params.giftCardProductId,
      amount: params.amount,
      paymentMethod: params.paymentMethod,
    );
  }
}

class CreateGiftCardOrderParams extends Equatable {
  final int giftCardProductId;
  final double amount;
  final GiftCardPaymentMethodEntity paymentMethod;

  const CreateGiftCardOrderParams({
    required this.giftCardProductId,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  List<Object> get props => [giftCardProductId, amount, paymentMethod];
}
