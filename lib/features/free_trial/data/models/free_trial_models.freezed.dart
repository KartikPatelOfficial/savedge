// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'free_trial_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FreeTrialStatusResponse {

 FreeTrialStatus get status; bool get canActivate; DateTime? get activatedAt; DateTime? get expiresAt; DateTime get offerExpiresAt; RemainingTimeResponse? get remainingTime; bool get hasActiveSubscription;
/// Create a copy of FreeTrialStatusResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FreeTrialStatusResponseCopyWith<FreeTrialStatusResponse> get copyWith => _$FreeTrialStatusResponseCopyWithImpl<FreeTrialStatusResponse>(this as FreeTrialStatusResponse, _$identity);

  /// Serializes this FreeTrialStatusResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FreeTrialStatusResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.canActivate, canActivate) || other.canActivate == canActivate)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.offerExpiresAt, offerExpiresAt) || other.offerExpiresAt == offerExpiresAt)&&(identical(other.remainingTime, remainingTime) || other.remainingTime == remainingTime)&&(identical(other.hasActiveSubscription, hasActiveSubscription) || other.hasActiveSubscription == hasActiveSubscription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,canActivate,activatedAt,expiresAt,offerExpiresAt,remainingTime,hasActiveSubscription);

@override
String toString() {
  return 'FreeTrialStatusResponse(status: $status, canActivate: $canActivate, activatedAt: $activatedAt, expiresAt: $expiresAt, offerExpiresAt: $offerExpiresAt, remainingTime: $remainingTime, hasActiveSubscription: $hasActiveSubscription)';
}


}

/// @nodoc
abstract mixin class $FreeTrialStatusResponseCopyWith<$Res>  {
  factory $FreeTrialStatusResponseCopyWith(FreeTrialStatusResponse value, $Res Function(FreeTrialStatusResponse) _then) = _$FreeTrialStatusResponseCopyWithImpl;
@useResult
$Res call({
 FreeTrialStatus status, bool canActivate, DateTime? activatedAt, DateTime? expiresAt, DateTime offerExpiresAt, RemainingTimeResponse? remainingTime, bool hasActiveSubscription
});


$RemainingTimeResponseCopyWith<$Res>? get remainingTime;

}
/// @nodoc
class _$FreeTrialStatusResponseCopyWithImpl<$Res>
    implements $FreeTrialStatusResponseCopyWith<$Res> {
  _$FreeTrialStatusResponseCopyWithImpl(this._self, this._then);

  final FreeTrialStatusResponse _self;
  final $Res Function(FreeTrialStatusResponse) _then;

/// Create a copy of FreeTrialStatusResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? canActivate = null,Object? activatedAt = freezed,Object? expiresAt = freezed,Object? offerExpiresAt = null,Object? remainingTime = freezed,Object? hasActiveSubscription = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FreeTrialStatus,canActivate: null == canActivate ? _self.canActivate : canActivate // ignore: cast_nullable_to_non_nullable
as bool,activatedAt: freezed == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,offerExpiresAt: null == offerExpiresAt ? _self.offerExpiresAt : offerExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,remainingTime: freezed == remainingTime ? _self.remainingTime : remainingTime // ignore: cast_nullable_to_non_nullable
as RemainingTimeResponse?,hasActiveSubscription: null == hasActiveSubscription ? _self.hasActiveSubscription : hasActiveSubscription // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of FreeTrialStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RemainingTimeResponseCopyWith<$Res>? get remainingTime {
    if (_self.remainingTime == null) {
    return null;
  }

  return $RemainingTimeResponseCopyWith<$Res>(_self.remainingTime!, (value) {
    return _then(_self.copyWith(remainingTime: value));
  });
}
}


