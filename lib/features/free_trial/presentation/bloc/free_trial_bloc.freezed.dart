// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'free_trial_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FreeTrialEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FreeTrialEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FreeTrialEvent()';
}


}

/// @nodoc
class $FreeTrialEventCopyWith<$Res>  {
$FreeTrialEventCopyWith(FreeTrialEvent _, $Res Function(FreeTrialEvent) __);
}


/// Adds pattern-matching-related methods to [FreeTrialEvent].
extension FreeTrialEventPatterns on FreeTrialEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadStatus value)?  loadStatus,TResult Function( _ActivateTrial value)?  activateTrial,TResult Function( _UpdateCountdown value)?  updateCountdown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadStatus() when loadStatus != null:
return loadStatus(_that);case _ActivateTrial() when activateTrial != null:
return activateTrial(_that);case _UpdateCountdown() when updateCountdown != null:
return updateCountdown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadStatus value)  loadStatus,required TResult Function( _ActivateTrial value)  activateTrial,required TResult Function( _UpdateCountdown value)  updateCountdown,}){
final _that = this;
switch (_that) {
case _LoadStatus():
return loadStatus(_that);case _ActivateTrial():
return activateTrial(_that);case _UpdateCountdown():
return updateCountdown(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadStatus value)?  loadStatus,TResult? Function( _ActivateTrial value)?  activateTrial,TResult? Function( _UpdateCountdown value)?  updateCountdown,}){
final _that = this;
switch (_that) {
case _LoadStatus() when loadStatus != null:
return loadStatus(_that);case _ActivateTrial() when activateTrial != null:
return activateTrial(_that);case _UpdateCountdown() when updateCountdown != null:
return updateCountdown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadStatus,TResult Function()?  activateTrial,TResult Function()?  updateCountdown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadStatus() when loadStatus != null:
return loadStatus();case _ActivateTrial() when activateTrial != null:
return activateTrial();case _UpdateCountdown() when updateCountdown != null:
return updateCountdown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadStatus,required TResult Function()  activateTrial,required TResult Function()  updateCountdown,}) {final _that = this;
switch (_that) {
case _LoadStatus():
return loadStatus();case _ActivateTrial():
return activateTrial();case _UpdateCountdown():
return updateCountdown();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadStatus,TResult? Function()?  activateTrial,TResult? Function()?  updateCountdown,}) {final _that = this;
switch (_that) {
case _LoadStatus() when loadStatus != null:
return loadStatus();case _ActivateTrial() when activateTrial != null:
return activateTrial();case _UpdateCountdown() when updateCountdown != null:
return updateCountdown();case _:
  return null;

}
}

}

/// @nodoc


class _LoadStatus implements FreeTrialEvent {
  const _LoadStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FreeTrialEvent.loadStatus()';
}


}




/// @nodoc


class _ActivateTrial implements FreeTrialEvent {
  const _ActivateTrial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ActivateTrial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FreeTrialEvent.activateTrial()';
}


}




/// @nodoc


class _UpdateCountdown implements FreeTrialEvent {
  const _UpdateCountdown();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCountdown);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FreeTrialEvent.updateCountdown()';
}


}




/// @nodoc
mixin _$FreeTrialState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FreeTrialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FreeTrialState()';
}


}

/// @nodoc
class $FreeTrialStateCopyWith<$Res>  {
$FreeTrialStateCopyWith(FreeTrialState _, $Res Function(FreeTrialState) __);
}


/// Adds pattern-matching-related methods to [FreeTrialState].
extension FreeTrialStatePatterns on FreeTrialState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Activating value)?  activating,TResult Function( _Activated value)?  activated,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Activating() when activating != null:
return activating(_that);case _Activated() when activated != null:
return activated(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Activating value)  activating,required TResult Function( _Activated value)  activated,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Activating():
return activating(_that);case _Activated():
return activated(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Activating value)?  activating,TResult? Function( _Activated value)?  activated,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Activating() when activating != null:
return activating(_that);case _Activated() when activated != null:
return activated(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( FreeTrialStatusResponse status)?  loaded,TResult Function()?  activating,TResult Function( ActivateFreeTrialResponse response)?  activated,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.status);case _Activating() when activating != null:
return activating();case _Activated() when activated != null:
return activated(_that.response);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( FreeTrialStatusResponse status)  loaded,required TResult Function()  activating,required TResult Function( ActivateFreeTrialResponse response)  activated,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.status);case _Activating():
return activating();case _Activated():
return activated(_that.response);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( FreeTrialStatusResponse status)?  loaded,TResult? Function()?  activating,TResult? Function( ActivateFreeTrialResponse response)?  activated,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.status);case _Activating() when activating != null:
return activating();case _Activated() when activated != null:
return activated(_that.response);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements FreeTrialState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FreeTrialState.initial()';
}


}




/// @nodoc


class _Loading implements FreeTrialState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FreeTrialState.loading()';
}


}




/// @nodoc


class _Loaded implements FreeTrialState {
  const _Loaded({required this.status});
  

 final  FreeTrialStatusResponse status;

/// Create a copy of FreeTrialState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'FreeTrialState.loaded(status: $status)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $FreeTrialStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 FreeTrialStatusResponse status
});


$FreeTrialStatusResponseCopyWith<$Res> get status;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of FreeTrialState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_Loaded(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FreeTrialStatusResponse,
  ));
}

/// Create a copy of FreeTrialState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FreeTrialStatusResponseCopyWith<$Res> get status {
  
  return $FreeTrialStatusResponseCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

/// @nodoc


class _Activating implements FreeTrialState {
  const _Activating();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Activating);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FreeTrialState.activating()';
}


}




/// @nodoc


class _Activated implements FreeTrialState {
  const _Activated({required this.response});
  

 final  ActivateFreeTrialResponse response;

/// Create a copy of FreeTrialState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ActivatedCopyWith<_Activated> get copyWith => __$ActivatedCopyWithImpl<_Activated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Activated&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'FreeTrialState.activated(response: $response)';
}


}

/// @nodoc
abstract mixin class _$ActivatedCopyWith<$Res> implements $FreeTrialStateCopyWith<$Res> {
  factory _$ActivatedCopyWith(_Activated value, $Res Function(_Activated) _then) = __$ActivatedCopyWithImpl;
@useResult
$Res call({
 ActivateFreeTrialResponse response
});


$ActivateFreeTrialResponseCopyWith<$Res> get response;

}
/// @nodoc
class __$ActivatedCopyWithImpl<$Res>
    implements _$ActivatedCopyWith<$Res> {
  __$ActivatedCopyWithImpl(this._self, this._then);

  final _Activated _self;
  final $Res Function(_Activated) _then;

/// Create a copy of FreeTrialState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_Activated(
response: null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ActivateFreeTrialResponse,
  ));
}

/// Create a copy of FreeTrialState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ActivateFreeTrialResponseCopyWith<$Res> get response {
  
  return $ActivateFreeTrialResponseCopyWith<$Res>(_self.response, (value) {
    return _then(_self.copyWith(response: value));
  });
}
}

/// @nodoc


class _Error implements FreeTrialState {
  const _Error({required this.message});
  

 final  String message;

/// Create a copy of FreeTrialState
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
  return 'FreeTrialState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $FreeTrialStateCopyWith<$Res> {
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

/// Create a copy of FreeTrialState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
