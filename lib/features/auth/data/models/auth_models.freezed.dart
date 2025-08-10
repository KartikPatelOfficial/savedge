// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileResponse {

 String get id; String get email; String? get firstName; String? get lastName; String? get firebaseUid; int? get organizationId; int get pointsBalance; DateTime? get pointsExpiry; bool? get isActive; DateTime? get createdAt;
/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileResponseCopyWith<UserProfileResponse> get copyWith => _$UserProfileResponseCopyWithImpl<UserProfileResponse>(this as UserProfileResponse, _$identity);

  /// Serializes this UserProfileResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,firebaseUid,organizationId,pointsBalance,pointsExpiry,isActive,createdAt);

@override
String toString() {
  return 'UserProfileResponse(id: $id, email: $email, firstName: $firstName, lastName: $lastName, firebaseUid: $firebaseUid, organizationId: $organizationId, pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserProfileResponseCopyWith<$Res>  {
  factory $UserProfileResponseCopyWith(UserProfileResponse value, $Res Function(UserProfileResponse) _then) = _$UserProfileResponseCopyWithImpl;
@useResult
$Res call({
 String id, String email, String? firstName, String? lastName, String? firebaseUid, int? organizationId, int pointsBalance, DateTime? pointsExpiry, bool? isActive, DateTime? createdAt
});




}
/// @nodoc
class _$UserProfileResponseCopyWithImpl<$Res>
    implements $UserProfileResponseCopyWith<$Res> {
  _$UserProfileResponseCopyWithImpl(this._self, this._then);

  final UserProfileResponse _self;
  final $Res Function(UserProfileResponse) _then;

/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? firebaseUid = freezed,Object? organizationId = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,firebaseUid: freezed == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int?,pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,pointsExpiry: freezed == pointsExpiry ? _self.pointsExpiry : pointsExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileResponse].
extension UserProfileResponsePatterns on UserProfileResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  int? organizationId,  int pointsBalance,  DateTime? pointsExpiry,  bool? isActive,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.organizationId,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  int? organizationId,  int pointsBalance,  DateTime? pointsExpiry,  bool? isActive,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse():
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.organizationId,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  int? organizationId,  int pointsBalance,  DateTime? pointsExpiry,  bool? isActive,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.organizationId,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileResponse implements UserProfileResponse {
  const _UserProfileResponse({required this.id, required this.email, this.firstName, this.lastName, this.firebaseUid, this.organizationId, required this.pointsBalance, this.pointsExpiry, this.isActive, this.createdAt});
  factory _UserProfileResponse.fromJson(Map<String, dynamic> json) => _$UserProfileResponseFromJson(json);

@override final  String id;
@override final  String email;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? firebaseUid;
@override final  int? organizationId;
@override final  int pointsBalance;
@override final  DateTime? pointsExpiry;
@override final  bool? isActive;
@override final  DateTime? createdAt;

/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileResponseCopyWith<_UserProfileResponse> get copyWith => __$UserProfileResponseCopyWithImpl<_UserProfileResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,firebaseUid,organizationId,pointsBalance,pointsExpiry,isActive,createdAt);

