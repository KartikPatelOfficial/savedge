// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coupon_gifting_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ColleagueModel {

 String get userId; String get email; String get employeeCode; String get department; String get position; String get firstName; String get lastName;
/// Create a copy of ColleagueModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ColleagueModelCopyWith<ColleagueModel> get copyWith => _$ColleagueModelCopyWithImpl<ColleagueModel>(this as ColleagueModel, _$identity);

  /// Serializes this ColleagueModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ColleagueModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email,employeeCode,department,position,firstName,lastName);

@override
String toString() {
  return 'ColleagueModel(userId: $userId, email: $email, employeeCode: $employeeCode, department: $department, position: $position, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class $ColleagueModelCopyWith<$Res>  {
  factory $ColleagueModelCopyWith(ColleagueModel value, $Res Function(ColleagueModel) _then) = _$ColleagueModelCopyWithImpl;
@useResult
$Res call({
 String userId, String email, String employeeCode, String department, String position, String firstName, String lastName
});




}
/// @nodoc
class _$ColleagueModelCopyWithImpl<$Res>
    implements $ColleagueModelCopyWith<$Res> {
  _$ColleagueModelCopyWithImpl(this._self, this._then);

  final ColleagueModel _self;
  final $Res Function(ColleagueModel) _then;

/// Create a copy of ColleagueModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? email = null,Object? employeeCode = null,Object? department = null,Object? position = null,Object? firstName = null,Object? lastName = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ColleagueModel].
extension ColleagueModelPatterns on ColleagueModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ColleagueModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ColleagueModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ColleagueModel value)  $default,){
final _that = this;
switch (_that) {
case _ColleagueModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ColleagueModel value)?  $default,){
final _that = this;
switch (_that) {
case _ColleagueModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String email,  String employeeCode,  String department,  String position,  String firstName,  String lastName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ColleagueModel() when $default != null:
return $default(_that.userId,_that.email,_that.employeeCode,_that.department,_that.position,_that.firstName,_that.lastName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String email,  String employeeCode,  String department,  String position,  String firstName,  String lastName)  $default,) {final _that = this;
switch (_that) {
case _ColleagueModel():
return $default(_that.userId,_that.email,_that.employeeCode,_that.department,_that.position,_that.firstName,_that.lastName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String email,  String employeeCode,  String department,  String position,  String firstName,  String lastName)?  $default,) {final _that = this;
switch (_that) {
case _ColleagueModel() when $default != null:
return $default(_that.userId,_that.email,_that.employeeCode,_that.department,_that.position,_that.firstName,_that.lastName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ColleagueModel implements ColleagueModel {
  const _ColleagueModel({required this.userId, required this.email, required this.employeeCode, required this.department, required this.position, required this.firstName, required this.lastName});
  factory _ColleagueModel.fromJson(Map<String, dynamic> json) => _$ColleagueModelFromJson(json);

@override final  String userId;
@override final  String email;
@override final  String employeeCode;
@override final  String department;
@override final  String position;
@override final  String firstName;
@override final  String lastName;

/// Create a copy of ColleagueModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ColleagueModelCopyWith<_ColleagueModel> get copyWith => __$ColleagueModelCopyWithImpl<_ColleagueModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ColleagueModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ColleagueModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.employeeCode, employeeCode) || other.employeeCode == employeeCode)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email,employeeCode,department,position,firstName,lastName);

@override
String toString() {
  return 'ColleagueModel(userId: $userId, email: $email, employeeCode: $employeeCode, department: $department, position: $position, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class _$ColleagueModelCopyWith<$Res> implements $ColleagueModelCopyWith<$Res> {
  factory _$ColleagueModelCopyWith(_ColleagueModel value, $Res Function(_ColleagueModel) _then) = __$ColleagueModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String email, String employeeCode, String department, String position, String firstName, String lastName
});




}
/// @nodoc
class __$ColleagueModelCopyWithImpl<$Res>
    implements _$ColleagueModelCopyWith<$Res> {
  __$ColleagueModelCopyWithImpl(this._self, this._then);

  final _ColleagueModel _self;
  final $Res Function(_ColleagueModel) _then;

/// Create a copy of ColleagueModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? email = null,Object? employeeCode = null,Object? department = null,Object? position = null,Object? firstName = null,Object? lastName = null,}) {
  return _then(_ColleagueModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,employeeCode: null == employeeCode ? _self.employeeCode : employeeCode // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GiftCouponRequest {

 int get userCouponId; String get toUserId; String? get message;
/// Create a copy of GiftCouponRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftCouponRequestCopyWith<GiftCouponRequest> get copyWith => _$GiftCouponRequestCopyWithImpl<GiftCouponRequest>(this as GiftCouponRequest, _$identity);

  /// Serializes this GiftCouponRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftCouponRequest&&(identical(other.userCouponId, userCouponId) || other.userCouponId == userCouponId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userCouponId,toUserId,message);

@override
String toString() {
  return 'GiftCouponRequest(userCouponId: $userCouponId, toUserId: $toUserId, message: $message)';
}


}

/// @nodoc
abstract mixin class $GiftCouponRequestCopyWith<$Res>  {
  factory $GiftCouponRequestCopyWith(GiftCouponRequest value, $Res Function(GiftCouponRequest) _then) = _$GiftCouponRequestCopyWithImpl;
@useResult
$Res call({
 int userCouponId, String toUserId, String? message
});




}
/// @nodoc
class _$GiftCouponRequestCopyWithImpl<$Res>
    implements $GiftCouponRequestCopyWith<$Res> {
  _$GiftCouponRequestCopyWithImpl(this._self, this._then);

  final GiftCouponRequest _self;
  final $Res Function(GiftCouponRequest) _then;

/// Create a copy of GiftCouponRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userCouponId = null,Object? toUserId = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
userCouponId: null == userCouponId ? _self.userCouponId : userCouponId // ignore: cast_nullable_to_non_nullable
as int,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftCouponRequest].
extension GiftCouponRequestPatterns on GiftCouponRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftCouponRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftCouponRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftCouponRequest value)  $default,){
final _that = this;
switch (_that) {
case _GiftCouponRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftCouponRequest value)?  $default,){
final _that = this;
switch (_that) {
case _GiftCouponRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int userCouponId,  String toUserId,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftCouponRequest() when $default != null:
return $default(_that.userCouponId,_that.toUserId,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int userCouponId,  String toUserId,  String? message)  $default,) {final _that = this;
switch (_that) {
case _GiftCouponRequest():
return $default(_that.userCouponId,_that.toUserId,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int userCouponId,  String toUserId,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _GiftCouponRequest() when $default != null:
return $default(_that.userCouponId,_that.toUserId,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftCouponRequest implements GiftCouponRequest {
  const _GiftCouponRequest({required this.userCouponId, required this.toUserId, this.message});
  factory _GiftCouponRequest.fromJson(Map<String, dynamic> json) => _$GiftCouponRequestFromJson(json);

@override final  int userCouponId;
@override final  String toUserId;
@override final  String? message;

/// Create a copy of GiftCouponRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftCouponRequestCopyWith<_GiftCouponRequest> get copyWith => __$GiftCouponRequestCopyWithImpl<_GiftCouponRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftCouponRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftCouponRequest&&(identical(other.userCouponId, userCouponId) || other.userCouponId == userCouponId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userCouponId,toUserId,message);

@override
String toString() {
  return 'GiftCouponRequest(userCouponId: $userCouponId, toUserId: $toUserId, message: $message)';
}


}

/// @nodoc
abstract mixin class _$GiftCouponRequestCopyWith<$Res> implements $GiftCouponRequestCopyWith<$Res> {
  factory _$GiftCouponRequestCopyWith(_GiftCouponRequest value, $Res Function(_GiftCouponRequest) _then) = __$GiftCouponRequestCopyWithImpl;
@override @useResult
$Res call({
 int userCouponId, String toUserId, String? message
});




}
/// @nodoc
class __$GiftCouponRequestCopyWithImpl<$Res>
    implements _$GiftCouponRequestCopyWith<$Res> {
  __$GiftCouponRequestCopyWithImpl(this._self, this._then);

  final _GiftCouponRequest _self;
  final $Res Function(_GiftCouponRequest) _then;

/// Create a copy of GiftCouponRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userCouponId = null,Object? toUserId = null,Object? message = freezed,}) {
  return _then(_GiftCouponRequest(
userCouponId: null == userCouponId ? _self.userCouponId : userCouponId // ignore: cast_nullable_to_non_nullable
as int,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GiftCouponResponse {

 bool get success; String get message; int get giftedCouponId; String get uniqueCode;
/// Create a copy of GiftCouponResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftCouponResponseCopyWith<GiftCouponResponse> get copyWith => _$GiftCouponResponseCopyWithImpl<GiftCouponResponse>(this as GiftCouponResponse, _$identity);

  /// Serializes this GiftCouponResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftCouponResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.giftedCouponId, giftedCouponId) || other.giftedCouponId == giftedCouponId)&&(identical(other.uniqueCode, uniqueCode) || other.uniqueCode == uniqueCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,giftedCouponId,uniqueCode);

@override
String toString() {
  return 'GiftCouponResponse(success: $success, message: $message, giftedCouponId: $giftedCouponId, uniqueCode: $uniqueCode)';
}


}

/// @nodoc
abstract mixin class $GiftCouponResponseCopyWith<$Res>  {
  factory $GiftCouponResponseCopyWith(GiftCouponResponse value, $Res Function(GiftCouponResponse) _then) = _$GiftCouponResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, int giftedCouponId, String uniqueCode
});




}
/// @nodoc
class _$GiftCouponResponseCopyWithImpl<$Res>
    implements $GiftCouponResponseCopyWith<$Res> {
  _$GiftCouponResponseCopyWithImpl(this._self, this._then);

  final GiftCouponResponse _self;
  final $Res Function(GiftCouponResponse) _then;

/// Create a copy of GiftCouponResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? giftedCouponId = null,Object? uniqueCode = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,giftedCouponId: null == giftedCouponId ? _self.giftedCouponId : giftedCouponId // ignore: cast_nullable_to_non_nullable
as int,uniqueCode: null == uniqueCode ? _self.uniqueCode : uniqueCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftCouponResponse].
extension GiftCouponResponsePatterns on GiftCouponResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftCouponResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftCouponResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftCouponResponse value)  $default,){
final _that = this;
switch (_that) {
case _GiftCouponResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftCouponResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GiftCouponResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  int giftedCouponId,  String uniqueCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftCouponResponse() when $default != null:
return $default(_that.success,_that.message,_that.giftedCouponId,_that.uniqueCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  int giftedCouponId,  String uniqueCode)  $default,) {final _that = this;
switch (_that) {
case _GiftCouponResponse():
return $default(_that.success,_that.message,_that.giftedCouponId,_that.uniqueCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  int giftedCouponId,  String uniqueCode)?  $default,) {final _that = this;
switch (_that) {
case _GiftCouponResponse() when $default != null:
return $default(_that.success,_that.message,_that.giftedCouponId,_that.uniqueCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftCouponResponse implements GiftCouponResponse {
  const _GiftCouponResponse({required this.success, required this.message, required this.giftedCouponId, required this.uniqueCode});
  factory _GiftCouponResponse.fromJson(Map<String, dynamic> json) => _$GiftCouponResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  int giftedCouponId;
@override final  String uniqueCode;

/// Create a copy of GiftCouponResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftCouponResponseCopyWith<_GiftCouponResponse> get copyWith => __$GiftCouponResponseCopyWithImpl<_GiftCouponResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftCouponResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftCouponResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.giftedCouponId, giftedCouponId) || other.giftedCouponId == giftedCouponId)&&(identical(other.uniqueCode, uniqueCode) || other.uniqueCode == uniqueCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,giftedCouponId,uniqueCode);

@override
String toString() {
  return 'GiftCouponResponse(success: $success, message: $message, giftedCouponId: $giftedCouponId, uniqueCode: $uniqueCode)';
}


}

/// @nodoc
abstract mixin class _$GiftCouponResponseCopyWith<$Res> implements $GiftCouponResponseCopyWith<$Res> {
  factory _$GiftCouponResponseCopyWith(_GiftCouponResponse value, $Res Function(_GiftCouponResponse) _then) = __$GiftCouponResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, int giftedCouponId, String uniqueCode
});




}
/// @nodoc
class __$GiftCouponResponseCopyWithImpl<$Res>
    implements _$GiftCouponResponseCopyWith<$Res> {
  __$GiftCouponResponseCopyWithImpl(this._self, this._then);

  final _GiftCouponResponse _self;
  final $Res Function(_GiftCouponResponse) _then;

/// Create a copy of GiftCouponResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? giftedCouponId = null,Object? uniqueCode = null,}) {
  return _then(_GiftCouponResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,giftedCouponId: null == giftedCouponId ? _self.giftedCouponId : giftedCouponId // ignore: cast_nullable_to_non_nullable
as int,uniqueCode: null == uniqueCode ? _self.uniqueCode : uniqueCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TransferPointsRequest {

 String get toUserId; int get points; String? get message;
/// Create a copy of TransferPointsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferPointsRequestCopyWith<TransferPointsRequest> get copyWith => _$TransferPointsRequestCopyWithImpl<TransferPointsRequest>(this as TransferPointsRequest, _$identity);

  /// Serializes this TransferPointsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferPointsRequest&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.points, points) || other.points == points)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,toUserId,points,message);

@override
String toString() {
  return 'TransferPointsRequest(toUserId: $toUserId, points: $points, message: $message)';
}


}

/// @nodoc
abstract mixin class $TransferPointsRequestCopyWith<$Res>  {
  factory $TransferPointsRequestCopyWith(TransferPointsRequest value, $Res Function(TransferPointsRequest) _then) = _$TransferPointsRequestCopyWithImpl;
@useResult
$Res call({
 String toUserId, int points, String? message
});




}
/// @nodoc
class _$TransferPointsRequestCopyWithImpl<$Res>
    implements $TransferPointsRequestCopyWith<$Res> {
  _$TransferPointsRequestCopyWithImpl(this._self, this._then);

  final TransferPointsRequest _self;
  final $Res Function(TransferPointsRequest) _then;

/// Create a copy of TransferPointsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? toUserId = null,Object? points = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferPointsRequest].
extension TransferPointsRequestPatterns on TransferPointsRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferPointsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferPointsRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferPointsRequest value)  $default,){
final _that = this;
switch (_that) {
case _TransferPointsRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferPointsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TransferPointsRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String toUserId,  int points,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferPointsRequest() when $default != null:
return $default(_that.toUserId,_that.points,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String toUserId,  int points,  String? message)  $default,) {final _that = this;
switch (_that) {
case _TransferPointsRequest():
return $default(_that.toUserId,_that.points,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String toUserId,  int points,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _TransferPointsRequest() when $default != null:
return $default(_that.toUserId,_that.points,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferPointsRequest implements TransferPointsRequest {
  const _TransferPointsRequest({required this.toUserId, required this.points, this.message});
  factory _TransferPointsRequest.fromJson(Map<String, dynamic> json) => _$TransferPointsRequestFromJson(json);

@override final  String toUserId;
@override final  int points;
@override final  String? message;

/// Create a copy of TransferPointsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferPointsRequestCopyWith<_TransferPointsRequest> get copyWith => __$TransferPointsRequestCopyWithImpl<_TransferPointsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferPointsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferPointsRequest&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.points, points) || other.points == points)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,toUserId,points,message);

@override
String toString() {
  return 'TransferPointsRequest(toUserId: $toUserId, points: $points, message: $message)';
}


}

/// @nodoc
abstract mixin class _$TransferPointsRequestCopyWith<$Res> implements $TransferPointsRequestCopyWith<$Res> {
  factory _$TransferPointsRequestCopyWith(_TransferPointsRequest value, $Res Function(_TransferPointsRequest) _then) = __$TransferPointsRequestCopyWithImpl;
@override @useResult
$Res call({
 String toUserId, int points, String? message
});




}
/// @nodoc
class __$TransferPointsRequestCopyWithImpl<$Res>
    implements _$TransferPointsRequestCopyWith<$Res> {
  __$TransferPointsRequestCopyWithImpl(this._self, this._then);

  final _TransferPointsRequest _self;
  final $Res Function(_TransferPointsRequest) _then;

/// Create a copy of TransferPointsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? toUserId = null,Object? points = null,Object? message = freezed,}) {
  return _then(_TransferPointsRequest(
toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TransferPointsResponse {

 bool get success; String get message; String get transferReference; int get transferredPoints;
/// Create a copy of TransferPointsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferPointsResponseCopyWith<TransferPointsResponse> get copyWith => _$TransferPointsResponseCopyWithImpl<TransferPointsResponse>(this as TransferPointsResponse, _$identity);

  /// Serializes this TransferPointsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferPointsResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.transferReference, transferReference) || other.transferReference == transferReference)&&(identical(other.transferredPoints, transferredPoints) || other.transferredPoints == transferredPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,transferReference,transferredPoints);

@override
String toString() {
  return 'TransferPointsResponse(success: $success, message: $message, transferReference: $transferReference, transferredPoints: $transferredPoints)';
}


}

/// @nodoc
abstract mixin class $TransferPointsResponseCopyWith<$Res>  {
  factory $TransferPointsResponseCopyWith(TransferPointsResponse value, $Res Function(TransferPointsResponse) _then) = _$TransferPointsResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, String transferReference, int transferredPoints
});




}
/// @nodoc
class _$TransferPointsResponseCopyWithImpl<$Res>
    implements $TransferPointsResponseCopyWith<$Res> {
  _$TransferPointsResponseCopyWithImpl(this._self, this._then);

  final TransferPointsResponse _self;
  final $Res Function(TransferPointsResponse) _then;

/// Create a copy of TransferPointsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? transferReference = null,Object? transferredPoints = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,transferReference: null == transferReference ? _self.transferReference : transferReference // ignore: cast_nullable_to_non_nullable
as String,transferredPoints: null == transferredPoints ? _self.transferredPoints : transferredPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferPointsResponse].
extension TransferPointsResponsePatterns on TransferPointsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferPointsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferPointsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferPointsResponse value)  $default,){
final _that = this;
switch (_that) {
case _TransferPointsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferPointsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TransferPointsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  String transferReference,  int transferredPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferPointsResponse() when $default != null:
return $default(_that.success,_that.message,_that.transferReference,_that.transferredPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  String transferReference,  int transferredPoints)  $default,) {final _that = this;
switch (_that) {
case _TransferPointsResponse():
return $default(_that.success,_that.message,_that.transferReference,_that.transferredPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  String transferReference,  int transferredPoints)?  $default,) {final _that = this;
switch (_that) {
case _TransferPointsResponse() when $default != null:
return $default(_that.success,_that.message,_that.transferReference,_that.transferredPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferPointsResponse implements TransferPointsResponse {
  const _TransferPointsResponse({required this.success, required this.message, required this.transferReference, required this.transferredPoints});
  factory _TransferPointsResponse.fromJson(Map<String, dynamic> json) => _$TransferPointsResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  String transferReference;
@override final  int transferredPoints;

/// Create a copy of TransferPointsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferPointsResponseCopyWith<_TransferPointsResponse> get copyWith => __$TransferPointsResponseCopyWithImpl<_TransferPointsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferPointsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferPointsResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.transferReference, transferReference) || other.transferReference == transferReference)&&(identical(other.transferredPoints, transferredPoints) || other.transferredPoints == transferredPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,transferReference,transferredPoints);

@override
String toString() {
  return 'TransferPointsResponse(success: $success, message: $message, transferReference: $transferReference, transferredPoints: $transferredPoints)';
}


}

/// @nodoc
abstract mixin class _$TransferPointsResponseCopyWith<$Res> implements $TransferPointsResponseCopyWith<$Res> {
  factory _$TransferPointsResponseCopyWith(_TransferPointsResponse value, $Res Function(_TransferPointsResponse) _then) = __$TransferPointsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, String transferReference, int transferredPoints
});




}
/// @nodoc
class __$TransferPointsResponseCopyWithImpl<$Res>
    implements _$TransferPointsResponseCopyWith<$Res> {
  __$TransferPointsResponseCopyWithImpl(this._self, this._then);

  final _TransferPointsResponse _self;
  final $Res Function(_TransferPointsResponse) _then;

/// Create a copy of TransferPointsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? transferReference = null,Object? transferredPoints = null,}) {
  return _then(_TransferPointsResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,transferReference: null == transferReference ? _self.transferReference : transferReference // ignore: cast_nullable_to_non_nullable
as String,transferredPoints: null == transferredPoints ? _self.transferredPoints : transferredPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$UserCouponDetailModel {

 int get id; int get couponId; String get title; String? get description;@JsonKey(name: 'vendorProfileId') int get vendorId; String get vendorUserId; String get vendorName; String get status;@JsonKey(name: 'purchasedDate') DateTime get acquiredDate; DateTime? get redeemedDate;@JsonKey(name: 'validUntil') DateTime get expiryDate; String get uniqueCode; String? get qrCode; String get discountType; double get discountValue; double? get minCartValue;// Optional source of coupon: 'Purchased', 'Subscription', or 'Gift'
 String? get source;// Optional amount paid for purchased coupons
 double? get amountPaid; String? get imageUrl; bool get isGifted; String? get giftedFromUserId; String? get giftedToUserId; DateTime? get giftedDate; String? get giftMessage;
/// Create a copy of UserCouponDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCouponDetailModelCopyWith<UserCouponDetailModel> get copyWith => _$UserCouponDetailModelCopyWithImpl<UserCouponDetailModel>(this as UserCouponDetailModel, _$identity);

  /// Serializes this UserCouponDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserCouponDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.couponId, couponId) || other.couponId == couponId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorUserId, vendorUserId) || other.vendorUserId == vendorUserId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.status, status) || other.status == status)&&(identical(other.acquiredDate, acquiredDate) || other.acquiredDate == acquiredDate)&&(identical(other.redeemedDate, redeemedDate) || other.redeemedDate == redeemedDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.uniqueCode, uniqueCode) || other.uniqueCode == uniqueCode)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.minCartValue, minCartValue) || other.minCartValue == minCartValue)&&(identical(other.source, source) || other.source == source)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isGifted, isGifted) || other.isGifted == isGifted)&&(identical(other.giftedFromUserId, giftedFromUserId) || other.giftedFromUserId == giftedFromUserId)&&(identical(other.giftedToUserId, giftedToUserId) || other.giftedToUserId == giftedToUserId)&&(identical(other.giftedDate, giftedDate) || other.giftedDate == giftedDate)&&(identical(other.giftMessage, giftMessage) || other.giftMessage == giftMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,couponId,title,description,vendorId,vendorUserId,vendorName,status,acquiredDate,redeemedDate,expiryDate,uniqueCode,qrCode,discountType,discountValue,minCartValue,source,amountPaid,imageUrl,isGifted,giftedFromUserId,giftedToUserId,giftedDate,giftMessage]);

@override
String toString() {
  return 'UserCouponDetailModel(id: $id, couponId: $couponId, title: $title, description: $description, vendorId: $vendorId, vendorUserId: $vendorUserId, vendorName: $vendorName, status: $status, acquiredDate: $acquiredDate, redeemedDate: $redeemedDate, expiryDate: $expiryDate, uniqueCode: $uniqueCode, qrCode: $qrCode, discountType: $discountType, discountValue: $discountValue, minCartValue: $minCartValue, source: $source, amountPaid: $amountPaid, imageUrl: $imageUrl, isGifted: $isGifted, giftedFromUserId: $giftedFromUserId, giftedToUserId: $giftedToUserId, giftedDate: $giftedDate, giftMessage: $giftMessage)';
}


}

/// @nodoc
abstract mixin class $UserCouponDetailModelCopyWith<$Res>  {
  factory $UserCouponDetailModelCopyWith(UserCouponDetailModel value, $Res Function(UserCouponDetailModel) _then) = _$UserCouponDetailModelCopyWithImpl;
@useResult
$Res call({
 int id, int couponId, String title, String? description,@JsonKey(name: 'vendorProfileId') int vendorId, String vendorUserId, String vendorName, String status,@JsonKey(name: 'purchasedDate') DateTime acquiredDate, DateTime? redeemedDate,@JsonKey(name: 'validUntil') DateTime expiryDate, String uniqueCode, String? qrCode, String discountType, double discountValue, double? minCartValue, String? source, double? amountPaid, String? imageUrl, bool isGifted, String? giftedFromUserId, String? giftedToUserId, DateTime? giftedDate, String? giftMessage
});




}
/// @nodoc
class _$UserCouponDetailModelCopyWithImpl<$Res>
    implements $UserCouponDetailModelCopyWith<$Res> {
  _$UserCouponDetailModelCopyWithImpl(this._self, this._then);

  final UserCouponDetailModel _self;
  final $Res Function(UserCouponDetailModel) _then;

/// Create a copy of UserCouponDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? couponId = null,Object? title = null,Object? description = freezed,Object? vendorId = null,Object? vendorUserId = null,Object? vendorName = null,Object? status = null,Object? acquiredDate = null,Object? redeemedDate = freezed,Object? expiryDate = null,Object? uniqueCode = null,Object? qrCode = freezed,Object? discountType = null,Object? discountValue = null,Object? minCartValue = freezed,Object? source = freezed,Object? amountPaid = freezed,Object? imageUrl = freezed,Object? isGifted = null,Object? giftedFromUserId = freezed,Object? giftedToUserId = freezed,Object? giftedDate = freezed,Object? giftMessage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,couponId: null == couponId ? _self.couponId : couponId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as int,vendorUserId: null == vendorUserId ? _self.vendorUserId : vendorUserId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,acquiredDate: null == acquiredDate ? _self.acquiredDate : acquiredDate // ignore: cast_nullable_to_non_nullable
as DateTime,redeemedDate: freezed == redeemedDate ? _self.redeemedDate : redeemedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,uniqueCode: null == uniqueCode ? _self.uniqueCode : uniqueCode // ignore: cast_nullable_to_non_nullable
as String,qrCode: freezed == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as String?,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as String,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,minCartValue: freezed == minCartValue ? _self.minCartValue : minCartValue // ignore: cast_nullable_to_non_nullable
as double?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,amountPaid: freezed == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isGifted: null == isGifted ? _self.isGifted : isGifted // ignore: cast_nullable_to_non_nullable
as bool,giftedFromUserId: freezed == giftedFromUserId ? _self.giftedFromUserId : giftedFromUserId // ignore: cast_nullable_to_non_nullable
as String?,giftedToUserId: freezed == giftedToUserId ? _self.giftedToUserId : giftedToUserId // ignore: cast_nullable_to_non_nullable
as String?,giftedDate: freezed == giftedDate ? _self.giftedDate : giftedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,giftMessage: freezed == giftMessage ? _self.giftMessage : giftMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserCouponDetailModel].
extension UserCouponDetailModelPatterns on UserCouponDetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserCouponDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserCouponDetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserCouponDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _UserCouponDetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserCouponDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserCouponDetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int couponId,  String title,  String? description, @JsonKey(name: 'vendorProfileId')  int vendorId,  String vendorUserId,  String vendorName,  String status, @JsonKey(name: 'purchasedDate')  DateTime acquiredDate,  DateTime? redeemedDate, @JsonKey(name: 'validUntil')  DateTime expiryDate,  String uniqueCode,  String? qrCode,  String discountType,  double discountValue,  double? minCartValue,  String? source,  double? amountPaid,  String? imageUrl,  bool isGifted,  String? giftedFromUserId,  String? giftedToUserId,  DateTime? giftedDate,  String? giftMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserCouponDetailModel() when $default != null:
return $default(_that.id,_that.couponId,_that.title,_that.description,_that.vendorId,_that.vendorUserId,_that.vendorName,_that.status,_that.acquiredDate,_that.redeemedDate,_that.expiryDate,_that.uniqueCode,_that.qrCode,_that.discountType,_that.discountValue,_that.minCartValue,_that.source,_that.amountPaid,_that.imageUrl,_that.isGifted,_that.giftedFromUserId,_that.giftedToUserId,_that.giftedDate,_that.giftMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int couponId,  String title,  String? description, @JsonKey(name: 'vendorProfileId')  int vendorId,  String vendorUserId,  String vendorName,  String status, @JsonKey(name: 'purchasedDate')  DateTime acquiredDate,  DateTime? redeemedDate, @JsonKey(name: 'validUntil')  DateTime expiryDate,  String uniqueCode,  String? qrCode,  String discountType,  double discountValue,  double? minCartValue,  String? source,  double? amountPaid,  String? imageUrl,  bool isGifted,  String? giftedFromUserId,  String? giftedToUserId,  DateTime? giftedDate,  String? giftMessage)  $default,) {final _that = this;
switch (_that) {
case _UserCouponDetailModel():
return $default(_that.id,_that.couponId,_that.title,_that.description,_that.vendorId,_that.vendorUserId,_that.vendorName,_that.status,_that.acquiredDate,_that.redeemedDate,_that.expiryDate,_that.uniqueCode,_that.qrCode,_that.discountType,_that.discountValue,_that.minCartValue,_that.source,_that.amountPaid,_that.imageUrl,_that.isGifted,_that.giftedFromUserId,_that.giftedToUserId,_that.giftedDate,_that.giftMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int couponId,  String title,  String? description, @JsonKey(name: 'vendorProfileId')  int vendorId,  String vendorUserId,  String vendorName,  String status, @JsonKey(name: 'purchasedDate')  DateTime acquiredDate,  DateTime? redeemedDate, @JsonKey(name: 'validUntil')  DateTime expiryDate,  String uniqueCode,  String? qrCode,  String discountType,  double discountValue,  double? minCartValue,  String? source,  double? amountPaid,  String? imageUrl,  bool isGifted,  String? giftedFromUserId,  String? giftedToUserId,  DateTime? giftedDate,  String? giftMessage)?  $default,) {final _that = this;
switch (_that) {
case _UserCouponDetailModel() when $default != null:
return $default(_that.id,_that.couponId,_that.title,_that.description,_that.vendorId,_that.vendorUserId,_that.vendorName,_that.status,_that.acquiredDate,_that.redeemedDate,_that.expiryDate,_that.uniqueCode,_that.qrCode,_that.discountType,_that.discountValue,_that.minCartValue,_that.source,_that.amountPaid,_that.imageUrl,_that.isGifted,_that.giftedFromUserId,_that.giftedToUserId,_that.giftedDate,_that.giftMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserCouponDetailModel implements UserCouponDetailModel {
  const _UserCouponDetailModel({required this.id, required this.couponId, required this.title, this.description, @JsonKey(name: 'vendorProfileId') required this.vendorId, required this.vendorUserId, required this.vendorName, required this.status, @JsonKey(name: 'purchasedDate') required this.acquiredDate, this.redeemedDate, @JsonKey(name: 'validUntil') required this.expiryDate, required this.uniqueCode, this.qrCode, required this.discountType, required this.discountValue, this.minCartValue, this.source, this.amountPaid, this.imageUrl, required this.isGifted, this.giftedFromUserId, this.giftedToUserId, this.giftedDate, this.giftMessage});
  factory _UserCouponDetailModel.fromJson(Map<String, dynamic> json) => _$UserCouponDetailModelFromJson(json);

@override final  int id;
@override final  int couponId;
@override final  String title;
@override final  String? description;
@override@JsonKey(name: 'vendorProfileId') final  int vendorId;
@override final  String vendorUserId;
@override final  String vendorName;
@override final  String status;
@override@JsonKey(name: 'purchasedDate') final  DateTime acquiredDate;
@override final  DateTime? redeemedDate;
@override@JsonKey(name: 'validUntil') final  DateTime expiryDate;
@override final  String uniqueCode;
@override final  String? qrCode;
@override final  String discountType;
@override final  double discountValue;
@override final  double? minCartValue;
// Optional source of coupon: 'Purchased', 'Subscription', or 'Gift'
@override final  String? source;
// Optional amount paid for purchased coupons
@override final  double? amountPaid;
@override final  String? imageUrl;
@override final  bool isGifted;
@override final  String? giftedFromUserId;
@override final  String? giftedToUserId;
@override final  DateTime? giftedDate;
@override final  String? giftMessage;

/// Create a copy of UserCouponDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCouponDetailModelCopyWith<_UserCouponDetailModel> get copyWith => __$UserCouponDetailModelCopyWithImpl<_UserCouponDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserCouponDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserCouponDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.couponId, couponId) || other.couponId == couponId)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.vendorId, vendorId) || other.vendorId == vendorId)&&(identical(other.vendorUserId, vendorUserId) || other.vendorUserId == vendorUserId)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.status, status) || other.status == status)&&(identical(other.acquiredDate, acquiredDate) || other.acquiredDate == acquiredDate)&&(identical(other.redeemedDate, redeemedDate) || other.redeemedDate == redeemedDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.uniqueCode, uniqueCode) || other.uniqueCode == uniqueCode)&&(identical(other.qrCode, qrCode) || other.qrCode == qrCode)&&(identical(other.discountType, discountType) || other.discountType == discountType)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.minCartValue, minCartValue) || other.minCartValue == minCartValue)&&(identical(other.source, source) || other.source == source)&&(identical(other.amountPaid, amountPaid) || other.amountPaid == amountPaid)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isGifted, isGifted) || other.isGifted == isGifted)&&(identical(other.giftedFromUserId, giftedFromUserId) || other.giftedFromUserId == giftedFromUserId)&&(identical(other.giftedToUserId, giftedToUserId) || other.giftedToUserId == giftedToUserId)&&(identical(other.giftedDate, giftedDate) || other.giftedDate == giftedDate)&&(identical(other.giftMessage, giftMessage) || other.giftMessage == giftMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,couponId,title,description,vendorId,vendorUserId,vendorName,status,acquiredDate,redeemedDate,expiryDate,uniqueCode,qrCode,discountType,discountValue,minCartValue,source,amountPaid,imageUrl,isGifted,giftedFromUserId,giftedToUserId,giftedDate,giftMessage]);

@override
String toString() {
  return 'UserCouponDetailModel(id: $id, couponId: $couponId, title: $title, description: $description, vendorId: $vendorId, vendorUserId: $vendorUserId, vendorName: $vendorName, status: $status, acquiredDate: $acquiredDate, redeemedDate: $redeemedDate, expiryDate: $expiryDate, uniqueCode: $uniqueCode, qrCode: $qrCode, discountType: $discountType, discountValue: $discountValue, minCartValue: $minCartValue, source: $source, amountPaid: $amountPaid, imageUrl: $imageUrl, isGifted: $isGifted, giftedFromUserId: $giftedFromUserId, giftedToUserId: $giftedToUserId, giftedDate: $giftedDate, giftMessage: $giftMessage)';
}


}

/// @nodoc
abstract mixin class _$UserCouponDetailModelCopyWith<$Res> implements $UserCouponDetailModelCopyWith<$Res> {
  factory _$UserCouponDetailModelCopyWith(_UserCouponDetailModel value, $Res Function(_UserCouponDetailModel) _then) = __$UserCouponDetailModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int couponId, String title, String? description,@JsonKey(name: 'vendorProfileId') int vendorId, String vendorUserId, String vendorName, String status,@JsonKey(name: 'purchasedDate') DateTime acquiredDate, DateTime? redeemedDate,@JsonKey(name: 'validUntil') DateTime expiryDate, String uniqueCode, String? qrCode, String discountType, double discountValue, double? minCartValue, String? source, double? amountPaid, String? imageUrl, bool isGifted, String? giftedFromUserId, String? giftedToUserId, DateTime? giftedDate, String? giftMessage
});




}
/// @nodoc
class __$UserCouponDetailModelCopyWithImpl<$Res>
    implements _$UserCouponDetailModelCopyWith<$Res> {
  __$UserCouponDetailModelCopyWithImpl(this._self, this._then);

  final _UserCouponDetailModel _self;
  final $Res Function(_UserCouponDetailModel) _then;

/// Create a copy of UserCouponDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? couponId = null,Object? title = null,Object? description = freezed,Object? vendorId = null,Object? vendorUserId = null,Object? vendorName = null,Object? status = null,Object? acquiredDate = null,Object? redeemedDate = freezed,Object? expiryDate = null,Object? uniqueCode = null,Object? qrCode = freezed,Object? discountType = null,Object? discountValue = null,Object? minCartValue = freezed,Object? source = freezed,Object? amountPaid = freezed,Object? imageUrl = freezed,Object? isGifted = null,Object? giftedFromUserId = freezed,Object? giftedToUserId = freezed,Object? giftedDate = freezed,Object? giftMessage = freezed,}) {
  return _then(_UserCouponDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,couponId: null == couponId ? _self.couponId : couponId // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,vendorId: null == vendorId ? _self.vendorId : vendorId // ignore: cast_nullable_to_non_nullable
as int,vendorUserId: null == vendorUserId ? _self.vendorUserId : vendorUserId // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,acquiredDate: null == acquiredDate ? _self.acquiredDate : acquiredDate // ignore: cast_nullable_to_non_nullable
as DateTime,redeemedDate: freezed == redeemedDate ? _self.redeemedDate : redeemedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,uniqueCode: null == uniqueCode ? _self.uniqueCode : uniqueCode // ignore: cast_nullable_to_non_nullable
as String,qrCode: freezed == qrCode ? _self.qrCode : qrCode // ignore: cast_nullable_to_non_nullable
as String?,discountType: null == discountType ? _self.discountType : discountType // ignore: cast_nullable_to_non_nullable
as String,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,minCartValue: freezed == minCartValue ? _self.minCartValue : minCartValue // ignore: cast_nullable_to_non_nullable
as double?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,amountPaid: freezed == amountPaid ? _self.amountPaid : amountPaid // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isGifted: null == isGifted ? _self.isGifted : isGifted // ignore: cast_nullable_to_non_nullable
as bool,giftedFromUserId: freezed == giftedFromUserId ? _self.giftedFromUserId : giftedFromUserId // ignore: cast_nullable_to_non_nullable
as String?,giftedToUserId: freezed == giftedToUserId ? _self.giftedToUserId : giftedToUserId // ignore: cast_nullable_to_non_nullable
as String?,giftedDate: freezed == giftedDate ? _self.giftedDate : giftedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,giftMessage: freezed == giftMessage ? _self.giftMessage : giftMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UserCouponsResponseModel {

 List<UserCouponDetailModel> get purchasedCoupons; List<UserCouponDetailModel> get usedCoupons; List<UserCouponDetailModel> get expiredCoupons; List<UserCouponDetailModel> get giftedReceivedCoupons; List<UserCouponDetailModel> get giftedSentCoupons; int get totalCount; int get activeCount; int get usedCount; int get expiredCount; int get giftedCount;
/// Create a copy of UserCouponsResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCouponsResponseModelCopyWith<UserCouponsResponseModel> get copyWith => _$UserCouponsResponseModelCopyWithImpl<UserCouponsResponseModel>(this as UserCouponsResponseModel, _$identity);

  /// Serializes this UserCouponsResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserCouponsResponseModel&&const DeepCollectionEquality().equals(other.purchasedCoupons, purchasedCoupons)&&const DeepCollectionEquality().equals(other.usedCoupons, usedCoupons)&&const DeepCollectionEquality().equals(other.expiredCoupons, expiredCoupons)&&const DeepCollectionEquality().equals(other.giftedReceivedCoupons, giftedReceivedCoupons)&&const DeepCollectionEquality().equals(other.giftedSentCoupons, giftedSentCoupons)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.activeCount, activeCount) || other.activeCount == activeCount)&&(identical(other.usedCount, usedCount) || other.usedCount == usedCount)&&(identical(other.expiredCount, expiredCount) || other.expiredCount == expiredCount)&&(identical(other.giftedCount, giftedCount) || other.giftedCount == giftedCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(purchasedCoupons),const DeepCollectionEquality().hash(usedCoupons),const DeepCollectionEquality().hash(expiredCoupons),const DeepCollectionEquality().hash(giftedReceivedCoupons),const DeepCollectionEquality().hash(giftedSentCoupons),totalCount,activeCount,usedCount,expiredCount,giftedCount);

@override
String toString() {
  return 'UserCouponsResponseModel(purchasedCoupons: $purchasedCoupons, usedCoupons: $usedCoupons, expiredCoupons: $expiredCoupons, giftedReceivedCoupons: $giftedReceivedCoupons, giftedSentCoupons: $giftedSentCoupons, totalCount: $totalCount, activeCount: $activeCount, usedCount: $usedCount, expiredCount: $expiredCount, giftedCount: $giftedCount)';
}


}

/// @nodoc
abstract mixin class $UserCouponsResponseModelCopyWith<$Res>  {
  factory $UserCouponsResponseModelCopyWith(UserCouponsResponseModel value, $Res Function(UserCouponsResponseModel) _then) = _$UserCouponsResponseModelCopyWithImpl;
@useResult
$Res call({
 List<UserCouponDetailModel> purchasedCoupons, List<UserCouponDetailModel> usedCoupons, List<UserCouponDetailModel> expiredCoupons, List<UserCouponDetailModel> giftedReceivedCoupons, List<UserCouponDetailModel> giftedSentCoupons, int totalCount, int activeCount, int usedCount, int expiredCount, int giftedCount
});




}
/// @nodoc
class _$UserCouponsResponseModelCopyWithImpl<$Res>
    implements $UserCouponsResponseModelCopyWith<$Res> {
  _$UserCouponsResponseModelCopyWithImpl(this._self, this._then);

  final UserCouponsResponseModel _self;
  final $Res Function(UserCouponsResponseModel) _then;

/// Create a copy of UserCouponsResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? purchasedCoupons = null,Object? usedCoupons = null,Object? expiredCoupons = null,Object? giftedReceivedCoupons = null,Object? giftedSentCoupons = null,Object? totalCount = null,Object? activeCount = null,Object? usedCount = null,Object? expiredCount = null,Object? giftedCount = null,}) {
  return _then(_self.copyWith(
purchasedCoupons: null == purchasedCoupons ? _self.purchasedCoupons : purchasedCoupons // ignore: cast_nullable_to_non_nullable
as List<UserCouponDetailModel>,usedCoupons: null == usedCoupons ? _self.usedCoupons : usedCoupons // ignore: cast_nullable_to_non_nullable
as List<UserCouponDetailModel>,expiredCoupons: null == expiredCoupons ? _self.expiredCoupons : expiredCoupons // ignore: cast_nullable_to_non_nullable
as List<UserCouponDetailModel>,giftedReceivedCoupons: null == giftedReceivedCoupons ? _self.giftedReceivedCoupons : giftedReceivedCoupons // ignore: cast_nullable_to_non_nullable
as List<UserCouponDetailModel>,giftedSentCoupons: null == giftedSentCoupons ? _self.giftedSentCoupons : giftedSentCoupons // ignore: cast_nullable_to_non_nullable
as List<UserCouponDetailModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,activeCount: null == activeCount ? _self.activeCount : activeCount // ignore: cast_nullable_to_non_nullable
as int,usedCount: null == usedCount ? _self.usedCount : usedCount // ignore: cast_nullable_to_non_nullable
as int,expiredCount: null == expiredCount ? _self.expiredCount : expiredCount // ignore: cast_nullable_to_non_nullable
as int,giftedCount: null == giftedCount ? _self.giftedCount : giftedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserCouponsResponseModel].
extension UserCouponsResponseModelPatterns on UserCouponsResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserCouponsResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserCouponsResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserCouponsResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _UserCouponsResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserCouponsResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserCouponsResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<UserCouponDetailModel> purchasedCoupons,  List<UserCouponDetailModel> usedCoupons,  List<UserCouponDetailModel> expiredCoupons,  List<UserCouponDetailModel> giftedReceivedCoupons,  List<UserCouponDetailModel> giftedSentCoupons,  int totalCount,  int activeCount,  int usedCount,  int expiredCount,  int giftedCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserCouponsResponseModel() when $default != null:
return $default(_that.purchasedCoupons,_that.usedCoupons,_that.expiredCoupons,_that.giftedReceivedCoupons,_that.giftedSentCoupons,_that.totalCount,_that.activeCount,_that.usedCount,_that.expiredCount,_that.giftedCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<UserCouponDetailModel> purchasedCoupons,  List<UserCouponDetailModel> usedCoupons,  List<UserCouponDetailModel> expiredCoupons,  List<UserCouponDetailModel> giftedReceivedCoupons,  List<UserCouponDetailModel> giftedSentCoupons,  int totalCount,  int activeCount,  int usedCount,  int expiredCount,  int giftedCount)  $default,) {final _that = this;
switch (_that) {
case _UserCouponsResponseModel():
return $default(_that.purchasedCoupons,_that.usedCoupons,_that.expiredCoupons,_that.giftedReceivedCoupons,_that.giftedSentCoupons,_that.totalCount,_that.activeCount,_that.usedCount,_that.expiredCount,_that.giftedCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<UserCouponDetailModel> purchasedCoupons,  List<UserCouponDetailModel> usedCoupons,  List<UserCouponDetailModel> expiredCoupons,  List<UserCouponDetailModel> giftedReceivedCoupons,  List<UserCouponDetailModel> giftedSentCoupons,  int totalCount,  int activeCount,  int usedCount,  int expiredCount,  int giftedCount)?  $default,) {final _that = this;
switch (_that) {
case _UserCouponsResponseModel() when $default != null:
return $default(_that.purchasedCoupons,_that.usedCoupons,_that.expiredCoupons,_that.giftedReceivedCoupons,_that.giftedSentCoupons,_that.totalCount,_that.activeCount,_that.usedCount,_that.expiredCount,_that.giftedCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserCouponsResponseModel implements UserCouponsResponseModel {
  const _UserCouponsResponseModel({final  List<UserCouponDetailModel> purchasedCoupons = const [], final  List<UserCouponDetailModel> usedCoupons = const [], final  List<UserCouponDetailModel> expiredCoupons = const [], final  List<UserCouponDetailModel> giftedReceivedCoupons = const [], final  List<UserCouponDetailModel> giftedSentCoupons = const [], this.totalCount = 0, this.activeCount = 0, this.usedCount = 0, this.expiredCount = 0, this.giftedCount = 0}): _purchasedCoupons = purchasedCoupons,_usedCoupons = usedCoupons,_expiredCoupons = expiredCoupons,_giftedReceivedCoupons = giftedReceivedCoupons,_giftedSentCoupons = giftedSentCoupons;
  factory _UserCouponsResponseModel.fromJson(Map<String, dynamic> json) => _$UserCouponsResponseModelFromJson(json);

 final  List<UserCouponDetailModel> _purchasedCoupons;
@override@JsonKey() List<UserCouponDetailModel> get purchasedCoupons {
  if (_purchasedCoupons is EqualUnmodifiableListView) return _purchasedCoupons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_purchasedCoupons);
}

 final  List<UserCouponDetailModel> _usedCoupons;
@override@JsonKey() List<UserCouponDetailModel> get usedCoupons {
  if (_usedCoupons is EqualUnmodifiableListView) return _usedCoupons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_usedCoupons);
}

 final  List<UserCouponDetailModel> _expiredCoupons;
@override@JsonKey() List<UserCouponDetailModel> get expiredCoupons {
  if (_expiredCoupons is EqualUnmodifiableListView) return _expiredCoupons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expiredCoupons);
}

 final  List<UserCouponDetailModel> _giftedReceivedCoupons;
@override@JsonKey() List<UserCouponDetailModel> get giftedReceivedCoupons {
  if (_giftedReceivedCoupons is EqualUnmodifiableListView) return _giftedReceivedCoupons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_giftedReceivedCoupons);
}

 final  List<UserCouponDetailModel> _giftedSentCoupons;
@override@JsonKey() List<UserCouponDetailModel> get giftedSentCoupons {
  if (_giftedSentCoupons is EqualUnmodifiableListView) return _giftedSentCoupons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_giftedSentCoupons);
}

@override@JsonKey() final  int totalCount;
@override@JsonKey() final  int activeCount;
@override@JsonKey() final  int usedCount;
@override@JsonKey() final  int expiredCount;
@override@JsonKey() final  int giftedCount;

/// Create a copy of UserCouponsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCouponsResponseModelCopyWith<_UserCouponsResponseModel> get copyWith => __$UserCouponsResponseModelCopyWithImpl<_UserCouponsResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserCouponsResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserCouponsResponseModel&&const DeepCollectionEquality().equals(other._purchasedCoupons, _purchasedCoupons)&&const DeepCollectionEquality().equals(other._usedCoupons, _usedCoupons)&&const DeepCollectionEquality().equals(other._expiredCoupons, _expiredCoupons)&&const DeepCollectionEquality().equals(other._giftedReceivedCoupons, _giftedReceivedCoupons)&&const DeepCollectionEquality().equals(other._giftedSentCoupons, _giftedSentCoupons)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.activeCount, activeCount) || other.activeCount == activeCount)&&(identical(other.usedCount, usedCount) || other.usedCount == usedCount)&&(identical(other.expiredCount, expiredCount) || other.expiredCount == expiredCount)&&(identical(other.giftedCount, giftedCount) || other.giftedCount == giftedCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_purchasedCoupons),const DeepCollectionEquality().hash(_usedCoupons),const DeepCollectionEquality().hash(_expiredCoupons),const DeepCollectionEquality().hash(_giftedReceivedCoupons),const DeepCollectionEquality().hash(_giftedSentCoupons),totalCount,activeCount,usedCount,expiredCount,giftedCount);

@override
String toString() {
  return 'UserCouponsResponseModel(purchasedCoupons: $purchasedCoupons, usedCoupons: $usedCoupons, expiredCoupons: $expiredCoupons, giftedReceivedCoupons: $giftedReceivedCoupons, giftedSentCoupons: $giftedSentCoupons, totalCount: $totalCount, activeCount: $activeCount, usedCount: $usedCount, expiredCount: $expiredCount, giftedCount: $giftedCount)';
}


}

/// @nodoc
abstract mixin class _$UserCouponsResponseModelCopyWith<$Res> implements $UserCouponsResponseModelCopyWith<$Res> {
  factory _$UserCouponsResponseModelCopyWith(_UserCouponsResponseModel value, $Res Function(_UserCouponsResponseModel) _then) = __$UserCouponsResponseModelCopyWithImpl;
@override @useResult
$Res call({
 List<UserCouponDetailModel> purchasedCoupons, List<UserCouponDetailModel> usedCoupons, List<UserCouponDetailModel> expiredCoupons, List<UserCouponDetailModel> giftedReceivedCoupons, List<UserCouponDetailModel> giftedSentCoupons, int totalCount, int activeCount, int usedCount, int expiredCount, int giftedCount
});




}
/// @nodoc
class __$UserCouponsResponseModelCopyWithImpl<$Res>
    implements _$UserCouponsResponseModelCopyWith<$Res> {
  __$UserCouponsResponseModelCopyWithImpl(this._self, this._then);

  final _UserCouponsResponseModel _self;
  final $Res Function(_UserCouponsResponseModel) _then;

/// Create a copy of UserCouponsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? purchasedCoupons = null,Object? usedCoupons = null,Object? expiredCoupons = null,Object? giftedReceivedCoupons = null,Object? giftedSentCoupons = null,Object? totalCount = null,Object? activeCount = null,Object? usedCount = null,Object? expiredCount = null,Object? giftedCount = null,}) {
  return _then(_UserCouponsResponseModel(
purchasedCoupons: null == purchasedCoupons ? _self._purchasedCoupons : purchasedCoupons // ignore: cast_nullable_to_non_nullable
as List<UserCouponDetailModel>,usedCoupons: null == usedCoupons ? _self._usedCoupons : usedCoupons // ignore: cast_nullable_to_non_nullable
as List<UserCouponDetailModel>,expiredCoupons: null == expiredCoupons ? _self._expiredCoupons : expiredCoupons // ignore: cast_nullable_to_non_nullable
as List<UserCouponDetailModel>,giftedReceivedCoupons: null == giftedReceivedCoupons ? _self._giftedReceivedCoupons : giftedReceivedCoupons // ignore: cast_nullable_to_non_nullable
as List<UserCouponDetailModel>,giftedSentCoupons: null == giftedSentCoupons ? _self._giftedSentCoupons : giftedSentCoupons // ignore: cast_nullable_to_non_nullable
as List<UserCouponDetailModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,activeCount: null == activeCount ? _self.activeCount : activeCount // ignore: cast_nullable_to_non_nullable
as int,usedCount: null == usedCount ? _self.usedCount : usedCount // ignore: cast_nullable_to_non_nullable
as int,expiredCount: null == expiredCount ? _self.expiredCount : expiredCount // ignore: cast_nullable_to_non_nullable
as int,giftedCount: null == giftedCount ? _self.giftedCount : giftedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$GiftedCouponHistoryModel {

 int get id; String get couponTitle; String get recipientUserId; DateTime get giftedDate; String? get message; String get status; String get direction;
/// Create a copy of GiftedCouponHistoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftedCouponHistoryModelCopyWith<GiftedCouponHistoryModel> get copyWith => _$GiftedCouponHistoryModelCopyWithImpl<GiftedCouponHistoryModel>(this as GiftedCouponHistoryModel, _$identity);

  /// Serializes this GiftedCouponHistoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftedCouponHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.couponTitle, couponTitle) || other.couponTitle == couponTitle)&&(identical(other.recipientUserId, recipientUserId) || other.recipientUserId == recipientUserId)&&(identical(other.giftedDate, giftedDate) || other.giftedDate == giftedDate)&&(identical(other.message, message) || other.message == message)&&(identical(other.status, status) || other.status == status)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,couponTitle,recipientUserId,giftedDate,message,status,direction);

@override
String toString() {
  return 'GiftedCouponHistoryModel(id: $id, couponTitle: $couponTitle, recipientUserId: $recipientUserId, giftedDate: $giftedDate, message: $message, status: $status, direction: $direction)';
}


}

/// @nodoc
abstract mixin class $GiftedCouponHistoryModelCopyWith<$Res>  {
  factory $GiftedCouponHistoryModelCopyWith(GiftedCouponHistoryModel value, $Res Function(GiftedCouponHistoryModel) _then) = _$GiftedCouponHistoryModelCopyWithImpl;
@useResult
$Res call({
 int id, String couponTitle, String recipientUserId, DateTime giftedDate, String? message, String status, String direction
});




}
/// @nodoc
class _$GiftedCouponHistoryModelCopyWithImpl<$Res>
    implements $GiftedCouponHistoryModelCopyWith<$Res> {
  _$GiftedCouponHistoryModelCopyWithImpl(this._self, this._then);

  final GiftedCouponHistoryModel _self;
  final $Res Function(GiftedCouponHistoryModel) _then;

/// Create a copy of GiftedCouponHistoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? couponTitle = null,Object? recipientUserId = null,Object? giftedDate = null,Object? message = freezed,Object? status = null,Object? direction = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,couponTitle: null == couponTitle ? _self.couponTitle : couponTitle // ignore: cast_nullable_to_non_nullable
as String,recipientUserId: null == recipientUserId ? _self.recipientUserId : recipientUserId // ignore: cast_nullable_to_non_nullable
as String,giftedDate: null == giftedDate ? _self.giftedDate : giftedDate // ignore: cast_nullable_to_non_nullable
as DateTime,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftedCouponHistoryModel].
extension GiftedCouponHistoryModelPatterns on GiftedCouponHistoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftedCouponHistoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftedCouponHistoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftedCouponHistoryModel value)  $default,){
final _that = this;
switch (_that) {
case _GiftedCouponHistoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftedCouponHistoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _GiftedCouponHistoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String couponTitle,  String recipientUserId,  DateTime giftedDate,  String? message,  String status,  String direction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftedCouponHistoryModel() when $default != null:
return $default(_that.id,_that.couponTitle,_that.recipientUserId,_that.giftedDate,_that.message,_that.status,_that.direction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String couponTitle,  String recipientUserId,  DateTime giftedDate,  String? message,  String status,  String direction)  $default,) {final _that = this;
switch (_that) {
case _GiftedCouponHistoryModel():
return $default(_that.id,_that.couponTitle,_that.recipientUserId,_that.giftedDate,_that.message,_that.status,_that.direction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String couponTitle,  String recipientUserId,  DateTime giftedDate,  String? message,  String status,  String direction)?  $default,) {final _that = this;
switch (_that) {
case _GiftedCouponHistoryModel() when $default != null:
return $default(_that.id,_that.couponTitle,_that.recipientUserId,_that.giftedDate,_that.message,_that.status,_that.direction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftedCouponHistoryModel implements GiftedCouponHistoryModel {
  const _GiftedCouponHistoryModel({required this.id, required this.couponTitle, required this.recipientUserId, required this.giftedDate, this.message, required this.status, required this.direction});
  factory _GiftedCouponHistoryModel.fromJson(Map<String, dynamic> json) => _$GiftedCouponHistoryModelFromJson(json);

@override final  int id;
@override final  String couponTitle;
@override final  String recipientUserId;
@override final  DateTime giftedDate;
@override final  String? message;
@override final  String status;
@override final  String direction;

/// Create a copy of GiftedCouponHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftedCouponHistoryModelCopyWith<_GiftedCouponHistoryModel> get copyWith => __$GiftedCouponHistoryModelCopyWithImpl<_GiftedCouponHistoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftedCouponHistoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftedCouponHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.couponTitle, couponTitle) || other.couponTitle == couponTitle)&&(identical(other.recipientUserId, recipientUserId) || other.recipientUserId == recipientUserId)&&(identical(other.giftedDate, giftedDate) || other.giftedDate == giftedDate)&&(identical(other.message, message) || other.message == message)&&(identical(other.status, status) || other.status == status)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,couponTitle,recipientUserId,giftedDate,message,status,direction);

@override
String toString() {
  return 'GiftedCouponHistoryModel(id: $id, couponTitle: $couponTitle, recipientUserId: $recipientUserId, giftedDate: $giftedDate, message: $message, status: $status, direction: $direction)';
}


}

/// @nodoc
abstract mixin class _$GiftedCouponHistoryModelCopyWith<$Res> implements $GiftedCouponHistoryModelCopyWith<$Res> {
  factory _$GiftedCouponHistoryModelCopyWith(_GiftedCouponHistoryModel value, $Res Function(_GiftedCouponHistoryModel) _then) = __$GiftedCouponHistoryModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String couponTitle, String recipientUserId, DateTime giftedDate, String? message, String status, String direction
});




}
/// @nodoc
class __$GiftedCouponHistoryModelCopyWithImpl<$Res>
    implements _$GiftedCouponHistoryModelCopyWith<$Res> {
  __$GiftedCouponHistoryModelCopyWithImpl(this._self, this._then);

  final _GiftedCouponHistoryModel _self;
  final $Res Function(_GiftedCouponHistoryModel) _then;

/// Create a copy of GiftedCouponHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? couponTitle = null,Object? recipientUserId = null,Object? giftedDate = null,Object? message = freezed,Object? status = null,Object? direction = null,}) {
  return _then(_GiftedCouponHistoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,couponTitle: null == couponTitle ? _self.couponTitle : couponTitle // ignore: cast_nullable_to_non_nullable
as String,recipientUserId: null == recipientUserId ? _self.recipientUserId : recipientUserId // ignore: cast_nullable_to_non_nullable
as String,giftedDate: null == giftedDate ? _self.giftedDate : giftedDate // ignore: cast_nullable_to_non_nullable
as DateTime,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GiftedCouponsHistoryResponseModel {

 List<GiftedCouponHistoryModel> get sentCoupons; List<GiftedCouponHistoryModel> get receivedCoupons;
/// Create a copy of GiftedCouponsHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GiftedCouponsHistoryResponseModelCopyWith<GiftedCouponsHistoryResponseModel> get copyWith => _$GiftedCouponsHistoryResponseModelCopyWithImpl<GiftedCouponsHistoryResponseModel>(this as GiftedCouponsHistoryResponseModel, _$identity);

  /// Serializes this GiftedCouponsHistoryResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GiftedCouponsHistoryResponseModel&&const DeepCollectionEquality().equals(other.sentCoupons, sentCoupons)&&const DeepCollectionEquality().equals(other.receivedCoupons, receivedCoupons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sentCoupons),const DeepCollectionEquality().hash(receivedCoupons));

@override
String toString() {
  return 'GiftedCouponsHistoryResponseModel(sentCoupons: $sentCoupons, receivedCoupons: $receivedCoupons)';
}


}

/// @nodoc
abstract mixin class $GiftedCouponsHistoryResponseModelCopyWith<$Res>  {
  factory $GiftedCouponsHistoryResponseModelCopyWith(GiftedCouponsHistoryResponseModel value, $Res Function(GiftedCouponsHistoryResponseModel) _then) = _$GiftedCouponsHistoryResponseModelCopyWithImpl;
@useResult
$Res call({
 List<GiftedCouponHistoryModel> sentCoupons, List<GiftedCouponHistoryModel> receivedCoupons
});




}
/// @nodoc
class _$GiftedCouponsHistoryResponseModelCopyWithImpl<$Res>
    implements $GiftedCouponsHistoryResponseModelCopyWith<$Res> {
  _$GiftedCouponsHistoryResponseModelCopyWithImpl(this._self, this._then);

  final GiftedCouponsHistoryResponseModel _self;
  final $Res Function(GiftedCouponsHistoryResponseModel) _then;

/// Create a copy of GiftedCouponsHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sentCoupons = null,Object? receivedCoupons = null,}) {
  return _then(_self.copyWith(
sentCoupons: null == sentCoupons ? _self.sentCoupons : sentCoupons // ignore: cast_nullable_to_non_nullable
as List<GiftedCouponHistoryModel>,receivedCoupons: null == receivedCoupons ? _self.receivedCoupons : receivedCoupons // ignore: cast_nullable_to_non_nullable
as List<GiftedCouponHistoryModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [GiftedCouponsHistoryResponseModel].
extension GiftedCouponsHistoryResponseModelPatterns on GiftedCouponsHistoryResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GiftedCouponsHistoryResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GiftedCouponsHistoryResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GiftedCouponsHistoryResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _GiftedCouponsHistoryResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GiftedCouponsHistoryResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _GiftedCouponsHistoryResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GiftedCouponHistoryModel> sentCoupons,  List<GiftedCouponHistoryModel> receivedCoupons)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GiftedCouponsHistoryResponseModel() when $default != null:
return $default(_that.sentCoupons,_that.receivedCoupons);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GiftedCouponHistoryModel> sentCoupons,  List<GiftedCouponHistoryModel> receivedCoupons)  $default,) {final _that = this;
switch (_that) {
case _GiftedCouponsHistoryResponseModel():
return $default(_that.sentCoupons,_that.receivedCoupons);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GiftedCouponHistoryModel> sentCoupons,  List<GiftedCouponHistoryModel> receivedCoupons)?  $default,) {final _that = this;
switch (_that) {
case _GiftedCouponsHistoryResponseModel() when $default != null:
return $default(_that.sentCoupons,_that.receivedCoupons);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GiftedCouponsHistoryResponseModel implements GiftedCouponsHistoryResponseModel {
  const _GiftedCouponsHistoryResponseModel({required final  List<GiftedCouponHistoryModel> sentCoupons, required final  List<GiftedCouponHistoryModel> receivedCoupons}): _sentCoupons = sentCoupons,_receivedCoupons = receivedCoupons;
  factory _GiftedCouponsHistoryResponseModel.fromJson(Map<String, dynamic> json) => _$GiftedCouponsHistoryResponseModelFromJson(json);

 final  List<GiftedCouponHistoryModel> _sentCoupons;
@override List<GiftedCouponHistoryModel> get sentCoupons {
  if (_sentCoupons is EqualUnmodifiableListView) return _sentCoupons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sentCoupons);
}

 final  List<GiftedCouponHistoryModel> _receivedCoupons;
@override List<GiftedCouponHistoryModel> get receivedCoupons {
  if (_receivedCoupons is EqualUnmodifiableListView) return _receivedCoupons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_receivedCoupons);
}


/// Create a copy of GiftedCouponsHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GiftedCouponsHistoryResponseModelCopyWith<_GiftedCouponsHistoryResponseModel> get copyWith => __$GiftedCouponsHistoryResponseModelCopyWithImpl<_GiftedCouponsHistoryResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GiftedCouponsHistoryResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GiftedCouponsHistoryResponseModel&&const DeepCollectionEquality().equals(other._sentCoupons, _sentCoupons)&&const DeepCollectionEquality().equals(other._receivedCoupons, _receivedCoupons));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sentCoupons),const DeepCollectionEquality().hash(_receivedCoupons));

@override
String toString() {
  return 'GiftedCouponsHistoryResponseModel(sentCoupons: $sentCoupons, receivedCoupons: $receivedCoupons)';
}


}

/// @nodoc
abstract mixin class _$GiftedCouponsHistoryResponseModelCopyWith<$Res> implements $GiftedCouponsHistoryResponseModelCopyWith<$Res> {
  factory _$GiftedCouponsHistoryResponseModelCopyWith(_GiftedCouponsHistoryResponseModel value, $Res Function(_GiftedCouponsHistoryResponseModel) _then) = __$GiftedCouponsHistoryResponseModelCopyWithImpl;
@override @useResult
$Res call({
 List<GiftedCouponHistoryModel> sentCoupons, List<GiftedCouponHistoryModel> receivedCoupons
});




}
/// @nodoc
class __$GiftedCouponsHistoryResponseModelCopyWithImpl<$Res>
    implements _$GiftedCouponsHistoryResponseModelCopyWith<$Res> {
  __$GiftedCouponsHistoryResponseModelCopyWithImpl(this._self, this._then);

  final _GiftedCouponsHistoryResponseModel _self;
  final $Res Function(_GiftedCouponsHistoryResponseModel) _then;

/// Create a copy of GiftedCouponsHistoryResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sentCoupons = null,Object? receivedCoupons = null,}) {
  return _then(_GiftedCouponsHistoryResponseModel(
sentCoupons: null == sentCoupons ? _self._sentCoupons : sentCoupons // ignore: cast_nullable_to_non_nullable
as List<GiftedCouponHistoryModel>,receivedCoupons: null == receivedCoupons ? _self._receivedCoupons : receivedCoupons // ignore: cast_nullable_to_non_nullable
as List<GiftedCouponHistoryModel>,
  ));
}


}


/// @nodoc
mixin _$PointsTransferHistoryModel {

 int get id; String get fromUserId; String get toUserId; int get points; String get status; DateTime get transferDate; String? get message; String get direction;
/// Create a copy of PointsTransferHistoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointsTransferHistoryModelCopyWith<PointsTransferHistoryModel> get copyWith => _$PointsTransferHistoryModelCopyWithImpl<PointsTransferHistoryModel>(this as PointsTransferHistoryModel, _$identity);

  /// Serializes this PointsTransferHistoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointsTransferHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.points, points) || other.points == points)&&(identical(other.status, status) || other.status == status)&&(identical(other.transferDate, transferDate) || other.transferDate == transferDate)&&(identical(other.message, message) || other.message == message)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromUserId,toUserId,points,status,transferDate,message,direction);

@override
String toString() {
  return 'PointsTransferHistoryModel(id: $id, fromUserId: $fromUserId, toUserId: $toUserId, points: $points, status: $status, transferDate: $transferDate, message: $message, direction: $direction)';
}


}

/// @nodoc
abstract mixin class $PointsTransferHistoryModelCopyWith<$Res>  {
  factory $PointsTransferHistoryModelCopyWith(PointsTransferHistoryModel value, $Res Function(PointsTransferHistoryModel) _then) = _$PointsTransferHistoryModelCopyWithImpl;
@useResult
$Res call({
 int id, String fromUserId, String toUserId, int points, String status, DateTime transferDate, String? message, String direction
});




}
/// @nodoc
class _$PointsTransferHistoryModelCopyWithImpl<$Res>
    implements $PointsTransferHistoryModelCopyWith<$Res> {
  _$PointsTransferHistoryModelCopyWithImpl(this._self, this._then);

  final PointsTransferHistoryModel _self;
  final $Res Function(PointsTransferHistoryModel) _then;

/// Create a copy of PointsTransferHistoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromUserId = null,Object? toUserId = null,Object? points = null,Object? status = null,Object? transferDate = null,Object? message = freezed,Object? direction = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fromUserId: null == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,transferDate: null == transferDate ? _self.transferDate : transferDate // ignore: cast_nullable_to_non_nullable
as DateTime,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PointsTransferHistoryModel].
extension PointsTransferHistoryModelPatterns on PointsTransferHistoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointsTransferHistoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointsTransferHistoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointsTransferHistoryModel value)  $default,){
final _that = this;
switch (_that) {
case _PointsTransferHistoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointsTransferHistoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _PointsTransferHistoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String fromUserId,  String toUserId,  int points,  String status,  DateTime transferDate,  String? message,  String direction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointsTransferHistoryModel() when $default != null:
return $default(_that.id,_that.fromUserId,_that.toUserId,_that.points,_that.status,_that.transferDate,_that.message,_that.direction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String fromUserId,  String toUserId,  int points,  String status,  DateTime transferDate,  String? message,  String direction)  $default,) {final _that = this;
switch (_that) {
case _PointsTransferHistoryModel():
return $default(_that.id,_that.fromUserId,_that.toUserId,_that.points,_that.status,_that.transferDate,_that.message,_that.direction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String fromUserId,  String toUserId,  int points,  String status,  DateTime transferDate,  String? message,  String direction)?  $default,) {final _that = this;
switch (_that) {
case _PointsTransferHistoryModel() when $default != null:
return $default(_that.id,_that.fromUserId,_that.toUserId,_that.points,_that.status,_that.transferDate,_that.message,_that.direction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PointsTransferHistoryModel implements PointsTransferHistoryModel {
  const _PointsTransferHistoryModel({required this.id, required this.fromUserId, required this.toUserId, required this.points, required this.status, required this.transferDate, this.message, required this.direction});
  factory _PointsTransferHistoryModel.fromJson(Map<String, dynamic> json) => _$PointsTransferHistoryModelFromJson(json);

@override final  int id;
@override final  String fromUserId;
@override final  String toUserId;
@override final  int points;
@override final  String status;
@override final  DateTime transferDate;
@override final  String? message;
@override final  String direction;

/// Create a copy of PointsTransferHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointsTransferHistoryModelCopyWith<_PointsTransferHistoryModel> get copyWith => __$PointsTransferHistoryModelCopyWithImpl<_PointsTransferHistoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PointsTransferHistoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointsTransferHistoryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.points, points) || other.points == points)&&(identical(other.status, status) || other.status == status)&&(identical(other.transferDate, transferDate) || other.transferDate == transferDate)&&(identical(other.message, message) || other.message == message)&&(identical(other.direction, direction) || other.direction == direction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromUserId,toUserId,points,status,transferDate,message,direction);

@override
String toString() {
  return 'PointsTransferHistoryModel(id: $id, fromUserId: $fromUserId, toUserId: $toUserId, points: $points, status: $status, transferDate: $transferDate, message: $message, direction: $direction)';
}


}

/// @nodoc
abstract mixin class _$PointsTransferHistoryModelCopyWith<$Res> implements $PointsTransferHistoryModelCopyWith<$Res> {
  factory _$PointsTransferHistoryModelCopyWith(_PointsTransferHistoryModel value, $Res Function(_PointsTransferHistoryModel) _then) = __$PointsTransferHistoryModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String fromUserId, String toUserId, int points, String status, DateTime transferDate, String? message, String direction
});




}
/// @nodoc
class __$PointsTransferHistoryModelCopyWithImpl<$Res>
    implements _$PointsTransferHistoryModelCopyWith<$Res> {
  __$PointsTransferHistoryModelCopyWithImpl(this._self, this._then);

  final _PointsTransferHistoryModel _self;
  final $Res Function(_PointsTransferHistoryModel) _then;

/// Create a copy of PointsTransferHistoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromUserId = null,Object? toUserId = null,Object? points = null,Object? status = null,Object? transferDate = null,Object? message = freezed,Object? direction = null,}) {
  return _then(_PointsTransferHistoryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,fromUserId: null == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,transferDate: null == transferDate ? _self.transferDate : transferDate // ignore: cast_nullable_to_non_nullable
as DateTime,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
