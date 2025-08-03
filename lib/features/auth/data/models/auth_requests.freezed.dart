// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_requests.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserRegistrationRequest {

 String get email; String? get firstName; String? get lastName;
/// Create a copy of UserRegistrationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserRegistrationRequestCopyWith<UserRegistrationRequest> get copyWith => _$UserRegistrationRequestCopyWithImpl<UserRegistrationRequest>(this as UserRegistrationRequest, _$identity);

  /// Serializes this UserRegistrationRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserRegistrationRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,firstName,lastName);

@override
String toString() {
  return 'UserRegistrationRequest(email: $email, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class $UserRegistrationRequestCopyWith<$Res>  {
  factory $UserRegistrationRequestCopyWith(UserRegistrationRequest value, $Res Function(UserRegistrationRequest) _then) = _$UserRegistrationRequestCopyWithImpl;
@useResult
$Res call({
 String email, String? firstName, String? lastName
});




}
/// @nodoc
class _$UserRegistrationRequestCopyWithImpl<$Res>
    implements $UserRegistrationRequestCopyWith<$Res> {
  _$UserRegistrationRequestCopyWithImpl(this._self, this._then);

  final UserRegistrationRequest _self;
  final $Res Function(UserRegistrationRequest) _then;

/// Create a copy of UserRegistrationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? firstName = freezed,Object? lastName = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserRegistrationRequest].
extension UserRegistrationRequestPatterns on UserRegistrationRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserRegistrationRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserRegistrationRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserRegistrationRequest value)  $default,){
final _that = this;
switch (_that) {
case _UserRegistrationRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserRegistrationRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UserRegistrationRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String? firstName,  String? lastName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserRegistrationRequest() when $default != null:
return $default(_that.email,_that.firstName,_that.lastName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String? firstName,  String? lastName)  $default,) {final _that = this;
switch (_that) {
case _UserRegistrationRequest():
return $default(_that.email,_that.firstName,_that.lastName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String? firstName,  String? lastName)?  $default,) {final _that = this;
switch (_that) {
case _UserRegistrationRequest() when $default != null:
return $default(_that.email,_that.firstName,_that.lastName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserRegistrationRequest implements UserRegistrationRequest {
  const _UserRegistrationRequest({required this.email, this.firstName, this.lastName});
  factory _UserRegistrationRequest.fromJson(Map<String, dynamic> json) => _$UserRegistrationRequestFromJson(json);

@override final  String email;
@override final  String? firstName;
@override final  String? lastName;

/// Create a copy of UserRegistrationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserRegistrationRequestCopyWith<_UserRegistrationRequest> get copyWith => __$UserRegistrationRequestCopyWithImpl<_UserRegistrationRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserRegistrationRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRegistrationRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,firstName,lastName);

@override
String toString() {
  return 'UserRegistrationRequest(email: $email, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class _$UserRegistrationRequestCopyWith<$Res> implements $UserRegistrationRequestCopyWith<$Res> {
  factory _$UserRegistrationRequestCopyWith(_UserRegistrationRequest value, $Res Function(_UserRegistrationRequest) _then) = __$UserRegistrationRequestCopyWithImpl;
@override @useResult
$Res call({
 String email, String? firstName, String? lastName
});




}
/// @nodoc
class __$UserRegistrationRequestCopyWithImpl<$Res>
    implements _$UserRegistrationRequestCopyWith<$Res> {
  __$UserRegistrationRequestCopyWithImpl(this._self, this._then);

  final _UserRegistrationRequest _self;
  final $Res Function(_UserRegistrationRequest) _then;

/// Create a copy of UserRegistrationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? firstName = freezed,Object? lastName = freezed,}) {
  return _then(_UserRegistrationRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SyncUserRequest {

 String get email; String? get displayName;
/// Create a copy of SyncUserRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncUserRequestCopyWith<SyncUserRequest> get copyWith => _$SyncUserRequestCopyWithImpl<SyncUserRequest>(this as SyncUserRequest, _$identity);

  /// Serializes this SyncUserRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncUserRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,displayName);

@override
String toString() {
  return 'SyncUserRequest(email: $email, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class $SyncUserRequestCopyWith<$Res>  {
  factory $SyncUserRequestCopyWith(SyncUserRequest value, $Res Function(SyncUserRequest) _then) = _$SyncUserRequestCopyWithImpl;
@useResult
$Res call({
 String email, String? displayName
});




}
/// @nodoc
class _$SyncUserRequestCopyWithImpl<$Res>
    implements $SyncUserRequestCopyWith<$Res> {
  _$SyncUserRequestCopyWithImpl(this._self, this._then);

  final SyncUserRequest _self;
  final $Res Function(SyncUserRequest) _then;

/// Create a copy of SyncUserRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? displayName = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncUserRequest].
extension SyncUserRequestPatterns on SyncUserRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncUserRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncUserRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncUserRequest value)  $default,){
final _that = this;
switch (_that) {
case _SyncUserRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncUserRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SyncUserRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String? displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncUserRequest() when $default != null:
return $default(_that.email,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String? displayName)  $default,) {final _that = this;
switch (_that) {
case _SyncUserRequest():
return $default(_that.email,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String? displayName)?  $default,) {final _that = this;
switch (_that) {
case _SyncUserRequest() when $default != null:
return $default(_that.email,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncUserRequest implements SyncUserRequest {
  const _SyncUserRequest({required this.email, this.displayName});
  factory _SyncUserRequest.fromJson(Map<String, dynamic> json) => _$SyncUserRequestFromJson(json);

@override final  String email;
@override final  String? displayName;

/// Create a copy of SyncUserRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncUserRequestCopyWith<_SyncUserRequest> get copyWith => __$SyncUserRequestCopyWithImpl<_SyncUserRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncUserRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncUserRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,displayName);

@override
String toString() {
  return 'SyncUserRequest(email: $email, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$SyncUserRequestCopyWith<$Res> implements $SyncUserRequestCopyWith<$Res> {
  factory _$SyncUserRequestCopyWith(_SyncUserRequest value, $Res Function(_SyncUserRequest) _then) = __$SyncUserRequestCopyWithImpl;
@override @useResult
$Res call({
 String email, String? displayName
});




}
/// @nodoc
class __$SyncUserRequestCopyWithImpl<$Res>
    implements _$SyncUserRequestCopyWith<$Res> {
  __$SyncUserRequestCopyWithImpl(this._self, this._then);

  final _SyncUserRequest _self;
  final $Res Function(_SyncUserRequest) _then;

/// Create a copy of SyncUserRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? displayName = freezed,}) {
  return _then(_SyncUserRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ValidateTokenRequest {

 String get idToken;
/// Create a copy of ValidateTokenRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidateTokenRequestCopyWith<ValidateTokenRequest> get copyWith => _$ValidateTokenRequestCopyWithImpl<ValidateTokenRequest>(this as ValidateTokenRequest, _$identity);

  /// Serializes this ValidateTokenRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidateTokenRequest&&(identical(other.idToken, idToken) || other.idToken == idToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idToken);

@override
String toString() {
  return 'ValidateTokenRequest(idToken: $idToken)';
}


}

/// @nodoc
abstract mixin class $ValidateTokenRequestCopyWith<$Res>  {
  factory $ValidateTokenRequestCopyWith(ValidateTokenRequest value, $Res Function(ValidateTokenRequest) _then) = _$ValidateTokenRequestCopyWithImpl;
@useResult
$Res call({
 String idToken
});




}
/// @nodoc
class _$ValidateTokenRequestCopyWithImpl<$Res>
    implements $ValidateTokenRequestCopyWith<$Res> {
  _$ValidateTokenRequestCopyWithImpl(this._self, this._then);

  final ValidateTokenRequest _self;
  final $Res Function(ValidateTokenRequest) _then;

/// Create a copy of ValidateTokenRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? idToken = null,}) {
  return _then(_self.copyWith(
idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ValidateTokenRequest].
extension ValidateTokenRequestPatterns on ValidateTokenRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ValidateTokenRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ValidateTokenRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ValidateTokenRequest value)  $default,){
final _that = this;
switch (_that) {
case _ValidateTokenRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ValidateTokenRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ValidateTokenRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String idToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ValidateTokenRequest() when $default != null:
return $default(_that.idToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String idToken)  $default,) {final _that = this;
switch (_that) {
case _ValidateTokenRequest():
return $default(_that.idToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String idToken)?  $default,) {final _that = this;
switch (_that) {
case _ValidateTokenRequest() when $default != null:
return $default(_that.idToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ValidateTokenRequest implements ValidateTokenRequest {
  const _ValidateTokenRequest({required this.idToken});
  factory _ValidateTokenRequest.fromJson(Map<String, dynamic> json) => _$ValidateTokenRequestFromJson(json);

@override final  String idToken;

/// Create a copy of ValidateTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ValidateTokenRequestCopyWith<_ValidateTokenRequest> get copyWith => __$ValidateTokenRequestCopyWithImpl<_ValidateTokenRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ValidateTokenRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ValidateTokenRequest&&(identical(other.idToken, idToken) || other.idToken == idToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,idToken);

@override
String toString() {
  return 'ValidateTokenRequest(idToken: $idToken)';
}


}

/// @nodoc
abstract mixin class _$ValidateTokenRequestCopyWith<$Res> implements $ValidateTokenRequestCopyWith<$Res> {
  factory _$ValidateTokenRequestCopyWith(_ValidateTokenRequest value, $Res Function(_ValidateTokenRequest) _then) = __$ValidateTokenRequestCopyWithImpl;
@override @useResult
$Res call({
 String idToken
});




}
/// @nodoc
class __$ValidateTokenRequestCopyWithImpl<$Res>
    implements _$ValidateTokenRequestCopyWith<$Res> {
  __$ValidateTokenRequestCopyWithImpl(this._self, this._then);

  final _ValidateTokenRequest _self;
  final $Res Function(_ValidateTokenRequest) _then;

/// Create a copy of ValidateTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? idToken = null,}) {
  return _then(_ValidateTokenRequest(
idToken: null == idToken ? _self.idToken : idToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UpdateUserProfileRequest {

 String? get firstName; String? get lastName;
/// Create a copy of UpdateUserProfileRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateUserProfileRequestCopyWith<UpdateUserProfileRequest> get copyWith => _$UpdateUserProfileRequestCopyWithImpl<UpdateUserProfileRequest>(this as UpdateUserProfileRequest, _$identity);

  /// Serializes this UpdateUserProfileRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserProfileRequest&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName);

@override
String toString() {
  return 'UpdateUserProfileRequest(firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class $UpdateUserProfileRequestCopyWith<$Res>  {
  factory $UpdateUserProfileRequestCopyWith(UpdateUserProfileRequest value, $Res Function(UpdateUserProfileRequest) _then) = _$UpdateUserProfileRequestCopyWithImpl;
@useResult
$Res call({
 String? firstName, String? lastName
});




}
/// @nodoc
class _$UpdateUserProfileRequestCopyWithImpl<$Res>
    implements $UpdateUserProfileRequestCopyWith<$Res> {
  _$UpdateUserProfileRequestCopyWithImpl(this._self, this._then);

  final UpdateUserProfileRequest _self;
  final $Res Function(UpdateUserProfileRequest) _then;

/// Create a copy of UpdateUserProfileRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = freezed,Object? lastName = freezed,}) {
  return _then(_self.copyWith(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateUserProfileRequest].
extension UpdateUserProfileRequestPatterns on UpdateUserProfileRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateUserProfileRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateUserProfileRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateUserProfileRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateUserProfileRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateUserProfileRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateUserProfileRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? firstName,  String? lastName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateUserProfileRequest() when $default != null:
return $default(_that.firstName,_that.lastName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? firstName,  String? lastName)  $default,) {final _that = this;
switch (_that) {
case _UpdateUserProfileRequest():
return $default(_that.firstName,_that.lastName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? firstName,  String? lastName)?  $default,) {final _that = this;
switch (_that) {
case _UpdateUserProfileRequest() when $default != null:
return $default(_that.firstName,_that.lastName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateUserProfileRequest implements UpdateUserProfileRequest {
  const _UpdateUserProfileRequest({this.firstName, this.lastName});
  factory _UpdateUserProfileRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserProfileRequestFromJson(json);

@override final  String? firstName;
@override final  String? lastName;

/// Create a copy of UpdateUserProfileRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateUserProfileRequestCopyWith<_UpdateUserProfileRequest> get copyWith => __$UpdateUserProfileRequestCopyWithImpl<_UpdateUserProfileRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateUserProfileRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUserProfileRequest&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName);

@override
String toString() {
  return 'UpdateUserProfileRequest(firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class _$UpdateUserProfileRequestCopyWith<$Res> implements $UpdateUserProfileRequestCopyWith<$Res> {
  factory _$UpdateUserProfileRequestCopyWith(_UpdateUserProfileRequest value, $Res Function(_UpdateUserProfileRequest) _then) = __$UpdateUserProfileRequestCopyWithImpl;
@override @useResult
$Res call({
 String? firstName, String? lastName
});




}
/// @nodoc
class __$UpdateUserProfileRequestCopyWithImpl<$Res>
    implements _$UpdateUserProfileRequestCopyWith<$Res> {
  __$UpdateUserProfileRequestCopyWithImpl(this._self, this._then);

  final _UpdateUserProfileRequest _self;
  final $Res Function(_UpdateUserProfileRequest) _then;

/// Create a copy of UpdateUserProfileRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = freezed,Object? lastName = freezed,}) {
  return _then(_UpdateUserProfileRequest(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ChangeOrganizationRequest {

 int get organizationId;
/// Create a copy of ChangeOrganizationRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeOrganizationRequestCopyWith<ChangeOrganizationRequest> get copyWith => _$ChangeOrganizationRequestCopyWithImpl<ChangeOrganizationRequest>(this as ChangeOrganizationRequest, _$identity);

  /// Serializes this ChangeOrganizationRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeOrganizationRequest&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId);

@override
String toString() {
  return 'ChangeOrganizationRequest(organizationId: $organizationId)';
}


}

/// @nodoc
abstract mixin class $ChangeOrganizationRequestCopyWith<$Res>  {
  factory $ChangeOrganizationRequestCopyWith(ChangeOrganizationRequest value, $Res Function(ChangeOrganizationRequest) _then) = _$ChangeOrganizationRequestCopyWithImpl;
@useResult
$Res call({
 int organizationId
});




}
/// @nodoc
class _$ChangeOrganizationRequestCopyWithImpl<$Res>
    implements $ChangeOrganizationRequestCopyWith<$Res> {
  _$ChangeOrganizationRequestCopyWithImpl(this._self, this._then);

  final ChangeOrganizationRequest _self;
  final $Res Function(ChangeOrganizationRequest) _then;

/// Create a copy of ChangeOrganizationRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizationId = null,}) {
  return _then(_self.copyWith(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangeOrganizationRequest].
extension ChangeOrganizationRequestPatterns on ChangeOrganizationRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangeOrganizationRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangeOrganizationRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangeOrganizationRequest value)  $default,){
final _that = this;
switch (_that) {
case _ChangeOrganizationRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangeOrganizationRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ChangeOrganizationRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int organizationId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangeOrganizationRequest() when $default != null:
return $default(_that.organizationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int organizationId)  $default,) {final _that = this;
switch (_that) {
case _ChangeOrganizationRequest():
return $default(_that.organizationId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int organizationId)?  $default,) {final _that = this;
switch (_that) {
case _ChangeOrganizationRequest() when $default != null:
return $default(_that.organizationId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangeOrganizationRequest implements ChangeOrganizationRequest {
  const _ChangeOrganizationRequest({required this.organizationId});
  factory _ChangeOrganizationRequest.fromJson(Map<String, dynamic> json) => _$ChangeOrganizationRequestFromJson(json);

@override final  int organizationId;

/// Create a copy of ChangeOrganizationRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangeOrganizationRequestCopyWith<_ChangeOrganizationRequest> get copyWith => __$ChangeOrganizationRequestCopyWithImpl<_ChangeOrganizationRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangeOrganizationRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeOrganizationRequest&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId);

@override
String toString() {
  return 'ChangeOrganizationRequest(organizationId: $organizationId)';
}


}

/// @nodoc
abstract mixin class _$ChangeOrganizationRequestCopyWith<$Res> implements $ChangeOrganizationRequestCopyWith<$Res> {
  factory _$ChangeOrganizationRequestCopyWith(_ChangeOrganizationRequest value, $Res Function(_ChangeOrganizationRequest) _then) = __$ChangeOrganizationRequestCopyWithImpl;
@override @useResult
$Res call({
 int organizationId
});




}
/// @nodoc
class __$ChangeOrganizationRequestCopyWithImpl<$Res>
    implements _$ChangeOrganizationRequestCopyWith<$Res> {
  __$ChangeOrganizationRequestCopyWithImpl(this._self, this._then);

  final _ChangeOrganizationRequest _self;
  final $Res Function(_ChangeOrganizationRequest) _then;

/// Create a copy of ChangeOrganizationRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizationId = null,}) {
  return _then(_ChangeOrganizationRequest(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
