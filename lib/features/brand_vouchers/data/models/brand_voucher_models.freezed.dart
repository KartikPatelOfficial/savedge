// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_voucher_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BrandVoucher {

 int get id; String get brandName; String get brandDescription; String get brandImageUrl; String get brandWebsiteUrl; double get minimumAmount; double get maximumAmount; double get processingFeePercentage; bool get isActive; String? get terms; String? get instructions; DateTime get created;
/// Create a copy of BrandVoucher
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandVoucherCopyWith<BrandVoucher> get copyWith => _$BrandVoucherCopyWithImpl<BrandVoucher>(this as BrandVoucher, _$identity);

  /// Serializes this BrandVoucher to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandVoucher&&(identical(other.id, id) || other.id == id)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandDescription, brandDescription) || other.brandDescription == brandDescription)&&(identical(other.brandImageUrl, brandImageUrl) || other.brandImageUrl == brandImageUrl)&&(identical(other.brandWebsiteUrl, brandWebsiteUrl) || other.brandWebsiteUrl == brandWebsiteUrl)&&(identical(other.minimumAmount, minimumAmount) || other.minimumAmount == minimumAmount)&&(identical(other.maximumAmount, maximumAmount) || other.maximumAmount == maximumAmount)&&(identical(other.processingFeePercentage, processingFeePercentage) || other.processingFeePercentage == processingFeePercentage)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.terms, terms) || other.terms == terms)&&(identical(other.instructions, instructions) || other.instructions == instructions)&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,brandName,brandDescription,brandImageUrl,brandWebsiteUrl,minimumAmount,maximumAmount,processingFeePercentage,isActive,terms,instructions,created);

@override
String toString() {
  return 'BrandVoucher(id: $id, brandName: $brandName, brandDescription: $brandDescription, brandImageUrl: $brandImageUrl, brandWebsiteUrl: $brandWebsiteUrl, minimumAmount: $minimumAmount, maximumAmount: $maximumAmount, processingFeePercentage: $processingFeePercentage, isActive: $isActive, terms: $terms, instructions: $instructions, created: $created)';
}


}

