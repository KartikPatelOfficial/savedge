// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_vendor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FavoriteVendorModel {

@HiveField(0) String get id;@HiveField(1) int get vendorId;@HiveField(2) String get businessName;@HiveField(3) String get category;@HiveField(4) String? get description;@HiveField(5) String? get imageUrl;@HiveField(6) String? get address;@HiveField(7) String? get city;@HiveField(8) String? get state;@HiveField(9) DateTime get addedAt;
/// Create a copy of FavoriteVendorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteVendorModelCopyWith<FavoriteVendorModel> get copyWith => _$FavoriteVendorModelCopyWithImpl<FavoriteVendorModel>(this as FavoriteVendorModel, _$identity);

  /// Serializes this FavoriteVendorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteVendorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vendorId,businessName,category,description,imageUrl,address,city,state,addedAt);

@override
String toString() {
  return 'FavoriteVendorModel(id: $id, vendorId: $vendorId, businessName: $businessName, category: $category, description: $description, imageUrl: $imageUrl, address: $address, city: $city, state: $state, addedAt: $addedAt)';
}


}

/// @nodoc
abstract mixin class $FavoriteVendorModelCopyWith<$Res>  {
  factory $FavoriteVendorModelCopyWith(FavoriteVendorModel value, $Res Function(FavoriteVendorModel) _then) = _$FavoriteVendorModelCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) int vendorId,@HiveField(2) String businessName,@HiveField(3) String category,@HiveField(4) String? description,@HiveField(5) String? imageUrl,@HiveField(6) String? address,@HiveField(7) String? city,@HiveField(8) String? state,@HiveField(9) DateTime addedAt
});




}
/// @nodoc
class _$FavoriteVendorModelCopyWithImpl<$Res>
    implements $FavoriteVendorModelCopyWith<$Res> {
  _$FavoriteVendorModelCopyWithImpl(this._self, this._then);

  final FavoriteVendorModel _self;
  final $Res Function(FavoriteVendorModel) _then;

/// Create a copy of FavoriteVendorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? vendorId = null,Object? businessName = null,Object? category = null,Object? description = freezed,Object? imageUrl = freezed,Object? address = freezed,Object? city = freezed,Object? state = freezed,Object? addedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as int,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteVendorModel].
extension FavoriteVendorModelPatterns on FavoriteVendorModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteVendorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteVendorModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteVendorModel value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteVendorModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteVendorModel value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteVendorModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  int vendorId, @HiveField(2)  String businessName, @HiveField(3)  String category, @HiveField(4)  String? description, @HiveField(5)  String? imageUrl, @HiveField(6)  String? address, @HiveField(7)  String? city, @HiveField(8)  String? state, @HiveField(9)  DateTime addedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteVendorModel() when $default != null:
return $default(_that.id,_that.vendorId,_that.businessName,_that.category,_that.description,_that.imageUrl,_that.address,_that.city,_that.state,_that.addedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  int vendorId, @HiveField(2)  String businessName, @HiveField(3)  String category, @HiveField(4)  String? description, @HiveField(5)  String? imageUrl, @HiveField(6)  String? address, @HiveField(7)  String? city, @HiveField(8)  String? state, @HiveField(9)  DateTime addedAt)  $default,) {final _that = this;
switch (_that) {
case _FavoriteVendorModel():
return $default(_that.id,_that.vendorId,_that.businessName,_that.category,_that.description,_that.imageUrl,_that.address,_that.city,_that.state,_that.addedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  int vendorId, @HiveField(2)  String businessName, @HiveField(3)  String category, @HiveField(4)  String? description, @HiveField(5)  String? imageUrl, @HiveField(6)  String? address, @HiveField(7)  String? city, @HiveField(8)  String? state, @HiveField(9)  DateTime addedAt)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteVendorModel() when $default != null:
return $default(_that.id,_that.vendorId,_that.businessName,_that.category,_that.description,_that.imageUrl,_that.address,_that.city,_that.state,_that.addedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FavoriteVendorModel extends FavoriteVendorModel {
  const _FavoriteVendorModel({@HiveField(0) required this.id, @HiveField(1) required this.vendorId, @HiveField(2) required this.businessName, @HiveField(3) required this.category, @HiveField(4) this.description, @HiveField(5) this.imageUrl, @HiveField(6) this.address, @HiveField(7) this.city, @HiveField(8) this.state, @HiveField(9) required this.addedAt}): super._();
  factory _FavoriteVendorModel.fromJson(Map<String, dynamic> json) => _$FavoriteVendorModelFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  int vendorId;
@override@HiveField(2) final  String businessName;
@override@HiveField(3) final  String category;
@override@HiveField(4) final  String? description;
@override@HiveField(5) final  String? imageUrl;
@override@HiveField(6) final  String? address;
@override@HiveField(7) final  String? city;
@override@HiveField(8) final  String? state;
@override@HiveField(9) final  DateTime addedAt;

/// Create a copy of FavoriteVendorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteVendorModelCopyWith<_FavoriteVendorModel> get copyWith => __$FavoriteVendorModelCopyWithImpl<_FavoriteVendorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FavoriteVendorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteVendorModel&&(identical(other.id, id) || other.id == id)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,vendorId,businessName,category,description,imageUrl,address,city,state,addedAt);

@override
String toString() {
  return 'FavoriteVendorModel(id: $id, vendorId: $vendorId, businessName: $businessName, category: $category, description: $description, imageUrl: $imageUrl, address: $address, city: $city, state: $state, addedAt: $addedAt)';
}


}

/// @nodoc
abstract mixin class _$FavoriteVendorModelCopyWith<$Res> implements $FavoriteVendorModelCopyWith<$Res> {
  factory _$FavoriteVendorModelCopyWith(_FavoriteVendorModel value, $Res Function(_FavoriteVendorModel) _then) = __$FavoriteVendorModelCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) int vendorId,@HiveField(2) String businessName,@HiveField(3) String category,@HiveField(4) String? description,@HiveField(5) String? imageUrl,@HiveField(6) String? address,@HiveField(7) String? city,@HiveField(8) String? state,@HiveField(9) DateTime addedAt
});




}
/// @nodoc
class __$FavoriteVendorModelCopyWithImpl<$Res>
    implements _$FavoriteVendorModelCopyWith<$Res> {
  __$FavoriteVendorModelCopyWithImpl(this._self, this._then);

  final _FavoriteVendorModel _self;
  final $Res Function(_FavoriteVendorModel) _then;

/// Create a copy of FavoriteVendorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? vendorId = null,Object? businessName = null,Object? category = null,Object? description = freezed,Object? imageUrl = freezed,Object? address = freezed,Object? city = freezed,Object? state = freezed,Object? addedAt = null,}) {
  return _then(_FavoriteVendorModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as int,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
