import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:savedge/core/error/failures.dart';
import 'package:savedge/features/vendors/data/datasources/vendors_remote_data_source.dart';
import 'package:savedge/features/vendors/data/models/coupon_models.dart';
import 'package:savedge/features/vendors/data/models/vendor_models.dart';
import 'package:savedge/features/vendors/domain/entities/coupon.dart' as domain;
import 'package:savedge/features/vendors/domain/entities/vendor.dart';
import 'package:savedge/features/vendors/domain/repositories/vendors_repository.dart';

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
      // Try to parse coupons from raw response payload if present
      List<domain.Coupon> coupons = const [];
      try {
        final raw = response.response.data;
        if (raw is Map<String, dynamic> && raw['coupons'] is List) {
          final items = (raw['coupons'] as List)
              .whereType<Map<String, dynamic>>()
              .map((j) => CouponResponse.fromJson(j))
              .map(_mapCouponResponseToEntity)
              .toList();
          coupons = items;
        }
      } catch (_) {
        // Ignore parsing issues; fallback stays empty
      }

      final vendor = _mapVendorResponseToEntity(
        response.data,
        coupons: coupons,
      );

      return Right(vendor);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e, stackTrace) {
      return Left(ServerFailure('Error: ${e.toString()}'));
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

  @override
  Future<Either<Failure, List<Vendor>>> getTopOfferVendors() async {
    try {
      final response = await remoteDataSource.getTopOfferVendors();
      
      // Parse the response data - expecting a direct list for top offers
      final data = response.data;
      if (data is List<dynamic>) {
        final vendors = data
            .map(
              (item) => _mapVendorResponseToEntity(
                VendorResponse.fromJson(item as Map<String, dynamic>),
              ),
            )
            .toList();
        return Right(vendors);
      } else {
        return const Left(ServerFailure('Invalid top offers response format'));
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Vendor _mapVendorResponseToEntity(
    VendorResponse response, {
    List<domain.Coupon> coupons = const [],
  }) {
    // Resolve vendor UID: prefer response.vendorUserId; else derive from coupons
    String resolvedVendorUid = (response.vendorUserId ?? '').trim();
    if (resolvedVendorUid.isEmpty) {
      for (final c in coupons) {
        final uid = c.vendorUserId.trim();
        if (uid.isNotEmpty) {
          resolvedVendorUid = uid;
          break;
        }
      }
    }

    return Vendor(
      id: response.id,
      vendorUserId: resolvedVendorUid,
      businessName: response.businessName,
      description: response.description,
      contactEmail: response.contactEmail ?? '',
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
      createdAt: response.createdAt ?? DateTime.now(),
      images: response.images.map(_mapVendorImageDtoToEntity).toList(),
      socialMediaLinks: response.socialMediaLinks
          .map(_mapVendorSocialMediaDtoToEntity)
          .toList(),
      coupons: coupons,
      // Use actual data from API, no fake values
    );
  }

  domain.Coupon _mapCouponResponseToEntity(CouponResponse dto) {
    // Debug: Log occasion data from API
    debugPrint('Mapping coupon: ${dto.title}');
    debugPrint('  DTO occasionType: ${dto.occasionType}');
    debugPrint('  DTO daysBeforeOccasion: ${dto.daysBeforeOccasion}');
    debugPrint('  DTO daysAfterOccasion: ${dto.daysAfterOccasion}');
    debugPrint('  DTO isOccasionBased: ${dto.isOccasionBased}');

    return domain.Coupon(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      discountValue: dto.discountValue,
      discountType: dto.discountType,
      minimumOrderAmount: dto.minimumOrderAmount,
      maximumDiscountAmount: dto.maximumDiscountAmount,
      validFrom: dto.validFrom,
      validTo: dto.validTo,
      vendorId: dto.vendorId,
      vendorUserId: dto.vendorUserId,
      status: dto.status,
      cashPrice: dto.cashPrice,
      termsAndConditions: dto.termsAndConditions,
      maxRedemptions: dto.maxRedemptions,
      totalClaimed: dto.totalClaimed,
      remainingClaims: dto.remainingClaims,
      isSpecialOffer: dto.isSpecialOffer,
      specialOfferStartDate: dto.specialOfferStartDate,
      specialOfferEndDate: dto.specialOfferEndDate,
      specialOfferPriority: dto.specialOfferPriority,
      specialOfferImageUrl: dto.specialOfferImageUrl,
      occasionType: dto.occasionType,
      daysBeforeOccasion: dto.daysBeforeOccasion,
      daysAfterOccasion: dto.daysAfterOccasion,
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
    // Map platform enum to integer value
    int platformValue;
    switch (dto.platform) {
      case SocialMediaPlatform.instagram:
        platformValue = 1;
        break;
      case SocialMediaPlatform.facebook:
        platformValue = 2;
        break;
      case SocialMediaPlatform.twitter:
        platformValue = 3;
        break;
      case SocialMediaPlatform.linkedin:
        platformValue = 4;
        break;
      case SocialMediaPlatform.youtube:
        platformValue = 5;
        break;
      case SocialMediaPlatform.googleMaps:
        platformValue = 6;
        break;
      case SocialMediaPlatform.whatsApp:
        platformValue = 7;
        break;
      case SocialMediaPlatform.other:
      default:
        platformValue = 8;
        break;
    }

    return VendorSocialMedia(
      id: dto.id,
      platform: platformValue,
      platformName: dto.platformName ?? 'Other',
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
