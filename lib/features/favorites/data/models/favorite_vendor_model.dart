import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/favorite_vendor.dart';

part 'favorite_vendor_model.freezed.dart';
part 'favorite_vendor_model.g.dart';

@freezed
@HiveType(typeId: 10)
abstract class FavoriteVendorModel with _$FavoriteVendorModel {
  const factory FavoriteVendorModel({
    @HiveField(0) required String id,
    @HiveField(1) required int vendorId,
    @HiveField(2) required String businessName,
    @HiveField(3) required String category,
    @HiveField(4) String? description,
    @HiveField(5) String? imageUrl,
    @HiveField(6) String? address,
    @HiveField(7) String? city,
    @HiveField(8) String? state,
    @HiveField(9) required DateTime addedAt,
  }) = _FavoriteVendorModel;

  const FavoriteVendorModel._();

  factory FavoriteVendorModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteVendorModelFromJson(json);

  factory FavoriteVendorModel.fromEntity(FavoriteVendor entity) {
    return FavoriteVendorModel(
      id: entity.id,
      vendorId: entity.vendorId,
      businessName: entity.businessName,
      category: entity.category,
      description: entity.description,
      imageUrl: entity.imageUrl,
      address: entity.address,
      city: entity.city,
      state: entity.state,
      addedAt: entity.addedAt,
    );
  }

  FavoriteVendor toEntity() {
    return FavoriteVendor(
      id: id,
      vendorId: vendorId,
      businessName: businessName,
      category: category,
      description: description,
      imageUrl: imageUrl,
      address: address,
      city: city,
      state: state,
      addedAt: addedAt,
    );
  }
}
