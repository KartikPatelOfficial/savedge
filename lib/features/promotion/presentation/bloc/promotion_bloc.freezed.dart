// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promotion_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PromotionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PromotionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PromotionEvent()';
}


}

/// @nodoc
class $PromotionEventCopyWith<$Res>  {
$PromotionEventCopyWith(PromotionEvent _, $Res Function(PromotionEvent) __);
}


/// Adds pattern-matching-related methods to [PromotionEvent].
extension PromotionEventPatterns on PromotionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CheckStatus value)?  checkStatus,TResult Function( _Enroll value)?  enroll,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckStatus() when checkStatus != null:
return checkStatus(_that);case _Enroll() when enroll != null:
return enroll(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CheckStatus value)  checkStatus,required TResult Function( _Enroll value)  enroll,}){
final _that = this;
switch (_that) {
case _CheckStatus():
return checkStatus(_that);case _Enroll():
return enroll(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CheckStatus value)?  checkStatus,TResult? Function( _Enroll value)?  enroll,}){
final _that = this;
switch (_that) {
case _CheckStatus() when checkStatus != null:
return checkStatus(_that);case _Enroll() when enroll != null:
return enroll(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  checkStatus,TResult Function()?  enroll,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckStatus() when checkStatus != null:
return checkStatus();case _Enroll() when enroll != null:
return enroll();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  checkStatus,required TResult Function()  enroll,}) {final _that = this;
switch (_that) {
case _CheckStatus():
return checkStatus();case _Enroll():
return enroll();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  checkStatus,TResult? Function()?  enroll,}) {final _that = this;
switch (_that) {
case _CheckStatus() when checkStatus != null:
return checkStatus();case _Enroll() when enroll != null:
return enroll();case _:
  return null;

}
}

}

/// @nodoc


class _CheckStatus implements PromotionEvent {
  const _CheckStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PromotionEvent.checkStatus()';
}


}




/// @nodoc


class _Enroll implements PromotionEvent {
  const _Enroll();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Enroll);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PromotionEvent.enroll()';
}


}




/// @nodoc
mixin _$PromotionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PromotionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PromotionState()';
}


}

/// @nodoc
class $PromotionStateCopyWith<$Res>  {
$PromotionStateCopyWith(PromotionState _, $Res Function(PromotionState) __);
}


/// Adds pattern-matching-related methods to [PromotionState].
extension PromotionStatePatterns on PromotionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Active value)?  active,TResult Function( _Enrolling value)?  enrolling,TResult Function( _Enrolled value)?  enrolled,TResult Function( _Inactive value)?  inactive,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Active() when active != null:
return active(_that);case _Enrolling() when enrolling != null:
return enrolling(_that);case _Enrolled() when enrolled != null:
return enrolled(_that);case _Inactive() when inactive != null:
return inactive(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Active value)  active,required TResult Function( _Enrolling value)  enrolling,required TResult Function( _Enrolled value)  enrolled,required TResult Function( _Inactive value)  inactive,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Active():
return active(_that);case _Enrolling():
return enrolling(_that);case _Enrolled():
return enrolled(_that);case _Inactive():
return inactive(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Active value)?  active,TResult? Function( _Enrolling value)?  enrolling,TResult? Function( _Enrolled value)?  enrolled,TResult? Function( _Inactive value)?  inactive,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Active() when active != null:
return active(_that);case _Enrolling() when enrolling != null:
return enrolling(_that);case _Enrolled() when enrolled != null:
return enrolled(_that);case _Inactive() when inactive != null:
return inactive(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( PromotionStatusResponse status)?  active,TResult Function()?  enrolling,TResult Function( EnrollPromotionResponse response)?  enrolled,TResult Function()?  inactive,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Active() when active != null:
return active(_that.status);case _Enrolling() when enrolling != null:
return enrolling();case _Enrolled() when enrolled != null:
return enrolled(_that.response);case _Inactive() when inactive != null:
return inactive();case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( PromotionStatusResponse status)  active,required TResult Function()  enrolling,required TResult Function( EnrollPromotionResponse response)  enrolled,required TResult Function()  inactive,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Active():
return active(_that.status);case _Enrolling():
return enrolling();case _Enrolled():
return enrolled(_that.response);case _Inactive():
return inactive();case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( PromotionStatusResponse status)?  active,TResult? Function()?  enrolling,TResult? Function( EnrollPromotionResponse response)?  enrolled,TResult? Function()?  inactive,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Active() when active != null:
return active(_that.status);case _Enrolling() when enrolling != null:
return enrolling();case _Enrolled() when enrolled != null:
return enrolled(_that.response);case _Inactive() when inactive != null:
return inactive();case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PromotionState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PromotionState.initial()';
}


}




