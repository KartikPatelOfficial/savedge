// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileResponse3 {

 String get id; String get email; String get phoneNumber; String get firstName; String get lastName; String get fullName; String? get profileImageUrl; bool get isActive; DateTime get createdAt; DateTime? get lastLoginAt; List<String> get roles; EmployeeInfo? get employeeInfo; VendorInfo? get vendorInfo; OrganizationInfo? get organizationInfo;
/// Create a copy of UserProfileResponse3
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileResponse3CopyWith<UserProfileResponse3> get copyWith => _$UserProfileResponse3CopyWithImpl<UserProfileResponse3>(this as UserProfileResponse3, _$identity);

  /// Serializes this UserProfileResponse3 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileResponse3&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&const DeepCollectionEquality().equals(other.roles, roles)&&(identical(other.employeeInfo, employeeInfo) || other.employeeInfo == employeeInfo)&&(identical(other.vendorInfo, vendorInfo) || other.vendorInfo == vendorInfo)&&(identical(other.organizationInfo, organizationInfo) || other.organizationInfo == organizationInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,phoneNumber,firstName,lastName,fullName,profileImageUrl,isActive,createdAt,lastLoginAt,const DeepCollectionEquality().hash(roles),employeeInfo,vendorInfo,organizationInfo);

@override
String toString() {
  return 'UserProfileResponse3(id: $id, email: $email, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, fullName: $fullName, profileImageUrl: $profileImageUrl, isActive: $isActive, createdAt: $createdAt, lastLoginAt: $lastLoginAt, roles: $roles, employeeInfo: $employeeInfo, vendorInfo: $vendorInfo, organizationInfo: $organizationInfo)';
}


}

