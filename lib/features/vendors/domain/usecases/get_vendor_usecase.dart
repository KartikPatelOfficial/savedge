import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/vendor.dart';
import '../repositories/vendors_repository.dart';

class GetVendorUseCase implements UseCase<Vendor, int> {
  const GetVendorUseCase(this.repository);

  final VendorsRepository repository;

  @override
  Future<Either<Failure, Vendor>> call(int vendorId) async {
    return repository.getVendor(vendorId);
  }
}
