// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get id; String get email; String get firebaseUid; String? get firstName; String? get lastName; int? get organizationId; String? get organizationName; int get pointsBalance; DateTime? get pointsExpiry; bool get isActive; DateTime? get createdAt; bool get isEmployee; String? get employeeCode; String? get department; String? get position; DateTime? get joinDate;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isEmployee, isEmployee) || other.isEmployee == isEmployee)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.joinDate, joinDate) || other.joinDate == joinDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firebaseUid,firstName,lastName,organizationId,organizationName,pointsBalance,pointsExpiry,isActive,createdAt,isEmployee,employeeCode,department,position,joinDate);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, firebaseUid: $firebaseUid, firstName: $firstName, lastName: $lastName, organizationId: $organizationId, organizationName: $organizationName, pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry, isActive: $isActive, createdAt: $createdAt, isEmployee: $isEmployee, employeeCode: $employeeCode, department: $department, position: $position, joinDate: $joinDate)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String email, String firebaseUid, String? firstName, String? lastName, int? organizationId, String? organizationName, int pointsBalance, DateTime? pointsExpiry, bool isActive, DateTime? createdAt, bool isEmployee, String? employeeCode, String? department, String? position, DateTime? joinDate
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? firebaseUid = null,Object? firstName = freezed,Object? lastName = freezed,Object? organizationId = freezed,Object? organizationName = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = null,Object? createdAt = freezed,Object? isEmployee = null,Object? employeeCode = freezed,Object? department = freezed,Object? position = freezed,Object? joinDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firebaseUid: null == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String firebaseUid,  String? firstName,  String? lastName,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime? createdAt,  bool isEmployee,  String? employeeCode,  String? department,  String? position,  DateTime? joinDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.firebaseUid,_that.firstName,_that.lastName,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.isEmployee,_that.employeeCode,_that.department,_that.position,_that.joinDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String firebaseUid,  String? firstName,  String? lastName,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime? createdAt,  bool isEmployee,  String? employeeCode,  String? department,  String? position,  DateTime? joinDate)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.email,_that.firebaseUid,_that.firstName,_that.lastName,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.isEmployee,_that.employeeCode,_that.department,_that.position,_that.joinDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String firebaseUid,  String? firstName,  String? lastName,  int? organizationId,  String? organizationName,  int pointsBalance,  DateTime? pointsExpiry,  bool isActive,  DateTime? createdAt,  bool isEmployee,  String? employeeCode,  String? department,  String? position,  DateTime? joinDate)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.firebaseUid,_that.firstName,_that.lastName,_that.organizationId,_that.organizationName,_that.pointsBalance,_that.pointsExpiry,_that.isActive,_that.createdAt,_that.isEmployee,_that.employeeCode,_that.department,_that.position,_that.joinDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel extends UserModel {
  const _UserModel({required this.id, required this.email, required this.firebaseUid, this.firstName, this.lastName, this.organizationId, this.organizationName, this.pointsBalance = 0, this.pointsExpiry, this.isActive = true, this.createdAt, this.isEmployee = false, this.employeeCode, this.department, this.position, this.joinDate}): super._();
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String id;
@override final  String email;
@override final  String firebaseUid;
@override final  String? firstName;
@override final  String? lastName;
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

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.organizationId, organizationId) || other.organizationId == organizationId)&&(identical(other.organizationName, organizationName) || other.organizationName == organizationName)&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isEmployee, isEmployee) || other.isEmployee == isEmployee)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.joinDate, joinDate) || other.joinDate == joinDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firebaseUid,firstName,lastName,organizationId,organizationName,pointsBalance,pointsExpiry,isActive,createdAt,isEmployee,employeeCode,department,position,joinDate);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, firebaseUid: $firebaseUid, firstName: $firstName, lastName: $lastName, organizationId: $organizationId, organizationName: $organizationName, pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry, isActive: $isActive, createdAt: $createdAt, isEmployee: $isEmployee, employeeCode: $employeeCode, department: $department, position: $position, joinDate: $joinDate)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String firebaseUid, String? firstName, String? lastName, int? organizationId, String? organizationName, int pointsBalance, DateTime? pointsExpiry, bool isActive, DateTime? createdAt, bool isEmployee, String? employeeCode, String? department, String? position, DateTime? joinDate
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? firebaseUid = null,Object? firstName = freezed,Object? lastName = freezed,Object? organizationId = freezed,Object? organizationName = freezed,Object? pointsBalance = null,Object? pointsExpiry = freezed,Object? isActive = null,Object? createdAt = freezed,Object? isEmployee = null,Object? employeeCode = freezed,Object? department = freezed,Object? position = freezed,Object? joinDate = freezed,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firebaseUid: null == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
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

// dart format on
