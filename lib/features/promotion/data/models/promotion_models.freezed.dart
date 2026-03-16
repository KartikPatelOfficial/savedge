// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promotion_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PromotionStatusResponse {

 bool get isPromotionActive; bool get isEnrolled; DateTime? get enrolledAt; DateTime? get promotionExpiresAt;
/// Create a copy of PromotionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PromotionStatusResponseCopyWith<PromotionStatusResponse> get copyWith => _$PromotionStatusResponseCopyWithImpl<PromotionStatusResponse>(this as PromotionStatusResponse, _$identity);

  /// Serializes this PromotionStatusResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PromotionStatusResponse&&(identical(other.isPromotionActive, isPromotionActive) || other.isPromotionActive == isPromotionActive)&&(identical(other.isEnrolled, isEnrolled) || other.isEnrolled == isEnrolled)&&(identical(other.enrolledAt, enrolledAt) || other.enrolledAt == enrolledAt)&&(identical(other.promotionExpiresAt, promotionExpiresAt) || other.promotionExpiresAt == promotionExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isPromotionActive,isEnrolled,enrolledAt,promotionExpiresAt);

@override
String toString() {
  return 'PromotionStatusResponse(isPromotionActive: $isPromotionActive, isEnrolled: $isEnrolled, enrolledAt: $enrolledAt, promotionExpiresAt: $promotionExpiresAt)';
}


}

