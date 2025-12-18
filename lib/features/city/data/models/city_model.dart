import 'package:json_annotation/json_annotation.dart';
import 'package:savedge/features/city/domain/entities/city.dart';

part 'city_model.g.dart';

/// City data transfer object
@JsonSerializable()
class CityModel {
  const CityModel({
    required this.id,
    required this.name,
    required this.state,
    required this.displayName,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  final int id;
  final String name;
  final String state;
  final String displayName;

  Map<String, dynamic> toJson() => _$CityModelToJson(this);

  /// Convert to domain entity
  City toEntity() => City(
        id: id,
        name: name,
        state: state,
        displayName: displayName,
      );
}
