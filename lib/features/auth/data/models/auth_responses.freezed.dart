// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_responses.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserRegistrationResponse {

 String get id; String get email; String? get firstName; String? get lastName; String? get firebaseUid; String? get role; int? get organizationId; String? get organizationName; int get pointsBalance; DateTime? get pointsExpiry; bool get isActive; DateTime? get createdAt; bool get isNewUser; bool get isEmployee; String? get employeeCode; String? get department; String? get position;
/// Create a copy of UserRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserRegistrationResponseCopyWith<UserRegistrationResponse> get copyWith => _$UserRegistrationResponseCopyWithImpl<UserRegistrationResponse>(this as UserRegistrationResponse, _$identity);

  /// Serializes this UserRegistrationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserRegistrationResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.role, role) || other.role == role)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser)&&(identical(other.isEmployee, isEmployee) || other.isEmployee == isEmployee)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,firebaseUid,role,organizationId,organizationName,pointsBalance,pointsExpiry,isActive,createdAt,isNewUser,isEmployee,employeeCode,department,position);

@override
String toString() {
  return 'UserRegistrationResponse(id: $id, email: $email, firstName: $firstName, lastName: $lastName, firebaseUid: $firebaseUid, role: $role, organizationId: $organizationId, organizationName: $organizationName, pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry, isActive: $isActive, createdAt: $createdAt, isNewUser: $isNewUser, isEmployee: $isEmployee, employeeCode: $employeeCode, department: $department, position: $position)';
}


}