/// Adds pattern-matching-related methods to [FreeTrialStatusResponse].
extension FreeTrialStatusResponsePatterns on FreeTrialStatusResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FreeTrialStatusResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FreeTrialStatusResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FreeTrialStatusResponse value)  $default,){
final _that = this;
switch (_that) {
case _FreeTrialStatusResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FreeTrialStatusResponse value)?  $default,){
final _that = this;
switch (_that) {
case _FreeTrialStatusResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FreeTrialStatus status,  bool canActivate,  DateTime? activatedAt,  DateTime? expiresAt,  DateTime offerExpiresAt,  RemainingTimeResponse? remainingTime,  bool hasActiveSubscription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FreeTrialStatusResponse() when $default != null:
return $default(_that.status,_that.canActivate,_that.activatedAt,_that.expiresAt,_that.offerExpiresAt,_that.remainingTime,_that.hasActiveSubscription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FreeTrialStatus status,  bool canActivate,  DateTime? activatedAt,  DateTime? expiresAt,  DateTime offerExpiresAt,  RemainingTimeResponse? remainingTime,  bool hasActiveSubscription)  $default,) {final _that = this;
switch (_that) {
case _FreeTrialStatusResponse():
return $default(_that.status,_that.canActivate,_that.activatedAt,_that.expiresAt,_that.offerExpiresAt,_that.remainingTime,_that.hasActiveSubscription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FreeTrialStatus status,  bool canActivate,  DateTime? activatedAt,  DateTime? expiresAt,  DateTime offerExpiresAt,  RemainingTimeResponse? remainingTime,  bool hasActiveSubscription)?  $default,) {final _that = this;
switch (_that) {
case _FreeTrialStatusResponse() when $default != null:
return $default(_that.status,_that.canActivate,_that.activatedAt,_that.expiresAt,_that.offerExpiresAt,_that.remainingTime,_that.hasActiveSubscription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FreeTrialStatusResponse implements FreeTrialStatusResponse {
  const _FreeTrialStatusResponse({required this.status, required this.canActivate, this.activatedAt, this.expiresAt, required this.offerExpiresAt, this.remainingTime, required this.hasActiveSubscription});
  factory _FreeTrialStatusResponse.fromJson(Map<String, dynamic> json) => _$FreeTrialStatusResponseFromJson(json);

@override final  FreeTrialStatus status;
@override final  bool canActivate;
@override final  DateTime? activatedAt;
@override final  DateTime? expiresAt;
@override final  DateTime offerExpiresAt;
@override final  RemainingTimeResponse? remainingTime;
@override final  bool hasActiveSubscription;

/// Create a copy of FreeTrialStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FreeTrialStatusResponseCopyWith<_FreeTrialStatusResponse> get copyWith => __$FreeTrialStatusResponseCopyWithImpl<_FreeTrialStatusResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FreeTrialStatusResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FreeTrialStatusResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.canActivate, canActivate) || other.canActivate == canActivate)&&(identical(other.activatedAt, activatedAt) || other.activatedAt == activatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.offerExpiresAt, offerExpiresAt) || other.offerExpiresAt == offerExpiresAt)&&(identical(other.remainingTime, remainingTime) || other.remainingTime == remainingTime)&&(identical(other.hasActiveSubscription, hasActiveSubscription) || other.hasActiveSubscription == hasActiveSubscription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,canActivate,activatedAt,expiresAt,offerExpiresAt,remainingTime,hasActiveSubscription);

@override
String toString() {
  return 'FreeTrialStatusResponse(status: $status, canActivate: $canActivate, activatedAt: $activatedAt, expiresAt: $expiresAt, offerExpiresAt: $offerExpiresAt, remainingTime: $remainingTime, hasActiveSubscription: $hasActiveSubscription)';
}


}

/// @nodoc
abstract mixin class _$FreeTrialStatusResponseCopyWith<$Res> implements $FreeTrialStatusResponseCopyWith<$Res> {
  factory _$FreeTrialStatusResponseCopyWith(_FreeTrialStatusResponse value, $Res Function(_FreeTrialStatusResponse) _then) = __$FreeTrialStatusResponseCopyWithImpl;
@override @useResult
$Res call({
 FreeTrialStatus status, bool canActivate, DateTime? activatedAt, DateTime? expiresAt, DateTime offerExpiresAt, RemainingTimeResponse? remainingTime, bool hasActiveSubscription
});


@override $RemainingTimeResponseCopyWith<$Res>? get remainingTime;

}
/// @nodoc
class __$FreeTrialStatusResponseCopyWithImpl<$Res>
    implements _$FreeTrialStatusResponseCopyWith<$Res> {
  __$FreeTrialStatusResponseCopyWithImpl(this._self, this._then);

  final _FreeTrialStatusResponse _self;
  final $Res Function(_FreeTrialStatusResponse) _then;

/// Create a copy of FreeTrialStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? canActivate = null,Object? activatedAt = freezed,Object? expiresAt = freezed,Object? offerExpiresAt = null,Object? remainingTime = freezed,Object? hasActiveSubscription = null,}) {
  return _then(_FreeTrialStatusResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FreeTrialStatus,canActivate: null == canActivate ? _self.canActivate : canActivate // ignore: cast_nullable_to_non_nullable
as bool,activatedAt: freezed == activatedAt ? _self.activatedAt : activatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,offerExpiresAt: null == offerExpiresAt ? _self.offerExpiresAt : offerExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,remainingTime: freezed == remainingTime ? _self.remainingTime : remainingTime // ignore: cast_nullable_to_non_nullable
as RemainingTimeResponse?,hasActiveSubscription: null == hasActiveSubscription ? _self.hasActiveSubscription : hasActiveSubscription // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of FreeTrialStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RemainingTimeResponseCopyWith<$Res>? get remainingTime {
    if (_self.remainingTime == null) {
    return null;
  }

  return $RemainingTimeResponseCopyWith<$Res>(_self.remainingTime!, (value) {
    return _then(_self.copyWith(remainingTime: value));
  });
}
}


/// @nodoc
mixin _$RemainingTimeResponse {

 int get days; int get hours; int get minutes; int get seconds; int get totalSeconds;
/// Create a copy of RemainingTimeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RemainingTimeResponseCopyWith<RemainingTimeResponse> get copyWith => _$RemainingTimeResponseCopyWithImpl<RemainingTimeResponse>(this as RemainingTimeResponse, _$identity);

  /// Serializes this RemainingTimeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RemainingTimeResponse&&(identical(other.days, days) || other.days == days)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.seconds, seconds) || other.seconds == seconds)&&(identical(other.totalSeconds, totalSeconds) || other.totalSeconds == totalSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,days,hours,minutes,seconds,totalSeconds);

@override
String toString() {
  return 'RemainingTimeResponse(days: $days, hours: $hours, minutes: $minutes, seconds: $seconds, totalSeconds: $totalSeconds)';
}


}

/// @nodoc
abstract mixin class $RemainingTimeResponseCopyWith<$Res>  {
  factory $RemainingTimeResponseCopyWith(RemainingTimeResponse value, $Res Function(RemainingTimeResponse) _then) = _$RemainingTimeResponseCopyWithImpl;
@useResult
$Res call({
 int days, int hours, int minutes, int seconds, int totalSeconds
});




}
/// @nodoc
class _$RemainingTimeResponseCopyWithImpl<$Res>
    implements $RemainingTimeResponseCopyWith<$Res> {
  _$RemainingTimeResponseCopyWithImpl(this._self, this._then);

  final RemainingTimeResponse _self;
  final $Res Function(RemainingTimeResponse) _then;

/// Create a copy of RemainingTimeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? days = null,Object? hours = null,Object? minutes = null,Object? seconds = null,Object? totalSeconds = null,}) {
  return _then(_self.copyWith(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,totalSeconds: null == totalSeconds ? _self.totalSeconds : totalSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RemainingTimeResponse].
extension RemainingTimeResponsePatterns on RemainingTimeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RemainingTimeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RemainingTimeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RemainingTimeResponse value)  $default,){
final _that = this;
switch (_that) {
case _RemainingTimeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RemainingTimeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RemainingTimeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int days,  int hours,  int minutes,  int seconds,  int totalSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RemainingTimeResponse() when $default != null:
return $default(_that.days,_that.hours,_that.minutes,_that.seconds,_that.totalSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int days,  int hours,  int minutes,  int seconds,  int totalSeconds)  $default,) {final _that = this;
switch (_that) {
case _RemainingTimeResponse():
return $default(_that.days,_that.hours,_that.minutes,_that.seconds,_that.totalSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int days,  int hours,  int minutes,  int seconds,  int totalSeconds)?  $default,) {final _that = this;
switch (_that) {
case _RemainingTimeResponse() when $default != null:
return $default(_that.days,_that.hours,_that.minutes,_that.seconds,_that.totalSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RemainingTimeResponse implements RemainingTimeResponse {
  const _RemainingTimeResponse({required this.days, required this.hours, required this.minutes, required this.seconds, required this.totalSeconds});
  factory _RemainingTimeResponse.fromJson(Map<String, dynamic> json) => _$RemainingTimeResponseFromJson(json);

@override final  int days;
@override final  int hours;
@override final  int minutes;
@override final  int seconds;
@override final  int totalSeconds;

/// Create a copy of RemainingTimeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemainingTimeResponseCopyWith<_RemainingTimeResponse> get copyWith => __$RemainingTimeResponseCopyWithImpl<_RemainingTimeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RemainingTimeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemainingTimeResponse&&(identical(other.days, days) || other.days == days)&&(identical(other.hours, hours) || other.hours == hours)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.seconds, seconds) || other.seconds == seconds)&&(identical(other.totalSeconds, totalSeconds) || other.totalSeconds == totalSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,days,hours,minutes,seconds,totalSeconds);

@override
String toString() {
  return 'RemainingTimeResponse(days: $days, hours: $hours, minutes: $minutes, seconds: $seconds, totalSeconds: $totalSeconds)';
}


}

/// @nodoc
abstract mixin class _$RemainingTimeResponseCopyWith<$Res> implements $RemainingTimeResponseCopyWith<$Res> {
  factory _$RemainingTimeResponseCopyWith(_RemainingTimeResponse value, $Res Function(_RemainingTimeResponse) _then) = __$RemainingTimeResponseCopyWithImpl;
@override @useResult
$Res call({
 int days, int hours, int minutes, int seconds, int totalSeconds
});




}
/// @nodoc
class __$RemainingTimeResponseCopyWithImpl<$Res>
    implements _$RemainingTimeResponseCopyWith<$Res> {
  __$RemainingTimeResponseCopyWithImpl(this._self, this._then);

  final _RemainingTimeResponse _self;
  final $Res Function(_RemainingTimeResponse) _then;

/// Create a copy of RemainingTimeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? days = null,Object? hours = null,Object? minutes = null,Object? seconds = null,Object? totalSeconds = null,}) {
  return _then(_RemainingTimeResponse(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,totalSeconds: null == totalSeconds ? _self.totalSeconds : totalSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ActivateFreeTrialResponse {

 bool get success; DateTime get expiresAt; String get message;
/// Create a copy of ActivateFreeTrialResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivateFreeTrialResponseCopyWith<ActivateFreeTrialResponse> get copyWith => _$ActivateFreeTrialResponseCopyWithImpl<ActivateFreeTrialResponse>(this as ActivateFreeTrialResponse, _$identity);

  /// Serializes this ActivateFreeTrialResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivateFreeTrialResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,expiresAt,message);

@override
String toString() {
  return 'ActivateFreeTrialResponse(success: $success, expiresAt: $expiresAt, message: $message)';
}


}

/// @nodoc
abstract mixin class $ActivateFreeTrialResponseCopyWith<$Res>  {
  factory $ActivateFreeTrialResponseCopyWith(ActivateFreeTrialResponse value, $Res Function(ActivateFreeTrialResponse) _then) = _$ActivateFreeTrialResponseCopyWithImpl;
@useResult
$Res call({
 bool success, DateTime expiresAt, String message
});




}
/// @nodoc
class _$ActivateFreeTrialResponseCopyWithImpl<$Res>
    implements $ActivateFreeTrialResponseCopyWith<$Res> {
  _$ActivateFreeTrialResponseCopyWithImpl(this._self, this._then);

  final ActivateFreeTrialResponse _self;
  final $Res Function(ActivateFreeTrialResponse) _then;

/// Create a copy of ActivateFreeTrialResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? expiresAt = null,Object? message = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ActivateFreeTrialResponse].
extension ActivateFreeTrialResponsePatterns on ActivateFreeTrialResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ActivateFreeTrialResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ActivateFreeTrialResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ActivateFreeTrialResponse value)  $default,){
final _that = this;
switch (_that) {
case _ActivateFreeTrialResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ActivateFreeTrialResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ActivateFreeTrialResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  DateTime expiresAt,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ActivateFreeTrialResponse() when $default != null:
return $default(_that.success,_that.expiresAt,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  DateTime expiresAt,  String message)  $default,) {final _that = this;
switch (_that) {
case _ActivateFreeTrialResponse():
return $default(_that.success,_that.expiresAt,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  DateTime expiresAt,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ActivateFreeTrialResponse() when $default != null:
return $default(_that.success,_that.expiresAt,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ActivateFreeTrialResponse implements ActivateFreeTrialResponse {
  const _ActivateFreeTrialResponse({required this.success, required this.expiresAt, required this.message});
  factory _ActivateFreeTrialResponse.fromJson(Map<String, dynamic> json) => _$ActivateFreeTrialResponseFromJson(json);

@override final  bool success;
@override final  DateTime expiresAt;
@override final  String message;

/// Create a copy of ActivateFreeTrialResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivateFreeTrialResponseCopyWith<_ActivateFreeTrialResponse> get copyWith => __$ActivateFreeTrialResponseCopyWithImpl<_ActivateFreeTrialResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ActivateFreeTrialResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivateFreeTrialResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,expiresAt,message);

@override
String toString() {
  return 'ActivateFreeTrialResponse(success: $success, expiresAt: $expiresAt, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ActivateFreeTrialResponseCopyWith<$Res> implements $ActivateFreeTrialResponseCopyWith<$Res> {
  factory _$ActivateFreeTrialResponseCopyWith(_ActivateFreeTrialResponse value, $Res Function(_ActivateFreeTrialResponse) _then) = __$ActivateFreeTrialResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, DateTime expiresAt, String message
});




}
/// @nodoc
class __$ActivateFreeTrialResponseCopyWithImpl<$Res>
    implements _$ActivateFreeTrialResponseCopyWith<$Res> {
  __$ActivateFreeTrialResponseCopyWithImpl(this._self, this._then);

  final _ActivateFreeTrialResponse _self;
  final $Res Function(_ActivateFreeTrialResponse) _then;

/// Create a copy of ActivateFreeTrialResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? expiresAt = null,Object? message = null,}) {
  return _then(_ActivateFreeTrialResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
