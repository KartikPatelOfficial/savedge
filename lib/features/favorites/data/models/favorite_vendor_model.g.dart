// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_vendor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FavoriteVendorModel _$FavoriteVendorModelFromJson(Map<String, dynamic> json) =>
    _FavoriteVendorModel(
      id: json['id'] as String,
      vendorId: (json['vendorId'] as num).toInt(),
      businessName: json['businessName'] as String,
      category: json['category'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      addedAt: DateTime.parse(json['addedAt'] as String),
    );

Map<String, dynamic> _$FavoriteVendorModelToJson(
  _FavoriteVendorModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'vendorId': instance.vendorId,
  'businessName': instance.businessName,
  'category': instance.category,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'address': instance.address,
  'city': instance.city,
  'state': instance.state,
  'addedAt': instance.addedAt.toIso8601String(),
};