/// @nodoc


class _Loading implements PromotionState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PromotionState.loading()';
}


}




/// @nodoc


class _Active implements PromotionState {
  const _Active({required this.status});
  

 final  PromotionStatusResponse status;

/// Create a copy of PromotionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActiveCopyWith<_Active> get copyWith => __$ActiveCopyWithImpl<_Active>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Active&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'PromotionState.active(status: $status)';
}


}

/// @nodoc
abstract mixin class _$ActiveCopyWith<$Res> implements $PromotionStateCopyWith<$Res> {
  factory _$ActiveCopyWith(_Active value, $Res Function(_Active) _then) = __$ActiveCopyWithImpl;
@useResult
$Res call({
 PromotionStatusResponse status
});


$PromotionStatusResponseCopyWith<$Res> get status;

}
/// @nodoc
class __$ActiveCopyWithImpl<$Res>
    implements _$ActiveCopyWith<$Res> {
  __$ActiveCopyWithImpl(this._self, this._then);

  final _Active _self;
  final $Res Function(_Active) _then;

/// Create a copy of PromotionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_Active(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PromotionStatusResponse,
  ));
}

/// Create a copy of PromotionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PromotionStatusResponseCopyWith<$Res> get status {
  
  return $PromotionStatusResponseCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

/// @nodoc


class _Enrolling implements PromotionState {
  const _Enrolling();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Enrolling);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PromotionState.enrolling()';
}


}




/// @nodoc


class _Enrolled implements PromotionState {
  const _Enrolled({required this.response});
  

 final  EnrollPromotionResponse response;

/// Create a copy of PromotionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnrolledCopyWith<_Enrolled> get copyWith => __$EnrolledCopyWithImpl<_Enrolled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Enrolled&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'PromotionState.enrolled(response: $response)';
}


}

/// @nodoc
abstract mixin class _$EnrolledCopyWith<$Res> implements $PromotionStateCopyWith<$Res> {
  factory _$EnrolledCopyWith(_Enrolled value, $Res Function(_Enrolled) _then) = __$EnrolledCopyWithImpl;
@useResult
$Res call({
 EnrollPromotionResponse response
});


$EnrollPromotionResponseCopyWith<$Res> get response;

}
/// @nodoc
class __$EnrolledCopyWithImpl<$Res>
    implements _$EnrolledCopyWith<$Res> {
  __$EnrolledCopyWithImpl(this._self, this._then);

  final _Enrolled _self;
  final $Res Function(_Enrolled) _then;

/// Create a copy of PromotionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_Enrolled(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as EnrollPromotionResponse,
  ));
}

/// Create a copy of PromotionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnrollPromotionResponseCopyWith<$Res> get response {
  
  return $EnrollPromotionResponseCopyWith<$Res>(_self.response, (value) {
    return _then(_self.copyWith(response: value));
  });
}
}

/// @nodoc


class _Inactive implements PromotionState {
  const _Inactive();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Inactive);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PromotionState.inactive()';
}


}




/// @nodoc


class _Error implements PromotionState {
  const _Error({required this.message});
  

 final  String message;

/// Create a copy of PromotionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PromotionState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $PromotionStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of PromotionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
