import 'package:freezed_annotation/freezed_annotation.dart';

part 'vendor_models.freezed.dart';
part 'vendor_models.g.dart';

/// Vendor response model
@freezed
abstract class VendorResponse with _$VendorResponse {
  const factory VendorResponse({
    required int id,
    String? vendorUserId,
    required String businessName,
    String? description,
    String? contactEmail,
    String? contactPhone,
    String? address,
    String? city,
    String? state,
    String? pinCode,
    required String category,
    String? website,
    @Default('Approved') String approvalStatus,
    required bool isActive,
    DateTime? approvedAt,
    String? approvedBy,
    DateTime? createdAt,
    @Default([]) List<VendorImageDto> images,
    @Default([]) List<VendorSocialMediaDto> socialMediaLinks,
  }) = _VendorResponse;

  factory VendorResponse.fromJson(Map<String, dynamic> json) =>
      _$VendorResponseFromJson(json);
}

/// Vendor image DTO
@freezed
abstract class VendorImageDto with _$VendorImageDto {
  const factory VendorImageDto({
    @Default(0) int id,
    required String imageUrl,
    String? altText,
    @Default(0) int displayOrder,
    required bool isPrimary,
    @Default(ImageType.gallery) ImageType imageType,
    @Default('Gallery') String imageTypeName,
  }) = _VendorImageDto;

  factory VendorImageDto.fromJson(Map<String, dynamic> json) =>
      _$VendorImageDtoFromJson(json);
}

/// Vendor social media DTO
@freezed
abstract class VendorSocialMediaDto with _$VendorSocialMediaDto {
  const factory VendorSocialMediaDto({
    @Default(0) int id,
    SocialMediaPlatform? platform,
    String? platformName,
    required String url,
    @Default(true) bool isActive,
  }) = _VendorSocialMediaDto;

  factory VendorSocialMediaDto.fromJson(Map<String, dynamic> json) =>
      _$VendorSocialMediaDtoFromJson(json);
}

/// Image type enum
enum ImageType {
  @JsonValue(1)
  logo,
  @JsonValue(2)
  gallery,
  @JsonValue(3)
  banner,
  @JsonValue(4)
  menu,
  @JsonValue(5)
  interior,
  @JsonValue(6)
  exterior,
  @JsonValue(7)
  product,
  @JsonValue(8)
  other,
}

/// Social media platform enum
enum SocialMediaPlatform {
  @JsonValue(1)
  instagram,
  @JsonValue(2)
  facebook,
  @JsonValue(3)
  twitter,
  @JsonValue(4)
  linkedin,
  @JsonValue(5)
  youtube,
  @JsonValue(6)
  googleMaps,
  @JsonValue(7)
  whatsApp,
  @JsonValue(8)
  other,
}

/// Paginated vendors response
@freezed
abstract class PaginatedVendorsResponse with _$PaginatedVendorsResponse {
  const factory PaginatedVendorsResponse({
    required List<VendorResponse> items,
    required int totalCount,
    required int pageNumber,
    required int pageSize,
    required int totalPages,
    required bool hasNextPage,
    required bool hasPreviousPage,
  }) = _PaginatedVendorsResponse;

  factory PaginatedVendorsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedVendorsResponseFromJson(json);
}