/// @nodoc
abstract mixin class $UserRegistrationResponseCopyWith<$Res>  {
  factory $UserRegistrationResponseCopyWith(UserRegistrationResponse value, $Res Function(UserRegistrationResponse) _then) = _$UserRegistrationResponseCopyWithImpl;
@useResult
$Res call({
 String id, String email, String? firstName, String? lastName, String? firebaseUid, String? role, int? organizationId, String? organizationName, int pointsBalance, DateTime? pointsExpiry, bool isActive, DateTime? createdAt, bool isNewUser, bool isEmployee, String? employeeCode, String? department, String? position
});




}
/// @nodoc
class _$UserRegistrationResponseCopyWithImpl<$Res>
    implements $UserRegistrationResponseCopyWith<$Res> {
  _$UserRegistrationResponseCopyWithImpl(this._self, this._then);

  final UserRegistrationResponse _self;
  final $Res Function(UserRegistrationResponse) _then;

/// Create a copy of UserRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? firebaseUid = freezed,Object? role = freezed,Object? organizationId = freezed,Object? organizationName = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = null,Object? createdAt = freezed,Object? isNewUser = null,Object? isEmployee = null,Object? employeeCode = freezed,Object? department = freezed,Object? position = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,firebaseUid: freezed == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int?,organizationName: freezed == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String?,pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,pointsExpiry: freezed == pointsExpiry ? _self.pointsExpiry : pointsExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,isEmployee: null == isEmployee ? _self.isEmployee : isEmployee // ignore: cast_nullable_to_non_nullable
as bool,employeeCode: freezed == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserRegistrationResponse].
extension UserRegistrationResponsePatterns on UserRegistrationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserRegistrationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserRegistrationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserRegistrationResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserRegistrationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserRegistrationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserRegistrationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  String? role,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime? createdAt,  bool isNewUser,  bool isEmployee,  String? employeeCode,  String? department,  String? position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserRegistrationResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  String? role,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime? createdAt,  bool isNewUser,  bool isEmployee,  String? employeeCode,  String? department,  String? position)  $default,) {final _that = this;
switch (_that) {
case _UserRegistrationResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  String? role,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime? createdAt,  bool isNewUser,  bool isEmployee,  String? employeeCode,  String? department,  String? position)?  $default,) {final _that = this;
switch (_that) {
case _UserRegistrationResponse() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.role,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.isNewUser,_that.isEmployee,_that.employeeCode,_that.department,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserRegistrationResponse extends UserRegistrationResponse {
  const _UserRegistrationResponse({required this.id, required this.email, this.firstName, this.lastName, this.firebaseUid, this.role, this.organizationId, this.organizationName, this.pointsBalance = 0, this.pointsExpiry, this.isActive = true, this.createdAt, this.isNewUser = false, this.isEmployee = false, this.employeeCode, this.department, this.position}): super._();
  factory _UserRegistrationResponse.fromJson(Map<String, dynamic> json) => _$UserRegistrationResponseFromJson(json);

@override final  String id;
@override final  String email;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? firebaseUid;
@override final  String? role;
@override final  int? organizationId;
@override final  String? organizationName;
@override@JsonKey() final  int pointsBalance;
@override final  DateTime? pointsExpiry;
@override@JsonKey() final  bool isActive;
@override final  DateTime? createdAt;
@override@JsonKey() final  bool isNewUser;
@override@JsonKey() final  bool isEmployee;
@override final  String? employeeCode;
@override final  String? department;
@override final  String? position;

/// Create a copy of UserRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserRegistrationResponseCopyWith<_UserRegistrationResponse> get copyWith => __$UserRegistrationResponseCopyWithImpl<_UserRegistrationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserRegistrationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRegistrationResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.role, role) || other.role == role)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isNewUser, isNewUser) || other.isNewUser == isNewUser)&&(identical(other.isEmployee, isEmployee) || other.isEmployee == isEmployee)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,firebaseUid,role,organizationId,organizationName,pointsBalance,pointsExpiry,isActive,createdAt,isNewUser,isEmployee,employeeCode,department,position);

@override
String toString() {
  return 'UserRegistrationResponse(id: $id, email: $email, firstName: $firstName, lastName: $lastName, firebaseUid: $firebaseUid, role: $role, organizationId: $organizationId, organizationName: $organizationName, pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry, isActive: $isActive, createdAt: $createdAt, isNewUser: $isNewUser, isEmployee: $isEmployee, employeeCode: $employeeCode, department: $department, position: $position)';
}


}

/// @nodoc
abstract mixin class _$UserRegistrationResponseCopyWith<$Res> implements $UserRegistrationResponseCopyWith<$Res> {
  factory _$UserRegistrationResponseCopyWith(_UserRegistrationResponse value, $Res Function(_UserRegistrationResponse) _then) = __$UserRegistrationResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String? firstName, String? lastName, String? firebaseUid, String? role, int? organizationId, String? organizationName, int pointsBalance, DateTime? pointsExpiry, bool isActive, DateTime? createdAt, bool isNewUser, bool isEmployee, String? employeeCode, String? department, String? position
});




}
/// @nodoc
class __$UserRegistrationResponseCopyWithImpl<$Res>
    implements _$UserRegistrationResponseCopyWith<$Res> {
  __$UserRegistrationResponseCopyWithImpl(this._self, this._then);

  final _UserRegistrationResponse _self;
  final $Res Function(_UserRegistrationResponse) _then;

/// Create a copy of UserRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? firebaseUid = freezed,Object? role = freezed,Object? organizationId = freezed,Object? organizationName = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = null,Object? createdAt = freezed,Object? isNewUser = null,Object? isEmployee = null,Object? employeeCode = freezed,Object? department = freezed,Object? position = freezed,}) {
  return _then(_UserRegistrationResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,firebaseUid: freezed == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int?,organizationName: freezed == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String?,pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,pointsExpiry: freezed == pointsExpiry ? _self.pointsExpiry : pointsExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isNewUser: null == isNewUser ? _self.isNewUser : isNewUser // ignore: cast_nullable_to_non_nullable
as bool,isEmployee: null == isEmployee ? _self.isEmployee : isEmployee // ignore: cast_nullable_to_non_nullable
as bool,employeeCode: freezed == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UserProfileResponse {

 String get id; String get email; String? get firstName; String? get lastName; String? get firebaseUid; int? get organizationId; int get pointsBalance; DateTime? get pointsExpiry; bool get isActive; DateTime? get createdAt;
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
 String id, String email, String? firstName, String? lastName, String? firebaseUid, int? organizationId, int pointsBalance, DateTime? pointsExpiry, bool isActive, DateTime? createdAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? firebaseUid = freezed,Object? organizationId = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,firebaseUid: freezed == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int?,pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,pointsExpiry: freezed == pointsExpiry ? _self.pointsExpiry : pointsExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  int? organizationId,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  int? organizationId,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime? createdAt)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  int? organizationId,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.organizationId,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileResponse extends UserProfileResponse {
  const _UserProfileResponse({required this.id, required this.email, this.firstName, this.lastName, this.firebaseUid, this.organizationId, this.pointsBalance = 0, this.pointsExpiry, this.isActive = true, this.createdAt}): super._();
  factory _UserProfileResponse.fromJson(Map<String, dynamic> json) => _$UserProfileResponseFromJson(json);

@override final  String id;
@override final  String email;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? firebaseUid;
@override final  int? organizationId;
@override@JsonKey() final  int pointsBalance;
@override final  DateTime? pointsExpiry;
@override@JsonKey() final  bool isActive;
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
 String id, String email, String? firstName, String? lastName, String? firebaseUid, int? organizationId, int pointsBalance, DateTime? pointsExpiry, bool isActive, DateTime? createdAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? firebaseUid = freezed,Object? organizationId = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = null,Object? createdAt = freezed,}) {
  return _then(_UserProfileResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,firebaseUid: freezed == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String?,organizationId: freezed == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int?,pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,pointsExpiry: freezed == pointsExpiry ? _self.pointsExpiry : pointsExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$UserProfileResponse2 {

 String get id; String get email; String? get firstName; String? get lastName; String? get firebaseUid; int? get organizationId; String? get organizationName; int get pointsBalance; DateTime? get pointsExpiry; bool get isActive; DateTime? get createdAt; bool get isEmployee; String? get employeeCode; String? get department; String? get position; DateTime? get joinDate;
/// Create a copy of UserProfileResponse2
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileResponse2CopyWith<UserProfileResponse2> get copyWith => _$UserProfileResponse2CopyWithImpl<UserProfileResponse2>(this as UserProfileResponse2, _$identity);

  /// Serializes this UserProfileResponse2 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileResponse2&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isEmployee, isEmployee) || other.isEmployee == isEmployee)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.joinDate, joinDate) || other.joinDate == joinDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,firebaseUid,organizationId,organizationName,pointsBalance,pointsExpiry,isActive,createdAt,isEmployee,employeeCode,department,position,joinDate);

@override
String toString() {
  return 'UserProfileResponse2(id: $id, email: $email, firstName: $firstName, lastName: $lastName, firebaseUid: $firebaseUid, organizationId: $organizationId, organizationName: $organizationName, pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry, isActive: $isActive, createdAt: $createdAt, isEmployee: $isEmployee, employeeCode: $employeeCode, department: $department, position: $position, joinDate: $joinDate)';
}


}

/// @nodoc
abstract mixin class $UserProfileResponse2CopyWith<$Res>  {
  factory $UserProfileResponse2CopyWith(UserProfileResponse2 value, $Res Function(UserProfileResponse2) _then) = _$UserProfileResponse2CopyWithImpl;
@useResult
$Res call({
 String id, String email, String? firstName, String? lastName, String? firebaseUid, int? organizationId, String? organizationName, int pointsBalance, DateTime? pointsExpiry, bool isActive, DateTime? createdAt, bool isEmployee, String? employeeCode, String? department, String? position, DateTime? joinDate
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? firebaseUid = freezed,Object? organizationId = freezed,Object? organizationName = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = null,Object? createdAt = freezed,Object? isEmployee = null,Object? employeeCode = freezed,Object? department = freezed,Object? position = freezed,Object? joinDate = freezed,}) {
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
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isEmployee: null == isEmployee ? _self.isEmployee : isEmployee // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime? createdAt,  bool isEmployee,  String? employeeCode,  String? department,  String? position,  DateTime? joinDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileResponse2() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.isEmployee,_that.employeeCode,_that.department,_that.position,_that.joinDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime? createdAt,  bool isEmployee,  String? employeeCode,  String? department,  String? position,  DateTime? joinDate)  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse2():
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.isEmployee,_that.employeeCode,_that.department,_that.position,_that.joinDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String? firstName,  String? lastName,  String? firebaseUid,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime? createdAt,  bool isEmployee,  String? employeeCode,  String? department,  String? position,  DateTime? joinDate)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse2() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.firebaseUid,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.isEmployee,_that.employeeCode,_that.department,_that.position,_that.joinDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileResponse2 extends UserProfileResponse2 {
  const _UserProfileResponse2({required this.id, required this.email, this.firstName, this.lastName, this.firebaseUid, this.organizationId, this.organizationName, this.pointsBalance = 0, this.pointsExpiry, this.isActive = true, this.createdAt, this.isEmployee = false, this.employeeCode, this.department, this.position, this.joinDate}): super._();
  factory _UserProfileResponse2.fromJson(Map<String, dynamic> json) => _$UserProfileResponse2FromJson(json);

@override final  String id;
@override final  String email;
@override final  String? firstName;
@override final  String? lastName;
@override final  String? firebaseUid;
@override final  int? organizationId;
@override final  String? organizationName;
@override@JsonKey() final  int pointsBalance;
@override final  DateTime? pointsExpiry;
@override@JsonKey() final  bool isActive;
@override final  DateTime? createdAt;
@override@JsonKey() final  bool isEmployee;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileResponse2&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isEmployee, isEmployee) || other.isEmployee == isEmployee)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.joinDate, joinDate) || other.joinDate == joinDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,firebaseUid,organizationId,organizationName,pointsBalance,pointsExpiry,isActive,createdAt,isEmployee,employeeCode,department,position,joinDate);

@override
String toString() {
  return 'UserProfileResponse2(id: $id, email: $email, firstName: $firstName, lastName: $lastName, firebaseUid: $firebaseUid, organizationId: $organizationId, organizationName: $organizationName, pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry, isActive: $isActive, createdAt: $createdAt, isEmployee: $isEmployee, employeeCode: $employeeCode, department: $department, position: $position, joinDate: $joinDate)';
}


}