/// @nodoc
abstract mixin class $UserProfileResponse3CopyWith<$Res>  {
  factory $UserProfileResponse3CopyWith(UserProfileResponse3 value, $Res Function(UserProfileResponse3) _then) = _$UserProfileResponse3CopyWithImpl;
@useResult
$Res call({
 String id, String email, String phoneNumber, String firstName, String lastName, String fullName, String? profileImageUrl, bool isActive, DateTime createdAt, DateTime? lastLoginAt, List<String> roles, EmployeeInfo? employeeInfo, VendorInfo? vendorInfo, OrganizationInfo? organizationInfo
});


$EmployeeInfoCopyWith<$Res>? get employeeInfo;$VendorInfoCopyWith<$Res>? get vendorInfo;$OrganizationInfoCopyWith<$Res>? get organizationInfo;

}
/// @nodoc
class _$UserProfileResponse3CopyWithImpl<$Res>
    implements $UserProfileResponse3CopyWith<$Res> {
  _$UserProfileResponse3CopyWithImpl(this._self, this._then);

  final UserProfileResponse3 _self;
  final $Res Function(UserProfileResponse3) _then;

/// Create a copy of UserProfileResponse3
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? phoneNumber = null,Object? firstName = null,Object? lastName = null,Object? fullName = null,Object? profileImageUrl = freezed,Object? isActive = null,Object? createdAt = null,Object? lastLoginAt = freezed,Object? roles = null,Object? employeeInfo = freezed,Object? vendorInfo = freezed,Object? organizationInfo = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,employeeInfo: freezed == employeeInfo ? _self.employeeInfo : employeeInfo // ignore: cast_nullable_to_non_nullable
as EmployeeInfo?,vendorInfo: freezed == vendorInfo ? _self.vendorInfo : vendorInfo // ignore: cast_nullable_to_non_nullable
as VendorInfo?,organizationInfo: freezed == organizationInfo ? _self.organizationInfo : organizationInfo // ignore: cast_nullable_to_non_nullable
as OrganizationInfo?,
  ));
}
/// Create a copy of UserProfileResponse3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmployeeInfoCopyWith<$Res>? get employeeInfo {
    if (_self.employeeInfo == null) {
    return null;
  }

  return $EmployeeInfoCopyWith<$Res>(_self.employeeInfo!, (value) {
    return _then(_self.copyWith(employeeInfo: value));
  });
}/// Create a copy of UserProfileResponse3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorInfoCopyWith<$Res>? get vendorInfo {
    if (_self.vendorInfo == null) {
    return null;
  }

  return $VendorInfoCopyWith<$Res>(_self.vendorInfo!, (value) {
    return _then(_self.copyWith(vendorInfo: value));
  });
}/// Create a copy of UserProfileResponse3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizationInfoCopyWith<$Res>? get organizationInfo {
    if (_self.organizationInfo == null) {
    return null;
  }

  return $OrganizationInfoCopyWith<$Res>(_self.organizationInfo!, (value) {
    return _then(_self.copyWith(organizationInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserProfileResponse3].
extension UserProfileResponse3Patterns on UserProfileResponse3 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileResponse3 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileResponse3() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileResponse3 value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileResponse3():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileResponse3 value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileResponse3() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String phoneNumber,  String firstName,  String lastName,  String fullName,  String? profileImageUrl,  bool isActive,  DateTime createdAt,  DateTime? lastLoginAt,  List<String> roles,  EmployeeInfo? employeeInfo,  VendorInfo? vendorInfo,  OrganizationInfo? organizationInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileResponse3() when $default != null:
return $default(_that.id,_that.email,_that.phoneNumber,_that.firstName,_that.lastName,_that.fullName,_that.profileImageUrl,_that.isActive,_that.createdAt,_that.lastLoginAt,_that.roles,_that.employeeInfo,_that.vendorInfo,_that.organizationInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String phoneNumber,  String firstName,  String lastName,  String fullName,  String? profileImageUrl,  bool isActive,  DateTime createdAt,  DateTime? lastLoginAt,  List<String> roles,  EmployeeInfo? employeeInfo,  VendorInfo? vendorInfo,  OrganizationInfo? organizationInfo)  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse3():
return $default(_that.id,_that.email,_that.phoneNumber,_that.firstName,_that.lastName,_that.fullName,_that.profileImageUrl,_that.isActive,_that.createdAt,_that.lastLoginAt,_that.roles,_that.employeeInfo,_that.vendorInfo,_that.organizationInfo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String phoneNumber,  String firstName,  String lastName,  String fullName,  String? profileImageUrl,  bool isActive,  DateTime createdAt,  DateTime? lastLoginAt,  List<String> roles,  EmployeeInfo? employeeInfo,  VendorInfo? vendorInfo,  OrganizationInfo? organizationInfo)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse3() when $default != null:
return $default(_that.id,_that.email,_that.phoneNumber,_that.firstName,_that.lastName,_that.fullName,_that.profileImageUrl,_that.isActive,_that.createdAt,_that.lastLoginAt,_that.roles,_that.employeeInfo,_that.vendorInfo,_that.organizationInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileResponse3 implements UserProfileResponse3 {
  const _UserProfileResponse3({required this.id, required this.email, required this.phoneNumber, required this.firstName, required this.lastName, required this.fullName, this.profileImageUrl, required this.isActive, required this.createdAt, this.lastLoginAt, required final  List<String> roles, this.employeeInfo, this.vendorInfo, this.organizationInfo}): _roles = roles;
  factory _UserProfileResponse3.fromJson(Map<String, dynamic> json) => _$UserProfileResponse3FromJson(json);

@override final  String id;
@override final  String email;
@override final  String phoneNumber;
@override final  String firstName;
@override final  String lastName;
@override final  String fullName;
@override final  String? profileImageUrl;
@override final  bool isActive;
@override final  DateTime createdAt;
@override final  DateTime? lastLoginAt;
 final  List<String> _roles;
@override List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

@override final  EmployeeInfo? employeeInfo;
@override final  VendorInfo? vendorInfo;
@override final  OrganizationInfo? organizationInfo;

/// Create a copy of UserProfileResponse3
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileResponse3CopyWith<_UserProfileResponse3> get copyWith => __$UserProfileResponse3CopyWithImpl<_UserProfileResponse3>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileResponse3ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileResponse3&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&const DeepCollectionEquality().equals(other._roles, _roles)&&(identical(other.employeeInfo, employeeInfo) || other.employeeInfo == employeeInfo)&&(identical(other.vendorInfo, vendorInfo) || other.vendorInfo == vendorInfo)&&(identical(other.organizationInfo, organizationInfo) || other.organizationInfo == organizationInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,phoneNumber,firstName,lastName,fullName,profileImageUrl,isActive,createdAt,lastLoginAt,const DeepCollectionEquality().hash(_roles),employeeInfo,vendorInfo,organizationInfo);

@override
String toString() {
  return 'UserProfileResponse3(id: $id, email: $email, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, fullName: $fullName, profileImageUrl: $profileImageUrl, isActive: $isActive, createdAt: $createdAt, lastLoginAt: $lastLoginAt, roles: $roles, employeeInfo: $employeeInfo, vendorInfo: $vendorInfo, organizationInfo: $organizationInfo)';
}


}

/// @nodoc
abstract mixin class _$UserProfileResponse3CopyWith<$Res> implements $UserProfileResponse3CopyWith<$Res> {
  factory _$UserProfileResponse3CopyWith(_UserProfileResponse3 value, $Res Function(_UserProfileResponse3) _then) = __$UserProfileResponse3CopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String phoneNumber, String firstName, String lastName, String fullName, String? profileImageUrl, bool isActive, DateTime createdAt, DateTime? lastLoginAt, List<String> roles, EmployeeInfo? employeeInfo, VendorInfo? vendorInfo, OrganizationInfo? organizationInfo
});


@override $EmployeeInfoCopyWith<$Res>? get employeeInfo;@override $VendorInfoCopyWith<$Res>? get vendorInfo;@override $OrganizationInfoCopyWith<$Res>? get organizationInfo;

}
/// @nodoc
class __$UserProfileResponse3CopyWithImpl<$Res>
    implements _$UserProfileResponse3CopyWith<$Res> {
  __$UserProfileResponse3CopyWithImpl(this._self, this._then);

  final _UserProfileResponse3 _self;
  final $Res Function(_UserProfileResponse3) _then;

/// Create a copy of UserProfileResponse3
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? phoneNumber = null,Object? firstName = null,Object? lastName = null,Object? fullName = null,Object? profileImageUrl = freezed,Object? isActive = null,Object? createdAt = null,Object? lastLoginAt = freezed,Object? roles = null,Object? employeeInfo = freezed,Object? vendorInfo = freezed,Object? organizationInfo = freezed,}) {
  return _then(_UserProfileResponse3(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,employeeInfo: freezed == employeeInfo ? _self.employeeInfo : employeeInfo // ignore: cast_nullable_to_non_nullable
as EmployeeInfo?,vendorInfo: freezed == vendorInfo ? _self.vendorInfo : vendorInfo // ignore: cast_nullable_to_non_nullable
as VendorInfo?,organizationInfo: freezed == organizationInfo ? _self.organizationInfo : organizationInfo // ignore: cast_nullable_to_non_nullable
as OrganizationInfo?,
  ));
}

/// Create a copy of UserProfileResponse3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmployeeInfoCopyWith<$Res>? get employeeInfo {
    if (_self.employeeInfo == null) {
    return null;
  }

  return $EmployeeInfoCopyWith<$Res>(_self.employeeInfo!, (value) {
    return _then(_self.copyWith(employeeInfo: value));
  });
}/// Create a copy of UserProfileResponse3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VendorInfoCopyWith<$Res>? get vendorInfo {
    if (_self.vendorInfo == null) {
    return null;
  }

  return $VendorInfoCopyWith<$Res>(_self.vendorInfo!, (value) {
    return _then(_self.copyWith(vendorInfo: value));
  });
}/// Create a copy of UserProfileResponse3
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizationInfoCopyWith<$Res>? get organizationInfo {
    if (_self.organizationInfo == null) {
    return null;
  }

  return $OrganizationInfoCopyWith<$Res>(_self.organizationInfo!, (value) {
    return _then(_self.copyWith(organizationInfo: value));
  });
}
}