/// @nodoc
abstract mixin class $BrandVoucherCopyWith<$Res>  {
  factory $BrandVoucherCopyWith(BrandVoucher value, $Res Function(BrandVoucher) _then) = _$BrandVoucherCopyWithImpl;
@useResult
$Res call({
 int id, String brandName, String brandDescription, String brandImageUrl, String brandWebsiteUrl, double minimumAmount, double maximumAmount, double processingFeePercentage, bool isActive, String? terms, String? instructions, DateTime created
});




}
/// @nodoc
class _$BrandVoucherCopyWithImpl<$Res>
    implements $BrandVoucherCopyWith<$Res> {
  _$BrandVoucherCopyWithImpl(this._self, this._then);

  final BrandVoucher _self;
  final $Res Function(BrandVoucher) _then;

/// Create a copy of BrandVoucher
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? brandName = null,Object? brandDescription = null,Object? brandImageUrl = null,Object? brandWebsiteUrl = null,Object? minimumAmount = null,Object? maximumAmount = null,Object? processingFeePercentage = null,Object? isActive = null,Object? terms = freezed,Object? instructions = freezed,Object? created = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,brandDescription: null == brandDescription ? _self.brandDescription : brandDescription // ignore: cast_nullable_to_non_nullable
as String,brandImageUrl: null == brandImageUrl ? _self.brandImageUrl : brandImageUrl // ignore: cast_nullable_to_non_nullable
as String,brandWebsiteUrl: null == brandWebsiteUrl ? _self.brandWebsiteUrl : brandWebsiteUrl // ignore: cast_nullable_to_non_nullable
as String,minimumAmount: null == minimumAmount ? _self.minimumAmount : minimumAmount // ignore: cast_nullable_to_non_nullable
as double,maximumAmount: null == maximumAmount ? _self.maximumAmount : maximumAmount // ignore: cast_nullable_to_non_nullable
as double,processingFeePercentage: null == processingFeePercentage ? _self.processingFeePercentage : processingFeePercentage // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,terms: freezed == terms ? _self.terms : terms // ignore: cast_nullable_to_non_nullable
as String?,instructions: freezed == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BrandVoucher].
extension BrandVoucherPatterns on BrandVoucher {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrandVoucher value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrandVoucher() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrandVoucher value)  $default,){
final _that = this;
switch (_that) {
case _BrandVoucher():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrandVoucher value)?  $default,){
final _that = this;
switch (_that) {
case _BrandVoucher() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String brandName,  String brandDescription,  String brandImageUrl,  String brandWebsiteUrl,  double minimumAmount,  double maximumAmount,  double processingFeePercentage,  bool isActive,  String? terms,  String? instructions,  DateTime created)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrandVoucher() when $default != null:
return $default(_that.id,_that.brandName,_that.brandDescription,_that.brandImageUrl,_that.brandWebsiteUrl,_that.minimumAmount,_that.maximumAmount,_that.processingFeePercentage,_that.isActive,_that.terms,_that.instructions,_that.created);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String brandName,  String brandDescription,  String brandImageUrl,  String brandWebsiteUrl,  double minimumAmount,  double maximumAmount,  double processingFeePercentage,  bool isActive,  String? terms,  String? instructions,  DateTime created)  $default,) {final _that = this;
switch (_that) {
case _BrandVoucher():
return $default(_that.id,_that.brandName,_that.brandDescription,_that.brandImageUrl,_that.brandWebsiteUrl,_that.minimumAmount,_that.maximumAmount,_that.processingFeePercentage,_that.isActive,_that.terms,_that.instructions,_that.created);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String brandName,  String brandDescription,  String brandImageUrl,  String brandWebsiteUrl,  double minimumAmount,  double maximumAmount,  double processingFeePercentage,  bool isActive,  String? terms,  String? instructions,  DateTime created)?  $default,) {final _that = this;
switch (_that) {
case _BrandVoucher() when $default != null:
return $default(_that.id,_that.brandName,_that.brandDescription,_that.brandImageUrl,_that.brandWebsiteUrl,_that.minimumAmount,_that.maximumAmount,_that.processingFeePercentage,_that.isActive,_that.terms,_that.instructions,_that.created);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BrandVoucher implements BrandVoucher {
  const _BrandVoucher({required this.id, required this.brandName, required this.brandDescription, required this.brandImageUrl, required this.brandWebsiteUrl, required this.minimumAmount, required this.maximumAmount, required this.processingFeePercentage, required this.isActive, this.terms, this.instructions, required this.created});
  factory _BrandVoucher.fromJson(Map<String, dynamic> json) => _$BrandVoucherFromJson(json);

@override final  int id;
@override final  String brandName;
@override final  String brandDescription;
@override final  String brandImageUrl;
@override final  String brandWebsiteUrl;
@override final  double minimumAmount;
@override final  double maximumAmount;
@override final  double processingFeePercentage;
@override final  bool isActive;
@override final  String? terms;
@override final  String? instructions;
@override final  DateTime created;

/// Create a copy of BrandVoucher
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandVoucherCopyWith<_BrandVoucher> get copyWith => __$BrandVoucherCopyWithImpl<_BrandVoucher>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BrandVoucherToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandVoucher&&(identical(other.id, id) || other.id == id)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandDescription, brandDescription) || other.brandDescription == brandDescription)&&(identical(other.brandImageUrl, brandImageUrl) || other.brandImageUrl == brandImageUrl)&&(identical(other.brandWebsiteUrl, brandWebsiteUrl) || other.brandWebsiteUrl == brandWebsiteUrl)&&(identical(other.minimumAmount, minimumAmount) || other.minimumAmount == minimumAmount)&&(identical(other.maximumAmount, maximumAmount) || other.maximumAmount == maximumAmount)&&(identical(other.processingFeePercentage, processingFeePercentage) || other.processingFeePercentage == processingFeePercentage)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.terms, terms) || other.terms == terms)&&(identical(other.instructions, instructions) || other.instructions == instructions)&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,brandName,brandDescription,brandImageUrl,brandWebsiteUrl,minimumAmount,maximumAmount,processingFeePercentage,isActive,terms,instructions,created);

@override
String toString() {
  return 'BrandVoucher(id: $id, brandName: $brandName, brandDescription: $brandDescription, brandImageUrl: $brandImageUrl, brandWebsiteUrl: $brandWebsiteUrl, minimumAmount: $minimumAmount, maximumAmount: $maximumAmount, processingFeePercentage: $processingFeePercentage, isActive: $isActive, terms: $terms, instructions: $instructions, created: $created)';
}


}