@override
String toString() {
  return 'UserProfileResponse(id: $id, email: $email, firstName: $firstName, lastName: $lastName, firebaseUid: $firebaseUid, organizationId: $organizationId, pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry, isActive: $isActive, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserProfileResponseCopyWith<$Res> implements $UserProfileResponseCopyWith<$Res> {
  factory _$UserProfileResponseCopyWith(_UserProfileResponse value, $Res Function(_UserProfileResponse) _then) = __$UserProfileResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String? firstName, String? lastName, String? firebaseUid, int? organizationId, int pointsBalance, DateTime? pointsExpiry, bool? isActive, DateTime? createdAt
});




}
/// @nodoc
class __$UserProfileResponseCopyWithImpl<$Res>
    implements _$UserProfileResponseCopyWith<$Res> {
  __$UserProfileResponseCopyWithImpl(this._self, this._then);

  final _UserProfileResponse _self;
  final $Res Function(_UserProfileResponse) _then;

/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? firebaseUid = freezed,Object? organizationId = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = freezed,Object? createdAt = freezed,}) {
  return _then(_UserProfileResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,firebaseUid: freezed == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int?,pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,pointsExpiry: freezed == pointsExpiry ? _self.pointsExpiry : pointsExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
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
mixin _$UserProfileResponse2 {

 String get id; String get email; String? get firstName; String? get lastName; String? get firebaseUid; int? get organizationId; String? get organizationName; int get pointsBalance; DateTime? get pointsExpiry; bool get isActive; DateTime get createdAt; List<String> get roles; bool get isEmployee; String? get employeeCode; String? get department; String? get position; DateTime? get joinDate;
/// Create a copy of UserProfileResponse2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileResponse2CopyWith<UserProfileResponse2> get copyWith => _$UserProfileResponse2CopyWithImpl<UserProfileResponse2>(this as UserProfileResponse2, _$identity);

  /// Serializes this UserProfileResponse2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileResponse2&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.roles, roles)&&(identical(other.isEmployee, isEmployee) || other.isEmployee == isEmployee)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.joinDate, joinDate) || other.joinDate == joinDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,firebaseUid,organizationId,organizationName,pointsBalance,pointsExpiry,isActive,createdAt,const DeepCollectionEquality().hash(roles),isEmployee,employeeCode,department,position,joinDate);

@override
String toString() {
  return 'UserProfileResponse2(id: $id, email: $email, firstName: $firstName, lastName: $lastName, firebaseUid: $firebaseUid, organizationId: $organizationId, organizationName: $organizationName, pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry, isActive: $isActive, createdAt: $createdAt, roles: $roles, isEmployee: $isEmployee, employeeCode: $employeeCode, department: $department, position: $position, joinDate: $joinDate)';
}


}

/// @nodoc
abstract mixin class $UserProfileResponse2CopyWith<$Res>  {
  factory $UserProfileResponse2CopyWith(UserProfileResponse2 value, $Res Function(UserProfileResponse2) _then) = _$UserProfileResponse2CopyWithImpl;
@useResult
$Res call({
 String id, String email, String? firstName, String? lastName, String? firebaseUid, int? organizationId, String? organizationName, int pointsBalance, DateTime? pointsExpiry, bool isActive, DateTime createdAt, List<String> roles, bool isEmployee, String? employeeCode, String? department, String? position, DateTime? joinDate
});




}
/// @nodoc
class _$UserProfileResponse2CopyWithImpl<$Res>
    implements $UserProfileResponse2CopyWith<$Res> {
  _$UserProfileResponse2CopyWithImpl(this._self, this._then);

  final UserProfileResponse2 _self;
  final $Res Function(UserProfileResponse2) _then;

/// Create a copy of UserProfileResponse2
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? firebaseUid = freezed,Object? organizationId = freezed,Object? organizationName = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = null,Object? createdAt = null,Object? roles = null,Object? isEmployee = null,Object? employeeCode = freezed,Object? department = freezed,Object? position = freezed,Object? joinDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,firebaseUid: freezed == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int?,organizationName: freezed == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String?,pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,pointsExpiry: freezed == pointsExpiry ? _self.pointsExpiry : pointsExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,isEmployee: null == isEmployee ? _self.isEmployee : isEmployee // ignore: cast_nullable_to_non_nullable
as bool,employeeCode: freezed == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,joinDate: freezed == joinDate ? _self.joinDate : joinDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileResponse2].
extension UserProfileResponse2Patterns on UserProfileResponse2 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileResponse2 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileResponse2() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileResponse2 value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileResponse2():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileResponse2 value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileResponse2() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime createdAt,  List<String> roles,  bool isEmployee,  String? employeeCode,  String? department,  String? position,  DateTime? joinDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileResponse2() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.roles,_that.isEmployee,_that.employeeCode,_that.department,_that.position,_that.joinDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime createdAt,  List<String> roles,  bool isEmployee,  String? employeeCode,  String? department,  String? position,  DateTime? joinDate)  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse2():
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.roles,_that.isEmployee,_that.employeeCode,_that.department,_that.position,_that.joinDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime createdAt,  List<String> roles,  bool isEmployee,  String? employeeCode,  String? department,  String? position,  DateTime? joinDate)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse2() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.roles,_that.isEmployee,_that.employeeCode,_that.department,_that.position,_that.joinDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileResponse2 implements UserProfileResponse2 {
  const _UserProfileResponse2({required this.id, required this.email, this.firstName, this.lastName, this.firebaseUid, this.organizationId, this.organizationName, required this.pointsBalance, this.pointsExpiry, required this.isActive, required this.createdAt, required final  List<String> roles, required this.isEmployee, this.employeeCode, this.department, this.position, this.joinDate}): _roles = roles;
  factory _UserProfileResponse2.fromJson(Map<String, dynamic> json) => _$UserProfileResponse2FromJson(json);

@override final  String id;
@override final  String email;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? firebaseUid;
@override final  int? organizationId;
@override final  String? organizationName;
@override final  int pointsBalance;
@override final  DateTime? pointsExpiry;
@override final  bool isActive;
@override final  DateTime createdAt;
 final  List<String> _roles;
@override List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

@override final  bool isEmployee;
@override final  String? employeeCode;
@override final  String? department;
@override final  String? position;
@override final  DateTime? joinDate;

/// Create a copy of UserProfileResponse2
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileResponse2CopyWith<_UserProfileResponse2> get copyWith => __$UserProfileResponse2CopyWithImpl<_UserProfileResponse2>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileResponse2ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileResponse2&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._roles, _roles)&&(identical(other.isEmployee, isEmployee) || other.isEmployee == isEmployee)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.joinDate, joinDate) || other.joinDate == joinDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,firebaseUid,organizationId,organizationName,pointsBalance,pointsExpiry,isActive,createdAt,const DeepCollectionEquality().hash(_roles),isEmployee,employeeCode,department,position,joinDate);

@override
String toString() {
  return 'UserProfileResponse2(id: $id, email: $email, firstName: $firstName, lastName: $lastName, firebaseUid: $firebaseUid, organizationId: $organizationId, organizationName: $organizationName, pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry, isActive: $isActive, createdAt: $createdAt, roles: $roles, isEmployee: $isEmployee, employeeCode: $employeeCode, department: $department, position: $position, joinDate: $joinDate)';
}


}