/// @nodoc
mixin _$EmployeeInfo {

 int get organizationId; String get organizationName; String get department; String get position; String get employeeCode; int get pointsBalance;
/// Create a copy of EmployeeInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeInfoCopyWith<EmployeeInfo> get copyWith => _$EmployeeInfoCopyWithImpl<EmployeeInfo>(this as EmployeeInfo, _$identity);

  /// Serializes this EmployeeInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeInfo&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,organizationName,department,position,employeeCode,pointsBalance);

@override
String toString() {
  return 'EmployeeInfo(organizationId: $organizationId, organizationName: $organizationName, department: $department, position: $position, employeeCode: $employeeCode, pointsBalance: $pointsBalance)';
}


}

/// @nodoc
abstract mixin class $EmployeeInfoCopyWith<$Res>  {
  factory $EmployeeInfoCopyWith(EmployeeInfo value, $Res Function(EmployeeInfo) _then) = _$EmployeeInfoCopyWithImpl;
@useResult
$Res call({
 int organizationId, String organizationName, String department, String position, String employeeCode, int pointsBalance
});




}
/// @nodoc
class _$EmployeeInfoCopyWithImpl<$Res>
    implements $EmployeeInfoCopyWith<$Res> {
  _$EmployeeInfoCopyWithImpl(this._self, this._then);

  final EmployeeInfo _self;
  final $Res Function(EmployeeInfo) _then;

/// Create a copy of EmployeeInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizationId = null,Object? organizationName = null,Object? department = null,Object? position = null,Object? employeeCode = null,Object? pointsBalance = null,}) {
  return _then(_self.copyWith(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int,organizationName: null == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeeInfo].
extension EmployeeInfoPatterns on EmployeeInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeInfo value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int organizationId,  String organizationName,  String department,  String position,  String employeeCode,  int pointsBalance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeInfo() when $default != null:
return $default(_that.organizationId,_that.organizationName,_that.department,_that.position,_that.employeeCode,_that.pointsBalance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int organizationId,  String organizationName,  String department,  String position,  String employeeCode,  int pointsBalance)  $default,) {final _that = this;
switch (_that) {
case _EmployeeInfo():
return $default(_that.organizationId,_that.organizationName,_that.department,_that.position,_that.employeeCode,_that.pointsBalance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int organizationId,  String organizationName,  String department,  String position,  String employeeCode,  int pointsBalance)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeInfo() when $default != null:
return $default(_that.organizationId,_that.organizationName,_that.department,_that.position,_that.employeeCode,_that.pointsBalance);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeInfo implements EmployeeInfo {
  const _EmployeeInfo({required this.organizationId, required this.organizationName, required this.department, required this.position, required this.employeeCode, required this.pointsBalance});
  factory _EmployeeInfo.fromJson(Map<String, dynamic> json) => _$EmployeeInfoFromJson(json);

@override final  int organizationId;
@override final  String organizationName;
@override final  String department;
@override final  String position;
@override final  String employeeCode;
@override final  int pointsBalance;

/// Create a copy of EmployeeInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeInfoCopyWith<_EmployeeInfo> get copyWith => __$EmployeeInfoCopyWithImpl<_EmployeeInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeInfo&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,organizationName,department,position,employeeCode,pointsBalance);

@override
String toString() {
  return 'EmployeeInfo(organizationId: $organizationId, organizationName: $organizationName, department: $department, position: $position, employeeCode: $employeeCode, pointsBalance: $pointsBalance)';
}


}

/// @nodoc
abstract mixin class _$EmployeeInfoCopyWith<$Res> implements $EmployeeInfoCopyWith<$Res> {
  factory _$EmployeeInfoCopyWith(_EmployeeInfo value, $Res Function(_EmployeeInfo) _then) = __$EmployeeInfoCopyWithImpl;
@override @useResult
$Res call({
 int organizationId, String organizationName, String department, String position, String employeeCode, int pointsBalance
});




}
/// @nodoc
class __$EmployeeInfoCopyWithImpl<$Res>
    implements _$EmployeeInfoCopyWith<$Res> {
  __$EmployeeInfoCopyWithImpl(this._self, this._then);

  final _EmployeeInfo _self;
  final $Res Function(_EmployeeInfo) _then;

/// Create a copy of EmployeeInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizationId = null,Object? organizationName = null,Object? department = null,Object? position = null,Object? employeeCode = null,Object? pointsBalance = null,}) {
  return _then(_EmployeeInfo(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int,organizationName: null == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$VendorInfo {

 String get businessName; String get category; String get approvalStatus; bool get isActive;
/// Create a copy of VendorInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VendorInfoCopyWith<VendorInfo> get copyWith => _$VendorInfoCopyWithImpl<VendorInfo>(this as VendorInfo, _$identity);

  /// Serializes this VendorInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VendorInfo&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.category, category) || other.category == category)&&(identical(other.approvalStatus, approvalStatus) || other.approvalStatus == approvalStatus)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,businessName,category,approvalStatus,isActive);

@override
String toString() {
  return 'VendorInfo(businessName: $businessName, category: $category, approvalStatus: $approvalStatus, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $VendorInfoCopyWith<$Res>  {
  factory $VendorInfoCopyWith(VendorInfo value, $Res Function(VendorInfo) _then) = _$VendorInfoCopyWithImpl;
@useResult
$Res call({
 String businessName, String category, String approvalStatus, bool isActive
});




}
/// @nodoc
class _$VendorInfoCopyWithImpl<$Res>
    implements $VendorInfoCopyWith<$Res> {
  _$VendorInfoCopyWithImpl(this._self, this._then);

  final VendorInfo _self;
  final $Res Function(VendorInfo) _then;

/// Create a copy of VendorInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? businessName = null,Object? category = null,Object? approvalStatus = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,approvalStatus: null == approvalStatus ? _self.approvalStatus : approvalStatus // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VendorInfo].
extension VendorInfoPatterns on VendorInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VendorInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VendorInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VendorInfo value)  $default,){
final _that = this;
switch (_that) {
case _VendorInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VendorInfo value)?  $default,){
final _that = this;
switch (_that) {
case _VendorInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String businessName,  String category,  String approvalStatus,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VendorInfo() when $default != null:
return $default(_that.businessName,_that.category,_that.approvalStatus,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String businessName,  String category,  String approvalStatus,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _VendorInfo():
return $default(_that.businessName,_that.category,_that.approvalStatus,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String businessName,  String category,  String approvalStatus,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _VendorInfo() when $default != null:
return $default(_that.businessName,_that.category,_that.approvalStatus,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VendorInfo implements VendorInfo {
  const _VendorInfo({required this.businessName, required this.category, required this.approvalStatus, required this.isActive});
  factory _VendorInfo.fromJson(Map<String, dynamic> json) => _$VendorInfoFromJson(json);

@override final  String businessName;
@override final  String category;
@override final  String approvalStatus;
@override final  bool isActive;

/// Create a copy of VendorInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VendorInfoCopyWith<_VendorInfo> get copyWith => __$VendorInfoCopyWithImpl<_VendorInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VendorInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VendorInfo&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.category, category) || other.category == category)&&(identical(other.approvalStatus, approvalStatus) || other.approvalStatus == approvalStatus)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,businessName,category,approvalStatus,isActive);

@override
String toString() {
  return 'VendorInfo(businessName: $businessName, category: $category, approvalStatus: $approvalStatus, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$VendorInfoCopyWith<$Res> implements $VendorInfoCopyWith<$Res> {
  factory _$VendorInfoCopyWith(_VendorInfo value, $Res Function(_VendorInfo) _then) = __$VendorInfoCopyWithImpl;
@override @useResult
$Res call({
 String businessName, String category, String approvalStatus, bool isActive
});




}
/// @nodoc
class __$VendorInfoCopyWithImpl<$Res>
    implements _$VendorInfoCopyWith<$Res> {
  __$VendorInfoCopyWithImpl(this._self, this._then);

  final _VendorInfo _self;
  final $Res Function(_VendorInfo) _then;

/// Create a copy of VendorInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? businessName = null,Object? category = null,Object? approvalStatus = null,Object? isActive = null,}) {
  return _then(_VendorInfo(
businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,approvalStatus: null == approvalStatus ? _self.approvalStatus : approvalStatus // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$OrganizationInfo {

 int get organizationId; String get organizationName; String get position;
/// Create a copy of OrganizationInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizationInfoCopyWith<OrganizationInfo> get copyWith => _$OrganizationInfoCopyWithImpl<OrganizationInfo>(this as OrganizationInfo, _$identity);

  /// Serializes this OrganizationInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizationInfo&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,organizationName,position);

@override
String toString() {
  return 'OrganizationInfo(organizationId: $organizationId, organizationName: $organizationName, position: $position)';
}


}

/// @nodoc
abstract mixin class $OrganizationInfoCopyWith<$Res>  {
  factory $OrganizationInfoCopyWith(OrganizationInfo value, $Res Function(OrganizationInfo) _then) = _$OrganizationInfoCopyWithImpl;
@useResult
$Res call({
 int organizationId, String organizationName, String position
});




}
/// @nodoc
class _$OrganizationInfoCopyWithImpl<$Res>
    implements $OrganizationInfoCopyWith<$Res> {
  _$OrganizationInfoCopyWithImpl(this._self, this._then);

  final OrganizationInfo _self;
  final $Res Function(OrganizationInfo) _then;

/// Create a copy of OrganizationInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? organizationId = null,Object? organizationName = null,Object? position = null,}) {
  return _then(_self.copyWith(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int,organizationName: null == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrganizationInfo].
extension OrganizationInfoPatterns on OrganizationInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrganizationInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrganizationInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrganizationInfo value)  $default,){
final _that = this;
switch (_that) {
case _OrganizationInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrganizationInfo value)?  $default,){
final _that = this;
switch (_that) {
case _OrganizationInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int organizationId,  String organizationName,  String position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrganizationInfo() when $default != null:
return $default(_that.organizationId,_that.organizationName,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int organizationId,  String organizationName,  String position)  $default,) {final _that = this;
switch (_that) {
case _OrganizationInfo():
return $default(_that.organizationId,_that.organizationName,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int organizationId,  String organizationName,  String position)?  $default,) {final _that = this;
switch (_that) {
case _OrganizationInfo() when $default != null:
return $default(_that.organizationId,_that.organizationName,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrganizationInfo implements OrganizationInfo {
  const _OrganizationInfo({required this.organizationId, required this.organizationName, required this.position});
  factory _OrganizationInfo.fromJson(Map<String, dynamic> json) => _$OrganizationInfoFromJson(json);

@override final  int organizationId;
@override final  String organizationName;
@override final  String position;

/// Create a copy of OrganizationInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizationInfoCopyWith<_OrganizationInfo> get copyWith => __$OrganizationInfoCopyWithImpl<_OrganizationInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrganizationInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrganizationInfo&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,organizationId,organizationName,position);

@override
String toString() {
  return 'OrganizationInfo(organizationId: $organizationId, organizationName: $organizationName, position: $position)';
}


}

/// @nodoc
abstract mixin class _$OrganizationInfoCopyWith<$Res> implements $OrganizationInfoCopyWith<$Res> {
  factory _$OrganizationInfoCopyWith(_OrganizationInfo value, $Res Function(_OrganizationInfo) _then) = __$OrganizationInfoCopyWithImpl;
@override @useResult
$Res call({
 int organizationId, String organizationName, String position
});




}
/// @nodoc
class __$OrganizationInfoCopyWithImpl<$Res>
    implements _$OrganizationInfoCopyWith<$Res> {
  __$OrganizationInfoCopyWithImpl(this._self, this._then);

  final _OrganizationInfo _self;
  final $Res Function(_OrganizationInfo) _then;

/// Create a copy of OrganizationInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? organizationId = null,Object? organizationName = null,Object? position = null,}) {
  return _then(_OrganizationInfo(
organizationId: null == organizationId ? _self.organizationId : organizationId // ignore: cast_nullable_to_non_nullable
as int,organizationName: null == organizationName ? _self.organizationName : organizationName // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UpdateUserProfileRequest3 {

 String? get firstName; String? get lastName; String? get email; String? get profileImageUrl;
/// Create a copy of UpdateUserProfileRequest3
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateUserProfileRequest3CopyWith<UpdateUserProfileRequest3> get copyWith => _$UpdateUserProfileRequest3CopyWithImpl<UpdateUserProfileRequest3>(this as UpdateUserProfileRequest3, _$identity);

  /// Serializes this UpdateUserProfileRequest3 to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserProfileRequest3&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,email,profileImageUrl);

@override
String toString() {
  return 'UpdateUserProfileRequest3(firstName: $firstName, lastName: $lastName, email: $email, profileImageUrl: $profileImageUrl)';
}


}

/// @nodoc
abstract mixin class $UpdateUserProfileRequest3CopyWith<$Res>  {
  factory $UpdateUserProfileRequest3CopyWith(UpdateUserProfileRequest3 value, $Res Function(UpdateUserProfileRequest3) _then) = _$UpdateUserProfileRequest3CopyWithImpl;
@useResult
$Res call({
 String? firstName, String? lastName, String? email, String? profileImageUrl
});




}
/// @nodoc
class _$UpdateUserProfileRequest3CopyWithImpl<$Res>
    implements $UpdateUserProfileRequest3CopyWith<$Res> {
  _$UpdateUserProfileRequest3CopyWithImpl(this._self, this._then);

  final UpdateUserProfileRequest3 _self;
  final $Res Function(UpdateUserProfileRequest3) _then;

/// Create a copy of UpdateUserProfileRequest3
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? email = freezed,Object? profileImageUrl = freezed,}) {
  return _then(_self.copyWith(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateUserProfileRequest3].
extension UpdateUserProfileRequest3Patterns on UpdateUserProfileRequest3 {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateUserProfileRequest3 value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateUserProfileRequest3() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateUserProfileRequest3 value)  $default,){
final _that = this;
switch (_that) {
case _UpdateUserProfileRequest3():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateUserProfileRequest3 value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateUserProfileRequest3() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? firstName,  String? lastName,  String? email,  String? profileImageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateUserProfileRequest3() when $default != null:
return $default(_that.firstName,_that.lastName,_that.email,_that.profileImageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? firstName,  String? lastName,  String? email,  String? profileImageUrl)  $default,) {final _that = this;
switch (_that) {
case _UpdateUserProfileRequest3():
return $default(_that.firstName,_that.lastName,_that.email,_that.profileImageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? firstName,  String? lastName,  String? email,  String? profileImageUrl)?  $default,) {final _that = this;
switch (_that) {
case _UpdateUserProfileRequest3() when $default != null:
return $default(_that.firstName,_that.lastName,_that.email,_that.profileImageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateUserProfileRequest3 implements UpdateUserProfileRequest3 {
  const _UpdateUserProfileRequest3({this.firstName, this.lastName, this.email, this.profileImageUrl});
  factory _UpdateUserProfileRequest3.fromJson(Map<String, dynamic> json) => _$UpdateUserProfileRequest3FromJson(json);

@override final  String? firstName;
@override final  String? lastName;
@override final  String? email;
@override final  String? profileImageUrl;

/// Create a copy of UpdateUserProfileRequest3
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateUserProfileRequest3CopyWith<_UpdateUserProfileRequest3> get copyWith => __$UpdateUserProfileRequest3CopyWithImpl<_UpdateUserProfileRequest3>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateUserProfileRequest3ToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUserProfileRequest3&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,email,profileImageUrl);

@override
String toString() {
  return 'UpdateUserProfileRequest3(firstName: $firstName, lastName: $lastName, email: $email, profileImageUrl: $profileImageUrl)';
}


}

/// @nodoc
abstract mixin class _$UpdateUserProfileRequest3CopyWith<$Res> implements $UpdateUserProfileRequest3CopyWith<$Res> {
  factory _$UpdateUserProfileRequest3CopyWith(_UpdateUserProfileRequest3 value, $Res Function(_UpdateUserProfileRequest3) _then) = __$UpdateUserProfileRequest3CopyWithImpl;
@override @useResult
$Res call({
 String? firstName, String? lastName, String? email, String? profileImageUrl
});




}
/// @nodoc
class __$UpdateUserProfileRequest3CopyWithImpl<$Res>
    implements _$UpdateUserProfileRequest3CopyWith<$Res> {
  __$UpdateUserProfileRequest3CopyWithImpl(this._self, this._then);

  final _UpdateUserProfileRequest3 _self;
  final $Res Function(_UpdateUserProfileRequest3) _then;

/// Create a copy of UpdateUserProfileRequest3
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = freezed,Object? lastName = freezed,Object? email = freezed,Object? profileImageUrl = freezed,}) {
  return _then(_UpdateUserProfileRequest3(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
