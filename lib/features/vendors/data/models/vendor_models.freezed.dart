// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vendor_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VendorResponse {

 int get id; String get businessName; String? get description; String? get contactEmail; String? get contactPhone; String? get address; String? get city; String? get state; String? get pinCode; String get category; String? get website; String get approvalStatus; bool get isActive; DateTime? get approvedAt; String? get approvedBy; DateTime? get createdAt; List<VendorImageDto> get images; List<VendorSocialMediaDto> get socialMediaLinks;
/// Create a copy of VendorResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorResponseCopyWith<VendorResponse> get copyWith => _$VendorResponseCopyWithImpl<VendorResponse>(this as VendorResponse, _$identity);

  /// Serializes this VendorResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.description, description) || other.description == description)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pinCode, pinCode) || other.pinCode == pinCode)&&(identical(other.category, category) || other.category == category)&&(identical(other.website, website) || other.website == website)&&(identical(other.approvalStatus, approvalStatus) || other.approvalStatus == approvalStatus)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.images, images)&&const DeepCollectionEquality().equals(other.socialMediaLinks, socialMediaLinks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,businessName,description,contactEmail,contactPhone,address,city,state,pinCode,category,website,approvalStatus,isActive,approvedAt,approvedBy,createdAt,const DeepCollectionEquality().hash(images),const DeepCollectionEquality().hash(socialMediaLinks));

@override
String toString() {
  return 'VendorResponse(id: $id, businessName: $businessName, description: $description, contactEmail: $contactEmail, contactPhone: $contactPhone, address: $address, city: $city, state: $state, pinCode: $pinCode, category: $category, website: $website, approvalStatus: $approvalStatus, isActive: $isActive, approvedAt: $approvedAt, approvedBy: $approvedBy, createdAt: $createdAt, images: $images, socialMediaLinks: $socialMediaLinks)';
}


}

