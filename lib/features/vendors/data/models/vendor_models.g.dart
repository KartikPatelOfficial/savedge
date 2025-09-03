// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VendorResponse _$VendorResponseFromJson(Map<String, dynamic> json) =>
    _VendorResponse(
      id: (json['id'] as num).toInt(),
      businessName: json['businessName'] as String,
      description: json['description'] as String?,
      contactEmail: json['contactEmail'] as String?,
      contactPhone: json['contactPhone'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      pinCode: json['pinCode'] as String?,
      category: json['category'] as String,
      website: json['website'] as String?,
      approvalStatus: json['approvalStatus'] as String? ?? 'Approved',
      isActive: json['isActive'] as bool,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      approvedBy: json['approvedBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => VendorImageDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      socialMediaLinks:
          (json['socialMediaLinks'] as List<dynamic>?)
              ?.map(
                (e) => VendorSocialMediaDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$VendorResponseToJson(_VendorResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'businessName': instance.businessName,
      'description': instance.description,
      'contactEmail': instance.contactEmail,
      'contactPhone': instance.contactPhone,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'pinCode': instance.pinCode,
      'category': instance.category,
      'website': instance.website,
      'approvalStatus': instance.approvalStatus,
      'isActive': instance.isActive,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'approvedBy': instance.approvedBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'images': instance.images,
      'socialMediaLinks': instance.socialMediaLinks,
    };

_VendorImageDto _$VendorImageDtoFromJson(Map<String, dynamic> json) =>
    _VendorImageDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      imageUrl: json['imageUrl'] as String,
      altText: json['altText'] as String?,
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
      isPrimary: json['isPrimary'] as bool,
      imageType:
          $enumDecodeNullable(_$ImageTypeEnumMap, json['imageType']) ??
          ImageType.gallery,
      imageTypeName: json['imageTypeName'] as String? ?? 'Gallery',
    );

Map<String, dynamic> _$VendorImageDtoToJson(_VendorImageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'altText': instance.altText,
      'displayOrder': instance.displayOrder,
      'isPrimary': instance.isPrimary,
      'imageType': _$ImageTypeEnumMap[instance.imageType]!,
      'imageTypeName': instance.imageTypeName,
    };

const _$ImageTypeEnumMap = {
  ImageType.logo: 1,
  ImageType.gallery: 2,
  ImageType.banner: 3,
  ImageType.menu: 4,
  ImageType.interior: 5,
  ImageType.exterior: 6,
  ImageType.product: 7,
  ImageType.other: 8,
};

_VendorSocialMediaDto _$VendorSocialMediaDtoFromJson(
  Map<String, dynamic> json,
) => _VendorSocialMediaDto(
  id: (json['id'] as num?)?.toInt() ?? 0,
  platform: $enumDecodeNullable(_$SocialMediaPlatformEnumMap, json['platform']),
  platformName: json['platformName'] as String?,
  url: json['url'] as String,
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$VendorSocialMediaDtoToJson(
  _VendorSocialMediaDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'platform': _$SocialMediaPlatformEnumMap[instance.platform],
  'platformName': instance.platformName,
  'url': instance.url,
  'isActive': instance.isActive,
};

const _$SocialMediaPlatformEnumMap = {
  SocialMediaPlatform.instagram: 1,
  SocialMediaPlatform.facebook: 2,
  SocialMediaPlatform.twitter: 3,
  SocialMediaPlatform.linkedin: 4,
  SocialMediaPlatform.youtube: 5,
  SocialMediaPlatform.googleMaps: 6,
  SocialMediaPlatform.whatsApp: 7,
  SocialMediaPlatform.other: 8,
};

_PaginatedVendorsResponse _$PaginatedVendorsResponseFromJson(
  Map<String, dynamic> json,
) => _PaginatedVendorsResponse(
  items: (json['items'] as List<dynamic>)
      .map((e) => VendorResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num).toInt(),
  pageNumber: (json['pageNumber'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasNextPage: json['hasNextPage'] as bool,
  hasPreviousPage: json['hasPreviousPage'] as bool,
);

Map<String, dynamic> _$PaginatedVendorsResponseToJson(
  _PaginatedVendorsResponse instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPreviousPage': instance.hasPreviousPage,
};
