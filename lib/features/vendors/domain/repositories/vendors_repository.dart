import 'package:dartz/dartz.dart';

import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/vendors/domain/entities/vendor.dart';

abstract class VendorsRepository {
  Future<Either<Failure, List<Vendor>>> getVendors({
    int pageNumber = 1,
    int pageSize = 10,
    String? searchTerm,
    String? category,
    String? businessType,
    bool? isApproved = true,
    bool? isActive = true,
    int? cityId,
  });

  Future<Either<Failure, Vendor>> getVendor(int id);

  Future<Either<Failure, List<VendorImage>>> getVendorImages(int vendorId);

  Future<Either<Failure, List<Vendor>>> getTopOfferVendors({int? cityId});
}