/// @nodoc
abstract mixin class $VendorResponseCopyWith<$Res>  {
  factory $VendorResponseCopyWith(VendorResponse value, $Res Function(VendorResponse) _then) = _$VendorResponseCopyWithImpl;
@useResult
$Res call({
 int id, String businessName, String? description, String? contactEmail, String? contactPhone, String? address, String? city, String? state, String? pinCode, String category, String? website, String approvalStatus, bool isActive, DateTime? approvedAt, String? approvedBy, DateTime? createdAt, List<VendorImageDto> images, List<VendorSocialMediaDto> socialMediaLinks
});




}
/// @nodoc
class _$VendorResponseCopyWithImpl<$Res>
    implements $VendorResponseCopyWith<$Res> {
  _$VendorResponseCopyWithImpl(this._self, this._then);

  final VendorResponse _self;
  final $Res Function(VendorResponse) _then;

/// Create a copy of VendorResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? businessName = null,Object? description = freezed,Object? contactEmail = freezed,Object? contactPhone = freezed,Object? address = freezed,Object? city = freezed,Object? state = freezed,Object? pinCode = freezed,Object? category = null,Object? website = freezed,Object? approvalStatus = null,Object? isActive = null,Object? approvedAt = freezed,Object? approvedBy = freezed,Object? createdAt = freezed,Object? images = null,Object? socialMediaLinks = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,contactEmail: freezed == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,pinCode: freezed == pinCode ? _self.pinCode : pinCode // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,approvalStatus: null == approvalStatus ? _self.approvalStatus : approvalStatus // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,approvedAt: freezed == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<VendorImageDto>,socialMediaLinks: null == socialMediaLinks ? _self.socialMediaLinks : socialMediaLinks // ignore: cast_nullable_to_non_nullable
as List<VendorSocialMediaDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorResponse].
extension VendorResponsePatterns on VendorResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorResponse value)  $default,){
final _that = this;
switch (_that) {
case _VendorResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VendorResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String businessName,  String? description,  String? contactEmail,  String? contactPhone,  String? address,  String? city,  String? state,  String? pinCode,  String category,  String? website,  String approvalStatus,  bool isActive,  DateTime? approvedAt,  String? approvedBy,  DateTime? createdAt,  List<VendorImageDto> images,  List<VendorSocialMediaDto> socialMediaLinks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorResponse() when $default != null:
return $default(_that.id,_that.businessName,_that.description,_that.contactEmail,_that.contactPhone,_that.address,_that.city,_that.state,_that.pinCode,_that.category,_that.website,_that.approvalStatus,_that.isActive,_that.approvedAt,_that.approvedBy,_that.createdAt,_that.images,_that.socialMediaLinks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String businessName,  String? description,  String? contactEmail,  String? contactPhone,  String? address,  String? city,  String? state,  String? pinCode,  String category,  String? website,  String approvalStatus,  bool isActive,  DateTime? approvedAt,  String? approvedBy,  DateTime? createdAt,  List<VendorImageDto> images,  List<VendorSocialMediaDto> socialMediaLinks)  $default,) {final _that = this;
switch (_that) {
case _VendorResponse():
return $default(_that.id,_that.businessName,_that.description,_that.contactEmail,_that.contactPhone,_that.address,_that.city,_that.state,_that.pinCode,_that.category,_that.website,_that.approvalStatus,_that.isActive,_that.approvedAt,_that.approvedBy,_that.createdAt,_that.images,_that.socialMediaLinks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String businessName,  String? description,  String? contactEmail,  String? contactPhone,  String? address,  String? city,  String? state,  String? pinCode,  String category,  String? website,  String approvalStatus,  bool isActive,  DateTime? approvedAt,  String? approvedBy,  DateTime? createdAt,  List<VendorImageDto> images,  List<VendorSocialMediaDto> socialMediaLinks)?  $default,) {final _that = this;
switch (_that) {
case _VendorResponse() when $default != null:
return $default(_that.id,_that.businessName,_that.description,_that.contactEmail,_that.contactPhone,_that.address,_that.city,_that.state,_that.pinCode,_that.category,_that.website,_that.approvalStatus,_that.isActive,_that.approvedAt,_that.approvedBy,_that.createdAt,_that.images,_that.socialMediaLinks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VendorResponse implements VendorResponse {
  const _VendorResponse({required this.id, required this.businessName, this.description, this.contactEmail, this.contactPhone, this.address, this.city, this.state, this.pinCode, required this.category, this.website, this.approvalStatus = 'Approved', required this.isActive, this.approvedAt, this.approvedBy, this.createdAt, final  List<VendorImageDto> images = const [], final  List<VendorSocialMediaDto> socialMediaLinks = const []}): _images = images,_socialMediaLinks = socialMediaLinks;
  factory _VendorResponse.fromJson(Map<String, dynamic> json) => _$VendorResponseFromJson(json);

@override final  int id;
@override final  String businessName;
@override final  String? description;
@override final  String? contactEmail;
@override final  String? contactPhone;
@override final  String? address;
@override final  String? city;
@override final  String? state;
@override final  String? pinCode;
@override final  String category;
@override final  String? website;
@override@JsonKey() final  String approvalStatus;
@override final  bool isActive;
@override final  DateTime? approvedAt;
@override final  String? approvedBy;
@override final  DateTime? createdAt;
 final  List<VendorImageDto> _images;
@override@JsonKey() List<VendorImageDto> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

 final  List<VendorSocialMediaDto> _socialMediaLinks;
@override@JsonKey() List<VendorSocialMediaDto> get socialMediaLinks {
  if (_socialMediaLinks is EqualUnmodifiableListView) return _socialMediaLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_socialMediaLinks);
}


/// Create a copy of VendorResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorResponseCopyWith<_VendorResponse> get copyWith => __$VendorResponseCopyWithImpl<_VendorResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VendorResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.description, description) || other.description == description)&&(identical(other.contactEmail, contactEmail) || other.contactEmail == contactEmail)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.pinCode, pinCode) || other.pinCode == pinCode)&&(identical(other.category, category) || other.category == category)&&(identical(other.website, website) || other.website == website)&&(identical(other.approvalStatus, approvalStatus) || other.approvalStatus == approvalStatus)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._images, _images)&&const DeepCollectionEquality().equals(other._socialMediaLinks, _socialMediaLinks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,businessName,description,contactEmail,contactPhone,address,city,state,pinCode,category,website,approvalStatus,isActive,approvedAt,approvedBy,createdAt,const DeepCollectionEquality().hash(_images),const DeepCollectionEquality().hash(_socialMediaLinks));

@override
String toString() {
  return 'VendorResponse(id: $id, businessName: $businessName, description: $description, contactEmail: $contactEmail, contactPhone: $contactPhone, address: $address, city: $city, state: $state, pinCode: $pinCode, category: $category, website: $website, approvalStatus: $approvalStatus, isActive: $isActive, approvedAt: $approvedAt, approvedBy: $approvedBy, createdAt: $createdAt, images: $images, socialMediaLinks: $socialMediaLinks)';
}


}

/// @nodoc
abstract mixin class _$VendorResponseCopyWith<$Res> implements $VendorResponseCopyWith<$Res> {
  factory _$VendorResponseCopyWith(_VendorResponse value, $Res Function(_VendorResponse) _then) = __$VendorResponseCopyWithImpl;
@override @useResult
$Res call({
 int id, String businessName, String? description, String? contactEmail, String? contactPhone, String? address, String? city, String? state, String? pinCode, String category, String? website, String approvalStatus, bool isActive, DateTime? approvedAt, String? approvedBy, DateTime? createdAt, List<VendorImageDto> images, List<VendorSocialMediaDto> socialMediaLinks
});




}
/// @nodoc
class __$VendorResponseCopyWithImpl<$Res>
    implements _$VendorResponseCopyWith<$Res> {
  __$VendorResponseCopyWithImpl(this._self, this._then);

  final _VendorResponse _self;
  final $Res Function(_VendorResponse) _then;

/// Create a copy of VendorResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? businessName = null,Object? description = freezed,Object? contactEmail = freezed,Object? contactPhone = freezed,Object? address = freezed,Object? city = freezed,Object? state = freezed,Object? pinCode = freezed,Object? category = null,Object? website = freezed,Object? approvalStatus = null,Object? isActive = null,Object? approvedAt = freezed,Object? approvedBy = freezed,Object? createdAt = freezed,Object? images = null,Object? socialMediaLinks = null,}) {
  return _then(_VendorResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,contactEmail: freezed == contactEmail ? _self.contactEmail : contactEmail // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,pinCode: freezed == pinCode ? _self.pinCode : pinCode // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,approvalStatus: null == approvalStatus ? _self.approvalStatus : approvalStatus // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,approvedAt: freezed == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<VendorImageDto>,socialMediaLinks: null == socialMediaLinks ? _self._socialMediaLinks : socialMediaLinks // ignore: cast_nullable_to_non_nullable
as List<VendorSocialMediaDto>,
  ));
}


}


/// @nodoc
mixin _$VendorImageDto {

 int get id; String get imageUrl; String? get altText; int get displayOrder; bool get isPrimary; ImageType get imageType; String get imageTypeName;
/// Create a copy of VendorImageDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorImageDtoCopyWith<VendorImageDto> get copyWith => _$VendorImageDtoCopyWithImpl<VendorImageDto>(this as VendorImageDto, _$identity);

  /// Serializes this VendorImageDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorImageDto&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.altText, altText) || other.altText == altText)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.imageType, imageType) || other.imageType == imageType)&&(identical(other.imageTypeName, imageTypeName) || other.imageTypeName == imageTypeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageUrl,altText,displayOrder,isPrimary,imageType,imageTypeName);

@override
String toString() {
  return 'VendorImageDto(id: $id, imageUrl: $imageUrl, altText: $altText, displayOrder: $displayOrder, isPrimary: $isPrimary, imageType: $imageType, imageTypeName: $imageTypeName)';
}


}

/// @nodoc
abstract mixin class $VendorImageDtoCopyWith<$Res>  {
  factory $VendorImageDtoCopyWith(VendorImageDto value, $Res Function(VendorImageDto) _then) = _$VendorImageDtoCopyWithImpl;
@useResult
$Res call({
 int id, String imageUrl, String? altText, int displayOrder, bool isPrimary, ImageType imageType, String imageTypeName
});




}
/// @nodoc
class _$VendorImageDtoCopyWithImpl<$Res>
    implements $VendorImageDtoCopyWith<$Res> {
  _$VendorImageDtoCopyWithImpl(this._self, this._then);

  final VendorImageDto _self;
  final $Res Function(VendorImageDto) _then;

/// Create a copy of VendorImageDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imageUrl = null,Object? altText = freezed,Object? displayOrder = null,Object? isPrimary = null,Object? imageType = null,Object? imageTypeName = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,altText: freezed == altText ? _self.altText : altText // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,imageType: null == imageType ? _self.imageType : imageType // ignore: cast_nullable_to_non_nullable
as ImageType,imageTypeName: null == imageTypeName ? _self.imageTypeName : imageTypeName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorImageDto].
extension VendorImageDtoPatterns on VendorImageDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorImageDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorImageDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorImageDto value)  $default,){
final _that = this;
switch (_that) {
case _VendorImageDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorImageDto value)?  $default,){
final _that = this;
switch (_that) {
case _VendorImageDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String imageUrl,  String? altText,  int displayOrder,  bool isPrimary,  ImageType imageType,  String imageTypeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorImageDto() when $default != null:
return $default(_that.id,_that.imageUrl,_that.altText,_that.displayOrder,_that.isPrimary,_that.imageType,_that.imageTypeName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String imageUrl,  String? altText,  int displayOrder,  bool isPrimary,  ImageType imageType,  String imageTypeName)  $default,) {final _that = this;
switch (_that) {
case _VendorImageDto():
return $default(_that.id,_that.imageUrl,_that.altText,_that.displayOrder,_that.isPrimary,_that.imageType,_that.imageTypeName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String imageUrl,  String? altText,  int displayOrder,  bool isPrimary,  ImageType imageType,  String imageTypeName)?  $default,) {final _that = this;
switch (_that) {
case _VendorImageDto() when $default != null:
return $default(_that.id,_that.imageUrl,_that.altText,_that.displayOrder,_that.isPrimary,_that.imageType,_that.imageTypeName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VendorImageDto implements VendorImageDto {
  const _VendorImageDto({this.id = 0, required this.imageUrl, this.altText, this.displayOrder = 0, required this.isPrimary, this.imageType = ImageType.gallery, this.imageTypeName = 'Gallery'});
  factory _VendorImageDto.fromJson(Map<String, dynamic> json) => _$VendorImageDtoFromJson(json);

@override@JsonKey() final  int id;
@override final  String imageUrl;
@override final  String? altText;
@override@JsonKey() final  int displayOrder;
@override final  bool isPrimary;
@override@JsonKey() final  ImageType imageType;
@override@JsonKey() final  String imageTypeName;

/// Create a copy of VendorImageDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorImageDtoCopyWith<_VendorImageDto> get copyWith => __$VendorImageDtoCopyWithImpl<_VendorImageDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VendorImageDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorImageDto&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.altText, altText) || other.altText == altText)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder)&&(identical(other.isPrimary, isPrimary) || other.isPrimary == isPrimary)&&(identical(other.imageType, imageType) || other.imageType == imageType)&&(identical(other.imageTypeName, imageTypeName) || other.imageTypeName == imageTypeName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,imageUrl,altText,displayOrder,isPrimary,imageType,imageTypeName);

@override
String toString() {
  return 'VendorImageDto(id: $id, imageUrl: $imageUrl, altText: $altText, displayOrder: $displayOrder, isPrimary: $isPrimary, imageType: $imageType, imageTypeName: $imageTypeName)';
}


}

/// @nodoc
abstract mixin class _$VendorImageDtoCopyWith<$Res> implements $VendorImageDtoCopyWith<$Res> {
  factory _$VendorImageDtoCopyWith(_VendorImageDto value, $Res Function(_VendorImageDto) _then) = __$VendorImageDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String imageUrl, String? altText, int displayOrder, bool isPrimary, ImageType imageType, String imageTypeName
});




}
/// @nodoc
class __$VendorImageDtoCopyWithImpl<$Res>
    implements _$VendorImageDtoCopyWith<$Res> {
  __$VendorImageDtoCopyWithImpl(this._self, this._then);

  final _VendorImageDto _self;
  final $Res Function(_VendorImageDto) _then;

/// Create a copy of VendorImageDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageUrl = null,Object? altText = freezed,Object? displayOrder = null,Object? isPrimary = null,Object? imageType = null,Object? imageTypeName = null,}) {
  return _then(_VendorImageDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,altText: freezed == altText ? _self.altText : altText // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,isPrimary: null == isPrimary ? _self.isPrimary : isPrimary // ignore: cast_nullable_to_non_nullable
as bool,imageType: null == imageType ? _self.imageType : imageType // ignore: cast_nullable_to_non_nullable
as ImageType,imageTypeName: null == imageTypeName ? _self.imageTypeName : imageTypeName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VendorSocialMediaDto {

 int get id; SocialMediaPlatform? get platform; String? get platformName; String get url; bool get isActive;
/// Create a copy of VendorSocialMediaDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorSocialMediaDtoCopyWith<VendorSocialMediaDto> get copyWith => _$VendorSocialMediaDtoCopyWithImpl<VendorSocialMediaDto>(this as VendorSocialMediaDto, _$identity);

  /// Serializes this VendorSocialMediaDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorSocialMediaDto&&(identical(other.id, id) || other.id == id)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.platformName, platformName) || other.platformName == platformName)&&(identical(other.url, url) || other.url == url)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,platform,platformName,url,isActive);

@override
String toString() {
  return 'VendorSocialMediaDto(id: $id, platform: $platform, platformName: $platformName, url: $url, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $VendorSocialMediaDtoCopyWith<$Res>  {
  factory $VendorSocialMediaDtoCopyWith(VendorSocialMediaDto value, $Res Function(VendorSocialMediaDto) _then) = _$VendorSocialMediaDtoCopyWithImpl;
@useResult
$Res call({
 int id, SocialMediaPlatform? platform, String? platformName, String url, bool isActive
});




}
/// @nodoc
class _$VendorSocialMediaDtoCopyWithImpl<$Res>
    implements $VendorSocialMediaDtoCopyWith<$Res> {
  _$VendorSocialMediaDtoCopyWithImpl(this._self, this._then);

  final VendorSocialMediaDto _self;
  final $Res Function(VendorSocialMediaDto) _then;

/// Create a copy of VendorSocialMediaDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? platform = freezed,Object? platformName = freezed,Object? url = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as SocialMediaPlatform?,platformName: freezed == platformName ? _self.platformName : platformName // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorSocialMediaDto].
extension VendorSocialMediaDtoPatterns on VendorSocialMediaDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorSocialMediaDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorSocialMediaDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorSocialMediaDto value)  $default,){
final _that = this;
switch (_that) {
case _VendorSocialMediaDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorSocialMediaDto value)?  $default,){
final _that = this;
switch (_that) {
case _VendorSocialMediaDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  SocialMediaPlatform? platform,  String? platformName,  String url,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorSocialMediaDto() when $default != null:
return $default(_that.id,_that.platform,_that.platformName,_that.url,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  SocialMediaPlatform? platform,  String? platformName,  String url,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _VendorSocialMediaDto():
return $default(_that.id,_that.platform,_that.platformName,_that.url,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  SocialMediaPlatform? platform,  String? platformName,  String url,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _VendorSocialMediaDto() when $default != null:
return $default(_that.id,_that.platform,_that.platformName,_that.url,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VendorSocialMediaDto implements VendorSocialMediaDto {
  const _VendorSocialMediaDto({this.id = 0, this.platform, this.platformName, required this.url, this.isActive = true});
  factory _VendorSocialMediaDto.fromJson(Map<String, dynamic> json) => _$VendorSocialMediaDtoFromJson(json);

@override@JsonKey() final  int id;
@override final  SocialMediaPlatform? platform;
@override final  String? platformName;
@override final  String url;
@override@JsonKey() final  bool isActive;

/// Create a copy of VendorSocialMediaDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorSocialMediaDtoCopyWith<_VendorSocialMediaDto> get copyWith => __$VendorSocialMediaDtoCopyWithImpl<_VendorSocialMediaDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VendorSocialMediaDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorSocialMediaDto&&(identical(other.id, id) || other.id == id)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.platformName, platformName) || other.platformName == platformName)&&(identical(other.url, url) || other.url == url)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,platform,platformName,url,isActive);

@override
String toString() {
  return 'VendorSocialMediaDto(id: $id, platform: $platform, platformName: $platformName, url: $url, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$VendorSocialMediaDtoCopyWith<$Res> implements $VendorSocialMediaDtoCopyWith<$Res> {
  factory _$VendorSocialMediaDtoCopyWith(_VendorSocialMediaDto value, $Res Function(_VendorSocialMediaDto) _then) = __$VendorSocialMediaDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, SocialMediaPlatform? platform, String? platformName, String url, bool isActive
});




}
/// @nodoc
class __$VendorSocialMediaDtoCopyWithImpl<$Res>
    implements _$VendorSocialMediaDtoCopyWith<$Res> {
  __$VendorSocialMediaDtoCopyWithImpl(this._self, this._then);

  final _VendorSocialMediaDto _self;
  final $Res Function(_VendorSocialMediaDto) _then;

/// Create a copy of VendorSocialMediaDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? platform = freezed,Object? platformName = freezed,Object? url = null,Object? isActive = null,}) {
  return _then(_VendorSocialMediaDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as SocialMediaPlatform?,platformName: freezed == platformName ? _self.platformName : platformName // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PaginatedVendorsResponse {

 List<VendorResponse> get items; int get totalCount; int get pageNumber; int get pageSize; int get totalPages; bool get hasNextPage; bool get hasPreviousPage;
/// Create a copy of PaginatedVendorsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedVendorsResponseCopyWith<PaginatedVendorsResponse> get copyWith => _$PaginatedVendorsResponseCopyWithImpl<PaginatedVendorsResponse>(this as PaginatedVendorsResponse, _$identity);

  /// Serializes this PaginatedVendorsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedVendorsResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),totalCount,pageNumber,pageSize,totalPages,hasNextPage,hasPreviousPage);

@override
String toString() {
  return 'PaginatedVendorsResponse(items: $items, totalCount: $totalCount, pageNumber: $pageNumber, pageSize: $pageSize, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
}


}

/// @nodoc
abstract mixin class $PaginatedVendorsResponseCopyWith<$Res>  {
  factory $PaginatedVendorsResponseCopyWith(PaginatedVendorsResponse value, $Res Function(PaginatedVendorsResponse) _then) = _$PaginatedVendorsResponseCopyWithImpl;
@useResult
$Res call({
 List<VendorResponse> items, int totalCount, int pageNumber, int pageSize, int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class _$PaginatedVendorsResponseCopyWithImpl<$Res>
    implements $PaginatedVendorsResponseCopyWith<$Res> {
  _$PaginatedVendorsResponseCopyWithImpl(this._self, this._then);

  final PaginatedVendorsResponse _self;
  final $Res Function(PaginatedVendorsResponse) _then;

/// Create a copy of PaginatedVendorsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalCount = null,Object? pageNumber = null,Object? pageSize = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<VendorResponse>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedVendorsResponse].
extension PaginatedVendorsResponsePatterns on PaginatedVendorsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedVendorsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedVendorsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedVendorsResponse value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedVendorsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedVendorsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedVendorsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VendorResponse> items,  int totalCount,  int pageNumber,  int pageSize,  int totalPages,  bool hasNextPage,  bool hasPreviousPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedVendorsResponse() when $default != null:
return $default(_that.items,_that.totalCount,_that.pageNumber,_that.pageSize,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VendorResponse> items,  int totalCount,  int pageNumber,  int pageSize,  int totalPages,  bool hasNextPage,  bool hasPreviousPage)  $default,) {final _that = this;
switch (_that) {
case _PaginatedVendorsResponse():
return $default(_that.items,_that.totalCount,_that.pageNumber,_that.pageSize,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VendorResponse> items,  int totalCount,  int pageNumber,  int pageSize,  int totalPages,  bool hasNextPage,  bool hasPreviousPage)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedVendorsResponse() when $default != null:
return $default(_that.items,_that.totalCount,_that.pageNumber,_that.pageSize,_that.totalPages,_that.hasNextPage,_that.hasPreviousPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedVendorsResponse implements PaginatedVendorsResponse {
  const _PaginatedVendorsResponse({required final  List<VendorResponse> items, required this.totalCount, required this.pageNumber, required this.pageSize, required this.totalPages, required this.hasNextPage, required this.hasPreviousPage}): _items = items;
  factory _PaginatedVendorsResponse.fromJson(Map<String, dynamic> json) => _$PaginatedVendorsResponseFromJson(json);

 final  List<VendorResponse> _items;
@override List<VendorResponse> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int totalCount;
@override final  int pageNumber;
@override final  int pageSize;
@override final  int totalPages;
@override final  bool hasNextPage;
@override final  bool hasPreviousPage;

/// Create a copy of PaginatedVendorsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedVendorsResponseCopyWith<_PaginatedVendorsResponse> get copyWith => __$PaginatedVendorsResponseCopyWithImpl<_PaginatedVendorsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedVendorsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedVendorsResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,pageNumber,pageSize,totalPages,hasNextPage,hasPreviousPage);

@override
String toString() {
  return 'PaginatedVendorsResponse(items: $items, totalCount: $totalCount, pageNumber: $pageNumber, pageSize: $pageSize, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
}


}

/// @nodoc
abstract mixin class _$PaginatedVendorsResponseCopyWith<$Res> implements $PaginatedVendorsResponseCopyWith<$Res> {
  factory _$PaginatedVendorsResponseCopyWith(_PaginatedVendorsResponse value, $Res Function(_PaginatedVendorsResponse) _then) = __$PaginatedVendorsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<VendorResponse> items, int totalCount, int pageNumber, int pageSize, int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class __$PaginatedVendorsResponseCopyWithImpl<$Res>
    implements _$PaginatedVendorsResponseCopyWith<$Res> {
  __$PaginatedVendorsResponseCopyWithImpl(this._self, this._then);

  final _PaginatedVendorsResponse _self;
  final $Res Function(_PaginatedVendorsResponse) _then;

/// Create a copy of PaginatedVendorsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? pageNumber = null,Object? pageSize = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(_PaginatedVendorsResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<VendorResponse>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
