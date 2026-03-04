// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gift_card_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GiftCardCategory {

 int get id; String get name; String? get description; String? get imageUrl; bool get isActive; int get productCount; int? get parentCategoryId; List<GiftCardCategory> get subCategories;
/// Create a copy of GiftCardCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftCardCategoryCopyWith<GiftCardCategory> get copyWith => _$GiftCardCategoryCopyWithImpl<GiftCardCategory>(this as GiftCardCategory, _$identity);

  /// Serializes this GiftCardCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftCardCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.productCount, productCount) || other.productCount == productCount)&&(identical(other.parentCategoryId, parentCategoryId) || other.parentCategoryId == parentCategoryId)&&const DeepCollectionEquality().equals(other.subCategories, subCategories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,imageUrl,isActive,productCount,parentCategoryId,const DeepCollectionEquality().hash(subCategories));

@override
String toString() {
  return 'GiftCardCategory(id: $id, name: $name, description: $description, imageUrl: $imageUrl, isActive: $isActive, productCount: $productCount, parentCategoryId: $parentCategoryId, subCategories: $subCategories)';
}


}

/// @nodoc
abstract mixin class $GiftCardCategoryCopyWith<$Res>  {
  factory $GiftCardCategoryCopyWith(GiftCardCategory value, $Res Function(GiftCardCategory) _then) = _$GiftCardCategoryCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, String? imageUrl, bool isActive, int productCount, int? parentCategoryId, List<GiftCardCategory> subCategories
});




}
/// @nodoc
class _$GiftCardCategoryCopyWithImpl<$Res>
    implements $GiftCardCategoryCopyWith<$Res> {
  _$GiftCardCategoryCopyWithImpl(this._self, this._then);

  final GiftCardCategory _self;
  final $Res Function(GiftCardCategory) _then;

/// Create a copy of GiftCardCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? imageUrl = freezed,Object? isActive = null,Object? productCount = null,Object? parentCategoryId = freezed,Object? subCategories = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,productCount: null == productCount ? _self.productCount : productCount // ignore: cast_nullable_to_non_nullable
as int,parentCategoryId: freezed == parentCategoryId ? _self.parentCategoryId : parentCategoryId // ignore: cast_nullable_to_non_nullable
as int?,subCategories: null == subCategories ? _self.subCategories : subCategories // ignore: cast_nullable_to_non_nullable
as List<GiftCardCategory>,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftCardCategory].
extension GiftCardCategoryPatterns on GiftCardCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftCardCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftCardCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftCardCategory value)  $default,){
final _that = this;
switch (_that) {
case _GiftCardCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftCardCategory value)?  $default,){
final _that = this;
switch (_that) {
case _GiftCardCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  String? imageUrl,  bool isActive,  int productCount,  int? parentCategoryId,  List<GiftCardCategory> subCategories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftCardCategory() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.imageUrl,_that.isActive,_that.productCount,_that.parentCategoryId,_that.subCategories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  String? imageUrl,  bool isActive,  int productCount,  int? parentCategoryId,  List<GiftCardCategory> subCategories)  $default,) {final _that = this;
switch (_that) {
case _GiftCardCategory():
return $default(_that.id,_that.name,_that.description,_that.imageUrl,_that.isActive,_that.productCount,_that.parentCategoryId,_that.subCategories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  String? imageUrl,  bool isActive,  int productCount,  int? parentCategoryId,  List<GiftCardCategory> subCategories)?  $default,) {final _that = this;
switch (_that) {
case _GiftCardCategory() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.imageUrl,_that.isActive,_that.productCount,_that.parentCategoryId,_that.subCategories);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftCardCategory implements GiftCardCategory {
  const _GiftCardCategory({required this.id, required this.name, this.description, this.imageUrl, required this.isActive, required this.productCount, this.parentCategoryId, final  List<GiftCardCategory> subCategories = const []}): _subCategories = subCategories;
  factory _GiftCardCategory.fromJson(Map<String, dynamic> json) => _$GiftCardCategoryFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override final  String? imageUrl;
@override final  bool isActive;
@override final  int productCount;
@override final  int? parentCategoryId;
 final  List<GiftCardCategory> _subCategories;
@override@JsonKey() List<GiftCardCategory> get subCategories {
  if (_subCategories is EqualUnmodifiableListView) return _subCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subCategories);
}


/// Create a copy of GiftCardCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftCardCategoryCopyWith<_GiftCardCategory> get copyWith => __$GiftCardCategoryCopyWithImpl<_GiftCardCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftCardCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftCardCategory&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.productCount, productCount) || other.productCount == productCount)&&(identical(other.parentCategoryId, parentCategoryId) || other.parentCategoryId == parentCategoryId)&&const DeepCollectionEquality().equals(other._subCategories, _subCategories));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,imageUrl,isActive,productCount,parentCategoryId,const DeepCollectionEquality().hash(_subCategories));

@override
String toString() {
  return 'GiftCardCategory(id: $id, name: $name, description: $description, imageUrl: $imageUrl, isActive: $isActive, productCount: $productCount, parentCategoryId: $parentCategoryId, subCategories: $subCategories)';
}


}

/// @nodoc
abstract mixin class _$GiftCardCategoryCopyWith<$Res> implements $GiftCardCategoryCopyWith<$Res> {
  factory _$GiftCardCategoryCopyWith(_GiftCardCategory value, $Res Function(_GiftCardCategory) _then) = __$GiftCardCategoryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, String? imageUrl, bool isActive, int productCount, int? parentCategoryId, List<GiftCardCategory> subCategories
});




}
/// @nodoc
class __$GiftCardCategoryCopyWithImpl<$Res>
    implements _$GiftCardCategoryCopyWith<$Res> {
  __$GiftCardCategoryCopyWithImpl(this._self, this._then);

  final _GiftCardCategory _self;
  final $Res Function(_GiftCardCategory) _then;

/// Create a copy of GiftCardCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? imageUrl = freezed,Object? isActive = null,Object? productCount = null,Object? parentCategoryId = freezed,Object? subCategories = null,}) {
  return _then(_GiftCardCategory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,productCount: null == productCount ? _self.productCount : productCount // ignore: cast_nullable_to_non_nullable
as int,parentCategoryId: freezed == parentCategoryId ? _self.parentCategoryId : parentCategoryId // ignore: cast_nullable_to_non_nullable
as int?,subCategories: null == subCategories ? _self._subCategories : subCategories // ignore: cast_nullable_to_non_nullable
as List<GiftCardCategory>,
  ));
}


}


/// @nodoc
mixin _$GiftCardProduct {

 int get id; String get name; String? get description; String get sku; String? get imageUrl; String? get thumbnailUrl; double get minPrice; double get maxPrice; bool get isActive; String? get categoryName; String? get brandName; String? get denominations; String? get currencySymbol; String? get offerDescription; String? get formatExpiry; double? get discountPercentage;
/// Create a copy of GiftCardProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftCardProductCopyWith<GiftCardProduct> get copyWith => _$GiftCardProductCopyWithImpl<GiftCardProduct>(this as GiftCardProduct, _$identity);

  /// Serializes this GiftCardProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftCardProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.denominations, denominations) || other.denominations == denominations)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol)&&(identical(other.offerDescription, offerDescription) || other.offerDescription == offerDescription)&&(identical(other.formatExpiry, formatExpiry) || other.formatExpiry == formatExpiry)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,sku,imageUrl,thumbnailUrl,minPrice,maxPrice,isActive,categoryName,brandName,denominations,currencySymbol,offerDescription,formatExpiry,discountPercentage);

@override
String toString() {
  return 'GiftCardProduct(id: $id, name: $name, description: $description, sku: $sku, imageUrl: $imageUrl, thumbnailUrl: $thumbnailUrl, minPrice: $minPrice, maxPrice: $maxPrice, isActive: $isActive, categoryName: $categoryName, brandName: $brandName, denominations: $denominations, currencySymbol: $currencySymbol, offerDescription: $offerDescription, formatExpiry: $formatExpiry, discountPercentage: $discountPercentage)';
}


}