/// @nodoc
abstract mixin class $PromotionStatusResponseCopyWith<$Res>  {
  factory $PromotionStatusResponseCopyWith(PromotionStatusResponse value, $Res Function(PromotionStatusResponse) _then) = _$PromotionStatusResponseCopyWithImpl;
@useResult
$Res call({
 bool isPromotionActive, bool isEnrolled, DateTime? enrolledAt, DateTime? promotionExpiresAt
});




}
/// @nodoc
class _$PromotionStatusResponseCopyWithImpl<$Res>
    implements $PromotionStatusResponseCopyWith<$Res> {
  _$PromotionStatusResponseCopyWithImpl(this._self, this._then);

  final PromotionStatusResponse _self;
  final $Res Function(PromotionStatusResponse) _then;

/// Create a copy of PromotionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isPromotionActive = null,Object? isEnrolled = null,Object? enrolledAt = freezed,Object? promotionExpiresAt = freezed,}) {
  return _then(_self.copyWith(
isPromotionActive: null == isPromotionActive ? _self.isPromotionActive : isPromotionActive // ignore: cast_nullable_to_non_nullable
as bool,isEnrolled: null == isEnrolled ? _self.isEnrolled : isEnrolled // ignore: cast_nullable_to_non_nullable
as bool,enrolledAt: freezed == enrolledAt ? _self.enrolledAt : enrolledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,promotionExpiresAt: freezed == promotionExpiresAt ? _self.promotionExpiresAt : promotionExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PromotionStatusResponse].
extension PromotionStatusResponsePatterns on PromotionStatusResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PromotionStatusResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PromotionStatusResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PromotionStatusResponse value)  $default,){
final _that = this;
switch (_that) {
case _PromotionStatusResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PromotionStatusResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PromotionStatusResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isPromotionActive,  bool isEnrolled,  DateTime? enrolledAt,  DateTime? promotionExpiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PromotionStatusResponse() when $default != null:
return $default(_that.isPromotionActive,_that.isEnrolled,_that.enrolledAt,_that.promotionExpiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isPromotionActive,  bool isEnrolled,  DateTime? enrolledAt,  DateTime? promotionExpiresAt)  $default,) {final _that = this;
switch (_that) {
case _PromotionStatusResponse():
return $default(_that.isPromotionActive,_that.isEnrolled,_that.enrolledAt,_that.promotionExpiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isPromotionActive,  bool isEnrolled,  DateTime? enrolledAt,  DateTime? promotionExpiresAt)?  $default,) {final _that = this;
switch (_that) {
case _PromotionStatusResponse() when $default != null:
return $default(_that.isPromotionActive,_that.isEnrolled,_that.enrolledAt,_that.promotionExpiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PromotionStatusResponse implements PromotionStatusResponse {
  const _PromotionStatusResponse({required this.isPromotionActive, required this.isEnrolled, this.enrolledAt, this.promotionExpiresAt});
  factory _PromotionStatusResponse.fromJson(Map<String, dynamic> json) => _$PromotionStatusResponseFromJson(json);

@override final  bool isPromotionActive;
@override final  bool isEnrolled;
@override final  DateTime? enrolledAt;
@override final  DateTime? promotionExpiresAt;

/// Create a copy of PromotionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PromotionStatusResponseCopyWith<_PromotionStatusResponse> get copyWith => __$PromotionStatusResponseCopyWithImpl<_PromotionStatusResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PromotionStatusResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PromotionStatusResponse&&(identical(other.isPromotionActive, isPromotionActive) || other.isPromotionActive == isPromotionActive)&&(identical(other.isEnrolled, isEnrolled) || other.isEnrolled == isEnrolled)&&(identical(other.enrolledAt, enrolledAt) || other.enrolledAt == enrolledAt)&&(identical(other.promotionExpiresAt, promotionExpiresAt) || other.promotionExpiresAt == promotionExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isPromotionActive,isEnrolled,enrolledAt,promotionExpiresAt);

@override
String toString() {
  return 'PromotionStatusResponse(isPromotionActive: $isPromotionActive, isEnrolled: $isEnrolled, enrolledAt: $enrolledAt, promotionExpiresAt: $promotionExpiresAt)';
}


}

/// @nodoc
abstract mixin class _$PromotionStatusResponseCopyWith<$Res> implements $PromotionStatusResponseCopyWith<$Res> {
  factory _$PromotionStatusResponseCopyWith(_PromotionStatusResponse value, $Res Function(_PromotionStatusResponse) _then) = __$PromotionStatusResponseCopyWithImpl;
@override @useResult
$Res call({
 bool isPromotionActive, bool isEnrolled, DateTime? enrolledAt, DateTime? promotionExpiresAt
});




}
/// @nodoc
class __$PromotionStatusResponseCopyWithImpl<$Res>
    implements _$PromotionStatusResponseCopyWith<$Res> {
  __$PromotionStatusResponseCopyWithImpl(this._self, this._then);

  final _PromotionStatusResponse _self;
  final $Res Function(_PromotionStatusResponse) _then;

/// Create a copy of PromotionStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isPromotionActive = null,Object? isEnrolled = null,Object? enrolledAt = freezed,Object? promotionExpiresAt = freezed,}) {
  return _then(_PromotionStatusResponse(
isPromotionActive: null == isPromotionActive ? _self.isPromotionActive : isPromotionActive // ignore: cast_nullable_to_non_nullable
as bool,isEnrolled: null == isEnrolled ? _self.isEnrolled : isEnrolled // ignore: cast_nullable_to_non_nullable
as bool,enrolledAt: freezed == enrolledAt ? _self.enrolledAt : enrolledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,promotionExpiresAt: freezed == promotionExpiresAt ? _self.promotionExpiresAt : promotionExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$EnrollPromotionResponse {

 bool get success; DateTime get enrolledAt; DateTime get promotionExpiresAt; String get message;
/// Create a copy of EnrollPromotionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnrollPromotionResponseCopyWith<EnrollPromotionResponse> get copyWith => _$EnrollPromotionResponseCopyWithImpl<EnrollPromotionResponse>(this as EnrollPromotionResponse, _$identity);

  /// Serializes this EnrollPromotionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnrollPromotionResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.enrolledAt, enrolledAt) || other.enrolledAt == enrolledAt)&&(identical(other.promotionExpiresAt, promotionExpiresAt) || other.promotionExpiresAt == promotionExpiresAt)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,enrolledAt,promotionExpiresAt,message);

@override
String toString() {
  return 'EnrollPromotionResponse(success: $success, enrolledAt: $enrolledAt, promotionExpiresAt: $promotionExpiresAt, message: $message)';
}


}

/// @nodoc
abstract mixin class $EnrollPromotionResponseCopyWith<$Res>  {
  factory $EnrollPromotionResponseCopyWith(EnrollPromotionResponse value, $Res Function(EnrollPromotionResponse) _then) = _$EnrollPromotionResponseCopyWithImpl;
@useResult
$Res call({
 bool success, DateTime enrolledAt, DateTime promotionExpiresAt, String message
});




}
/// @nodoc
class _$EnrollPromotionResponseCopyWithImpl<$Res>
    implements $EnrollPromotionResponseCopyWith<$Res> {
  _$EnrollPromotionResponseCopyWithImpl(this._self, this._then);

  final EnrollPromotionResponse _self;
  final $Res Function(EnrollPromotionResponse) _then;

/// Create a copy of EnrollPromotionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? enrolledAt = null,Object? promotionExpiresAt = null,Object? message = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,enrolledAt: null == enrolledAt ? _self.enrolledAt : enrolledAt // ignore: cast_nullable_to_non_nullable
as DateTime,promotionExpiresAt: null == promotionExpiresAt ? _self.promotionExpiresAt : promotionExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EnrollPromotionResponse].
extension EnrollPromotionResponsePatterns on EnrollPromotionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnrollPromotionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnrollPromotionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnrollPromotionResponse value)  $default,){
final _that = this;
switch (_that) {
case _EnrollPromotionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnrollPromotionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EnrollPromotionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  DateTime enrolledAt,  DateTime promotionExpiresAt,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EnrollPromotionResponse() when $default != null:
return $default(_that.success,_that.enrolledAt,_that.promotionExpiresAt,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  DateTime enrolledAt,  DateTime promotionExpiresAt,  String message)  $default,) {final _that = this;
switch (_that) {
case _EnrollPromotionResponse():
return $default(_that.success,_that.enrolledAt,_that.promotionExpiresAt,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  DateTime enrolledAt,  DateTime promotionExpiresAt,  String message)?  $default,) {final _that = this;
switch (_that) {
case _EnrollPromotionResponse() when $default != null:
return $default(_that.success,_that.enrolledAt,_that.promotionExpiresAt,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EnrollPromotionResponse implements EnrollPromotionResponse {
  const _EnrollPromotionResponse({required this.success, required this.enrolledAt, required this.promotionExpiresAt, required this.message});
  factory _EnrollPromotionResponse.fromJson(Map<String, dynamic> json) => _$EnrollPromotionResponseFromJson(json);

@override final  bool success;
@override final  DateTime enrolledAt;
@override final  DateTime promotionExpiresAt;
@override final  String message;

/// Create a copy of EnrollPromotionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnrollPromotionResponseCopyWith<_EnrollPromotionResponse> get copyWith => __$EnrollPromotionResponseCopyWithImpl<_EnrollPromotionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EnrollPromotionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnrollPromotionResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.enrolledAt, enrolledAt) || other.enrolledAt == enrolledAt)&&(identical(other.promotionExpiresAt, promotionExpiresAt) || other.promotionExpiresAt == promotionExpiresAt)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,enrolledAt,promotionExpiresAt,message);

@override
String toString() {
  return 'EnrollPromotionResponse(success: $success, enrolledAt: $enrolledAt, promotionExpiresAt: $promotionExpiresAt, message: $message)';
}


}

/// @nodoc
abstract mixin class _$EnrollPromotionResponseCopyWith<$Res> implements $EnrollPromotionResponseCopyWith<$Res> {
  factory _$EnrollPromotionResponseCopyWith(_EnrollPromotionResponse value, $Res Function(_EnrollPromotionResponse) _then) = __$EnrollPromotionResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, DateTime enrolledAt, DateTime promotionExpiresAt, String message
});




}
/// @nodoc
class __$EnrollPromotionResponseCopyWithImpl<$Res>
    implements _$EnrollPromotionResponseCopyWith<$Res> {
  __$EnrollPromotionResponseCopyWithImpl(this._self, this._then);

  final _EnrollPromotionResponse _self;
  final $Res Function(_EnrollPromotionResponse) _then;

/// Create a copy of EnrollPromotionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? enrolledAt = null,Object? promotionExpiresAt = null,Object? message = null,}) {
  return _then(_EnrollPromotionResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,enrolledAt: null == enrolledAt ? _self.enrolledAt : enrolledAt // ignore: cast_nullable_to_non_nullable
as DateTime,promotionExpiresAt: null == promotionExpiresAt ? _self.promotionExpiresAt : promotionExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
