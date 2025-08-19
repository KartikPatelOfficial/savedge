import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/brand_voucher_repository.dart';

@injectable
class CreateVoucherOrderUseCase
    implements UseCase<int, CreateVoucherOrderParams> {
  final BrandVoucherRepository repository;

  CreateVoucherOrderUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(CreateVoucherOrderParams params) async {
    return await repository.createVoucherOrder(
      userId: params.userId,
      brandVoucherId: params.brandVoucherId,
      voucherAmount: params.voucherAmount,
    );
  }
}

class CreateVoucherOrderParams extends Equatable {
  final String userId;
  final int brandVoucherId;
  final double voucherAmount;

  const CreateVoucherOrderParams({
    required this.userId,
    required this.brandVoucherId,
    required this.voucherAmount,
  });

  @override
  List<Object> get props => [userId, brandVoucherId, voucherAmount];
}