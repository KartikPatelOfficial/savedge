import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/vendor.dart';
import '../../domain/repositories/vendors_repository.dart';
import '../datasources/vendors_remote_data_source.dart';
import '../models/vendor_models.dart';

class VendorsRepositoryImpl implements VendorsRepository {
  const VendorsRepositoryImpl({required this.remoteDataSource});

  final VendorsRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<Vendor>>> getVendors({
    int pageNumber = 1,
    int pageSize = 10,
    String? searchTerm,
    String? category,
    String? businessType,
    bool? isApproved = true,
    bool? isActive = true,
  }) async {
    try {
      final response = await remoteDataSource.getVendors(
        pageNumber: pageNumber,
        pageSize: pageSize,
        searchTerm: searchTerm,
        category: category,
        businessType: businessType,
        isApproved: isApproved,
        isActive: isActive,
      );

      // Parse the response data
      final data = response.data;
      if (data is Map<String, dynamic>) {
        final items = data['items'] as List<dynamic>? ?? [];
        final vendors = items
            .map(
              (item) => _mapVendorResponseToEntity(
                VendorResponse.fromJson(item as Map<String, dynamic>),
              ),
            )
            .toList();
        return Right(vendors);
      } else if (data is List<dynamic>) {
        final vendors = data
            .map(
              (item) => _mapVendorResponseToEntity(
                VendorResponse.fromJson(item as Map<String, dynamic>),
              ),
            )
            .toList();
        return Right(vendors);
      } else {
        return const Left(ServerFailure('Invalid response format'));
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Vendor>> getVendor(int id) async {
    try {
      final response = await remoteDataSource.getVendor(id);
      final vendor = _mapVendorResponseToEntity(response.data);
      return Right(vendor);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VendorImage>>> getVendorImages(
    int vendorId,
  ) async {
    try {
      final response = await remoteDataSource.getVendorImages(vendorId);
      final images = response.data
          .map((imageDto) => _mapVendorImageDtoToEntity(imageDto))
          .toList();
      return Right(images);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Vendor _mapVendorResponseToEntity(VendorResponse response) {
    return Vendor(
      id: response.id,
      businessName: response.businessName,
      description: response.description,
      contactEmail: response.contactEmail,
      contactPhone: response.contactPhone,
      address: response.address,
      city: response.city,
      state: response.state,
      pinCode: response.pinCode,
      category: response.category,
      website: response.website,
      approvalStatus: response.approvalStatus,
      isActive: response.isActive,
      approvedAt: response.approvedAt,
      approvedBy: response.approvedBy,
      createdAt: response.createdAt,
      firebaseUid: response.firebaseUid,
      vendorFirstName: response.vendorFirstName,
      vendorLastName: response.vendorLastName,
      vendorFullName: response.vendorFullName,
      images: response.images.map(_mapVendorImageDtoToEntity).toList(),
      socialMediaLinks: response.socialMediaLinks
          .map(_mapVendorSocialMediaDtoToEntity)
          .toList(),
      // Add some mock data for UI
      rating: 4.5 + (response.id % 10) * 0.05,
      // Mock rating between 4.5-4.95
      averagePrice: 500 + (response.id % 5) * 100,
      // Mock price between 500-900
      isOpen: true,
      openingHours: '11:00 AM',
      closingHours: '3:00 PM',
    );
  }

  VendorImage _mapVendorImageDtoToEntity(VendorImageDto dto) {
    return VendorImage(
      id: dto.id,
      imageUrl: dto.imageUrl,
      altText: dto.altText,
      displayOrder: dto.displayOrder,
      isPrimary: dto.isPrimary,
      imageType: dto.imageTypeName,
      imageTypeName: dto.imageTypeName,
    );
  }

  VendorSocialMedia _mapVendorSocialMediaDtoToEntity(VendorSocialMediaDto dto) {
    return VendorSocialMedia(
      id: dto.id,
      platform: dto.platformName,
      platformName: dto.platformName,
      url: dto.url,
      isActive: dto.isActive,
    );
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 404) {
          return const NotFoundFailure('Vendor not found');
        } else if (statusCode == 401) {
          return const AuthFailure('Unauthorized access');
        } else {
          return ServerFailure(
            'Server error: ${error.response?.statusMessage}',
          );
        }
      case DioExceptionType.cancel:
        return const NetworkFailure('Request cancelled');
      case DioExceptionType.unknown:
      default:
        return const NetworkFailure('Network error occurred');
    }
  }
}