/// @nodoc
abstract mixin class _$UserProfileResponse2CopyWith<$Res> implements $UserProfileResponse2CopyWith<$Res> {
  factory _$UserProfileResponse2CopyWith(_UserProfileResponse2 value, $Res Function(_UserProfileResponse2) _then) = __$UserProfileResponse2CopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String? firstName, String? lastName, String? firebaseUid, int? organizationId, String? organizationName, int pointsBalance, DateTime? pointsExpiry, bool isActive, DateTime? createdAt, bool isEmployee, String? employeeCode, String? department, String? position, DateTime? joinDate
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? firebaseUid = freezed,Object? organizationId = freezed,Object? organizationName = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = null,Object? createdAt = freezed,Object? isEmployee = null,Object? employeeCode = freezed,Object? department = freezed,Object? position = freezed,Object? joinDate = freezed,}) {
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
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isEmployee: null == isEmployee ? _self.isEmployee : isEmployee // ignore: cast_nullable_to_non_nullable
as bool,employeeCode: freezed == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String?,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,joinDate: freezed == joinDate ? _self.joinDate : joinDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$UserExistsResponse {

 bool get exists; String? get firebaseUid; UserProfileResponse2? get userProfile;
/// Create a copy of UserExistsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserExistsResponseCopyWith<UserExistsResponse> get copyWith => _$UserExistsResponseCopyWithImpl<UserExistsResponse>(this as UserExistsResponse, _$identity);

  /// Serializes this UserExistsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserExistsResponse&&(identical(other.exists, exists) || other.exists == exists)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exists,firebaseUid,userProfile);

@override
String toString() {
  return 'UserExistsResponse(exists: $exists, firebaseUid: $firebaseUid, userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class $UserExistsResponseCopyWith<$Res>  {
  factory $UserExistsResponseCopyWith(UserExistsResponse value, $Res Function(UserExistsResponse) _then) = _$UserExistsResponseCopyWithImpl;
@useResult
$Res call({
 bool exists, String? firebaseUid, UserProfileResponse2? userProfile
});


$UserProfileResponse2CopyWith<$Res>? get userProfile;

}
/// @nodoc
class _$UserExistsResponseCopyWithImpl<$Res>
    implements $UserExistsResponseCopyWith<$Res> {
  _$UserExistsResponseCopyWithImpl(this._self, this._then);

  final UserExistsResponse _self;
  final $Res Function(UserExistsResponse) _then;

/// Create a copy of UserExistsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exists = null,Object? firebaseUid = freezed,Object? userProfile = freezed,}) {
  return _then(_self.copyWith(
exists: null == exists ? _self.exists : exists // ignore: cast_nullable_to_non_nullable
as bool,firebaseUid: freezed == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String?,userProfile: freezed == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfileResponse2?,
  ));
}
/// Create a copy of UserExistsResponse
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


/// Adds pattern-matching-related methods to [UserExistsResponse].
extension UserExistsResponsePatterns on UserExistsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserExistsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserExistsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserExistsResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserExistsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserExistsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserExistsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool exists,  String? firebaseUid,  UserProfileResponse2? userProfile)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserExistsResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool exists,  String? firebaseUid,  UserProfileResponse2? userProfile)  $default,) {final _that = this;
switch (_that) {
case _UserExistsResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool exists,  String? firebaseUid,  UserProfileResponse2? userProfile)?  $default,) {final _that = this;
switch (_that) {
case _UserExistsResponse() when $default != null:
return $default(_that.exists,_that.firebaseUid,_that.userProfile);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserExistsResponse implements UserExistsResponse {
  const _UserExistsResponse({required this.exists, this.firebaseUid, this.userProfile});
  factory _UserExistsResponse.fromJson(Map<String, dynamic> json) => _$UserExistsResponseFromJson(json);

@override final  bool exists;
@override final  String? firebaseUid;
@override final  UserProfileResponse2? userProfile;

/// Create a copy of UserExistsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserExistsResponseCopyWith<_UserExistsResponse> get copyWith => __$UserExistsResponseCopyWithImpl<_UserExistsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserExistsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserExistsResponse&&(identical(other.exists, exists) || other.exists == exists)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exists,firebaseUid,userProfile);

@override
String toString() {
  return 'UserExistsResponse(exists: $exists, firebaseUid: $firebaseUid, userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class _$UserExistsResponseCopyWith<$Res> implements $UserExistsResponseCopyWith<$Res> {
  factory _$UserExistsResponseCopyWith(_UserExistsResponse value, $Res Function(_UserExistsResponse) _then) = __$UserExistsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool exists, String? firebaseUid, UserProfileResponse2? userProfile
});


@override $UserProfileResponse2CopyWith<$Res>? get userProfile;

}
/// @nodoc
class __$UserExistsResponseCopyWithImpl<$Res>
    implements _$UserExistsResponseCopyWith<$Res> {
  __$UserExistsResponseCopyWithImpl(this._self, this._then);

  final _UserExistsResponse _self;
  final $Res Function(_UserExistsResponse) _then;

/// Create a copy of UserExistsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exists = null,Object? firebaseUid = freezed,Object? userProfile = freezed,}) {
  return _then(_UserExistsResponse(
exists: null == exists ? _self.exists : exists // ignore: cast_nullable_to_non_nullable
as bool,firebaseUid: freezed == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String?,userProfile: freezed == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfileResponse2?,
  ));
}

/// Create a copy of UserExistsResponse
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

// dart format on