/// @nodoc
abstract mixin class $GiftCardProductCopyWith<$Res>  {
  factory $GiftCardProductCopyWith(GiftCardProduct value, $Res Function(GiftCardProduct) _then) = _$GiftCardProductCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, String sku, String? imageUrl, String? thumbnailUrl, double minPrice, double maxPrice, bool isActive, String? categoryName, String? brandName, String? denominations, String? currencySymbol, String? offerDescription, String? formatExpiry, double? discountPercentage
});




}
/// @nodoc
class _$GiftCardProductCopyWithImpl<$Res>
    implements $GiftCardProductCopyWith<$Res> {
  _$GiftCardProductCopyWithImpl(this._self, this._then);

  final GiftCardProduct _self;
  final $Res Function(GiftCardProduct) _then;

/// Create a copy of GiftCardProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? sku = null,Object? imageUrl = freezed,Object? thumbnailUrl = freezed,Object? minPrice = null,Object? maxPrice = null,Object? isActive = null,Object? categoryName = freezed,Object? brandName = freezed,Object? denominations = freezed,Object? currencySymbol = freezed,Object? offerDescription = freezed,Object? formatExpiry = freezed,Object? discountPercentage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,minPrice: null == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double,maxPrice: null == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,denominations: freezed == denominations ? _self.denominations : denominations // ignore: cast_nullable_to_non_nullable
as String?,currencySymbol: freezed == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String?,offerDescription: freezed == offerDescription ? _self.offerDescription : offerDescription // ignore: cast_nullable_to_non_nullable
as String?,formatExpiry: freezed == formatExpiry ? _self.formatExpiry : formatExpiry // ignore: cast_nullable_to_non_nullable
as String?,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftCardProduct].
extension GiftCardProductPatterns on GiftCardProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftCardProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftCardProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftCardProduct value)  $default,){
final _that = this;
switch (_that) {
case _GiftCardProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftCardProduct value)?  $default,){
final _that = this;
switch (_that) {
case _GiftCardProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  String sku,  String? imageUrl,  String? thumbnailUrl,  double minPrice,  double maxPrice,  bool isActive,  String? categoryName,  String? brandName,  String? denominations,  String? currencySymbol,  String? offerDescription,  String? formatExpiry,  double? discountPercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftCardProduct() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.sku,_that.imageUrl,_that.thumbnailUrl,_that.minPrice,_that.maxPrice,_that.isActive,_that.categoryName,_that.brandName,_that.denominations,_that.currencySymbol,_that.offerDescription,_that.formatExpiry,_that.discountPercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  String sku,  String? imageUrl,  String? thumbnailUrl,  double minPrice,  double maxPrice,  bool isActive,  String? categoryName,  String? brandName,  String? denominations,  String? currencySymbol,  String? offerDescription,  String? formatExpiry,  double? discountPercentage)  $default,) {final _that = this;
switch (_that) {
case _GiftCardProduct():
return $default(_that.id,_that.name,_that.description,_that.sku,_that.imageUrl,_that.thumbnailUrl,_that.minPrice,_that.maxPrice,_that.isActive,_that.categoryName,_that.brandName,_that.denominations,_that.currencySymbol,_that.offerDescription,_that.formatExpiry,_that.discountPercentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  String sku,  String? imageUrl,  String? thumbnailUrl,  double minPrice,  double maxPrice,  bool isActive,  String? categoryName,  String? brandName,  String? denominations,  String? currencySymbol,  String? offerDescription,  String? formatExpiry,  double? discountPercentage)?  $default,) {final _that = this;
switch (_that) {
case _GiftCardProduct() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.sku,_that.imageUrl,_that.thumbnailUrl,_that.minPrice,_that.maxPrice,_that.isActive,_that.categoryName,_that.brandName,_that.denominations,_that.currencySymbol,_that.offerDescription,_that.formatExpiry,_that.discountPercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftCardProduct implements GiftCardProduct {
  const _GiftCardProduct({required this.id, required this.name, this.description, required this.sku, this.imageUrl, this.thumbnailUrl, required this.minPrice, required this.maxPrice, required this.isActive, this.categoryName, this.brandName, this.denominations, this.currencySymbol, this.offerDescription, this.formatExpiry, this.discountPercentage});
  factory _GiftCardProduct.fromJson(Map<String, dynamic> json) => _$GiftCardProductFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override final  String sku;
@override final  String? imageUrl;
@override final  String? thumbnailUrl;
@override final  double minPrice;
@override final  double maxPrice;
@override final  bool isActive;
@override final  String? categoryName;
@override final  String? brandName;
@override final  String? denominations;
@override final  String? currencySymbol;
@override final  String? offerDescription;
@override final  String? formatExpiry;
@override final  double? discountPercentage;

/// Create a copy of GiftCardProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftCardProductCopyWith<_GiftCardProduct> get copyWith => __$GiftCardProductCopyWithImpl<_GiftCardProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftCardProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftCardProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.denominations, denominations) || other.denominations == denominations)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol)&&(identical(other.offerDescription, offerDescription) || other.offerDescription == offerDescription)&&(identical(other.formatExpiry, formatExpiry) || other.formatExpiry == formatExpiry)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,sku,imageUrl,thumbnailUrl,minPrice,maxPrice,isActive,categoryName,brandName,denominations,currencySymbol,offerDescription,formatExpiry,discountPercentage);

@override
String toString() {
  return 'GiftCardProduct(id: $id, name: $name, description: $description, sku: $sku, imageUrl: $imageUrl, thumbnailUrl: $thumbnailUrl, minPrice: $minPrice, maxPrice: $maxPrice, isActive: $isActive, categoryName: $categoryName, brandName: $brandName, denominations: $denominations, currencySymbol: $currencySymbol, offerDescription: $offerDescription, formatExpiry: $formatExpiry, discountPercentage: $discountPercentage)';
}


}

/// @nodoc
abstract mixin class _$GiftCardProductCopyWith<$Res> implements $GiftCardProductCopyWith<$Res> {
  factory _$GiftCardProductCopyWith(_GiftCardProduct value, $Res Function(_GiftCardProduct) _then) = __$GiftCardProductCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, String sku, String? imageUrl, String? thumbnailUrl, double minPrice, double maxPrice, bool isActive, String? categoryName, String? brandName, String? denominations, String? currencySymbol, String? offerDescription, String? formatExpiry, double? discountPercentage
});




}
/// @nodoc
class __$GiftCardProductCopyWithImpl<$Res>
    implements _$GiftCardProductCopyWith<$Res> {
  __$GiftCardProductCopyWithImpl(this._self, this._then);

  final _GiftCardProduct _self;
  final $Res Function(_GiftCardProduct) _then;

/// Create a copy of GiftCardProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? sku = null,Object? imageUrl = freezed,Object? thumbnailUrl = freezed,Object? minPrice = null,Object? maxPrice = null,Object? isActive = null,Object? categoryName = freezed,Object? brandName = freezed,Object? denominations = freezed,Object? currencySymbol = freezed,Object? offerDescription = freezed,Object? formatExpiry = freezed,Object? discountPercentage = freezed,}) {
  return _then(_GiftCardProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,minPrice: null == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double,maxPrice: null == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,brandName: freezed == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String?,denominations: freezed == denominations ? _self.denominations : denominations // ignore: cast_nullable_to_non_nullable
as String?,currencySymbol: freezed == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String?,offerDescription: freezed == offerDescription ? _self.offerDescription : offerDescription // ignore: cast_nullable_to_non_nullable
as String?,formatExpiry: freezed == formatExpiry ? _self.formatExpiry : formatExpiry // ignore: cast_nullable_to_non_nullable
as String?,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$PaginatedGiftCardProductResponse {

 List<GiftCardProduct> get items; int get pageNumber; int get totalPages; int get totalCount; bool get hasPreviousPage; bool get hasNextPage;
/// Create a copy of PaginatedGiftCardProductResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedGiftCardProductResponseCopyWith<PaginatedGiftCardProductResponse> get copyWith => _$PaginatedGiftCardProductResponseCopyWithImpl<PaginatedGiftCardProductResponse>(this as PaginatedGiftCardProductResponse, _$identity);

  /// Serializes this PaginatedGiftCardProductResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedGiftCardProductResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),pageNumber,totalPages,totalCount,hasPreviousPage,hasNextPage);

@override
String toString() {
  return 'PaginatedGiftCardProductResponse(items: $items, pageNumber: $pageNumber, totalPages: $totalPages, totalCount: $totalCount, hasPreviousPage: $hasPreviousPage, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class $PaginatedGiftCardProductResponseCopyWith<$Res>  {
  factory $PaginatedGiftCardProductResponseCopyWith(PaginatedGiftCardProductResponse value, $Res Function(PaginatedGiftCardProductResponse) _then) = _$PaginatedGiftCardProductResponseCopyWithImpl;
@useResult
$Res call({
 List<GiftCardProduct> items, int pageNumber, int totalPages, int totalCount, bool hasPreviousPage, bool hasNextPage
});




}
/// @nodoc
class _$PaginatedGiftCardProductResponseCopyWithImpl<$Res>
    implements $PaginatedGiftCardProductResponseCopyWith<$Res> {
  _$PaginatedGiftCardProductResponseCopyWithImpl(this._self, this._then);

  final PaginatedGiftCardProductResponse _self;
  final $Res Function(PaginatedGiftCardProductResponse) _then;

/// Create a copy of PaginatedGiftCardProductResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? pageNumber = null,Object? totalPages = null,Object? totalCount = null,Object? hasPreviousPage = null,Object? hasNextPage = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<GiftCardProduct>,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedGiftCardProductResponse].
extension PaginatedGiftCardProductResponsePatterns on PaginatedGiftCardProductResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedGiftCardProductResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedGiftCardProductResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedGiftCardProductResponse value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedGiftCardProductResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedGiftCardProductResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedGiftCardProductResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GiftCardProduct> items,  int pageNumber,  int totalPages,  int totalCount,  bool hasPreviousPage,  bool hasNextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedGiftCardProductResponse() when $default != null:
return $default(_that.items,_that.pageNumber,_that.totalPages,_that.totalCount,_that.hasPreviousPage,_that.hasNextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GiftCardProduct> items,  int pageNumber,  int totalPages,  int totalCount,  bool hasPreviousPage,  bool hasNextPage)  $default,) {final _that = this;
switch (_that) {
case _PaginatedGiftCardProductResponse():
return $default(_that.items,_that.pageNumber,_that.totalPages,_that.totalCount,_that.hasPreviousPage,_that.hasNextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GiftCardProduct> items,  int pageNumber,  int totalPages,  int totalCount,  bool hasPreviousPage,  bool hasNextPage)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedGiftCardProductResponse() when $default != null:
return $default(_that.items,_that.pageNumber,_that.totalPages,_that.totalCount,_that.hasPreviousPage,_that.hasNextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedGiftCardProductResponse implements PaginatedGiftCardProductResponse {
  const _PaginatedGiftCardProductResponse({required final  List<GiftCardProduct> items, required this.pageNumber, required this.totalPages, required this.totalCount, required this.hasPreviousPage, required this.hasNextPage}): _items = items;
  factory _PaginatedGiftCardProductResponse.fromJson(Map<String, dynamic> json) => _$PaginatedGiftCardProductResponseFromJson(json);

 final  List<GiftCardProduct> _items;
@override List<GiftCardProduct> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int pageNumber;
@override final  int totalPages;
@override final  int totalCount;
@override final  bool hasPreviousPage;
@override final  bool hasNextPage;

/// Create a copy of PaginatedGiftCardProductResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedGiftCardProductResponseCopyWith<_PaginatedGiftCardProductResponse> get copyWith => __$PaginatedGiftCardProductResponseCopyWithImpl<_PaginatedGiftCardProductResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedGiftCardProductResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedGiftCardProductResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),pageNumber,totalPages,totalCount,hasPreviousPage,hasNextPage);

@override
String toString() {
  return 'PaginatedGiftCardProductResponse(items: $items, pageNumber: $pageNumber, totalPages: $totalPages, totalCount: $totalCount, hasPreviousPage: $hasPreviousPage, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class _$PaginatedGiftCardProductResponseCopyWith<$Res> implements $PaginatedGiftCardProductResponseCopyWith<$Res> {
  factory _$PaginatedGiftCardProductResponseCopyWith(_PaginatedGiftCardProductResponse value, $Res Function(_PaginatedGiftCardProductResponse) _then) = __$PaginatedGiftCardProductResponseCopyWithImpl;
@override @useResult
$Res call({
 List<GiftCardProduct> items, int pageNumber, int totalPages, int totalCount, bool hasPreviousPage, bool hasNextPage
});




}
/// @nodoc
class __$PaginatedGiftCardProductResponseCopyWithImpl<$Res>
    implements _$PaginatedGiftCardProductResponseCopyWith<$Res> {
  __$PaginatedGiftCardProductResponseCopyWithImpl(this._self, this._then);

  final _PaginatedGiftCardProductResponse _self;
  final $Res Function(_PaginatedGiftCardProductResponse) _then;

/// Create a copy of PaginatedGiftCardProductResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? pageNumber = null,Object? totalPages = null,Object? totalCount = null,Object? hasPreviousPage = null,Object? hasNextPage = null,}) {
  return _then(_PaginatedGiftCardProductResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GiftCardProduct>,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$GiftCardOrder {

 int get id; String get userId; int get giftCardProductId; String get productName; String? get productImageUrl; double get requestedAmount; double get discountPercentage; double get discountAmount; double get payableAmount; GiftCardPaymentMethod get paymentMethod; GiftCardPaymentStatus get paymentStatus; double get totalPointsUsed; String? get razorpayOrderId; String? get razorpayPaymentId; GiftCardOrderStatus get status; String? get woohooCardNumber; String? get woohooCardPin; String? get woohooActivationCode; String? get woohooActivationUrl; double? get woohooActivatedAmount; DateTime? get woohooCardExpiry; String? get failureReason; DateTime get created;
/// Create a copy of GiftCardOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftCardOrderCopyWith<GiftCardOrder> get copyWith => _$GiftCardOrderCopyWithImpl<GiftCardOrder>(this as GiftCardOrder, _$identity);

  /// Serializes this GiftCardOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftCardOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.giftCardProductId, giftCardProductId) || other.giftCardProductId == giftCardProductId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productImageUrl, productImageUrl) || other.productImageUrl == productImageUrl)&&(identical(other.requestedAmount, requestedAmount) || other.requestedAmount == requestedAmount)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.payableAmount, payableAmount) || other.payableAmount == payableAmount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.totalPointsUsed, totalPointsUsed) || other.totalPointsUsed == totalPointsUsed)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.woohooCardNumber, woohooCardNumber) || other.woohooCardNumber == woohooCardNumber)&&(identical(other.woohooCardPin, woohooCardPin) || other.woohooCardPin == woohooCardPin)&&(identical(other.woohooActivationCode, woohooActivationCode) || other.woohooActivationCode == woohooActivationCode)&&(identical(other.woohooActivationUrl, woohooActivationUrl) || other.woohooActivationUrl == woohooActivationUrl)&&(identical(other.woohooActivatedAmount, woohooActivatedAmount) || other.woohooActivatedAmount == woohooActivatedAmount)&&(identical(other.woohooCardExpiry, woohooCardExpiry) || other.woohooCardExpiry == woohooCardExpiry)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,giftCardProductId,productName,productImageUrl,requestedAmount,discountPercentage,discountAmount,payableAmount,paymentMethod,paymentStatus,totalPointsUsed,razorpayOrderId,razorpayPaymentId,status,woohooCardNumber,woohooCardPin,woohooActivationCode,woohooActivationUrl,woohooActivatedAmount,woohooCardExpiry,failureReason,created]);

@override
String toString() {
  return 'GiftCardOrder(id: $id, userId: $userId, giftCardProductId: $giftCardProductId, productName: $productName, productImageUrl: $productImageUrl, requestedAmount: $requestedAmount, discountPercentage: $discountPercentage, discountAmount: $discountAmount, payableAmount: $payableAmount, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, totalPointsUsed: $totalPointsUsed, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, status: $status, woohooCardNumber: $woohooCardNumber, woohooCardPin: $woohooCardPin, woohooActivationCode: $woohooActivationCode, woohooActivationUrl: $woohooActivationUrl, woohooActivatedAmount: $woohooActivatedAmount, woohooCardExpiry: $woohooCardExpiry, failureReason: $failureReason, created: $created)';
}


}

/// @nodoc
abstract mixin class $GiftCardOrderCopyWith<$Res>  {
  factory $GiftCardOrderCopyWith(GiftCardOrder value, $Res Function(GiftCardOrder) _then) = _$GiftCardOrderCopyWithImpl;
@useResult
$Res call({
 int id, String userId, int giftCardProductId, String productName, String? productImageUrl, double requestedAmount, double discountPercentage, double discountAmount, double payableAmount, GiftCardPaymentMethod paymentMethod, GiftCardPaymentStatus paymentStatus, double totalPointsUsed, String? razorpayOrderId, String? razorpayPaymentId, GiftCardOrderStatus status, String? woohooCardNumber, String? woohooCardPin, String? woohooActivationCode, String? woohooActivationUrl, double? woohooActivatedAmount, DateTime? woohooCardExpiry, String? failureReason, DateTime created
});




}
/// @nodoc
class _$GiftCardOrderCopyWithImpl<$Res>
    implements $GiftCardOrderCopyWith<$Res> {
  _$GiftCardOrderCopyWithImpl(this._self, this._then);

  final GiftCardOrder _self;
  final $Res Function(GiftCardOrder) _then;

/// Create a copy of GiftCardOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? giftCardProductId = null,Object? productName = null,Object? productImageUrl = freezed,Object? requestedAmount = null,Object? discountPercentage = null,Object? discountAmount = null,Object? payableAmount = null,Object? paymentMethod = null,Object? paymentStatus = null,Object? totalPointsUsed = null,Object? razorpayOrderId = freezed,Object? razorpayPaymentId = freezed,Object? status = null,Object? woohooCardNumber = freezed,Object? woohooCardPin = freezed,Object? woohooActivationCode = freezed,Object? woohooActivationUrl = freezed,Object? woohooActivatedAmount = freezed,Object? woohooCardExpiry = freezed,Object? failureReason = freezed,Object? created = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,giftCardProductId: null == giftCardProductId ? _self.giftCardProductId : giftCardProductId // ignore: cast_nullable_to_non_nullable
as int,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productImageUrl: freezed == productImageUrl ? _self.productImageUrl : productImageUrl // ignore: cast_nullable_to_non_nullable
as String?,requestedAmount: null == requestedAmount ? _self.requestedAmount : requestedAmount // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,payableAmount: null == payableAmount ? _self.payableAmount : payableAmount // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as GiftCardPaymentMethod,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as GiftCardPaymentStatus,totalPointsUsed: null == totalPointsUsed ? _self.totalPointsUsed : totalPointsUsed // ignore: cast_nullable_to_non_nullable
as double,razorpayOrderId: freezed == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String?,razorpayPaymentId: freezed == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GiftCardOrderStatus,woohooCardNumber: freezed == woohooCardNumber ? _self.woohooCardNumber : woohooCardNumber // ignore: cast_nullable_to_non_nullable
as String?,woohooCardPin: freezed == woohooCardPin ? _self.woohooCardPin : woohooCardPin // ignore: cast_nullable_to_non_nullable
as String?,woohooActivationCode: freezed == woohooActivationCode ? _self.woohooActivationCode : woohooActivationCode // ignore: cast_nullable_to_non_nullable
as String?,woohooActivationUrl: freezed == woohooActivationUrl ? _self.woohooActivationUrl : woohooActivationUrl // ignore: cast_nullable_to_non_nullable
as String?,woohooActivatedAmount: freezed == woohooActivatedAmount ? _self.woohooActivatedAmount : woohooActivatedAmount // ignore: cast_nullable_to_non_nullable
as double?,woohooCardExpiry: freezed == woohooCardExpiry ? _self.woohooCardExpiry : woohooCardExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftCardOrder].
extension GiftCardOrderPatterns on GiftCardOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftCardOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftCardOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftCardOrder value)  $default,){
final _that = this;
switch (_that) {
case _GiftCardOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftCardOrder value)?  $default,){
final _that = this;
switch (_that) {
case _GiftCardOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String userId,  int giftCardProductId,  String productName,  String? productImageUrl,  double requestedAmount,  double discountPercentage,  double discountAmount,  double payableAmount,  GiftCardPaymentMethod paymentMethod,  GiftCardPaymentStatus paymentStatus,  double totalPointsUsed,  String? razorpayOrderId,  String? razorpayPaymentId,  GiftCardOrderStatus status,  String? woohooCardNumber,  String? woohooCardPin,  String? woohooActivationCode,  String? woohooActivationUrl,  double? woohooActivatedAmount,  DateTime? woohooCardExpiry,  String? failureReason,  DateTime created)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftCardOrder() when $default != null:
return $default(_that.id,_that.userId,_that.giftCardProductId,_that.productName,_that.productImageUrl,_that.requestedAmount,_that.discountPercentage,_that.discountAmount,_that.payableAmount,_that.paymentMethod,_that.paymentStatus,_that.totalPointsUsed,_that.razorpayOrderId,_that.razorpayPaymentId,_that.status,_that.woohooCardNumber,_that.woohooCardPin,_that.woohooActivationCode,_that.woohooActivationUrl,_that.woohooActivatedAmount,_that.woohooCardExpiry,_that.failureReason,_that.created);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String userId,  int giftCardProductId,  String productName,  String? productImageUrl,  double requestedAmount,  double discountPercentage,  double discountAmount,  double payableAmount,  GiftCardPaymentMethod paymentMethod,  GiftCardPaymentStatus paymentStatus,  double totalPointsUsed,  String? razorpayOrderId,  String? razorpayPaymentId,  GiftCardOrderStatus status,  String? woohooCardNumber,  String? woohooCardPin,  String? woohooActivationCode,  String? woohooActivationUrl,  double? woohooActivatedAmount,  DateTime? woohooCardExpiry,  String? failureReason,  DateTime created)  $default,) {final _that = this;
switch (_that) {
case _GiftCardOrder():
return $default(_that.id,_that.userId,_that.giftCardProductId,_that.productName,_that.productImageUrl,_that.requestedAmount,_that.discountPercentage,_that.discountAmount,_that.payableAmount,_that.paymentMethod,_that.paymentStatus,_that.totalPointsUsed,_that.razorpayOrderId,_that.razorpayPaymentId,_that.status,_that.woohooCardNumber,_that.woohooCardPin,_that.woohooActivationCode,_that.woohooActivationUrl,_that.woohooActivatedAmount,_that.woohooCardExpiry,_that.failureReason,_that.created);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String userId,  int giftCardProductId,  String productName,  String? productImageUrl,  double requestedAmount,  double discountPercentage,  double discountAmount,  double payableAmount,  GiftCardPaymentMethod paymentMethod,  GiftCardPaymentStatus paymentStatus,  double totalPointsUsed,  String? razorpayOrderId,  String? razorpayPaymentId,  GiftCardOrderStatus status,  String? woohooCardNumber,  String? woohooCardPin,  String? woohooActivationCode,  String? woohooActivationUrl,  double? woohooActivatedAmount,  DateTime? woohooCardExpiry,  String? failureReason,  DateTime created)?  $default,) {final _that = this;
switch (_that) {
case _GiftCardOrder() when $default != null:
return $default(_that.id,_that.userId,_that.giftCardProductId,_that.productName,_that.productImageUrl,_that.requestedAmount,_that.discountPercentage,_that.discountAmount,_that.payableAmount,_that.paymentMethod,_that.paymentStatus,_that.totalPointsUsed,_that.razorpayOrderId,_that.razorpayPaymentId,_that.status,_that.woohooCardNumber,_that.woohooCardPin,_that.woohooActivationCode,_that.woohooActivationUrl,_that.woohooActivatedAmount,_that.woohooCardExpiry,_that.failureReason,_that.created);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftCardOrder implements GiftCardOrder {
  const _GiftCardOrder({required this.id, required this.userId, required this.giftCardProductId, required this.productName, this.productImageUrl, required this.requestedAmount, required this.discountPercentage, required this.discountAmount, required this.payableAmount, required this.paymentMethod, required this.paymentStatus, required this.totalPointsUsed, this.razorpayOrderId, this.razorpayPaymentId, required this.status, this.woohooCardNumber, this.woohooCardPin, this.woohooActivationCode, this.woohooActivationUrl, this.woohooActivatedAmount, this.woohooCardExpiry, this.failureReason, required this.created});
  factory _GiftCardOrder.fromJson(Map<String, dynamic> json) => _$GiftCardOrderFromJson(json);

@override final  int id;
@override final  String userId;
@override final  int giftCardProductId;
@override final  String productName;
@override final  String? productImageUrl;
@override final  double requestedAmount;
@override final  double discountPercentage;
@override final  double discountAmount;
@override final  double payableAmount;
@override final  GiftCardPaymentMethod paymentMethod;
@override final  GiftCardPaymentStatus paymentStatus;
@override final  double totalPointsUsed;
@override final  String? razorpayOrderId;
@override final  String? razorpayPaymentId;
@override final  GiftCardOrderStatus status;
@override final  String? woohooCardNumber;
@override final  String? woohooCardPin;
@override final  String? woohooActivationCode;
@override final  String? woohooActivationUrl;
@override final  double? woohooActivatedAmount;
@override final  DateTime? woohooCardExpiry;
@override final  String? failureReason;
@override final  DateTime created;

/// Create a copy of GiftCardOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftCardOrderCopyWith<_GiftCardOrder> get copyWith => __$GiftCardOrderCopyWithImpl<_GiftCardOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftCardOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftCardOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.giftCardProductId, giftCardProductId) || other.giftCardProductId == giftCardProductId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.productImageUrl, productImageUrl) || other.productImageUrl == productImageUrl)&&(identical(other.requestedAmount, requestedAmount) || other.requestedAmount == requestedAmount)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.payableAmount, payableAmount) || other.payableAmount == payableAmount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.totalPointsUsed, totalPointsUsed) || other.totalPointsUsed == totalPointsUsed)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.woohooCardNumber, woohooCardNumber) || other.woohooCardNumber == woohooCardNumber)&&(identical(other.woohooCardPin, woohooCardPin) || other.woohooCardPin == woohooCardPin)&&(identical(other.woohooActivationCode, woohooActivationCode) || other.woohooActivationCode == woohooActivationCode)&&(identical(other.woohooActivationUrl, woohooActivationUrl) || other.woohooActivationUrl == woohooActivationUrl)&&(identical(other.woohooActivatedAmount, woohooActivatedAmount) || other.woohooActivatedAmount == woohooActivatedAmount)&&(identical(other.woohooCardExpiry, woohooCardExpiry) || other.woohooCardExpiry == woohooCardExpiry)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,giftCardProductId,productName,productImageUrl,requestedAmount,discountPercentage,discountAmount,payableAmount,paymentMethod,paymentStatus,totalPointsUsed,razorpayOrderId,razorpayPaymentId,status,woohooCardNumber,woohooCardPin,woohooActivationCode,woohooActivationUrl,woohooActivatedAmount,woohooCardExpiry,failureReason,created]);

@override
String toString() {
  return 'GiftCardOrder(id: $id, userId: $userId, giftCardProductId: $giftCardProductId, productName: $productName, productImageUrl: $productImageUrl, requestedAmount: $requestedAmount, discountPercentage: $discountPercentage, discountAmount: $discountAmount, payableAmount: $payableAmount, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, totalPointsUsed: $totalPointsUsed, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, status: $status, woohooCardNumber: $woohooCardNumber, woohooCardPin: $woohooCardPin, woohooActivationCode: $woohooActivationCode, woohooActivationUrl: $woohooActivationUrl, woohooActivatedAmount: $woohooActivatedAmount, woohooCardExpiry: $woohooCardExpiry, failureReason: $failureReason, created: $created)';
}


}

/// @nodoc
abstract mixin class _$GiftCardOrderCopyWith<$Res> implements $GiftCardOrderCopyWith<$Res> {
  factory _$GiftCardOrderCopyWith(_GiftCardOrder value, $Res Function(_GiftCardOrder) _then) = __$GiftCardOrderCopyWithImpl;
@override @useResult
$Res call({
 int id, String userId, int giftCardProductId, String productName, String? productImageUrl, double requestedAmount, double discountPercentage, double discountAmount, double payableAmount, GiftCardPaymentMethod paymentMethod, GiftCardPaymentStatus paymentStatus, double totalPointsUsed, String? razorpayOrderId, String? razorpayPaymentId, GiftCardOrderStatus status, String? woohooCardNumber, String? woohooCardPin, String? woohooActivationCode, String? woohooActivationUrl, double? woohooActivatedAmount, DateTime? woohooCardExpiry, String? failureReason, DateTime created
});




}
/// @nodoc
class __$GiftCardOrderCopyWithImpl<$Res>
    implements _$GiftCardOrderCopyWith<$Res> {
  __$GiftCardOrderCopyWithImpl(this._self, this._then);

  final _GiftCardOrder _self;
  final $Res Function(_GiftCardOrder) _then;

/// Create a copy of GiftCardOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? giftCardProductId = null,Object? productName = null,Object? productImageUrl = freezed,Object? requestedAmount = null,Object? discountPercentage = null,Object? discountAmount = null,Object? payableAmount = null,Object? paymentMethod = null,Object? paymentStatus = null,Object? totalPointsUsed = null,Object? razorpayOrderId = freezed,Object? razorpayPaymentId = freezed,Object? status = null,Object? woohooCardNumber = freezed,Object? woohooCardPin = freezed,Object? woohooActivationCode = freezed,Object? woohooActivationUrl = freezed,Object? woohooActivatedAmount = freezed,Object? woohooCardExpiry = freezed,Object? failureReason = freezed,Object? created = null,}) {
  return _then(_GiftCardOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,giftCardProductId: null == giftCardProductId ? _self.giftCardProductId : giftCardProductId // ignore: cast_nullable_to_non_nullable
as int,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,productImageUrl: freezed == productImageUrl ? _self.productImageUrl : productImageUrl // ignore: cast_nullable_to_non_nullable
as String?,requestedAmount: null == requestedAmount ? _self.requestedAmount : requestedAmount // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,payableAmount: null == payableAmount ? _self.payableAmount : payableAmount // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as GiftCardPaymentMethod,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as GiftCardPaymentStatus,totalPointsUsed: null == totalPointsUsed ? _self.totalPointsUsed : totalPointsUsed // ignore: cast_nullable_to_non_nullable
as double,razorpayOrderId: freezed == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String?,razorpayPaymentId: freezed == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GiftCardOrderStatus,woohooCardNumber: freezed == woohooCardNumber ? _self.woohooCardNumber : woohooCardNumber // ignore: cast_nullable_to_non_nullable
as String?,woohooCardPin: freezed == woohooCardPin ? _self.woohooCardPin : woohooCardPin // ignore: cast_nullable_to_non_nullable
as String?,woohooActivationCode: freezed == woohooActivationCode ? _self.woohooActivationCode : woohooActivationCode // ignore: cast_nullable_to_non_nullable
as String?,woohooActivationUrl: freezed == woohooActivationUrl ? _self.woohooActivationUrl : woohooActivationUrl // ignore: cast_nullable_to_non_nullable
as String?,woohooActivatedAmount: freezed == woohooActivatedAmount ? _self.woohooActivatedAmount : woohooActivatedAmount // ignore: cast_nullable_to_non_nullable
as double?,woohooCardExpiry: freezed == woohooCardExpiry ? _self.woohooCardExpiry : woohooCardExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$PaginatedGiftCardOrderResponse {

 List<GiftCardOrder> get items; int get pageNumber; int get totalPages; int get totalCount; bool get hasPreviousPage; bool get hasNextPage;
/// Create a copy of PaginatedGiftCardOrderResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedGiftCardOrderResponseCopyWith<PaginatedGiftCardOrderResponse> get copyWith => _$PaginatedGiftCardOrderResponseCopyWithImpl<PaginatedGiftCardOrderResponse>(this as PaginatedGiftCardOrderResponse, _$identity);

  /// Serializes this PaginatedGiftCardOrderResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedGiftCardOrderResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),pageNumber,totalPages,totalCount,hasPreviousPage,hasNextPage);

@override
String toString() {
  return 'PaginatedGiftCardOrderResponse(items: $items, pageNumber: $pageNumber, totalPages: $totalPages, totalCount: $totalCount, hasPreviousPage: $hasPreviousPage, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class $PaginatedGiftCardOrderResponseCopyWith<$Res>  {
  factory $PaginatedGiftCardOrderResponseCopyWith(PaginatedGiftCardOrderResponse value, $Res Function(PaginatedGiftCardOrderResponse) _then) = _$PaginatedGiftCardOrderResponseCopyWithImpl;
@useResult
$Res call({
 List<GiftCardOrder> items, int pageNumber, int totalPages, int totalCount, bool hasPreviousPage, bool hasNextPage
});




}
/// @nodoc
class _$PaginatedGiftCardOrderResponseCopyWithImpl<$Res>
    implements $PaginatedGiftCardOrderResponseCopyWith<$Res> {
  _$PaginatedGiftCardOrderResponseCopyWithImpl(this._self, this._then);

  final PaginatedGiftCardOrderResponse _self;
  final $Res Function(PaginatedGiftCardOrderResponse) _then;

/// Create a copy of PaginatedGiftCardOrderResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? pageNumber = null,Object? totalPages = null,Object? totalCount = null,Object? hasPreviousPage = null,Object? hasNextPage = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<GiftCardOrder>,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedGiftCardOrderResponse].
extension PaginatedGiftCardOrderResponsePatterns on PaginatedGiftCardOrderResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedGiftCardOrderResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedGiftCardOrderResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedGiftCardOrderResponse value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedGiftCardOrderResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedGiftCardOrderResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedGiftCardOrderResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GiftCardOrder> items,  int pageNumber,  int totalPages,  int totalCount,  bool hasPreviousPage,  bool hasNextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedGiftCardOrderResponse() when $default != null:
return $default(_that.items,_that.pageNumber,_that.totalPages,_that.totalCount,_that.hasPreviousPage,_that.hasNextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GiftCardOrder> items,  int pageNumber,  int totalPages,  int totalCount,  bool hasPreviousPage,  bool hasNextPage)  $default,) {final _that = this;
switch (_that) {
case _PaginatedGiftCardOrderResponse():
return $default(_that.items,_that.pageNumber,_that.totalPages,_that.totalCount,_that.hasPreviousPage,_that.hasNextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GiftCardOrder> items,  int pageNumber,  int totalPages,  int totalCount,  bool hasPreviousPage,  bool hasNextPage)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedGiftCardOrderResponse() when $default != null:
return $default(_that.items,_that.pageNumber,_that.totalPages,_that.totalCount,_that.hasPreviousPage,_that.hasNextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedGiftCardOrderResponse implements PaginatedGiftCardOrderResponse {
  const _PaginatedGiftCardOrderResponse({required final  List<GiftCardOrder> items, required this.pageNumber, required this.totalPages, required this.totalCount, required this.hasPreviousPage, required this.hasNextPage}): _items = items;
  factory _PaginatedGiftCardOrderResponse.fromJson(Map<String, dynamic> json) => _$PaginatedGiftCardOrderResponseFromJson(json);

 final  List<GiftCardOrder> _items;
@override List<GiftCardOrder> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int pageNumber;
@override final  int totalPages;
@override final  int totalCount;
@override final  bool hasPreviousPage;
@override final  bool hasNextPage;

/// Create a copy of PaginatedGiftCardOrderResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedGiftCardOrderResponseCopyWith<_PaginatedGiftCardOrderResponse> get copyWith => __$PaginatedGiftCardOrderResponseCopyWithImpl<_PaginatedGiftCardOrderResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedGiftCardOrderResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedGiftCardOrderResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),pageNumber,totalPages,totalCount,hasPreviousPage,hasNextPage);

@override
String toString() {
  return 'PaginatedGiftCardOrderResponse(items: $items, pageNumber: $pageNumber, totalPages: $totalPages, totalCount: $totalCount, hasPreviousPage: $hasPreviousPage, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class _$PaginatedGiftCardOrderResponseCopyWith<$Res> implements $PaginatedGiftCardOrderResponseCopyWith<$Res> {
  factory _$PaginatedGiftCardOrderResponseCopyWith(_PaginatedGiftCardOrderResponse value, $Res Function(_PaginatedGiftCardOrderResponse) _then) = __$PaginatedGiftCardOrderResponseCopyWithImpl;
@override @useResult
$Res call({
 List<GiftCardOrder> items, int pageNumber, int totalPages, int totalCount, bool hasPreviousPage, bool hasNextPage
});




}
/// @nodoc
class __$PaginatedGiftCardOrderResponseCopyWithImpl<$Res>
    implements _$PaginatedGiftCardOrderResponseCopyWith<$Res> {
  __$PaginatedGiftCardOrderResponseCopyWithImpl(this._self, this._then);

  final _PaginatedGiftCardOrderResponse _self;
  final $Res Function(_PaginatedGiftCardOrderResponse) _then;

/// Create a copy of PaginatedGiftCardOrderResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? pageNumber = null,Object? totalPages = null,Object? totalCount = null,Object? hasPreviousPage = null,Object? hasNextPage = null,}) {
  return _then(_PaginatedGiftCardOrderResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<GiftCardOrder>,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CreateGiftCardOrderRequest {

 int get giftCardProductId; double get amount; GiftCardPaymentMethod get paymentMethod;
/// Create a copy of CreateGiftCardOrderRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateGiftCardOrderRequestCopyWith<CreateGiftCardOrderRequest> get copyWith => _$CreateGiftCardOrderRequestCopyWithImpl<CreateGiftCardOrderRequest>(this as CreateGiftCardOrderRequest, _$identity);

  /// Serializes this CreateGiftCardOrderRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateGiftCardOrderRequest&&(identical(other.giftCardProductId, giftCardProductId) || other.giftCardProductId == giftCardProductId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,giftCardProductId,amount,paymentMethod);

@override
String toString() {
  return 'CreateGiftCardOrderRequest(giftCardProductId: $giftCardProductId, amount: $amount, paymentMethod: $paymentMethod)';
}


}

/// @nodoc
abstract mixin class $CreateGiftCardOrderRequestCopyWith<$Res>  {
  factory $CreateGiftCardOrderRequestCopyWith(CreateGiftCardOrderRequest value, $Res Function(CreateGiftCardOrderRequest) _then) = _$CreateGiftCardOrderRequestCopyWithImpl;
@useResult
$Res call({
 int giftCardProductId, double amount, GiftCardPaymentMethod paymentMethod
});




}
/// @nodoc
class _$CreateGiftCardOrderRequestCopyWithImpl<$Res>
    implements $CreateGiftCardOrderRequestCopyWith<$Res> {
  _$CreateGiftCardOrderRequestCopyWithImpl(this._self, this._then);

  final CreateGiftCardOrderRequest _self;
  final $Res Function(CreateGiftCardOrderRequest) _then;

/// Create a copy of CreateGiftCardOrderRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? giftCardProductId = null,Object? amount = null,Object? paymentMethod = null,}) {
  return _then(_self.copyWith(
giftCardProductId: null == giftCardProductId ? _self.giftCardProductId : giftCardProductId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as GiftCardPaymentMethod,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateGiftCardOrderRequest].
extension CreateGiftCardOrderRequestPatterns on CreateGiftCardOrderRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateGiftCardOrderRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateGiftCardOrderRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateGiftCardOrderRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateGiftCardOrderRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateGiftCardOrderRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateGiftCardOrderRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int giftCardProductId,  double amount,  GiftCardPaymentMethod paymentMethod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateGiftCardOrderRequest() when $default != null:
return $default(_that.giftCardProductId,_that.amount,_that.paymentMethod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int giftCardProductId,  double amount,  GiftCardPaymentMethod paymentMethod)  $default,) {final _that = this;
switch (_that) {
case _CreateGiftCardOrderRequest():
return $default(_that.giftCardProductId,_that.amount,_that.paymentMethod);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int giftCardProductId,  double amount,  GiftCardPaymentMethod paymentMethod)?  $default,) {final _that = this;
switch (_that) {
case _CreateGiftCardOrderRequest() when $default != null:
return $default(_that.giftCardProductId,_that.amount,_that.paymentMethod);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateGiftCardOrderRequest implements CreateGiftCardOrderRequest {
  const _CreateGiftCardOrderRequest({required this.giftCardProductId, required this.amount, required this.paymentMethod});
  factory _CreateGiftCardOrderRequest.fromJson(Map<String, dynamic> json) => _$CreateGiftCardOrderRequestFromJson(json);

@override final  int giftCardProductId;
@override final  double amount;
@override final  GiftCardPaymentMethod paymentMethod;

/// Create a copy of CreateGiftCardOrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateGiftCardOrderRequestCopyWith<_CreateGiftCardOrderRequest> get copyWith => __$CreateGiftCardOrderRequestCopyWithImpl<_CreateGiftCardOrderRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateGiftCardOrderRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateGiftCardOrderRequest&&(identical(other.giftCardProductId, giftCardProductId) || other.giftCardProductId == giftCardProductId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,giftCardProductId,amount,paymentMethod);

@override
String toString() {
  return 'CreateGiftCardOrderRequest(giftCardProductId: $giftCardProductId, amount: $amount, paymentMethod: $paymentMethod)';
}


}

/// @nodoc
abstract mixin class _$CreateGiftCardOrderRequestCopyWith<$Res> implements $CreateGiftCardOrderRequestCopyWith<$Res> {
  factory _$CreateGiftCardOrderRequestCopyWith(_CreateGiftCardOrderRequest value, $Res Function(_CreateGiftCardOrderRequest) _then) = __$CreateGiftCardOrderRequestCopyWithImpl;
@override @useResult
$Res call({
 int giftCardProductId, double amount, GiftCardPaymentMethod paymentMethod
});




}
/// @nodoc
class __$CreateGiftCardOrderRequestCopyWithImpl<$Res>
    implements _$CreateGiftCardOrderRequestCopyWith<$Res> {
  __$CreateGiftCardOrderRequestCopyWithImpl(this._self, this._then);

  final _CreateGiftCardOrderRequest _self;
  final $Res Function(_CreateGiftCardOrderRequest) _then;

/// Create a copy of CreateGiftCardOrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? giftCardProductId = null,Object? amount = null,Object? paymentMethod = null,}) {
  return _then(_CreateGiftCardOrderRequest(
giftCardProductId: null == giftCardProductId ? _self.giftCardProductId : giftCardProductId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as GiftCardPaymentMethod,
  ));
}


}


/// @nodoc
mixin _$GiftCardPriceBreakdown {

 int get productId; String get productName; double get requestedAmount; double get discountPercentage; double get discountAmount; double get payableAmount;
/// Create a copy of GiftCardPriceBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftCardPriceBreakdownCopyWith<GiftCardPriceBreakdown> get copyWith => _$GiftCardPriceBreakdownCopyWithImpl<GiftCardPriceBreakdown>(this as GiftCardPriceBreakdown, _$identity);

  /// Serializes this GiftCardPriceBreakdown to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftCardPriceBreakdown&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.requestedAmount, requestedAmount) || other.requestedAmount == requestedAmount)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.payableAmount, payableAmount) || other.payableAmount == payableAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,productName,requestedAmount,discountPercentage,discountAmount,payableAmount);

@override
String toString() {
  return 'GiftCardPriceBreakdown(productId: $productId, productName: $productName, requestedAmount: $requestedAmount, discountPercentage: $discountPercentage, discountAmount: $discountAmount, payableAmount: $payableAmount)';
}


}

/// @nodoc
abstract mixin class $GiftCardPriceBreakdownCopyWith<$Res>  {
  factory $GiftCardPriceBreakdownCopyWith(GiftCardPriceBreakdown value, $Res Function(GiftCardPriceBreakdown) _then) = _$GiftCardPriceBreakdownCopyWithImpl;
@useResult
$Res call({
 int productId, String productName, double requestedAmount, double discountPercentage, double discountAmount, double payableAmount
});




}
/// @nodoc
class _$GiftCardPriceBreakdownCopyWithImpl<$Res>
    implements $GiftCardPriceBreakdownCopyWith<$Res> {
  _$GiftCardPriceBreakdownCopyWithImpl(this._self, this._then);

  final GiftCardPriceBreakdown _self;
  final $Res Function(GiftCardPriceBreakdown) _then;

/// Create a copy of GiftCardPriceBreakdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? productName = null,Object? requestedAmount = null,Object? discountPercentage = null,Object? discountAmount = null,Object? payableAmount = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,requestedAmount: null == requestedAmount ? _self.requestedAmount : requestedAmount // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,payableAmount: null == payableAmount ? _self.payableAmount : payableAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftCardPriceBreakdown].
extension GiftCardPriceBreakdownPatterns on GiftCardPriceBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftCardPriceBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftCardPriceBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftCardPriceBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _GiftCardPriceBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftCardPriceBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _GiftCardPriceBreakdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int productId,  String productName,  double requestedAmount,  double discountPercentage,  double discountAmount,  double payableAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftCardPriceBreakdown() when $default != null:
return $default(_that.productId,_that.productName,_that.requestedAmount,_that.discountPercentage,_that.discountAmount,_that.payableAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int productId,  String productName,  double requestedAmount,  double discountPercentage,  double discountAmount,  double payableAmount)  $default,) {final _that = this;
switch (_that) {
case _GiftCardPriceBreakdown():
return $default(_that.productId,_that.productName,_that.requestedAmount,_that.discountPercentage,_that.discountAmount,_that.payableAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int productId,  String productName,  double requestedAmount,  double discountPercentage,  double discountAmount,  double payableAmount)?  $default,) {final _that = this;
switch (_that) {
case _GiftCardPriceBreakdown() when $default != null:
return $default(_that.productId,_that.productName,_that.requestedAmount,_that.discountPercentage,_that.discountAmount,_that.payableAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftCardPriceBreakdown implements GiftCardPriceBreakdown {
  const _GiftCardPriceBreakdown({required this.productId, required this.productName, required this.requestedAmount, required this.discountPercentage, required this.discountAmount, required this.payableAmount});
  factory _GiftCardPriceBreakdown.fromJson(Map<String, dynamic> json) => _$GiftCardPriceBreakdownFromJson(json);

@override final  int productId;
@override final  String productName;
@override final  double requestedAmount;
@override final  double discountPercentage;
@override final  double discountAmount;
@override final  double payableAmount;

/// Create a copy of GiftCardPriceBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftCardPriceBreakdownCopyWith<_GiftCardPriceBreakdown> get copyWith => __$GiftCardPriceBreakdownCopyWithImpl<_GiftCardPriceBreakdown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftCardPriceBreakdownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftCardPriceBreakdown&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.requestedAmount, requestedAmount) || other.requestedAmount == requestedAmount)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.payableAmount, payableAmount) || other.payableAmount == payableAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,productName,requestedAmount,discountPercentage,discountAmount,payableAmount);

@override
String toString() {
  return 'GiftCardPriceBreakdown(productId: $productId, productName: $productName, requestedAmount: $requestedAmount, discountPercentage: $discountPercentage, discountAmount: $discountAmount, payableAmount: $payableAmount)';
}


}

/// @nodoc
abstract mixin class _$GiftCardPriceBreakdownCopyWith<$Res> implements $GiftCardPriceBreakdownCopyWith<$Res> {
  factory _$GiftCardPriceBreakdownCopyWith(_GiftCardPriceBreakdown value, $Res Function(_GiftCardPriceBreakdown) _then) = __$GiftCardPriceBreakdownCopyWithImpl;
@override @useResult
$Res call({
 int productId, String productName, double requestedAmount, double discountPercentage, double discountAmount, double payableAmount
});




}
/// @nodoc
class __$GiftCardPriceBreakdownCopyWithImpl<$Res>
    implements _$GiftCardPriceBreakdownCopyWith<$Res> {
  __$GiftCardPriceBreakdownCopyWithImpl(this._self, this._then);

  final _GiftCardPriceBreakdown _self;
  final $Res Function(_GiftCardPriceBreakdown) _then;

/// Create a copy of GiftCardPriceBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? productName = null,Object? requestedAmount = null,Object? discountPercentage = null,Object? discountAmount = null,Object? payableAmount = null,}) {
  return _then(_GiftCardPriceBreakdown(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,requestedAmount: null == requestedAmount ? _self.requestedAmount : requestedAmount // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,payableAmount: null == payableAmount ? _self.payableAmount : payableAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CreateGiftCardPaymentOrderRequest {

 int get giftCardProductId; double get amount;
/// Create a copy of CreateGiftCardPaymentOrderRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateGiftCardPaymentOrderRequestCopyWith<CreateGiftCardPaymentOrderRequest> get copyWith => _$CreateGiftCardPaymentOrderRequestCopyWithImpl<CreateGiftCardPaymentOrderRequest>(this as CreateGiftCardPaymentOrderRequest, _$identity);

  /// Serializes this CreateGiftCardPaymentOrderRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateGiftCardPaymentOrderRequest&&(identical(other.giftCardProductId, giftCardProductId) || other.giftCardProductId == giftCardProductId)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,giftCardProductId,amount);

@override
String toString() {
  return 'CreateGiftCardPaymentOrderRequest(giftCardProductId: $giftCardProductId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $CreateGiftCardPaymentOrderRequestCopyWith<$Res>  {
  factory $CreateGiftCardPaymentOrderRequestCopyWith(CreateGiftCardPaymentOrderRequest value, $Res Function(CreateGiftCardPaymentOrderRequest) _then) = _$CreateGiftCardPaymentOrderRequestCopyWithImpl;
@useResult
$Res call({
 int giftCardProductId, double amount
});




}
/// @nodoc
class _$CreateGiftCardPaymentOrderRequestCopyWithImpl<$Res>
    implements $CreateGiftCardPaymentOrderRequestCopyWith<$Res> {
  _$CreateGiftCardPaymentOrderRequestCopyWithImpl(this._self, this._then);

  final CreateGiftCardPaymentOrderRequest _self;
  final $Res Function(CreateGiftCardPaymentOrderRequest) _then;

/// Create a copy of CreateGiftCardPaymentOrderRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? giftCardProductId = null,Object? amount = null,}) {
  return _then(_self.copyWith(
giftCardProductId: null == giftCardProductId ? _self.giftCardProductId : giftCardProductId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateGiftCardPaymentOrderRequest].
extension CreateGiftCardPaymentOrderRequestPatterns on CreateGiftCardPaymentOrderRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateGiftCardPaymentOrderRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateGiftCardPaymentOrderRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateGiftCardPaymentOrderRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateGiftCardPaymentOrderRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateGiftCardPaymentOrderRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateGiftCardPaymentOrderRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int giftCardProductId,  double amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateGiftCardPaymentOrderRequest() when $default != null:
return $default(_that.giftCardProductId,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int giftCardProductId,  double amount)  $default,) {final _that = this;
switch (_that) {
case _CreateGiftCardPaymentOrderRequest():
return $default(_that.giftCardProductId,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int giftCardProductId,  double amount)?  $default,) {final _that = this;
switch (_that) {
case _CreateGiftCardPaymentOrderRequest() when $default != null:
return $default(_that.giftCardProductId,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateGiftCardPaymentOrderRequest implements CreateGiftCardPaymentOrderRequest {
  const _CreateGiftCardPaymentOrderRequest({required this.giftCardProductId, required this.amount});
  factory _CreateGiftCardPaymentOrderRequest.fromJson(Map<String, dynamic> json) => _$CreateGiftCardPaymentOrderRequestFromJson(json);

@override final  int giftCardProductId;
@override final  double amount;

/// Create a copy of CreateGiftCardPaymentOrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateGiftCardPaymentOrderRequestCopyWith<_CreateGiftCardPaymentOrderRequest> get copyWith => __$CreateGiftCardPaymentOrderRequestCopyWithImpl<_CreateGiftCardPaymentOrderRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateGiftCardPaymentOrderRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateGiftCardPaymentOrderRequest&&(identical(other.giftCardProductId, giftCardProductId) || other.giftCardProductId == giftCardProductId)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,giftCardProductId,amount);

@override
String toString() {
  return 'CreateGiftCardPaymentOrderRequest(giftCardProductId: $giftCardProductId, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$CreateGiftCardPaymentOrderRequestCopyWith<$Res> implements $CreateGiftCardPaymentOrderRequestCopyWith<$Res> {
  factory _$CreateGiftCardPaymentOrderRequestCopyWith(_CreateGiftCardPaymentOrderRequest value, $Res Function(_CreateGiftCardPaymentOrderRequest) _then) = __$CreateGiftCardPaymentOrderRequestCopyWithImpl;
@override @useResult
$Res call({
 int giftCardProductId, double amount
});




}
/// @nodoc
class __$CreateGiftCardPaymentOrderRequestCopyWithImpl<$Res>
    implements _$CreateGiftCardPaymentOrderRequestCopyWith<$Res> {
  __$CreateGiftCardPaymentOrderRequestCopyWithImpl(this._self, this._then);

  final _CreateGiftCardPaymentOrderRequest _self;
  final $Res Function(_CreateGiftCardPaymentOrderRequest) _then;

/// Create a copy of CreateGiftCardPaymentOrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? giftCardProductId = null,Object? amount = null,}) {
  return _then(_CreateGiftCardPaymentOrderRequest(
giftCardProductId: null == giftCardProductId ? _self.giftCardProductId : giftCardProductId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CreateGiftCardPaymentOrderResponse {

 String get razorpayOrderId; int get razorpayAmountInPaise; String get currency; String get razorpayKeyId; int get orderId; String get productName; double get requestedAmount; double get discountPercentage; double get discountAmount; double get payableAmount;
/// Create a copy of CreateGiftCardPaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateGiftCardPaymentOrderResponseCopyWith<CreateGiftCardPaymentOrderResponse> get copyWith => _$CreateGiftCardPaymentOrderResponseCopyWithImpl<CreateGiftCardPaymentOrderResponse>(this as CreateGiftCardPaymentOrderResponse, _$identity);

  /// Serializes this CreateGiftCardPaymentOrderResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateGiftCardPaymentOrderResponse&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayAmountInPaise, razorpayAmountInPaise) || other.razorpayAmountInPaise == razorpayAmountInPaise)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.razorpayKeyId, razorpayKeyId) || other.razorpayKeyId == razorpayKeyId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.requestedAmount, requestedAmount) || other.requestedAmount == requestedAmount)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.payableAmount, payableAmount) || other.payableAmount == payableAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,razorpayOrderId,razorpayAmountInPaise,currency,razorpayKeyId,orderId,productName,requestedAmount,discountPercentage,discountAmount,payableAmount);

@override
String toString() {
  return 'CreateGiftCardPaymentOrderResponse(razorpayOrderId: $razorpayOrderId, razorpayAmountInPaise: $razorpayAmountInPaise, currency: $currency, razorpayKeyId: $razorpayKeyId, orderId: $orderId, productName: $productName, requestedAmount: $requestedAmount, discountPercentage: $discountPercentage, discountAmount: $discountAmount, payableAmount: $payableAmount)';
}


}

/// @nodoc
abstract mixin class $CreateGiftCardPaymentOrderResponseCopyWith<$Res>  {
  factory $CreateGiftCardPaymentOrderResponseCopyWith(CreateGiftCardPaymentOrderResponse value, $Res Function(CreateGiftCardPaymentOrderResponse) _then) = _$CreateGiftCardPaymentOrderResponseCopyWithImpl;
@useResult
$Res call({
 String razorpayOrderId, int razorpayAmountInPaise, String currency, String razorpayKeyId, int orderId, String productName, double requestedAmount, double discountPercentage, double discountAmount, double payableAmount
});




}
/// @nodoc
class _$CreateGiftCardPaymentOrderResponseCopyWithImpl<$Res>
    implements $CreateGiftCardPaymentOrderResponseCopyWith<$Res> {
  _$CreateGiftCardPaymentOrderResponseCopyWithImpl(this._self, this._then);

  final CreateGiftCardPaymentOrderResponse _self;
  final $Res Function(CreateGiftCardPaymentOrderResponse) _then;

/// Create a copy of CreateGiftCardPaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? razorpayOrderId = null,Object? razorpayAmountInPaise = null,Object? currency = null,Object? razorpayKeyId = null,Object? orderId = null,Object? productName = null,Object? requestedAmount = null,Object? discountPercentage = null,Object? discountAmount = null,Object? payableAmount = null,}) {
  return _then(_self.copyWith(
razorpayOrderId: null == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String,razorpayAmountInPaise: null == razorpayAmountInPaise ? _self.razorpayAmountInPaise : razorpayAmountInPaise // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,razorpayKeyId: null == razorpayKeyId ? _self.razorpayKeyId : razorpayKeyId // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,requestedAmount: null == requestedAmount ? _self.requestedAmount : requestedAmount // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,payableAmount: null == payableAmount ? _self.payableAmount : payableAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateGiftCardPaymentOrderResponse].
extension CreateGiftCardPaymentOrderResponsePatterns on CreateGiftCardPaymentOrderResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateGiftCardPaymentOrderResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateGiftCardPaymentOrderResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateGiftCardPaymentOrderResponse value)  $default,){
final _that = this;
switch (_that) {
case _CreateGiftCardPaymentOrderResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateGiftCardPaymentOrderResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CreateGiftCardPaymentOrderResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String razorpayOrderId,  int razorpayAmountInPaise,  String currency,  String razorpayKeyId,  int orderId,  String productName,  double requestedAmount,  double discountPercentage,  double discountAmount,  double payableAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateGiftCardPaymentOrderResponse() when $default != null:
return $default(_that.razorpayOrderId,_that.razorpayAmountInPaise,_that.currency,_that.razorpayKeyId,_that.orderId,_that.productName,_that.requestedAmount,_that.discountPercentage,_that.discountAmount,_that.payableAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String razorpayOrderId,  int razorpayAmountInPaise,  String currency,  String razorpayKeyId,  int orderId,  String productName,  double requestedAmount,  double discountPercentage,  double discountAmount,  double payableAmount)  $default,) {final _that = this;
switch (_that) {
case _CreateGiftCardPaymentOrderResponse():
return $default(_that.razorpayOrderId,_that.razorpayAmountInPaise,_that.currency,_that.razorpayKeyId,_that.orderId,_that.productName,_that.requestedAmount,_that.discountPercentage,_that.discountAmount,_that.payableAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String razorpayOrderId,  int razorpayAmountInPaise,  String currency,  String razorpayKeyId,  int orderId,  String productName,  double requestedAmount,  double discountPercentage,  double discountAmount,  double payableAmount)?  $default,) {final _that = this;
switch (_that) {
case _CreateGiftCardPaymentOrderResponse() when $default != null:
return $default(_that.razorpayOrderId,_that.razorpayAmountInPaise,_that.currency,_that.razorpayKeyId,_that.orderId,_that.productName,_that.requestedAmount,_that.discountPercentage,_that.discountAmount,_that.payableAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateGiftCardPaymentOrderResponse implements CreateGiftCardPaymentOrderResponse {
  const _CreateGiftCardPaymentOrderResponse({required this.razorpayOrderId, required this.razorpayAmountInPaise, required this.currency, required this.razorpayKeyId, required this.orderId, required this.productName, required this.requestedAmount, required this.discountPercentage, required this.discountAmount, required this.payableAmount});
  factory _CreateGiftCardPaymentOrderResponse.fromJson(Map<String, dynamic> json) => _$CreateGiftCardPaymentOrderResponseFromJson(json);

@override final  String razorpayOrderId;
@override final  int razorpayAmountInPaise;
@override final  String currency;
@override final  String razorpayKeyId;
@override final  int orderId;
@override final  String productName;
@override final  double requestedAmount;
@override final  double discountPercentage;
@override final  double discountAmount;
@override final  double payableAmount;

/// Create a copy of CreateGiftCardPaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateGiftCardPaymentOrderResponseCopyWith<_CreateGiftCardPaymentOrderResponse> get copyWith => __$CreateGiftCardPaymentOrderResponseCopyWithImpl<_CreateGiftCardPaymentOrderResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateGiftCardPaymentOrderResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateGiftCardPaymentOrderResponse&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayAmountInPaise, razorpayAmountInPaise) || other.razorpayAmountInPaise == razorpayAmountInPaise)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.razorpayKeyId, razorpayKeyId) || other.razorpayKeyId == razorpayKeyId)&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.requestedAmount, requestedAmount) || other.requestedAmount == requestedAmount)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.payableAmount, payableAmount) || other.payableAmount == payableAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,razorpayOrderId,razorpayAmountInPaise,currency,razorpayKeyId,orderId,productName,requestedAmount,discountPercentage,discountAmount,payableAmount);

@override
String toString() {
  return 'CreateGiftCardPaymentOrderResponse(razorpayOrderId: $razorpayOrderId, razorpayAmountInPaise: $razorpayAmountInPaise, currency: $currency, razorpayKeyId: $razorpayKeyId, orderId: $orderId, productName: $productName, requestedAmount: $requestedAmount, discountPercentage: $discountPercentage, discountAmount: $discountAmount, payableAmount: $payableAmount)';
}


}

/// @nodoc
abstract mixin class _$CreateGiftCardPaymentOrderResponseCopyWith<$Res> implements $CreateGiftCardPaymentOrderResponseCopyWith<$Res> {
  factory _$CreateGiftCardPaymentOrderResponseCopyWith(_CreateGiftCardPaymentOrderResponse value, $Res Function(_CreateGiftCardPaymentOrderResponse) _then) = __$CreateGiftCardPaymentOrderResponseCopyWithImpl;
@override @useResult
$Res call({
 String razorpayOrderId, int razorpayAmountInPaise, String currency, String razorpayKeyId, int orderId, String productName, double requestedAmount, double discountPercentage, double discountAmount, double payableAmount
});




}
/// @nodoc
class __$CreateGiftCardPaymentOrderResponseCopyWithImpl<$Res>
    implements _$CreateGiftCardPaymentOrderResponseCopyWith<$Res> {
  __$CreateGiftCardPaymentOrderResponseCopyWithImpl(this._self, this._then);

  final _CreateGiftCardPaymentOrderResponse _self;
  final $Res Function(_CreateGiftCardPaymentOrderResponse) _then;

/// Create a copy of CreateGiftCardPaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? razorpayOrderId = null,Object? razorpayAmountInPaise = null,Object? currency = null,Object? razorpayKeyId = null,Object? orderId = null,Object? productName = null,Object? requestedAmount = null,Object? discountPercentage = null,Object? discountAmount = null,Object? payableAmount = null,}) {
  return _then(_CreateGiftCardPaymentOrderResponse(
razorpayOrderId: null == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String,razorpayAmountInPaise: null == razorpayAmountInPaise ? _self.razorpayAmountInPaise : razorpayAmountInPaise // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,razorpayKeyId: null == razorpayKeyId ? _self.razorpayKeyId : razorpayKeyId // ignore: cast_nullable_to_non_nullable
as String,orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,productName: null == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String,requestedAmount: null == requestedAmount ? _self.requestedAmount : requestedAmount // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,payableAmount: null == payableAmount ? _self.payableAmount : payableAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$VerifyGiftCardPaymentRequest {

 int get orderId; String get razorpayOrderId; String get razorpayPaymentId; String get razorpaySignature;
/// Create a copy of VerifyGiftCardPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyGiftCardPaymentRequestCopyWith<VerifyGiftCardPaymentRequest> get copyWith => _$VerifyGiftCardPaymentRequestCopyWithImpl<VerifyGiftCardPaymentRequest>(this as VerifyGiftCardPaymentRequest, _$identity);

  /// Serializes this VerifyGiftCardPaymentRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyGiftCardPaymentRequest&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.razorpaySignature, razorpaySignature) || other.razorpaySignature == razorpaySignature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,razorpayOrderId,razorpayPaymentId,razorpaySignature);

@override
String toString() {
  return 'VerifyGiftCardPaymentRequest(orderId: $orderId, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, razorpaySignature: $razorpaySignature)';
}


}

/// @nodoc
abstract mixin class $VerifyGiftCardPaymentRequestCopyWith<$Res>  {
  factory $VerifyGiftCardPaymentRequestCopyWith(VerifyGiftCardPaymentRequest value, $Res Function(VerifyGiftCardPaymentRequest) _then) = _$VerifyGiftCardPaymentRequestCopyWithImpl;
@useResult
$Res call({
 int orderId, String razorpayOrderId, String razorpayPaymentId, String razorpaySignature
});




}
/// @nodoc
class _$VerifyGiftCardPaymentRequestCopyWithImpl<$Res>
    implements $VerifyGiftCardPaymentRequestCopyWith<$Res> {
  _$VerifyGiftCardPaymentRequestCopyWithImpl(this._self, this._then);

  final VerifyGiftCardPaymentRequest _self;
  final $Res Function(VerifyGiftCardPaymentRequest) _then;

/// Create a copy of VerifyGiftCardPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? razorpayOrderId = null,Object? razorpayPaymentId = null,Object? razorpaySignature = null,}) {
  return _then(_self.copyWith(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,razorpayOrderId: null == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String,razorpayPaymentId: null == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String,razorpaySignature: null == razorpaySignature ? _self.razorpaySignature : razorpaySignature // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyGiftCardPaymentRequest].
extension VerifyGiftCardPaymentRequestPatterns on VerifyGiftCardPaymentRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyGiftCardPaymentRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyGiftCardPaymentRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyGiftCardPaymentRequest value)  $default,){
final _that = this;
switch (_that) {
case _VerifyGiftCardPaymentRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyGiftCardPaymentRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyGiftCardPaymentRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int orderId,  String razorpayOrderId,  String razorpayPaymentId,  String razorpaySignature)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyGiftCardPaymentRequest() when $default != null:
return $default(_that.orderId,_that.razorpayOrderId,_that.razorpayPaymentId,_that.razorpaySignature);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int orderId,  String razorpayOrderId,  String razorpayPaymentId,  String razorpaySignature)  $default,) {final _that = this;
switch (_that) {
case _VerifyGiftCardPaymentRequest():
return $default(_that.orderId,_that.razorpayOrderId,_that.razorpayPaymentId,_that.razorpaySignature);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int orderId,  String razorpayOrderId,  String razorpayPaymentId,  String razorpaySignature)?  $default,) {final _that = this;
switch (_that) {
case _VerifyGiftCardPaymentRequest() when $default != null:
return $default(_that.orderId,_that.razorpayOrderId,_that.razorpayPaymentId,_that.razorpaySignature);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyGiftCardPaymentRequest implements VerifyGiftCardPaymentRequest {
  const _VerifyGiftCardPaymentRequest({required this.orderId, required this.razorpayOrderId, required this.razorpayPaymentId, required this.razorpaySignature});
  factory _VerifyGiftCardPaymentRequest.fromJson(Map<String, dynamic> json) => _$VerifyGiftCardPaymentRequestFromJson(json);

@override final  int orderId;
@override final  String razorpayOrderId;
@override final  String razorpayPaymentId;
@override final  String razorpaySignature;

/// Create a copy of VerifyGiftCardPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyGiftCardPaymentRequestCopyWith<_VerifyGiftCardPaymentRequest> get copyWith => __$VerifyGiftCardPaymentRequestCopyWithImpl<_VerifyGiftCardPaymentRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyGiftCardPaymentRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyGiftCardPaymentRequest&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.razorpaySignature, razorpaySignature) || other.razorpaySignature == razorpaySignature));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,razorpayOrderId,razorpayPaymentId,razorpaySignature);

@override
String toString() {
  return 'VerifyGiftCardPaymentRequest(orderId: $orderId, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, razorpaySignature: $razorpaySignature)';
}


}

/// @nodoc
abstract mixin class _$VerifyGiftCardPaymentRequestCopyWith<$Res> implements $VerifyGiftCardPaymentRequestCopyWith<$Res> {
  factory _$VerifyGiftCardPaymentRequestCopyWith(_VerifyGiftCardPaymentRequest value, $Res Function(_VerifyGiftCardPaymentRequest) _then) = __$VerifyGiftCardPaymentRequestCopyWithImpl;
@override @useResult
$Res call({
 int orderId, String razorpayOrderId, String razorpayPaymentId, String razorpaySignature
});




}
/// @nodoc
class __$VerifyGiftCardPaymentRequestCopyWithImpl<$Res>
    implements _$VerifyGiftCardPaymentRequestCopyWith<$Res> {
  __$VerifyGiftCardPaymentRequestCopyWithImpl(this._self, this._then);

  final _VerifyGiftCardPaymentRequest _self;
  final $Res Function(_VerifyGiftCardPaymentRequest) _then;

/// Create a copy of VerifyGiftCardPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? razorpayOrderId = null,Object? razorpayPaymentId = null,Object? razorpaySignature = null,}) {
  return _then(_VerifyGiftCardPaymentRequest(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,razorpayOrderId: null == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String,razorpayPaymentId: null == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String,razorpaySignature: null == razorpaySignature ? _self.razorpaySignature : razorpaySignature // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
