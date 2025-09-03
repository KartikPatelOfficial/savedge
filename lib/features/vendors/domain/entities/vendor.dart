import 'package:equatable/equatable.dart';

/// Import the coupon entity
// TODO: Uncomment when coupon entity is properly set up
// import 'coupon.dart';

/// Vendor domain entity
class Vendor extends Equatable {
  const Vendor({
    required this.id,
    required this.businessName,
    this.description,
    required this.contactEmail,
    this.contactPhone,
    this.address,
    this.city,
    this.state,
    this.pinCode,
    required this.category,
    this.website,
    required this.approvalStatus,
    required this.isActive,
    this.approvedAt,
    this.approvedBy,
    required this.createdAt,
    // Removed Firebase/vendor personal fields per backend DTO update
    this.images = const [],
    this.socialMediaLinks = const [],
    // this.coupons = const [], // TODO: Uncomment when coupon entity is ready
    this.rating,
    this.averagePrice,
    this.isOpen,
    this.openingHours,
    this.closingHours,
  });

  final int id;
  final String businessName;
  final String? description;
  final String contactEmail;
  final String? contactPhone;
  final String? address;
  final String? city;
  final String? state;
  final String? pinCode;
  final String category;
  final String? website;
  final String approvalStatus;
  final bool isActive;
  final DateTime? approvedAt;
  final String? approvedBy;
  final DateTime createdAt;
  final List<VendorImage> images;
  final List<VendorSocialMedia> socialMediaLinks;
  // final List<Coupon> coupons; // TODO: Uncomment when coupon entity is ready

  // Additional computed properties for UI
  final double? rating;
  final int? averagePrice;
  final bool? isOpen;
  final String? openingHours;
  final String? closingHours;

  /// Get primary image URL
  String? get primaryImageUrl {
    final primaryImage = images.where((img) => img.isPrimary).firstOrNull;
    return primaryImage?.imageUrl ?? images.firstOrNull?.imageUrl;
  }

  /// Get full address string
  String get fullAddress {
    final addressParts = <String>[];
    if (address?.isNotEmpty == true) addressParts.add(address!);
    if (city?.isNotEmpty == true) addressParts.add(city!);
    if (state?.isNotEmpty == true) addressParts.add(state!);
    if (pinCode?.isNotEmpty == true) addressParts.add(pinCode!);
    return addressParts.join(', ');
  }

  /// Check if vendor is currently open
  bool get isCurrentlyOpen {
    if (isOpen != null) return isOpen!;
    // You can add time-based logic here
    return true; // Default to open
  }

  /// Get average price display
  String get averagePriceDisplay {
    if (averagePrice == null) return '';
    return '₹$averagePrice Avg. For 2 Person';
  }

  /// Get rating display
  String get ratingDisplay {
    if (rating == null) return '0.0';
    return rating!.toStringAsFixed(1);
  }

  @override
  List<Object?> get props => [
    id,
    businessName,
    description,
    contactEmail,
    contactPhone,
    address,
    city,
    state,
    pinCode,
    category,
    website,
    approvalStatus,
    isActive,
    approvedAt,
    approvedBy,
    createdAt,
    images,
    socialMediaLinks,
    rating,
    averagePrice,
    isOpen,
    openingHours,
    closingHours,
  ];
}

/// Vendor image entity
class VendorImage extends Equatable {
  const VendorImage({
    required this.id,
    required this.imageUrl,
    this.altText,
    required this.displayOrder,
    required this.isPrimary,
    required this.imageType,
    required this.imageTypeName,
  });

  final int id;
  final String imageUrl;
  final String? altText;
  final int displayOrder;
  final bool isPrimary;
  final String imageType;
  final String imageTypeName;

  @override
  List<Object?> get props => [
    id,
    imageUrl,
    altText,
    displayOrder,
    isPrimary,
    imageType,
    imageTypeName,
  ];
}

/// Vendor social media entity
class VendorSocialMedia extends Equatable {
  const VendorSocialMedia({
    required this.id,
    required this.platform,
    required this.platformName,
    required this.url,
    required this.isActive,
  });

  final int id;
  final String platform;
  final String platformName;
  final String url;
  final bool isActive;

  @override
  List<Object?> get props => [id, platform, platformName, url, isActive];
}