/// @nodoc
abstract mixin class _$BrandVoucherCopyWith<$Res> implements $BrandVoucherCopyWith<$Res> {
  factory _$BrandVoucherCopyWith(_BrandVoucher value, $Res Function(_BrandVoucher) _then) = __$BrandVoucherCopyWithImpl;
@override @useResult
$Res call({
 int id, String brandName, String brandDescription, String brandImageUrl, String brandWebsiteUrl, double minimumAmount, double maximumAmount, double processingFeePercentage, bool isActive, String? terms, String? instructions, DateTime created
});




}
/// @nodoc
class __$BrandVoucherCopyWithImpl<$Res>
    implements _$BrandVoucherCopyWith<$Res> {
  __$BrandVoucherCopyWithImpl(this._self, this._then);

  final _BrandVoucher _self;
  final $Res Function(_BrandVoucher) _then;

/// Create a copy of BrandVoucher
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brandName = null,Object? brandDescription = null,Object? brandImageUrl = null,Object? brandWebsiteUrl = null,Object? minimumAmount = null,Object? maximumAmount = null,Object? processingFeePercentage = null,Object? isActive = null,Object? terms = freezed,Object? instructions = freezed,Object? created = null,}) {
  return _then(_BrandVoucher(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,brandDescription: null == brandDescription ? _self.brandDescription : brandDescription // ignore: cast_nullable_to_non_nullable
as String,brandImageUrl: null == brandImageUrl ? _self.brandImageUrl : brandImageUrl // ignore: cast_nullable_to_non_nullable
as String,brandWebsiteUrl: null == brandWebsiteUrl ? _self.brandWebsiteUrl : brandWebsiteUrl // ignore: cast_nullable_to_non_nullable
as String,minimumAmount: null == minimumAmount ? _self.minimumAmount : minimumAmount // ignore: cast_nullable_to_non_nullable
as double,maximumAmount: null == maximumAmount ? _self.maximumAmount : maximumAmount // ignore: cast_nullable_to_non_nullable
as double,processingFeePercentage: null == processingFeePercentage ? _self.processingFeePercentage : processingFeePercentage // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,terms: freezed == terms ? _self.terms : terms // ignore: cast_nullable_to_non_nullable
as String?,instructions: freezed == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$VoucherOrder {

 int get id; String get userId; int get brandVoucherId; String get brandName; String get brandImageUrl; double get voucherAmount; double get processingFee; double get totalPointsUsed; VoucherOrderStatus get status; String? get voucherCode; String? get voucherPin; DateTime? get fulfilledAt; String? get fulfilledBy; String? get rejectionReason; DateTime? get expiresAt; String? get notes; DateTime get created;
/// Create a copy of VoucherOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoucherOrderCopyWith<VoucherOrder> get copyWith => _$VoucherOrderCopyWithImpl<VoucherOrder>(this as VoucherOrder, _$identity);

  /// Serializes this VoucherOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoucherOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.brandVoucherId, brandVoucherId) || other.brandVoucherId == brandVoucherId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandImageUrl, brandImageUrl) || other.brandImageUrl == brandImageUrl)&&(identical(other.voucherAmount, voucherAmount) || other.voucherAmount == voucherAmount)&&(identical(other.processingFee, processingFee) || other.processingFee == processingFee)&&(identical(other.totalPointsUsed, totalPointsUsed) || other.totalPointsUsed == totalPointsUsed)&&(identical(other.status, status) || other.status == status)&&(identical(other.voucherCode, voucherCode) || other.voucherCode == voucherCode)&&(identical(other.voucherPin, voucherPin) || other.voucherPin == voucherPin)&&(identical(other.fulfilledAt, fulfilledAt) || other.fulfilledAt == fulfilledAt)&&(identical(other.fulfilledBy, fulfilledBy) || other.fulfilledBy == fulfilledBy)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,brandVoucherId,brandName,brandImageUrl,voucherAmount,processingFee,totalPointsUsed,status,voucherCode,voucherPin,fulfilledAt,fulfilledBy,rejectionReason,expiresAt,notes,created);

@override
String toString() {
  return 'VoucherOrder(id: $id, userId: $userId, brandVoucherId: $brandVoucherId, brandName: $brandName, brandImageUrl: $brandImageUrl, voucherAmount: $voucherAmount, processingFee: $processingFee, totalPointsUsed: $totalPointsUsed, status: $status, voucherCode: $voucherCode, voucherPin: $voucherPin, fulfilledAt: $fulfilledAt, fulfilledBy: $fulfilledBy, rejectionReason: $rejectionReason, expiresAt: $expiresAt, notes: $notes, created: $created)';
}


}

/// @nodoc
abstract mixin class $VoucherOrderCopyWith<$Res>  {
  factory $VoucherOrderCopyWith(VoucherOrder value, $Res Function(VoucherOrder) _then) = _$VoucherOrderCopyWithImpl;
@useResult
$Res call({
 int id, String userId, int brandVoucherId, String brandName, String brandImageUrl, double voucherAmount, double processingFee, double totalPointsUsed, VoucherOrderStatus status, String? voucherCode, String? voucherPin, DateTime? fulfilledAt, String? fulfilledBy, String? rejectionReason, DateTime? expiresAt, String? notes, DateTime created
});




}
/// @nodoc
class _$VoucherOrderCopyWithImpl<$Res>
    implements $VoucherOrderCopyWith<$Res> {
  _$VoucherOrderCopyWithImpl(this._self, this._then);

  final VoucherOrder _self;
  final $Res Function(VoucherOrder) _then;

/// Create a copy of VoucherOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? brandVoucherId = null,Object? brandName = null,Object? brandImageUrl = null,Object? voucherAmount = null,Object? processingFee = null,Object? totalPointsUsed = null,Object? status = null,Object? voucherCode = freezed,Object? voucherPin = freezed,Object? fulfilledAt = freezed,Object? fulfilledBy = freezed,Object? rejectionReason = freezed,Object? expiresAt = freezed,Object? notes = freezed,Object? created = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,brandVoucherId: null == brandVoucherId ? _self.brandVoucherId : brandVoucherId // ignore: cast_nullable_to_non_nullable
as int,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,brandImageUrl: null == brandImageUrl ? _self.brandImageUrl : brandImageUrl // ignore: cast_nullable_to_non_nullable
as String,voucherAmount: null == voucherAmount ? _self.voucherAmount : voucherAmount // ignore: cast_nullable_to_non_nullable
as double,processingFee: null == processingFee ? _self.processingFee : processingFee // ignore: cast_nullable_to_non_nullable
as double,totalPointsUsed: null == totalPointsUsed ? _self.totalPointsUsed : totalPointsUsed // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoucherOrderStatus,voucherCode: freezed == voucherCode ? _self.voucherCode : voucherCode // ignore: cast_nullable_to_non_nullable
as String?,voucherPin: freezed == voucherPin ? _self.voucherPin : voucherPin // ignore: cast_nullable_to_non_nullable
as String?,fulfilledAt: freezed == fulfilledAt ? _self.fulfilledAt : fulfilledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fulfilledBy: freezed == fulfilledBy ? _self.fulfilledBy : fulfilledBy // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [VoucherOrder].
extension VoucherOrderPatterns on VoucherOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoucherOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoucherOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoucherOrder value)  $default,){
final _that = this;
switch (_that) {
case _VoucherOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoucherOrder value)?  $default,){
final _that = this;
switch (_that) {
case _VoucherOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String userId,  int brandVoucherId,  String brandName,  String brandImageUrl,  double voucherAmount,  double processingFee,  double totalPointsUsed,  VoucherOrderStatus status,  String? voucherCode,  String? voucherPin,  DateTime? fulfilledAt,  String? fulfilledBy,  String? rejectionReason,  DateTime? expiresAt,  String? notes,  DateTime created)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoucherOrder() when $default != null:
return $default(_that.id,_that.userId,_that.brandVoucherId,_that.brandName,_that.brandImageUrl,_that.voucherAmount,_that.processingFee,_that.totalPointsUsed,_that.status,_that.voucherCode,_that.voucherPin,_that.fulfilledAt,_that.fulfilledBy,_that.rejectionReason,_that.expiresAt,_that.notes,_that.created);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String userId,  int brandVoucherId,  String brandName,  String brandImageUrl,  double voucherAmount,  double processingFee,  double totalPointsUsed,  VoucherOrderStatus status,  String? voucherCode,  String? voucherPin,  DateTime? fulfilledAt,  String? fulfilledBy,  String? rejectionReason,  DateTime? expiresAt,  String? notes,  DateTime created)  $default,) {final _that = this;
switch (_that) {
case _VoucherOrder():
return $default(_that.id,_that.userId,_that.brandVoucherId,_that.brandName,_that.brandImageUrl,_that.voucherAmount,_that.processingFee,_that.totalPointsUsed,_that.status,_that.voucherCode,_that.voucherPin,_that.fulfilledAt,_that.fulfilledBy,_that.rejectionReason,_that.expiresAt,_that.notes,_that.created);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String userId,  int brandVoucherId,  String brandName,  String brandImageUrl,  double voucherAmount,  double processingFee,  double totalPointsUsed,  VoucherOrderStatus status,  String? voucherCode,  String? voucherPin,  DateTime? fulfilledAt,  String? fulfilledBy,  String? rejectionReason,  DateTime? expiresAt,  String? notes,  DateTime created)?  $default,) {final _that = this;
switch (_that) {
case _VoucherOrder() when $default != null:
return $default(_that.id,_that.userId,_that.brandVoucherId,_that.brandName,_that.brandImageUrl,_that.voucherAmount,_that.processingFee,_that.totalPointsUsed,_that.status,_that.voucherCode,_that.voucherPin,_that.fulfilledAt,_that.fulfilledBy,_that.rejectionReason,_that.expiresAt,_that.notes,_that.created);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VoucherOrder implements VoucherOrder {
  const _VoucherOrder({required this.id, required this.userId, required this.brandVoucherId, required this.brandName, required this.brandImageUrl, required this.voucherAmount, required this.processingFee, required this.totalPointsUsed, required this.status, this.voucherCode, this.voucherPin, this.fulfilledAt, this.fulfilledBy, this.rejectionReason, this.expiresAt, this.notes, required this.created});
  factory _VoucherOrder.fromJson(Map<String, dynamic> json) => _$VoucherOrderFromJson(json);

@override final  int id;
@override final  String userId;
@override final  int brandVoucherId;
@override final  String brandName;
@override final  String brandImageUrl;
@override final  double voucherAmount;
@override final  double processingFee;
@override final  double totalPointsUsed;
@override final  VoucherOrderStatus status;
@override final  String? voucherCode;
@override final  String? voucherPin;
@override final  DateTime? fulfilledAt;
@override final  String? fulfilledBy;
@override final  String? rejectionReason;
@override final  DateTime? expiresAt;
@override final  String? notes;
@override final  DateTime created;

/// Create a copy of VoucherOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoucherOrderCopyWith<_VoucherOrder> get copyWith => __$VoucherOrderCopyWithImpl<_VoucherOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VoucherOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoucherOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.brandVoucherId, brandVoucherId) || other.brandVoucherId == brandVoucherId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandImageUrl, brandImageUrl) || other.brandImageUrl == brandImageUrl)&&(identical(other.voucherAmount, voucherAmount) || other.voucherAmount == voucherAmount)&&(identical(other.processingFee, processingFee) || other.processingFee == processingFee)&&(identical(other.totalPointsUsed, totalPointsUsed) || other.totalPointsUsed == totalPointsUsed)&&(identical(other.status, status) || other.status == status)&&(identical(other.voucherCode, voucherCode) || other.voucherCode == voucherCode)&&(identical(other.voucherPin, voucherPin) || other.voucherPin == voucherPin)&&(identical(other.fulfilledAt, fulfilledAt) || other.fulfilledAt == fulfilledAt)&&(identical(other.fulfilledBy, fulfilledBy) || other.fulfilledBy == fulfilledBy)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.created, created) || other.created == created));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,brandVoucherId,brandName,brandImageUrl,voucherAmount,processingFee,totalPointsUsed,status,voucherCode,voucherPin,fulfilledAt,fulfilledBy,rejectionReason,expiresAt,notes,created);

@override
String toString() {
  return 'VoucherOrder(id: $id, userId: $userId, brandVoucherId: $brandVoucherId, brandName: $brandName, brandImageUrl: $brandImageUrl, voucherAmount: $voucherAmount, processingFee: $processingFee, totalPointsUsed: $totalPointsUsed, status: $status, voucherCode: $voucherCode, voucherPin: $voucherPin, fulfilledAt: $fulfilledAt, fulfilledBy: $fulfilledBy, rejectionReason: $rejectionReason, expiresAt: $expiresAt, notes: $notes, created: $created)';
}


}

/// @nodoc
abstract mixin class _$VoucherOrderCopyWith<$Res> implements $VoucherOrderCopyWith<$Res> {
  factory _$VoucherOrderCopyWith(_VoucherOrder value, $Res Function(_VoucherOrder) _then) = __$VoucherOrderCopyWithImpl;
@override @useResult
$Res call({
 int id, String userId, int brandVoucherId, String brandName, String brandImageUrl, double voucherAmount, double processingFee, double totalPointsUsed, VoucherOrderStatus status, String? voucherCode, String? voucherPin, DateTime? fulfilledAt, String? fulfilledBy, String? rejectionReason, DateTime? expiresAt, String? notes, DateTime created
});




}
/// @nodoc
class __$VoucherOrderCopyWithImpl<$Res>
    implements _$VoucherOrderCopyWith<$Res> {
  __$VoucherOrderCopyWithImpl(this._self, this._then);

  final _VoucherOrder _self;
  final $Res Function(_VoucherOrder) _then;

/// Create a copy of VoucherOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? brandVoucherId = null,Object? brandName = null,Object? brandImageUrl = null,Object? voucherAmount = null,Object? processingFee = null,Object? totalPointsUsed = null,Object? status = null,Object? voucherCode = freezed,Object? voucherPin = freezed,Object? fulfilledAt = freezed,Object? fulfilledBy = freezed,Object? rejectionReason = freezed,Object? expiresAt = freezed,Object? notes = freezed,Object? created = null,}) {
  return _then(_VoucherOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,brandVoucherId: null == brandVoucherId ? _self.brandVoucherId : brandVoucherId // ignore: cast_nullable_to_non_nullable
as int,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,brandImageUrl: null == brandImageUrl ? _self.brandImageUrl : brandImageUrl // ignore: cast_nullable_to_non_nullable
as String,voucherAmount: null == voucherAmount ? _self.voucherAmount : voucherAmount // ignore: cast_nullable_to_non_nullable
as double,processingFee: null == processingFee ? _self.processingFee : processingFee // ignore: cast_nullable_to_non_nullable
as double,totalPointsUsed: null == totalPointsUsed ? _self.totalPointsUsed : totalPointsUsed // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoucherOrderStatus,voucherCode: freezed == voucherCode ? _self.voucherCode : voucherCode // ignore: cast_nullable_to_non_nullable
as String?,voucherPin: freezed == voucherPin ? _self.voucherPin : voucherPin // ignore: cast_nullable_to_non_nullable
as String?,fulfilledAt: freezed == fulfilledAt ? _self.fulfilledAt : fulfilledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fulfilledBy: freezed == fulfilledBy ? _self.fulfilledBy : fulfilledBy // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CreateVoucherOrderRequest {

 String get userId; int get brandVoucherId; double get voucherAmount;
/// Create a copy of CreateVoucherOrderRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateVoucherOrderRequestCopyWith<CreateVoucherOrderRequest> get copyWith => _$CreateVoucherOrderRequestCopyWithImpl<CreateVoucherOrderRequest>(this as CreateVoucherOrderRequest, _$identity);

  /// Serializes this CreateVoucherOrderRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateVoucherOrderRequest&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.brandVoucherId, brandVoucherId) || other.brandVoucherId == brandVoucherId)&&(identical(other.voucherAmount, voucherAmount) || other.voucherAmount == voucherAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,brandVoucherId,voucherAmount);

@override
String toString() {
  return 'CreateVoucherOrderRequest(userId: $userId, brandVoucherId: $brandVoucherId, voucherAmount: $voucherAmount)';
}


}

/// @nodoc
abstract mixin class $CreateVoucherOrderRequestCopyWith<$Res>  {
  factory $CreateVoucherOrderRequestCopyWith(CreateVoucherOrderRequest value, $Res Function(CreateVoucherOrderRequest) _then) = _$CreateVoucherOrderRequestCopyWithImpl;
@useResult
$Res call({
 String userId, int brandVoucherId, double voucherAmount
});




}
/// @nodoc
class _$CreateVoucherOrderRequestCopyWithImpl<$Res>
    implements $CreateVoucherOrderRequestCopyWith<$Res> {
  _$CreateVoucherOrderRequestCopyWithImpl(this._self, this._then);

  final CreateVoucherOrderRequest _self;
  final $Res Function(CreateVoucherOrderRequest) _then;

/// Create a copy of CreateVoucherOrderRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? brandVoucherId = null,Object? voucherAmount = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,brandVoucherId: null == brandVoucherId ? _self.brandVoucherId : brandVoucherId // ignore: cast_nullable_to_non_nullable
as int,voucherAmount: null == voucherAmount ? _self.voucherAmount : voucherAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateVoucherOrderRequest].
extension CreateVoucherOrderRequestPatterns on CreateVoucherOrderRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateVoucherOrderRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateVoucherOrderRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateVoucherOrderRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateVoucherOrderRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateVoucherOrderRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateVoucherOrderRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  int brandVoucherId,  double voucherAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateVoucherOrderRequest() when $default != null:
return $default(_that.userId,_that.brandVoucherId,_that.voucherAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  int brandVoucherId,  double voucherAmount)  $default,) {final _that = this;
switch (_that) {
case _CreateVoucherOrderRequest():
return $default(_that.userId,_that.brandVoucherId,_that.voucherAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  int brandVoucherId,  double voucherAmount)?  $default,) {final _that = this;
switch (_that) {
case _CreateVoucherOrderRequest() when $default != null:
return $default(_that.userId,_that.brandVoucherId,_that.voucherAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateVoucherOrderRequest implements CreateVoucherOrderRequest {
  const _CreateVoucherOrderRequest({required this.userId, required this.brandVoucherId, required this.voucherAmount});
  factory _CreateVoucherOrderRequest.fromJson(Map<String, dynamic> json) => _$CreateVoucherOrderRequestFromJson(json);

@override final  String userId;
@override final  int brandVoucherId;
@override final  double voucherAmount;

/// Create a copy of CreateVoucherOrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateVoucherOrderRequestCopyWith<_CreateVoucherOrderRequest> get copyWith => __$CreateVoucherOrderRequestCopyWithImpl<_CreateVoucherOrderRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateVoucherOrderRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateVoucherOrderRequest&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.brandVoucherId, brandVoucherId) || other.brandVoucherId == brandVoucherId)&&(identical(other.voucherAmount, voucherAmount) || other.voucherAmount == voucherAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,brandVoucherId,voucherAmount);

@override
String toString() {
  return 'CreateVoucherOrderRequest(userId: $userId, brandVoucherId: $brandVoucherId, voucherAmount: $voucherAmount)';
}


}

/// @nodoc
abstract mixin class _$CreateVoucherOrderRequestCopyWith<$Res> implements $CreateVoucherOrderRequestCopyWith<$Res> {
  factory _$CreateVoucherOrderRequestCopyWith(_CreateVoucherOrderRequest value, $Res Function(_CreateVoucherOrderRequest) _then) = __$CreateVoucherOrderRequestCopyWithImpl;
@override @useResult
$Res call({
 String userId, int brandVoucherId, double voucherAmount
});




}
/// @nodoc
class __$CreateVoucherOrderRequestCopyWithImpl<$Res>
    implements _$CreateVoucherOrderRequestCopyWith<$Res> {
  __$CreateVoucherOrderRequestCopyWithImpl(this._self, this._then);

  final _CreateVoucherOrderRequest _self;
  final $Res Function(_CreateVoucherOrderRequest) _then;

/// Create a copy of CreateVoucherOrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? brandVoucherId = null,Object? voucherAmount = null,}) {
  return _then(_CreateVoucherOrderRequest(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,brandVoucherId: null == brandVoucherId ? _self.brandVoucherId : brandVoucherId // ignore: cast_nullable_to_non_nullable
as int,voucherAmount: null == voucherAmount ? _self.voucherAmount : voucherAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$PaginatedBrandVoucherResponse {

 List<BrandVoucher> get items; int get pageNumber; int get totalPages; int get totalCount; bool get hasPreviousPage; bool get hasNextPage;
/// Create a copy of PaginatedBrandVoucherResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedBrandVoucherResponseCopyWith<PaginatedBrandVoucherResponse> get copyWith => _$PaginatedBrandVoucherResponseCopyWithImpl<PaginatedBrandVoucherResponse>(this as PaginatedBrandVoucherResponse, _$identity);

  /// Serializes this PaginatedBrandVoucherResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedBrandVoucherResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),pageNumber,totalPages,totalCount,hasPreviousPage,hasNextPage);

@override
String toString() {
  return 'PaginatedBrandVoucherResponse(items: $items, pageNumber: $pageNumber, totalPages: $totalPages, totalCount: $totalCount, hasPreviousPage: $hasPreviousPage, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class $PaginatedBrandVoucherResponseCopyWith<$Res>  {
  factory $PaginatedBrandVoucherResponseCopyWith(PaginatedBrandVoucherResponse value, $Res Function(PaginatedBrandVoucherResponse) _then) = _$PaginatedBrandVoucherResponseCopyWithImpl;
@useResult
$Res call({
 List<BrandVoucher> items, int pageNumber, int totalPages, int totalCount, bool hasPreviousPage, bool hasNextPage
});




}
/// @nodoc
class _$PaginatedBrandVoucherResponseCopyWithImpl<$Res>
    implements $PaginatedBrandVoucherResponseCopyWith<$Res> {
  _$PaginatedBrandVoucherResponseCopyWithImpl(this._self, this._then);

  final PaginatedBrandVoucherResponse _self;
  final $Res Function(PaginatedBrandVoucherResponse) _then;

/// Create a copy of PaginatedBrandVoucherResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? pageNumber = null,Object? totalPages = null,Object? totalCount = null,Object? hasPreviousPage = null,Object? hasNextPage = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<BrandVoucher>,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedBrandVoucherResponse].
extension PaginatedBrandVoucherResponsePatterns on PaginatedBrandVoucherResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedBrandVoucherResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedBrandVoucherResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedBrandVoucherResponse value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedBrandVoucherResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedBrandVoucherResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedBrandVoucherResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BrandVoucher> items,  int pageNumber,  int totalPages,  int totalCount,  bool hasPreviousPage,  bool hasNextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedBrandVoucherResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BrandVoucher> items,  int pageNumber,  int totalPages,  int totalCount,  bool hasPreviousPage,  bool hasNextPage)  $default,) {final _that = this;
switch (_that) {
case _PaginatedBrandVoucherResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BrandVoucher> items,  int pageNumber,  int totalPages,  int totalCount,  bool hasPreviousPage,  bool hasNextPage)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedBrandVoucherResponse() when $default != null:
return $default(_that.items,_that.pageNumber,_that.totalPages,_that.totalCount,_that.hasPreviousPage,_that.hasNextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedBrandVoucherResponse implements PaginatedBrandVoucherResponse {
  const _PaginatedBrandVoucherResponse({required final  List<BrandVoucher> items, required this.pageNumber, required this.totalPages, required this.totalCount, required this.hasPreviousPage, required this.hasNextPage}): _items = items;
  factory _PaginatedBrandVoucherResponse.fromJson(Map<String, dynamic> json) => _$PaginatedBrandVoucherResponseFromJson(json);

 final  List<BrandVoucher> _items;
@override List<BrandVoucher> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int pageNumber;
@override final  int totalPages;
@override final  int totalCount;
@override final  bool hasPreviousPage;
@override final  bool hasNextPage;

/// Create a copy of PaginatedBrandVoucherResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedBrandVoucherResponseCopyWith<_PaginatedBrandVoucherResponse> get copyWith => __$PaginatedBrandVoucherResponseCopyWithImpl<_PaginatedBrandVoucherResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedBrandVoucherResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedBrandVoucherResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),pageNumber,totalPages,totalCount,hasPreviousPage,hasNextPage);

@override
String toString() {
  return 'PaginatedBrandVoucherResponse(items: $items, pageNumber: $pageNumber, totalPages: $totalPages, totalCount: $totalCount, hasPreviousPage: $hasPreviousPage, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class _$PaginatedBrandVoucherResponseCopyWith<$Res> implements $PaginatedBrandVoucherResponseCopyWith<$Res> {
  factory _$PaginatedBrandVoucherResponseCopyWith(_PaginatedBrandVoucherResponse value, $Res Function(_PaginatedBrandVoucherResponse) _then) = __$PaginatedBrandVoucherResponseCopyWithImpl;
@override @useResult
$Res call({
 List<BrandVoucher> items, int pageNumber, int totalPages, int totalCount, bool hasPreviousPage, bool hasNextPage
});




}
/// @nodoc
class __$PaginatedBrandVoucherResponseCopyWithImpl<$Res>
    implements _$PaginatedBrandVoucherResponseCopyWith<$Res> {
  __$PaginatedBrandVoucherResponseCopyWithImpl(this._self, this._then);

  final _PaginatedBrandVoucherResponse _self;
  final $Res Function(_PaginatedBrandVoucherResponse) _then;

/// Create a copy of PaginatedBrandVoucherResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? pageNumber = null,Object? totalPages = null,Object? totalCount = null,Object? hasPreviousPage = null,Object? hasNextPage = null,}) {
  return _then(_PaginatedBrandVoucherResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<BrandVoucher>,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PaginatedVoucherOrderResponse {

 List<VoucherOrder> get items; int get pageNumber; int get totalPages; int get totalCount; bool get hasPreviousPage; bool get hasNextPage;
/// Create a copy of PaginatedVoucherOrderResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedVoucherOrderResponseCopyWith<PaginatedVoucherOrderResponse> get copyWith => _$PaginatedVoucherOrderResponseCopyWithImpl<PaginatedVoucherOrderResponse>(this as PaginatedVoucherOrderResponse, _$identity);

  /// Serializes this PaginatedVoucherOrderResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedVoucherOrderResponse&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),pageNumber,totalPages,totalCount,hasPreviousPage,hasNextPage);

@override
String toString() {
  return 'PaginatedVoucherOrderResponse(items: $items, pageNumber: $pageNumber, totalPages: $totalPages, totalCount: $totalCount, hasPreviousPage: $hasPreviousPage, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class $PaginatedVoucherOrderResponseCopyWith<$Res>  {
  factory $PaginatedVoucherOrderResponseCopyWith(PaginatedVoucherOrderResponse value, $Res Function(PaginatedVoucherOrderResponse) _then) = _$PaginatedVoucherOrderResponseCopyWithImpl;
@useResult
$Res call({
 List<VoucherOrder> items, int pageNumber, int totalPages, int totalCount, bool hasPreviousPage, bool hasNextPage
});




}
/// @nodoc
class _$PaginatedVoucherOrderResponseCopyWithImpl<$Res>
    implements $PaginatedVoucherOrderResponseCopyWith<$Res> {
  _$PaginatedVoucherOrderResponseCopyWithImpl(this._self, this._then);

  final PaginatedVoucherOrderResponse _self;
  final $Res Function(PaginatedVoucherOrderResponse) _then;

/// Create a copy of PaginatedVoucherOrderResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? pageNumber = null,Object? totalPages = null,Object? totalCount = null,Object? hasPreviousPage = null,Object? hasNextPage = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<VoucherOrder>,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginatedVoucherOrderResponse].
extension PaginatedVoucherOrderResponsePatterns on PaginatedVoucherOrderResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedVoucherOrderResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedVoucherOrderResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedVoucherOrderResponse value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedVoucherOrderResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedVoucherOrderResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedVoucherOrderResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VoucherOrder> items,  int pageNumber,  int totalPages,  int totalCount,  bool hasPreviousPage,  bool hasNextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedVoucherOrderResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VoucherOrder> items,  int pageNumber,  int totalPages,  int totalCount,  bool hasPreviousPage,  bool hasNextPage)  $default,) {final _that = this;
switch (_that) {
case _PaginatedVoucherOrderResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VoucherOrder> items,  int pageNumber,  int totalPages,  int totalCount,  bool hasPreviousPage,  bool hasNextPage)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedVoucherOrderResponse() when $default != null:
return $default(_that.items,_that.pageNumber,_that.totalPages,_that.totalCount,_that.hasPreviousPage,_that.hasNextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedVoucherOrderResponse implements PaginatedVoucherOrderResponse {
  const _PaginatedVoucherOrderResponse({required final  List<VoucherOrder> items, required this.pageNumber, required this.totalPages, required this.totalCount, required this.hasPreviousPage, required this.hasNextPage}): _items = items;
  factory _PaginatedVoucherOrderResponse.fromJson(Map<String, dynamic> json) => _$PaginatedVoucherOrderResponseFromJson(json);

 final  List<VoucherOrder> _items;
@override List<VoucherOrder> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int pageNumber;
@override final  int totalPages;
@override final  int totalCount;
@override final  bool hasPreviousPage;
@override final  bool hasNextPage;

/// Create a copy of PaginatedVoucherOrderResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedVoucherOrderResponseCopyWith<_PaginatedVoucherOrderResponse> get copyWith => __$PaginatedVoucherOrderResponseCopyWithImpl<_PaginatedVoucherOrderResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedVoucherOrderResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedVoucherOrderResponse&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),pageNumber,totalPages,totalCount,hasPreviousPage,hasNextPage);

@override
String toString() {
  return 'PaginatedVoucherOrderResponse(items: $items, pageNumber: $pageNumber, totalPages: $totalPages, totalCount: $totalCount, hasPreviousPage: $hasPreviousPage, hasNextPage: $hasNextPage)';
}


}

/// @nodoc
abstract mixin class _$PaginatedVoucherOrderResponseCopyWith<$Res> implements $PaginatedVoucherOrderResponseCopyWith<$Res> {
  factory _$PaginatedVoucherOrderResponseCopyWith(_PaginatedVoucherOrderResponse value, $Res Function(_PaginatedVoucherOrderResponse) _then) = __$PaginatedVoucherOrderResponseCopyWithImpl;
@override @useResult
$Res call({
 List<VoucherOrder> items, int pageNumber, int totalPages, int totalCount, bool hasPreviousPage, bool hasNextPage
});




}
/// @nodoc
class __$PaginatedVoucherOrderResponseCopyWithImpl<$Res>
    implements _$PaginatedVoucherOrderResponseCopyWith<$Res> {
  __$PaginatedVoucherOrderResponseCopyWithImpl(this._self, this._then);

  final _PaginatedVoucherOrderResponse _self;
  final $Res Function(_PaginatedVoucherOrderResponse) _then;

/// Create a copy of PaginatedVoucherOrderResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? pageNumber = null,Object? totalPages = null,Object? totalCount = null,Object? hasPreviousPage = null,Object? hasNextPage = null,}) {
  return _then(_PaginatedVoucherOrderResponse(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<VoucherOrder>,pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
