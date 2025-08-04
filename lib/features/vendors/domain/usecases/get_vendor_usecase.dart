import 'package:dartz/dartz.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/core/usecases/usecase.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/domain/repositories/vendors_repository.dart';

class GetVendorUseCase implements UseCase<Vendor, int> {
  const GetVendorUseCase(this.repository);

  final VendorsRepository repository;

  @override
  Future<Either<Failure, Vendor>> call(int vendorId) async {
    return repository.getVendor(vendorId);
  }
}
