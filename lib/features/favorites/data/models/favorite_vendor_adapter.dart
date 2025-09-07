import 'package:hive/hive.dart';
import 'favorite_vendor_model.dart';

/// Manual Hive TypeAdapter for FavoriteVendorModel
/// Since we can't use hive_generator due to dependency conflicts,
/// we implement the adapter manually
class FavoriteVendorModelAdapter extends TypeAdapter<FavoriteVendorModel> {
  @override
  final int typeId = 10;

  @override
  FavoriteVendorModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteVendorModel(
      id: fields[0] as String,
      vendorId: fields[1] as int,
      businessName: fields[2] as String,
      category: fields[3] as String,
      description: fields[4] as String?,
      imageUrl: fields[5] as String?,
      address: fields[6] as String?,
      city: fields[7] as String?,
      state: fields[8] as String?,
      addedAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteVendorModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vendorId)
      ..writeByte(2)
      ..write(obj.businessName)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.address)
      ..writeByte(7)
      ..write(obj.city)
      ..writeByte(8)
      ..write(obj.state)
      ..writeByte(9)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteVendorModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}