/// @nodoc
abstract mixin class _$UserProfileResponse2CopyWith<$Res> implements $UserProfileResponse2CopyWith<$Res> {
  factory _$UserProfileResponse2CopyWith(_UserProfileResponse2 value, $Res Function(_UserProfileResponse2) _then) = __$UserProfileResponse2CopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String? firstName, String? lastName, String? firebaseUid, int? organizationId, String? organizationName, int pointsBalance, DateTime? pointsExpiry, bool isActive, DateTime createdAt, List<String> roles, bool isEmployee, String? employeeCode, String? department, String? position, DateTime? joinDate
});




}
/// @nodoc
class __$UserProfileResponse2CopyWithImpl<$Res>
    implements _$UserProfileResponse2CopyWith<$Res> {
  __$UserProfileResponse2CopyWithImpl(this._self, this._then);

  final _UserProfileResponse2 _self;
  final $Res Function(_UserProfileResponse2) _then;

/// Create a copy of UserProfileResponse2
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? firebaseUid = freezed,Object? organizationId = freezed,Object? organizationName = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = null,Object? createdAt = null,Object? roles = null,Object? isEmployee = null,Object? employeeCode = freezed,Object? department = freezed,Object? position = freezed,Object? joinDate = freezed,}) {
  return _then(_UserProfileResponse2(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,firebaseUid: freezed == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int?,organizationName: freezed == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String?,pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,pointsExpiry: freezed == pointsExpiry ? _self.pointsExpiry : pointsExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,isEmployee: null == isEmployee ? _self.isEmployee : isEmployee // ignore: cast_nullable_to_non_nullable
as bool,employeeCode: freezed == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,joinDate: freezed == joinDate ? _self.joinDate : joinDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$UpdateUserProfileRequest {

 String get email; String? get firstName; String? get lastName;
/// Create a copy of UpdateUserProfileRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateUserProfileRequestCopyWith<UpdateUserProfileRequest> get copyWith => _$UpdateUserProfileRequestCopyWithImpl<UpdateUserProfileRequest>(this as UpdateUserProfileRequest, _$identity);

  /// Serializes this UpdateUserProfileRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserProfileRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,firstName,lastName);

@override
String toString() {
  return 'UpdateUserProfileRequest(email: $email, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class $UpdateUserProfileRequestCopyWith<$Res>  {
  factory $UpdateUserProfileRequestCopyWith(UpdateUserProfileRequest value, $Res Function(UpdateUserProfileRequest) _then) = _$UpdateUserProfileRequestCopyWithImpl;
@useResult
$Res call({
 String email, String? firstName, String? lastName
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
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? firstName = freezed,Object? lastName = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String? firstName,  String? lastName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateUserProfileRequest() when $default != null:
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
case _UpdateUserProfileRequest():
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
case _UpdateUserProfileRequest() when $default != null:
return $default(_that.email,_that.firstName,_that.lastName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateUserProfileRequest implements UpdateUserProfileRequest {
  const _UpdateUserProfileRequest({required this.email, this.firstName, this.lastName});
  factory _UpdateUserProfileRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserProfileRequestFromJson(json);

@override final  String email;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUserProfileRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,firstName,lastName);

@override
String toString() {
  return 'UpdateUserProfileRequest(email: $email, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class _$UpdateUserProfileRequestCopyWith<$Res> implements $UpdateUserProfileRequestCopyWith<$Res> {
  factory _$UpdateUserProfileRequestCopyWith(_UpdateUserProfileRequest value, $Res Function(_UpdateUserProfileRequest) _then) = __$UpdateUserProfileRequestCopyWithImpl;
@override @useResult
$Res call({
 String email, String? firstName, String? lastName
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
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? firstName = freezed,Object? lastName = freezed,}) {
  return _then(_UpdateUserProfileRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CheckUserExistsRequest {

 String get firebaseUid;
/// Create a copy of CheckUserExistsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckUserExistsRequestCopyWith<CheckUserExistsRequest> get copyWith => _$CheckUserExistsRequestCopyWithImpl<CheckUserExistsRequest>(this as CheckUserExistsRequest, _$identity);

  /// Serializes this CheckUserExistsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckUserExistsRequest&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firebaseUid);

@override
String toString() {
  return 'CheckUserExistsRequest(firebaseUid: $firebaseUid)';
}


}

/// @nodoc
abstract mixin class $CheckUserExistsRequestCopyWith<$Res>  {
  factory $CheckUserExistsRequestCopyWith(CheckUserExistsRequest value, $Res Function(CheckUserExistsRequest) _then) = _$CheckUserExistsRequestCopyWithImpl;
@useResult
$Res call({
 String firebaseUid
});




}
/// @nodoc
class _$CheckUserExistsRequestCopyWithImpl<$Res>
    implements $CheckUserExistsRequestCopyWith<$Res> {
  _$CheckUserExistsRequestCopyWithImpl(this._self, this._then);

  final CheckUserExistsRequest _self;
  final $Res Function(CheckUserExistsRequest) _then;

/// Create a copy of CheckUserExistsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firebaseUid = null,}) {
  return _then(_self.copyWith(
firebaseUid: null == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckUserExistsRequest].
extension CheckUserExistsRequestPatterns on CheckUserExistsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckUserExistsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckUserExistsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckUserExistsRequest value)  $default,){
final _that = this;
switch (_that) {
case _CheckUserExistsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckUserExistsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CheckUserExistsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firebaseUid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckUserExistsRequest() when $default != null:
return $default(_that.firebaseUid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firebaseUid)  $default,) {final _that = this;
switch (_that) {
case _CheckUserExistsRequest():
return $default(_that.firebaseUid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firebaseUid)?  $default,) {final _that = this;
switch (_that) {
case _CheckUserExistsRequest() when $default != null:
return $default(_that.firebaseUid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckUserExistsRequest implements CheckUserExistsRequest {
  const _CheckUserExistsRequest({required this.firebaseUid});
  factory _CheckUserExistsRequest.fromJson(Map<String, dynamic> json) => _$CheckUserExistsRequestFromJson(json);

@override final  String firebaseUid;

/// Create a copy of CheckUserExistsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckUserExistsRequestCopyWith<_CheckUserExistsRequest> get copyWith => __$CheckUserExistsRequestCopyWithImpl<_CheckUserExistsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckUserExistsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckUserExistsRequest&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firebaseUid);

@override
String toString() {
  return 'CheckUserExistsRequest(firebaseUid: $firebaseUid)';
}


}

/// @nodoc
abstract mixin class _$CheckUserExistsRequestCopyWith<$Res> implements $CheckUserExistsRequestCopyWith<$Res> {
  factory _$CheckUserExistsRequestCopyWith(_CheckUserExistsRequest value, $Res Function(_CheckUserExistsRequest) _then) = __$CheckUserExistsRequestCopyWithImpl;
@override @useResult
$Res call({
 String firebaseUid
});




}
/// @nodoc
class __$CheckUserExistsRequestCopyWithImpl<$Res>
    implements _$CheckUserExistsRequestCopyWith<$Res> {
  __$CheckUserExistsRequestCopyWithImpl(this._self, this._then);

  final _CheckUserExistsRequest _self;
  final $Res Function(_CheckUserExistsRequest) _then;

/// Create a copy of CheckUserExistsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firebaseUid = null,}) {
  return _then(_CheckUserExistsRequest(
firebaseUid: null == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CheckUserExistsResponse {

 bool get exists; String get firebaseUid; UserProfileResponse2? get userProfile;
/// Create a copy of CheckUserExistsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckUserExistsResponseCopyWith<CheckUserExistsResponse> get copyWith => _$CheckUserExistsResponseCopyWithImpl<CheckUserExistsResponse>(this as CheckUserExistsResponse, _$identity);

  /// Serializes this CheckUserExistsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckUserExistsResponse&&(identical(other.exists, exists) || other.exists == exists)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exists,firebaseUid,userProfile);

@override
String toString() {
  return 'CheckUserExistsResponse(exists: $exists, firebaseUid: $firebaseUid, userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class $CheckUserExistsResponseCopyWith<$Res>  {
  factory $CheckUserExistsResponseCopyWith(CheckUserExistsResponse value, $Res Function(CheckUserExistsResponse) _then) = _$CheckUserExistsResponseCopyWithImpl;
@useResult
$Res call({
 bool exists, String firebaseUid, UserProfileResponse2? userProfile
});


$UserProfileResponse2CopyWith<$Res>? get userProfile;

}
/// @nodoc
class _$CheckUserExistsResponseCopyWithImpl<$Res>
    implements $CheckUserExistsResponseCopyWith<$Res> {
  _$CheckUserExistsResponseCopyWithImpl(this._self, this._then);

  final CheckUserExistsResponse _self;
  final $Res Function(CheckUserExistsResponse) _then;

/// Create a copy of CheckUserExistsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exists = null,Object? firebaseUid = null,Object? userProfile = freezed,}) {
  return _then(_self.copyWith(
exists: null == exists ? _self.exists : exists // ignore: cast_nullable_to_non_nullable
as bool,firebaseUid: null == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String,userProfile: freezed == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfileResponse2?,
  ));
}
/// Create a copy of CheckUserExistsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileResponse2CopyWith<$Res>? get userProfile {
    if (_self.userProfile == null) {
    return null;
  }

  return $UserProfileResponse2CopyWith<$Res>(_self.userProfile!, (value) {
    return _then(_self.copyWith(userProfile: value));
  });
}
}


/// Adds pattern-matching-related methods to [CheckUserExistsResponse].
extension CheckUserExistsResponsePatterns on CheckUserExistsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckUserExistsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckUserExistsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckUserExistsResponse value)  $default,){
final _that = this;
switch (_that) {
case _CheckUserExistsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckUserExistsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CheckUserExistsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool exists,  String firebaseUid,  UserProfileResponse2? userProfile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckUserExistsResponse() when $default != null:
return $default(_that.exists,_that.firebaseUid,_that.userProfile);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool exists,  String firebaseUid,  UserProfileResponse2? userProfile)  $default,) {final _that = this;
switch (_that) {
case _CheckUserExistsResponse():
return $default(_that.exists,_that.firebaseUid,_that.userProfile);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool exists,  String firebaseUid,  UserProfileResponse2? userProfile)?  $default,) {final _that = this;
switch (_that) {
case _CheckUserExistsResponse() when $default != null:
return $default(_that.exists,_that.firebaseUid,_that.userProfile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckUserExistsResponse implements CheckUserExistsResponse {
  const _CheckUserExistsResponse({required this.exists, required this.firebaseUid, this.userProfile});
  factory _CheckUserExistsResponse.fromJson(Map<String, dynamic> json) => _$CheckUserExistsResponseFromJson(json);

@override final  bool exists;
@override final  String firebaseUid;
@override final  UserProfileResponse2? userProfile;

/// Create a copy of CheckUserExistsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckUserExistsResponseCopyWith<_CheckUserExistsResponse> get copyWith => __$CheckUserExistsResponseCopyWithImpl<_CheckUserExistsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckUserExistsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckUserExistsResponse&&(identical(other.exists, exists) || other.exists == exists)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exists,firebaseUid,userProfile);

@override
String toString() {
  return 'CheckUserExistsResponse(exists: $exists, firebaseUid: $firebaseUid, userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class _$CheckUserExistsResponseCopyWith<$Res> implements $CheckUserExistsResponseCopyWith<$Res> {
  factory _$CheckUserExistsResponseCopyWith(_CheckUserExistsResponse value, $Res Function(_CheckUserExistsResponse) _then) = __$CheckUserExistsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool exists, String firebaseUid, UserProfileResponse2? userProfile
});


@override $UserProfileResponse2CopyWith<$Res>? get userProfile;

}
/// @nodoc
class __$CheckUserExistsResponseCopyWithImpl<$Res>
    implements _$CheckUserExistsResponseCopyWith<$Res> {
  __$CheckUserExistsResponseCopyWithImpl(this._self, this._then);

  final _CheckUserExistsResponse _self;
  final $Res Function(_CheckUserExistsResponse) _then;

/// Create a copy of CheckUserExistsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exists = null,Object? firebaseUid = null,Object? userProfile = freezed,}) {
  return _then(_CheckUserExistsResponse(
exists: null == exists ? _self.exists : exists // ignore: cast_nullable_to_non_nullable
as bool,firebaseUid: null == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String,userProfile: freezed == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfileResponse2?,
  ));
}

/// Create a copy of CheckUserExistsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileResponse2CopyWith<$Res>? get userProfile {
    if (_self.userProfile == null) {
    return null;
  }

  return $UserProfileResponse2CopyWith<$Res>(_self.userProfile!, (value) {
    return _then(_self.copyWith(userProfile: value));
  });
}
}


/// @nodoc
mixin _$CheckEmployeeByPhoneRequest {

 String get phoneNumber;
/// Create a copy of CheckEmployeeByPhoneRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckEmployeeByPhoneRequestCopyWith<CheckEmployeeByPhoneRequest> get copyWith => _$CheckEmployeeByPhoneRequestCopyWithImpl<CheckEmployeeByPhoneRequest>(this as CheckEmployeeByPhoneRequest, _$identity);

  /// Serializes this CheckEmployeeByPhoneRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckEmployeeByPhoneRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber);

@override
String toString() {
  return 'CheckEmployeeByPhoneRequest(phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $CheckEmployeeByPhoneRequestCopyWith<$Res>  {
  factory $CheckEmployeeByPhoneRequestCopyWith(CheckEmployeeByPhoneRequest value, $Res Function(CheckEmployeeByPhoneRequest) _then) = _$CheckEmployeeByPhoneRequestCopyWithImpl;
@useResult
$Res call({
 String phoneNumber
});




}
/// @nodoc
class _$CheckEmployeeByPhoneRequestCopyWithImpl<$Res>
    implements $CheckEmployeeByPhoneRequestCopyWith<$Res> {
  _$CheckEmployeeByPhoneRequestCopyWithImpl(this._self, this._then);

  final CheckEmployeeByPhoneRequest _self;
  final $Res Function(CheckEmployeeByPhoneRequest) _then;

/// Create a copy of CheckEmployeeByPhoneRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckEmployeeByPhoneRequest].
extension CheckEmployeeByPhoneRequestPatterns on CheckEmployeeByPhoneRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckEmployeeByPhoneRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckEmployeeByPhoneRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckEmployeeByPhoneRequest value)  $default,){
final _that = this;
switch (_that) {
case _CheckEmployeeByPhoneRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckEmployeeByPhoneRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CheckEmployeeByPhoneRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckEmployeeByPhoneRequest() when $default != null:
return $default(_that.phoneNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber)  $default,) {final _that = this;
switch (_that) {
case _CheckEmployeeByPhoneRequest():
return $default(_that.phoneNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber)?  $default,) {final _that = this;
switch (_that) {
case _CheckEmployeeByPhoneRequest() when $default != null:
return $default(_that.phoneNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckEmployeeByPhoneRequest implements CheckEmployeeByPhoneRequest {
  const _CheckEmployeeByPhoneRequest({required this.phoneNumber});
  factory _CheckEmployeeByPhoneRequest.fromJson(Map<String, dynamic> json) => _$CheckEmployeeByPhoneRequestFromJson(json);

@override final  String phoneNumber;

/// Create a copy of CheckEmployeeByPhoneRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckEmployeeByPhoneRequestCopyWith<_CheckEmployeeByPhoneRequest> get copyWith => __$CheckEmployeeByPhoneRequestCopyWithImpl<_CheckEmployeeByPhoneRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckEmployeeByPhoneRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckEmployeeByPhoneRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber);

@override
String toString() {
  return 'CheckEmployeeByPhoneRequest(phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$CheckEmployeeByPhoneRequestCopyWith<$Res> implements $CheckEmployeeByPhoneRequestCopyWith<$Res> {
  factory _$CheckEmployeeByPhoneRequestCopyWith(_CheckEmployeeByPhoneRequest value, $Res Function(_CheckEmployeeByPhoneRequest) _then) = __$CheckEmployeeByPhoneRequestCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber
});




}
/// @nodoc
class __$CheckEmployeeByPhoneRequestCopyWithImpl<$Res>
    implements _$CheckEmployeeByPhoneRequestCopyWith<$Res> {
  __$CheckEmployeeByPhoneRequestCopyWithImpl(this._self, this._then);

  final _CheckEmployeeByPhoneRequest _self;
  final $Res Function(_CheckEmployeeByPhoneRequest) _then;

/// Create a copy of CheckEmployeeByPhoneRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,}) {
  return _then(_CheckEmployeeByPhoneRequest(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EmployeeInfoResponse {

 int get id; String get email; String get employeeCode; String get department; String get position; String get phoneNumber; DateTime get joinDate; bool get isRegistered; int get organizationId; String get organizationName; bool get isActive;
/// Create a copy of EmployeeInfoResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeInfoResponseCopyWith<EmployeeInfoResponse> get copyWith => _$EmployeeInfoResponseCopyWithImpl<EmployeeInfoResponse>(this as EmployeeInfoResponse, _$identity);

  /// Serializes this EmployeeInfoResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeInfoResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.joinDate, joinDate) || other.joinDate == joinDate)&&(identical(other.isRegistered, isRegistered) || other.isRegistered == isRegistered)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,employeeCode,department,position,phoneNumber,joinDate,isRegistered,organizationId,organizationName,isActive);

@override
String toString() {
  return 'EmployeeInfoResponse(id: $id, email: $email, employeeCode: $employeeCode, department: $department, position: $position, phoneNumber: $phoneNumber, joinDate: $joinDate, isRegistered: $isRegistered, organizationId: $organizationId, organizationName: $organizationName, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $EmployeeInfoResponseCopyWith<$Res>  {
  factory $EmployeeInfoResponseCopyWith(EmployeeInfoResponse value, $Res Function(EmployeeInfoResponse) _then) = _$EmployeeInfoResponseCopyWithImpl;
@useResult
$Res call({
 int id, String email, String employeeCode, String department, String position, String phoneNumber, DateTime joinDate, bool isRegistered, int organizationId, String organizationName, bool isActive
});




}
/// @nodoc
class _$EmployeeInfoResponseCopyWithImpl<$Res>
    implements $EmployeeInfoResponseCopyWith<$Res> {
  _$EmployeeInfoResponseCopyWithImpl(this._self, this._then);

  final EmployeeInfoResponse _self;
  final $Res Function(EmployeeInfoResponse) _then;

/// Create a copy of EmployeeInfoResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? employeeCode = null,Object? department = null,Object? position = null,Object? phoneNumber = null,Object? joinDate = null,Object? isRegistered = null,Object? organizationId = null,Object? organizationName = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,joinDate: null == joinDate ? _self.joinDate : joinDate // ignore: cast_nullable_to_non_nullable
as DateTime,isRegistered: null == isRegistered ? _self.isRegistered : isRegistered // ignore: cast_nullable_to_non_nullable
as bool,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int,organizationName: null == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeInfoResponse].
extension EmployeeInfoResponsePatterns on EmployeeInfoResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeInfoResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeInfoResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeInfoResponse value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeInfoResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeInfoResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeInfoResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String email,  String employeeCode,  String department,  String position,  String phoneNumber,  DateTime joinDate,  bool isRegistered,  int organizationId,  String organizationName,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeInfoResponse() when $default != null:
return $default(_that.id,_that.email,_that.employeeCode,_that.department,_that.position,_that.phoneNumber,_that.joinDate,_that.isRegistered,_that.organizationId,_that.organizationName,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String email,  String employeeCode,  String department,  String position,  String phoneNumber,  DateTime joinDate,  bool isRegistered,  int organizationId,  String organizationName,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _EmployeeInfoResponse():
return $default(_that.id,_that.email,_that.employeeCode,_that.department,_that.position,_that.phoneNumber,_that.joinDate,_that.isRegistered,_that.organizationId,_that.organizationName,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String email,  String employeeCode,  String department,  String position,  String phoneNumber,  DateTime joinDate,  bool isRegistered,  int organizationId,  String organizationName,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeInfoResponse() when $default != null:
return $default(_that.id,_that.email,_that.employeeCode,_that.department,_that.position,_that.phoneNumber,_that.joinDate,_that.isRegistered,_that.organizationId,_that.organizationName,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeInfoResponse implements EmployeeInfoResponse {
  const _EmployeeInfoResponse({required this.id, required this.email, required this.employeeCode, required this.department, required this.position, required this.phoneNumber, required this.joinDate, required this.isRegistered, required this.organizationId, required this.organizationName, required this.isActive});
  factory _EmployeeInfoResponse.fromJson(Map<String, dynamic> json) => _$EmployeeInfoResponseFromJson(json);

@override final  int id;
@override final  String email;
@override final  String employeeCode;
@override final  String department;
@override final  String position;
@override final  String phoneNumber;
@override final  DateTime joinDate;
@override final  bool isRegistered;
@override final  int organizationId;
@override final  String organizationName;
@override final  bool isActive;

/// Create a copy of EmployeeInfoResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeInfoResponseCopyWith<_EmployeeInfoResponse> get copyWith => __$EmployeeInfoResponseCopyWithImpl<_EmployeeInfoResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeInfoResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeInfoResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.joinDate, joinDate) || other.joinDate == joinDate)&&(identical(other.isRegistered, isRegistered) || other.isRegistered == isRegistered)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,employeeCode,department,position,phoneNumber,joinDate,isRegistered,organizationId,organizationName,isActive);

@override
String toString() {
  return 'EmployeeInfoResponse(id: $id, email: $email, employeeCode: $employeeCode, department: $department, position: $position, phoneNumber: $phoneNumber, joinDate: $joinDate, isRegistered: $isRegistered, organizationId: $organizationId, organizationName: $organizationName, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$EmployeeInfoResponseCopyWith<$Res> implements $EmployeeInfoResponseCopyWith<$Res> {
  factory _$EmployeeInfoResponseCopyWith(_EmployeeInfoResponse value, $Res Function(_EmployeeInfoResponse) _then) = __$EmployeeInfoResponseCopyWithImpl;
@override @useResult
$Res call({
 int id, String email, String employeeCode, String department, String position, String phoneNumber, DateTime joinDate, bool isRegistered, int organizationId, String organizationName, bool isActive
});




}
/// @nodoc
class __$EmployeeInfoResponseCopyWithImpl<$Res>
    implements _$EmployeeInfoResponseCopyWith<$Res> {
  __$EmployeeInfoResponseCopyWithImpl(this._self, this._then);

  final _EmployeeInfoResponse _self;
  final $Res Function(_EmployeeInfoResponse) _then;

/// Create a copy of EmployeeInfoResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? employeeCode = null,Object? department = null,Object? position = null,Object? phoneNumber = null,Object? joinDate = null,Object? isRegistered = null,Object? organizationId = null,Object? organizationName = null,Object? isActive = null,}) {
  return _then(_EmployeeInfoResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,joinDate: null == joinDate ? _self.joinDate : joinDate // ignore: cast_nullable_to_non_nullable
as DateTime,isRegistered: null == isRegistered ? _self.isRegistered : isRegistered // ignore: cast_nullable_to_non_nullable
as bool,organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int,organizationName: null == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$RegisterEmployeeByPhoneRequest {

 String get phoneNumber; String get email; String get firstName; String get lastName;
/// Create a copy of RegisterEmployeeByPhoneRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterEmployeeByPhoneRequestCopyWith<RegisterEmployeeByPhoneRequest> get copyWith => _$RegisterEmployeeByPhoneRequestCopyWithImpl<RegisterEmployeeByPhoneRequest>(this as RegisterEmployeeByPhoneRequest, _$identity);

  /// Serializes this RegisterEmployeeByPhoneRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterEmployeeByPhoneRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,email,firstName,lastName);

@override
String toString() {
  return 'RegisterEmployeeByPhoneRequest(phoneNumber: $phoneNumber, email: $email, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class $RegisterEmployeeByPhoneRequestCopyWith<$Res>  {
  factory $RegisterEmployeeByPhoneRequestCopyWith(RegisterEmployeeByPhoneRequest value, $Res Function(RegisterEmployeeByPhoneRequest) _then) = _$RegisterEmployeeByPhoneRequestCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String email, String firstName, String lastName
});




}
/// @nodoc
class _$RegisterEmployeeByPhoneRequestCopyWithImpl<$Res>
    implements $RegisterEmployeeByPhoneRequestCopyWith<$Res> {
  _$RegisterEmployeeByPhoneRequestCopyWithImpl(this._self, this._then);

  final RegisterEmployeeByPhoneRequest _self;
  final $Res Function(RegisterEmployeeByPhoneRequest) _then;

/// Create a copy of RegisterEmployeeByPhoneRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? email = null,Object? firstName = null,Object? lastName = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterEmployeeByPhoneRequest].
extension RegisterEmployeeByPhoneRequestPatterns on RegisterEmployeeByPhoneRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterEmployeeByPhoneRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterEmployeeByPhoneRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterEmployeeByPhoneRequest value)  $default,){
final _that = this;
switch (_that) {
case _RegisterEmployeeByPhoneRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterEmployeeByPhoneRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterEmployeeByPhoneRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber,  String email,  String firstName,  String lastName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterEmployeeByPhoneRequest() when $default != null:
return $default(_that.phoneNumber,_that.email,_that.firstName,_that.lastName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber,  String email,  String firstName,  String lastName)  $default,) {final _that = this;
switch (_that) {
case _RegisterEmployeeByPhoneRequest():
return $default(_that.phoneNumber,_that.email,_that.firstName,_that.lastName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber,  String email,  String firstName,  String lastName)?  $default,) {final _that = this;
switch (_that) {
case _RegisterEmployeeByPhoneRequest() when $default != null:
return $default(_that.phoneNumber,_that.email,_that.firstName,_that.lastName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterEmployeeByPhoneRequest implements RegisterEmployeeByPhoneRequest {
  const _RegisterEmployeeByPhoneRequest({required this.phoneNumber, required this.email, required this.firstName, required this.lastName});
  factory _RegisterEmployeeByPhoneRequest.fromJson(Map<String, dynamic> json) => _$RegisterEmployeeByPhoneRequestFromJson(json);

@override final  String phoneNumber;
@override final  String email;
@override final  String firstName;
@override final  String lastName;

/// Create a copy of RegisterEmployeeByPhoneRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterEmployeeByPhoneRequestCopyWith<_RegisterEmployeeByPhoneRequest> get copyWith => __$RegisterEmployeeByPhoneRequestCopyWithImpl<_RegisterEmployeeByPhoneRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterEmployeeByPhoneRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterEmployeeByPhoneRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,email,firstName,lastName);

@override
String toString() {
  return 'RegisterEmployeeByPhoneRequest(phoneNumber: $phoneNumber, email: $email, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class _$RegisterEmployeeByPhoneRequestCopyWith<$Res> implements $RegisterEmployeeByPhoneRequestCopyWith<$Res> {
  factory _$RegisterEmployeeByPhoneRequestCopyWith(_RegisterEmployeeByPhoneRequest value, $Res Function(_RegisterEmployeeByPhoneRequest) _then) = __$RegisterEmployeeByPhoneRequestCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String email, String firstName, String lastName
});




}
/// @nodoc
class __$RegisterEmployeeByPhoneRequestCopyWithImpl<$Res>
    implements _$RegisterEmployeeByPhoneRequestCopyWith<$Res> {
  __$RegisterEmployeeByPhoneRequestCopyWithImpl(this._self, this._then);

  final _RegisterEmployeeByPhoneRequest _self;
  final $Res Function(_RegisterEmployeeByPhoneRequest) _then;

/// Create a copy of RegisterEmployeeByPhoneRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? email = null,Object? firstName = null,Object? lastName = null,}) {
  return _then(_RegisterEmployeeByPhoneRequest(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RegisterUserByPhoneRequest {

 String get phoneNumber; String get email; String get firstName; String get lastName;
/// Create a copy of RegisterUserByPhoneRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterUserByPhoneRequestCopyWith<RegisterUserByPhoneRequest> get copyWith => _$RegisterUserByPhoneRequestCopyWithImpl<RegisterUserByPhoneRequest>(this as RegisterUserByPhoneRequest, _$identity);

  /// Serializes this RegisterUserByPhoneRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterUserByPhoneRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,email,firstName,lastName);

@override
String toString() {
  return 'RegisterUserByPhoneRequest(phoneNumber: $phoneNumber, email: $email, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class $RegisterUserByPhoneRequestCopyWith<$Res>  {
  factory $RegisterUserByPhoneRequestCopyWith(RegisterUserByPhoneRequest value, $Res Function(RegisterUserByPhoneRequest) _then) = _$RegisterUserByPhoneRequestCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String email, String firstName, String lastName
});




}
/// @nodoc
class _$RegisterUserByPhoneRequestCopyWithImpl<$Res>
    implements $RegisterUserByPhoneRequestCopyWith<$Res> {
  _$RegisterUserByPhoneRequestCopyWithImpl(this._self, this._then);

  final RegisterUserByPhoneRequest _self;
  final $Res Function(RegisterUserByPhoneRequest) _then;

/// Create a copy of RegisterUserByPhoneRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? email = null,Object? firstName = null,Object? lastName = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterUserByPhoneRequest].
extension RegisterUserByPhoneRequestPatterns on RegisterUserByPhoneRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterUserByPhoneRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterUserByPhoneRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterUserByPhoneRequest value)  $default,){
final _that = this;
switch (_that) {
case _RegisterUserByPhoneRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterUserByPhoneRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterUserByPhoneRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber,  String email,  String firstName,  String lastName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterUserByPhoneRequest() when $default != null:
return $default(_that.phoneNumber,_that.email,_that.firstName,_that.lastName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber,  String email,  String firstName,  String lastName)  $default,) {final _that = this;
switch (_that) {
case _RegisterUserByPhoneRequest():
return $default(_that.phoneNumber,_that.email,_that.firstName,_that.lastName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber,  String email,  String firstName,  String lastName)?  $default,) {final _that = this;
switch (_that) {
case _RegisterUserByPhoneRequest() when $default != null:
return $default(_that.phoneNumber,_that.email,_that.firstName,_that.lastName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterUserByPhoneRequest implements RegisterUserByPhoneRequest {
  const _RegisterUserByPhoneRequest({required this.phoneNumber, required this.email, required this.firstName, required this.lastName});
  factory _RegisterUserByPhoneRequest.fromJson(Map<String, dynamic> json) => _$RegisterUserByPhoneRequestFromJson(json);

@override final  String phoneNumber;
@override final  String email;
@override final  String firstName;
@override final  String lastName;

/// Create a copy of RegisterUserByPhoneRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterUserByPhoneRequestCopyWith<_RegisterUserByPhoneRequest> get copyWith => __$RegisterUserByPhoneRequestCopyWithImpl<_RegisterUserByPhoneRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterUserByPhoneRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterUserByPhoneRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,email,firstName,lastName);

@override
String toString() {
  return 'RegisterUserByPhoneRequest(phoneNumber: $phoneNumber, email: $email, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class _$RegisterUserByPhoneRequestCopyWith<$Res> implements $RegisterUserByPhoneRequestCopyWith<$Res> {
  factory _$RegisterUserByPhoneRequestCopyWith(_RegisterUserByPhoneRequest value, $Res Function(_RegisterUserByPhoneRequest) _then) = __$RegisterUserByPhoneRequestCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String email, String firstName, String lastName
});




}
/// @nodoc
class __$RegisterUserByPhoneRequestCopyWithImpl<$Res>
    implements _$RegisterUserByPhoneRequestCopyWith<$Res> {
  __$RegisterUserByPhoneRequestCopyWithImpl(this._self, this._then);

  final _RegisterUserByPhoneRequest _self;
  final $Res Function(_RegisterUserByPhoneRequest) _then;

/// Create a copy of RegisterUserByPhoneRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? email = null,Object? firstName = null,Object? lastName = null,}) {
  return _then(_RegisterUserByPhoneRequest(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PhoneRegistrationResponse {

 String get id; String get email; String get firstName; String get lastName; String get firebaseUid; String get role; int? get organizationId; String? get organizationName; int get pointsBalance; DateTime? get pointsExpiry; bool get isActive; DateTime get createdAt; bool get isNewUser; bool get isEmployee; String? get employeeCode; String? get department; String? get position;
/// Create a copy of PhoneRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneRegistrationResponseCopyWith<PhoneRegistrationResponse> get copyWith => _$PhoneRegistrationResponseCopyWithImpl<PhoneRegistrationResponse>(this as PhoneRegistrationResponse, _$identity);

  /// Serializes this PhoneRegistrationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneRegistrationResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.role, role) || other.role == role)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser)&&(identical(other.isEmployee, isEmployee) || other.isEmployee == isEmployee)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,firebaseUid,role,organizationId,organizationName,pointsBalance,pointsExpiry,isActive,createdAt,isNewUser,isEmployee,employeeCode,department,position);

@override
String toString() {
  return 'PhoneRegistrationResponse(id: $id, email: $email, firstName: $firstName, lastName: $lastName, firebaseUid: $firebaseUid, role: $role, organizationId: $organizationId, organizationName: $organizationName, pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry, isActive: $isActive, createdAt: $createdAt, isNewUser: $isNewUser, isEmployee: $isEmployee, employeeCode: $employeeCode, department: $department, position: $position)';
}


}

/// @nodoc
abstract mixin class $PhoneRegistrationResponseCopyWith<$Res>  {
  factory $PhoneRegistrationResponseCopyWith(PhoneRegistrationResponse value, $Res Function(PhoneRegistrationResponse) _then) = _$PhoneRegistrationResponseCopyWithImpl;
@useResult
$Res call({
 String id, String email, String firstName, String lastName, String firebaseUid, String role, int? organizationId, String? organizationName, int pointsBalance, DateTime? pointsExpiry, bool isActive, DateTime createdAt, bool isNewUser, bool isEmployee, String? employeeCode, String? department, String? position
});




}
/// @nodoc
class _$PhoneRegistrationResponseCopyWithImpl<$Res>
    implements $PhoneRegistrationResponseCopyWith<$Res> {
  _$PhoneRegistrationResponseCopyWithImpl(this._self, this._then);

  final PhoneRegistrationResponse _self;
  final $Res Function(PhoneRegistrationResponse) _then;

/// Create a copy of PhoneRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? firebaseUid = null,Object? role = null,Object? organizationId = freezed,Object? organizationName = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = null,Object? createdAt = null,Object? isNewUser = null,Object? isEmployee = null,Object? employeeCode = freezed,Object? department = freezed,Object? position = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,firebaseUid: null == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int?,organizationName: freezed == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String?,pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,pointsExpiry: freezed == pointsExpiry ? _self.pointsExpiry : pointsExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,isEmployee: null == isEmployee ? _self.isEmployee : isEmployee // ignore: cast_nullable_to_non_nullable
as bool,employeeCode: freezed == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneRegistrationResponse].
extension PhoneRegistrationResponsePatterns on PhoneRegistrationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneRegistrationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneRegistrationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneRegistrationResponse value)  $default,){
final _that = this;
switch (_that) {
case _PhoneRegistrationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneRegistrationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneRegistrationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String firstName,  String lastName,  String firebaseUid,  String role,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime createdAt,  bool isNewUser,  bool isEmployee,  String? employeeCode,  String? department,  String? position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneRegistrationResponse() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.role,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.isNewUser,_that.isEmployee,_that.employeeCode,_that.department,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String firstName,  String lastName,  String firebaseUid,  String role,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime createdAt,  bool isNewUser,  bool isEmployee,  String? employeeCode,  String? department,  String? position)  $default,) {final _that = this;
switch (_that) {
case _PhoneRegistrationResponse():
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.role,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.isNewUser,_that.isEmployee,_that.employeeCode,_that.department,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String firstName,  String lastName,  String firebaseUid,  String role,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime createdAt,  bool isNewUser,  bool isEmployee,  String? employeeCode,  String? department,  String? position)?  $default,) {final _that = this;
switch (_that) {
case _PhoneRegistrationResponse() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.role,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.isNewUser,_that.isEmployee,_that.employeeCode,_that.department,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneRegistrationResponse implements PhoneRegistrationResponse {
  const _PhoneRegistrationResponse({required this.id, required this.email, required this.firstName, required this.lastName, required this.firebaseUid, required this.role, this.organizationId, this.organizationName, required this.pointsBalance, this.pointsExpiry, required this.isActive, required this.createdAt, required this.isNewUser, required this.isEmployee, this.employeeCode, this.department, this.position});
  factory _PhoneRegistrationResponse.fromJson(Map<String, dynamic> json) => _$PhoneRegistrationResponseFromJson(json);

@override final  String id;
@override final  String email;
@override final  String firstName;
@override final  String lastName;
@override final  String firebaseUid;
@override final  String role;
@override final  int? organizationId;
@override final  String? organizationName;
@override final  int pointsBalance;
@override final  DateTime? pointsExpiry;
@override final  bool isActive;
@override final  DateTime createdAt;
@override final  bool isNewUser;
@override final  bool isEmployee;
@override final  String? employeeCode;
@override final  String? department;
@override final  String? position;

/// Create a copy of PhoneRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneRegistrationResponseCopyWith<_PhoneRegistrationResponse> get copyWith => __$PhoneRegistrationResponseCopyWithImpl<_PhoneRegistrationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneRegistrationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneRegistrationResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.role, role) || other.role == role)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser)&&(identical(other.isEmployee, isEmployee) || other.isEmployee == isEmployee)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,firebaseUid,role,organizationId,organizationName,pointsBalance,pointsExpiry,isActive,createdAt,isNewUser,isEmployee,employeeCode,department,position);

@override
String toString() {
  return 'PhoneRegistrationResponse(id: $id, email: $email, firstName: $firstName, lastName: $lastName, firebaseUid: $firebaseUid, role: $role, organizationId: $organizationId, organizationName: $organizationName, pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry, isActive: $isActive, createdAt: $createdAt, isNewUser: $isNewUser, isEmployee: $isEmployee, employeeCode: $employeeCode, department: $department, position: $position)';
}


}

/// @nodoc
abstract mixin class _$PhoneRegistrationResponseCopyWith<$Res> implements $PhoneRegistrationResponseCopyWith<$Res> {
  factory _$PhoneRegistrationResponseCopyWith(_PhoneRegistrationResponse value, $Res Function(_PhoneRegistrationResponse) _then) = __$PhoneRegistrationResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String firstName, String lastName, String firebaseUid, String role, int? organizationId, String? organizationName, int pointsBalance, DateTime? pointsExpiry, bool isActive, DateTime createdAt, bool isNewUser, bool isEmployee, String? employeeCode, String? department, String? position
});




}
/// @nodoc
class __$PhoneRegistrationResponseCopyWithImpl<$Res>
    implements _$PhoneRegistrationResponseCopyWith<$Res> {
  __$PhoneRegistrationResponseCopyWithImpl(this._self, this._then);

  final _PhoneRegistrationResponse _self;
  final $Res Function(_PhoneRegistrationResponse) _then;

/// Create a copy of PhoneRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? firebaseUid = null,Object? role = null,Object? organizationId = freezed,Object? organizationName = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = null,Object? createdAt = null,Object? isNewUser = null,Object? isEmployee = null,Object? employeeCode = freezed,Object? department = freezed,Object? position = freezed,}) {
  return _then(_PhoneRegistrationResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,firebaseUid: null == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int?,organizationName: freezed == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String?,pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,pointsExpiry: freezed == pointsExpiry ? _self.pointsExpiry : pointsExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,isEmployee: null == isEmployee ? _self.isEmployee : isEmployee // ignore: cast_nullable_to_non_nullable
as bool,employeeCode: freezed == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
