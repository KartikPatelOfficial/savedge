// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coupon_redemption_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RedeemMyCouponRequest {

 int get userCouponId;
/// Create a copy of RedeemMyCouponRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RedeemMyCouponRequestCopyWith<RedeemMyCouponRequest> get copyWith => _$RedeemMyCouponRequestCopyWithImpl<RedeemMyCouponRequest>(this as RedeemMyCouponRequest, _$identity);

  /// Serializes this RedeemMyCouponRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RedeemMyCouponRequest&&(identical(other.userCouponId, userCouponId) || other.userCouponId == userCouponId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userCouponId);

@override
String toString() {
  return 'RedeemMyCouponRequest(userCouponId: $userCouponId)';
}


}

/// @nodoc
abstract mixin class $RedeemMyCouponRequestCopyWith<$Res>  {
  factory $RedeemMyCouponRequestCopyWith(RedeemMyCouponRequest value, $Res Function(RedeemMyCouponRequest) _then) = _$RedeemMyCouponRequestCopyWithImpl;
@useResult
$Res call({
 int userCouponId
});




}
/// @nodoc
class _$RedeemMyCouponRequestCopyWithImpl<$Res>
    implements $RedeemMyCouponRequestCopyWith<$Res> {
  _$RedeemMyCouponRequestCopyWithImpl(this._self, this._then);

  final RedeemMyCouponRequest _self;
  final $Res Function(RedeemMyCouponRequest) _then;

/// Create a copy of RedeemMyCouponRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userCouponId = null,}) {
  return _then(_self.copyWith(
userCouponId: null == userCouponId ? _self.userCouponId : userCouponId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RedeemMyCouponRequest].
extension RedeemMyCouponRequestPatterns on RedeemMyCouponRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RedeemMyCouponRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RedeemMyCouponRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RedeemMyCouponRequest value)  $default,){
final _that = this;
switch (_that) {
case _RedeemMyCouponRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RedeemMyCouponRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RedeemMyCouponRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userCouponId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RedeemMyCouponRequest() when $default != null:
return $default(_that.userCouponId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userCouponId)  $default,) {final _that = this;
switch (_that) {
case _RedeemMyCouponRequest():
return $default(_that.userCouponId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userCouponId)?  $default,) {final _that = this;
switch (_that) {
case _RedeemMyCouponRequest() when $default != null:
return $default(_that.userCouponId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RedeemMyCouponRequest implements RedeemMyCouponRequest {
  const _RedeemMyCouponRequest({required this.userCouponId});
  factory _RedeemMyCouponRequest.fromJson(Map<String, dynamic> json) => _$RedeemMyCouponRequestFromJson(json);

@override final  int userCouponId;

/// Create a copy of RedeemMyCouponRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RedeemMyCouponRequestCopyWith<_RedeemMyCouponRequest> get copyWith => __$RedeemMyCouponRequestCopyWithImpl<_RedeemMyCouponRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RedeemMyCouponRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RedeemMyCouponRequest&&(identical(other.userCouponId, userCouponId) || other.userCouponId == userCouponId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userCouponId);

@override
String toString() {
  return 'RedeemMyCouponRequest(userCouponId: $userCouponId)';
}


}

/// @nodoc
abstract mixin class _$RedeemMyCouponRequestCopyWith<$Res> implements $RedeemMyCouponRequestCopyWith<$Res> {
  factory _$RedeemMyCouponRequestCopyWith(_RedeemMyCouponRequest value, $Res Function(_RedeemMyCouponRequest) _then) = __$RedeemMyCouponRequestCopyWithImpl;
@override @useResult
$Res call({
 int userCouponId
});




}
/// @nodoc
class __$RedeemMyCouponRequestCopyWithImpl<$Res>
    implements _$RedeemMyCouponRequestCopyWith<$Res> {
  __$RedeemMyCouponRequestCopyWithImpl(this._self, this._then);

  final _RedeemMyCouponRequest _self;
  final $Res Function(_RedeemMyCouponRequest) _then;

/// Create a copy of RedeemMyCouponRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userCouponId = null,}) {
  return _then(_RedeemMyCouponRequest(
userCouponId: null == userCouponId ? _self.userCouponId : userCouponId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RedeemCouponResponse {

 bool get success; String get message; DateTime get redeemedAt; String get couponTitle; String get vendorName; double get discountValue; String get discountType; String get uniqueCode;
/// Create a copy of RedeemCouponResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RedeemCouponResponseCopyWith<RedeemCouponResponse> get copyWith => _$RedeemCouponResponseCopyWithImpl<RedeemCouponResponse>(this as RedeemCouponResponse, _$identity);

  /// Serializes this RedeemCouponResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RedeemCouponResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt)&&(identical(other.couponTitle, couponTitle) || other.couponTitle == couponTitle)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.uniqueCode, uniqueCode) || other.uniqueCode == uniqueCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,redeemedAt,couponTitle,vendorName,discountValue,discountType,uniqueCode);

@override
String toString() {
  return 'RedeemCouponResponse(success: $success, message: $message, redeemedAt: $redeemedAt, couponTitle: $couponTitle, vendorName: $vendorName, discountValue: $discountValue, discountType: $discountType, uniqueCode: $uniqueCode)';
}


}

/// @nodoc
abstract mixin class $RedeemCouponResponseCopyWith<$Res>  {
  factory $RedeemCouponResponseCopyWith(RedeemCouponResponse value, $Res Function(RedeemCouponResponse) _then) = _$RedeemCouponResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, DateTime redeemedAt, String couponTitle, String vendorName, double discountValue, String discountType, String uniqueCode
});




}
/// @nodoc
class _$RedeemCouponResponseCopyWithImpl<$Res>
    implements $RedeemCouponResponseCopyWith<$Res> {
  _$RedeemCouponResponseCopyWithImpl(this._self, this._then);

  final RedeemCouponResponse _self;
  final $Res Function(RedeemCouponResponse) _then;

/// Create a copy of RedeemCouponResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? redeemedAt = null,Object? couponTitle = null,Object? vendorName = null,Object? discountValue = null,Object? discountType = null,Object? uniqueCode = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,redeemedAt: null == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime,couponTitle: null == couponTitle ? _self.couponTitle : couponTitle // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as String,uniqueCode: null == uniqueCode ? _self.uniqueCode : uniqueCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RedeemCouponResponse].
extension RedeemCouponResponsePatterns on RedeemCouponResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RedeemCouponResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RedeemCouponResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RedeemCouponResponse value)  $default,){
final _that = this;
switch (_that) {
case _RedeemCouponResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RedeemCouponResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RedeemCouponResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  DateTime redeemedAt,  String couponTitle,  String vendorName,  double discountValue,  String discountType,  String uniqueCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RedeemCouponResponse() when $default != null:
return $default(_that.success,_that.message,_that.redeemedAt,_that.couponTitle,_that.vendorName,_that.discountValue,_that.discountType,_that.uniqueCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  DateTime redeemedAt,  String couponTitle,  String vendorName,  double discountValue,  String discountType,  String uniqueCode)  $default,) {final _that = this;
switch (_that) {
case _RedeemCouponResponse():
return $default(_that.success,_that.message,_that.redeemedAt,_that.couponTitle,_that.vendorName,_that.discountValue,_that.discountType,_that.uniqueCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  DateTime redeemedAt,  String couponTitle,  String vendorName,  double discountValue,  String discountType,  String uniqueCode)?  $default,) {final _that = this;
switch (_that) {
case _RedeemCouponResponse() when $default != null:
return $default(_that.success,_that.message,_that.redeemedAt,_that.couponTitle,_that.vendorName,_that.discountValue,_that.discountType,_that.uniqueCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RedeemCouponResponse implements RedeemCouponResponse {
  const _RedeemCouponResponse({required this.success, required this.message, required this.redeemedAt, required this.couponTitle, required this.vendorName, required this.discountValue, required this.discountType, required this.uniqueCode});
  factory _RedeemCouponResponse.fromJson(Map<String, dynamic> json) => _$RedeemCouponResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  DateTime redeemedAt;
@override final  String couponTitle;
@override final  String vendorName;
@override final  double discountValue;
@override final  String discountType;
@override final  String uniqueCode;

/// Create a copy of RedeemCouponResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RedeemCouponResponseCopyWith<_RedeemCouponResponse> get copyWith => __$RedeemCouponResponseCopyWithImpl<_RedeemCouponResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RedeemCouponResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RedeemCouponResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.redeemedAt, redeemedAt) || other.redeemedAt == redeemedAt)&&(identical(other.couponTitle, couponTitle) || other.couponTitle == couponTitle)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.uniqueCode, uniqueCode) || other.uniqueCode == uniqueCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,redeemedAt,couponTitle,vendorName,discountValue,discountType,uniqueCode);

@override
String toString() {
  return 'RedeemCouponResponse(success: $success, message: $message, redeemedAt: $redeemedAt, couponTitle: $couponTitle, vendorName: $vendorName, discountValue: $discountValue, discountType: $discountType, uniqueCode: $uniqueCode)';
}


}

/// @nodoc
abstract mixin class _$RedeemCouponResponseCopyWith<$Res> implements $RedeemCouponResponseCopyWith<$Res> {
  factory _$RedeemCouponResponseCopyWith(_RedeemCouponResponse value, $Res Function(_RedeemCouponResponse) _then) = __$RedeemCouponResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, DateTime redeemedAt, String couponTitle, String vendorName, double discountValue, String discountType, String uniqueCode
});




}
/// @nodoc
class __$RedeemCouponResponseCopyWithImpl<$Res>
    implements _$RedeemCouponResponseCopyWith<$Res> {
  __$RedeemCouponResponseCopyWithImpl(this._self, this._then);

  final _RedeemCouponResponse _self;
  final $Res Function(_RedeemCouponResponse) _then;

/// Create a copy of RedeemCouponResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? redeemedAt = null,Object? couponTitle = null,Object? vendorName = null,Object? discountValue = null,Object? discountType = null,Object? uniqueCode = null,}) {
  return _then(_RedeemCouponResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,redeemedAt: null == redeemedAt ? _self.redeemedAt : redeemedAt // ignore: cast_nullable_to_non_nullable
as DateTime,couponTitle: null == couponTitle ? _self.couponTitle : couponTitle // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as String,uniqueCode: null == uniqueCode ? _self.uniqueCode : uniqueCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ClaimCouponRequest {

 int get couponId;
/// Create a copy of ClaimCouponRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimCouponRequestCopyWith<ClaimCouponRequest> get copyWith => _$ClaimCouponRequestCopyWithImpl<ClaimCouponRequest>(this as ClaimCouponRequest, _$identity);

  /// Serializes this ClaimCouponRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimCouponRequest&&(identical(other.couponId, couponId) || other.couponId == couponId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,couponId);

@override
String toString() {
  return 'ClaimCouponRequest(couponId: $couponId)';
}


}

/// @nodoc
abstract mixin class $ClaimCouponRequestCopyWith<$Res>  {
  factory $ClaimCouponRequestCopyWith(ClaimCouponRequest value, $Res Function(ClaimCouponRequest) _then) = _$ClaimCouponRequestCopyWithImpl;
@useResult
$Res call({
 int couponId
});




}
/// @nodoc
class _$ClaimCouponRequestCopyWithImpl<$Res>
    implements $ClaimCouponRequestCopyWith<$Res> {
  _$ClaimCouponRequestCopyWithImpl(this._self, this._then);

  final ClaimCouponRequest _self;
  final $Res Function(ClaimCouponRequest) _then;

/// Create a copy of ClaimCouponRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? couponId = null,}) {
  return _then(_self.copyWith(
couponId: null == couponId ? _self.couponId : couponId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimCouponRequest].
extension ClaimCouponRequestPatterns on ClaimCouponRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimCouponRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimCouponRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimCouponRequest value)  $default,){
final _that = this;
switch (_that) {
case _ClaimCouponRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimCouponRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimCouponRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int couponId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimCouponRequest() when $default != null:
return $default(_that.couponId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int couponId)  $default,) {final _that = this;
switch (_that) {
case _ClaimCouponRequest():
return $default(_that.couponId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int couponId)?  $default,) {final _that = this;
switch (_that) {
case _ClaimCouponRequest() when $default != null:
return $default(_that.couponId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClaimCouponRequest implements ClaimCouponRequest {
  const _ClaimCouponRequest({required this.couponId});
  factory _ClaimCouponRequest.fromJson(Map<String, dynamic> json) => _$ClaimCouponRequestFromJson(json);

@override final  int couponId;

/// Create a copy of ClaimCouponRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimCouponRequestCopyWith<_ClaimCouponRequest> get copyWith => __$ClaimCouponRequestCopyWithImpl<_ClaimCouponRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClaimCouponRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimCouponRequest&&(identical(other.couponId, couponId) || other.couponId == couponId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,couponId);

@override
String toString() {
  return 'ClaimCouponRequest(couponId: $couponId)';
}


}

/// @nodoc
abstract mixin class _$ClaimCouponRequestCopyWith<$Res> implements $ClaimCouponRequestCopyWith<$Res> {
  factory _$ClaimCouponRequestCopyWith(_ClaimCouponRequest value, $Res Function(_ClaimCouponRequest) _then) = __$ClaimCouponRequestCopyWithImpl;
@override @useResult
$Res call({
 int couponId
});




}
/// @nodoc
class __$ClaimCouponRequestCopyWithImpl<$Res>
    implements _$ClaimCouponRequestCopyWith<$Res> {
  __$ClaimCouponRequestCopyWithImpl(this._self, this._then);

  final _ClaimCouponRequest _self;
  final $Res Function(_ClaimCouponRequest) _then;

/// Create a copy of ClaimCouponRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? couponId = null,}) {
  return _then(_ClaimCouponRequest(
couponId: null == couponId ? _self.couponId : couponId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ClaimFromSubscriptionRequest {

 int get couponId;
/// Create a copy of ClaimFromSubscriptionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimFromSubscriptionRequestCopyWith<ClaimFromSubscriptionRequest> get copyWith => _$ClaimFromSubscriptionRequestCopyWithImpl<ClaimFromSubscriptionRequest>(this as ClaimFromSubscriptionRequest, _$identity);

  /// Serializes this ClaimFromSubscriptionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimFromSubscriptionRequest&&(identical(other.couponId, couponId) || other.couponId == couponId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,couponId);

@override
String toString() {
  return 'ClaimFromSubscriptionRequest(couponId: $couponId)';
}


}

/// @nodoc
abstract mixin class $ClaimFromSubscriptionRequestCopyWith<$Res>  {
  factory $ClaimFromSubscriptionRequestCopyWith(ClaimFromSubscriptionRequest value, $Res Function(ClaimFromSubscriptionRequest) _then) = _$ClaimFromSubscriptionRequestCopyWithImpl;
@useResult
$Res call({
 int couponId
});




}
/// @nodoc
class _$ClaimFromSubscriptionRequestCopyWithImpl<$Res>
    implements $ClaimFromSubscriptionRequestCopyWith<$Res> {
  _$ClaimFromSubscriptionRequestCopyWithImpl(this._self, this._then);

  final ClaimFromSubscriptionRequest _self;
  final $Res Function(ClaimFromSubscriptionRequest) _then;

/// Create a copy of ClaimFromSubscriptionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? couponId = null,}) {
  return _then(_self.copyWith(
couponId: null == couponId ? _self.couponId : couponId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimFromSubscriptionRequest].
extension ClaimFromSubscriptionRequestPatterns on ClaimFromSubscriptionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimFromSubscriptionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimFromSubscriptionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimFromSubscriptionRequest value)  $default,){
final _that = this;
switch (_that) {
case _ClaimFromSubscriptionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimFromSubscriptionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimFromSubscriptionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int couponId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimFromSubscriptionRequest() when $default != null:
return $default(_that.couponId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int couponId)  $default,) {final _that = this;
switch (_that) {
case _ClaimFromSubscriptionRequest():
return $default(_that.couponId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int couponId)?  $default,) {final _that = this;
switch (_that) {
case _ClaimFromSubscriptionRequest() when $default != null:
return $default(_that.couponId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClaimFromSubscriptionRequest implements ClaimFromSubscriptionRequest {
  const _ClaimFromSubscriptionRequest({required this.couponId});
  factory _ClaimFromSubscriptionRequest.fromJson(Map<String, dynamic> json) => _$ClaimFromSubscriptionRequestFromJson(json);

@override final  int couponId;

/// Create a copy of ClaimFromSubscriptionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimFromSubscriptionRequestCopyWith<_ClaimFromSubscriptionRequest> get copyWith => __$ClaimFromSubscriptionRequestCopyWithImpl<_ClaimFromSubscriptionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClaimFromSubscriptionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimFromSubscriptionRequest&&(identical(other.couponId, couponId) || other.couponId == couponId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,couponId);

@override
String toString() {
  return 'ClaimFromSubscriptionRequest(couponId: $couponId)';
}


}

/// @nodoc
abstract mixin class _$ClaimFromSubscriptionRequestCopyWith<$Res> implements $ClaimFromSubscriptionRequestCopyWith<$Res> {
  factory _$ClaimFromSubscriptionRequestCopyWith(_ClaimFromSubscriptionRequest value, $Res Function(_ClaimFromSubscriptionRequest) _then) = __$ClaimFromSubscriptionRequestCopyWithImpl;
@override @useResult
$Res call({
 int couponId
});




}
/// @nodoc
class __$ClaimFromSubscriptionRequestCopyWithImpl<$Res>
    implements _$ClaimFromSubscriptionRequestCopyWith<$Res> {
  __$ClaimFromSubscriptionRequestCopyWithImpl(this._self, this._then);

  final _ClaimFromSubscriptionRequest _self;
  final $Res Function(_ClaimFromSubscriptionRequest) _then;

/// Create a copy of ClaimFromSubscriptionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? couponId = null,}) {
  return _then(_ClaimFromSubscriptionRequest(
couponId: null == couponId ? _self.couponId : couponId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ClaimCouponResponse {

 int get userCouponId; String get uniqueCode; String get message;
/// Create a copy of ClaimCouponResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClaimCouponResponseCopyWith<ClaimCouponResponse> get copyWith => _$ClaimCouponResponseCopyWithImpl<ClaimCouponResponse>(this as ClaimCouponResponse, _$identity);

  /// Serializes this ClaimCouponResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClaimCouponResponse&&(identical(other.userCouponId, userCouponId) || other.userCouponId == userCouponId)&&(identical(other.uniqueCode, uniqueCode) || other.uniqueCode == uniqueCode)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userCouponId,uniqueCode,message);

@override
String toString() {
  return 'ClaimCouponResponse(userCouponId: $userCouponId, uniqueCode: $uniqueCode, message: $message)';
}


}

/// @nodoc
abstract mixin class $ClaimCouponResponseCopyWith<$Res>  {
  factory $ClaimCouponResponseCopyWith(ClaimCouponResponse value, $Res Function(ClaimCouponResponse) _then) = _$ClaimCouponResponseCopyWithImpl;
@useResult
$Res call({
 int userCouponId, String uniqueCode, String message
});




}
/// @nodoc
class _$ClaimCouponResponseCopyWithImpl<$Res>
    implements $ClaimCouponResponseCopyWith<$Res> {
  _$ClaimCouponResponseCopyWithImpl(this._self, this._then);

  final ClaimCouponResponse _self;
  final $Res Function(ClaimCouponResponse) _then;

/// Create a copy of ClaimCouponResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userCouponId = null,Object? uniqueCode = null,Object? message = null,}) {
  return _then(_self.copyWith(
userCouponId: null == userCouponId ? _self.userCouponId : userCouponId // ignore: cast_nullable_to_non_nullable
as int,uniqueCode: null == uniqueCode ? _self.uniqueCode : uniqueCode // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ClaimCouponResponse].
extension ClaimCouponResponsePatterns on ClaimCouponResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClaimCouponResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClaimCouponResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClaimCouponResponse value)  $default,){
final _that = this;
switch (_that) {
case _ClaimCouponResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClaimCouponResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ClaimCouponResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userCouponId,  String uniqueCode,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClaimCouponResponse() when $default != null:
return $default(_that.userCouponId,_that.uniqueCode,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userCouponId,  String uniqueCode,  String message)  $default,) {final _that = this;
switch (_that) {
case _ClaimCouponResponse():
return $default(_that.userCouponId,_that.uniqueCode,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userCouponId,  String uniqueCode,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ClaimCouponResponse() when $default != null:
return $default(_that.userCouponId,_that.uniqueCode,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClaimCouponResponse implements ClaimCouponResponse {
  const _ClaimCouponResponse({required this.userCouponId, required this.uniqueCode, required this.message});
  factory _ClaimCouponResponse.fromJson(Map<String, dynamic> json) => _$ClaimCouponResponseFromJson(json);

@override final  int userCouponId;
@override final  String uniqueCode;
@override final  String message;

/// Create a copy of ClaimCouponResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClaimCouponResponseCopyWith<_ClaimCouponResponse> get copyWith => __$ClaimCouponResponseCopyWithImpl<_ClaimCouponResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClaimCouponResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClaimCouponResponse&&(identical(other.userCouponId, userCouponId) || other.userCouponId == userCouponId)&&(identical(other.uniqueCode, uniqueCode) || other.uniqueCode == uniqueCode)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userCouponId,uniqueCode,message);

@override
String toString() {
  return 'ClaimCouponResponse(userCouponId: $userCouponId, uniqueCode: $uniqueCode, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ClaimCouponResponseCopyWith<$Res> implements $ClaimCouponResponseCopyWith<$Res> {
  factory _$ClaimCouponResponseCopyWith(_ClaimCouponResponse value, $Res Function(_ClaimCouponResponse) _then) = __$ClaimCouponResponseCopyWithImpl;
@override @useResult
$Res call({
 int userCouponId, String uniqueCode, String message
});




}
/// @nodoc
class __$ClaimCouponResponseCopyWithImpl<$Res>
    implements _$ClaimCouponResponseCopyWith<$Res> {
  __$ClaimCouponResponseCopyWithImpl(this._self, this._then);

  final _ClaimCouponResponse _self;
  final $Res Function(_ClaimCouponResponse) _then;

/// Create a copy of ClaimCouponResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userCouponId = null,Object? uniqueCode = null,Object? message = null,}) {
  return _then(_ClaimCouponResponse(
userCouponId: null == userCouponId ? _self.userCouponId : userCouponId // ignore: cast_nullable_to_non_nullable
as int,uniqueCode: null == uniqueCode ? _self.uniqueCode : uniqueCode // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
