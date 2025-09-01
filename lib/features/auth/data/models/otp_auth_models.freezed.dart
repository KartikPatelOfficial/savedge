// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SendOtpRequest {

 String get phoneNumber;
/// Create a copy of SendOtpRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendOtpRequestCopyWith<SendOtpRequest> get copyWith => _$SendOtpRequestCopyWithImpl<SendOtpRequest>(this as SendOtpRequest, _$identity);

  /// Serializes this SendOtpRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendOtpRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber);

@override
String toString() {
  return 'SendOtpRequest(phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class $SendOtpRequestCopyWith<$Res>  {
  factory $SendOtpRequestCopyWith(SendOtpRequest value, $Res Function(SendOtpRequest) _then) = _$SendOtpRequestCopyWithImpl;
@useResult
$Res call({
 String phoneNumber
});




}
/// @nodoc
class _$SendOtpRequestCopyWithImpl<$Res>
    implements $SendOtpRequestCopyWith<$Res> {
  _$SendOtpRequestCopyWithImpl(this._self, this._then);

  final SendOtpRequest _self;
  final $Res Function(SendOtpRequest) _then;

/// Create a copy of SendOtpRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SendOtpRequest].
extension SendOtpRequestPatterns on SendOtpRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendOtpRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendOtpRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendOtpRequest value)  $default,){
final _that = this;
switch (_that) {
case _SendOtpRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendOtpRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SendOtpRequest() when $default != null:
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
case _SendOtpRequest() when $default != null:
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
case _SendOtpRequest():
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
case _SendOtpRequest() when $default != null:
return $default(_that.phoneNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendOtpRequest implements SendOtpRequest {
  const _SendOtpRequest({required this.phoneNumber});
  factory _SendOtpRequest.fromJson(Map<String, dynamic> json) => _$SendOtpRequestFromJson(json);

@override final  String phoneNumber;

/// Create a copy of SendOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendOtpRequestCopyWith<_SendOtpRequest> get copyWith => __$SendOtpRequestCopyWithImpl<_SendOtpRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendOtpRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendOtpRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber);

@override
String toString() {
  return 'SendOtpRequest(phoneNumber: $phoneNumber)';
}


}

/// @nodoc
abstract mixin class _$SendOtpRequestCopyWith<$Res> implements $SendOtpRequestCopyWith<$Res> {
  factory _$SendOtpRequestCopyWith(_SendOtpRequest value, $Res Function(_SendOtpRequest) _then) = __$SendOtpRequestCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber
});




}
/// @nodoc
class __$SendOtpRequestCopyWithImpl<$Res>
    implements _$SendOtpRequestCopyWith<$Res> {
  __$SendOtpRequestCopyWithImpl(this._self, this._then);

  final _SendOtpRequest _self;
  final $Res Function(_SendOtpRequest) _then;

/// Create a copy of SendOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,}) {
  return _then(_SendOtpRequest(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VerifyOtpRequest {

 String get phoneNumber; String get otp;
/// Create a copy of VerifyOtpRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpRequestCopyWith<VerifyOtpRequest> get copyWith => _$VerifyOtpRequestCopyWithImpl<VerifyOtpRequest>(this as VerifyOtpRequest, _$identity);

  /// Serializes this VerifyOtpRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,otp);

@override
String toString() {
  return 'VerifyOtpRequest(phoneNumber: $phoneNumber, otp: $otp)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpRequestCopyWith<$Res>  {
  factory $VerifyOtpRequestCopyWith(VerifyOtpRequest value, $Res Function(VerifyOtpRequest) _then) = _$VerifyOtpRequestCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String otp
});




}
/// @nodoc
class _$VerifyOtpRequestCopyWithImpl<$Res>
    implements $VerifyOtpRequestCopyWith<$Res> {
  _$VerifyOtpRequestCopyWithImpl(this._self, this._then);

  final VerifyOtpRequest _self;
  final $Res Function(VerifyOtpRequest) _then;

/// Create a copy of VerifyOtpRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? otp = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyOtpRequest].
extension VerifyOtpRequestPatterns on VerifyOtpRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyOtpRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyOtpRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyOtpRequest value)  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyOtpRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber,  String otp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyOtpRequest() when $default != null:
return $default(_that.phoneNumber,_that.otp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber,  String otp)  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpRequest():
return $default(_that.phoneNumber,_that.otp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber,  String otp)?  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpRequest() when $default != null:
return $default(_that.phoneNumber,_that.otp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyOtpRequest implements VerifyOtpRequest {
  const _VerifyOtpRequest({required this.phoneNumber, required this.otp});
  factory _VerifyOtpRequest.fromJson(Map<String, dynamic> json) => _$VerifyOtpRequestFromJson(json);

@override final  String phoneNumber;
@override final  String otp;

/// Create a copy of VerifyOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpRequestCopyWith<_VerifyOtpRequest> get copyWith => __$VerifyOtpRequestCopyWithImpl<_VerifyOtpRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyOtpRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.otp, otp) || other.otp == otp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,otp);

@override
String toString() {
  return 'VerifyOtpRequest(phoneNumber: $phoneNumber, otp: $otp)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpRequestCopyWith<$Res> implements $VerifyOtpRequestCopyWith<$Res> {
  factory _$VerifyOtpRequestCopyWith(_VerifyOtpRequest value, $Res Function(_VerifyOtpRequest) _then) = __$VerifyOtpRequestCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String otp
});




}
/// @nodoc
class __$VerifyOtpRequestCopyWithImpl<$Res>
    implements _$VerifyOtpRequestCopyWith<$Res> {
  __$VerifyOtpRequestCopyWithImpl(this._self, this._then);

  final _VerifyOtpRequest _self;
  final $Res Function(_VerifyOtpRequest) _then;

/// Create a copy of VerifyOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? otp = null,}) {
  return _then(_VerifyOtpRequest(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RegisterIndividualRequest {

 String get phoneNumber; String get email; String get firstName; String get lastName; DateTime? get dateOfBirth;
/// Create a copy of RegisterIndividualRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterIndividualRequestCopyWith<RegisterIndividualRequest> get copyWith => _$RegisterIndividualRequestCopyWithImpl<RegisterIndividualRequest>(this as RegisterIndividualRequest, _$identity);

  /// Serializes this RegisterIndividualRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterIndividualRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,email,firstName,lastName,dateOfBirth);

@override
String toString() {
  return 'RegisterIndividualRequest(phoneNumber: $phoneNumber, email: $email, firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth)';
}


}

/// @nodoc
abstract mixin class $RegisterIndividualRequestCopyWith<$Res>  {
  factory $RegisterIndividualRequestCopyWith(RegisterIndividualRequest value, $Res Function(RegisterIndividualRequest) _then) = _$RegisterIndividualRequestCopyWithImpl;
@useResult
$Res call({
 String phoneNumber, String email, String firstName, String lastName, DateTime? dateOfBirth
});




}
/// @nodoc
class _$RegisterIndividualRequestCopyWithImpl<$Res>
    implements $RegisterIndividualRequestCopyWith<$Res> {
  _$RegisterIndividualRequestCopyWithImpl(this._self, this._then);

  final RegisterIndividualRequest _self;
  final $Res Function(RegisterIndividualRequest) _then;

/// Create a copy of RegisterIndividualRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? dateOfBirth = freezed,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterIndividualRequest].
extension RegisterIndividualRequestPatterns on RegisterIndividualRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterIndividualRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterIndividualRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterIndividualRequest value)  $default,){
final _that = this;
switch (_that) {
case _RegisterIndividualRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterIndividualRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterIndividualRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String phoneNumber,  String email,  String firstName,  String lastName,  DateTime? dateOfBirth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterIndividualRequest() when $default != null:
return $default(_that.phoneNumber,_that.email,_that.firstName,_that.lastName,_that.dateOfBirth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String phoneNumber,  String email,  String firstName,  String lastName,  DateTime? dateOfBirth)  $default,) {final _that = this;
switch (_that) {
case _RegisterIndividualRequest():
return $default(_that.phoneNumber,_that.email,_that.firstName,_that.lastName,_that.dateOfBirth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String phoneNumber,  String email,  String firstName,  String lastName,  DateTime? dateOfBirth)?  $default,) {final _that = this;
switch (_that) {
case _RegisterIndividualRequest() when $default != null:
return $default(_that.phoneNumber,_that.email,_that.firstName,_that.lastName,_that.dateOfBirth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterIndividualRequest implements RegisterIndividualRequest {
  const _RegisterIndividualRequest({required this.phoneNumber, required this.email, required this.firstName, required this.lastName, this.dateOfBirth});
  factory _RegisterIndividualRequest.fromJson(Map<String, dynamic> json) => _$RegisterIndividualRequestFromJson(json);

@override final  String phoneNumber;
@override final  String email;
@override final  String firstName;
@override final  String lastName;
@override final  DateTime? dateOfBirth;

/// Create a copy of RegisterIndividualRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterIndividualRequestCopyWith<_RegisterIndividualRequest> get copyWith => __$RegisterIndividualRequestCopyWithImpl<_RegisterIndividualRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterIndividualRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterIndividualRequest&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,email,firstName,lastName,dateOfBirth);

@override
String toString() {
  return 'RegisterIndividualRequest(phoneNumber: $phoneNumber, email: $email, firstName: $firstName, lastName: $lastName, dateOfBirth: $dateOfBirth)';
}


}

/// @nodoc
abstract mixin class _$RegisterIndividualRequestCopyWith<$Res> implements $RegisterIndividualRequestCopyWith<$Res> {
  factory _$RegisterIndividualRequestCopyWith(_RegisterIndividualRequest value, $Res Function(_RegisterIndividualRequest) _then) = __$RegisterIndividualRequestCopyWithImpl;
@override @useResult
$Res call({
 String phoneNumber, String email, String firstName, String lastName, DateTime? dateOfBirth
});




}
/// @nodoc
class __$RegisterIndividualRequestCopyWithImpl<$Res>
    implements _$RegisterIndividualRequestCopyWith<$Res> {
  __$RegisterIndividualRequestCopyWithImpl(this._self, this._then);

  final _RegisterIndividualRequest _self;
  final $Res Function(_RegisterIndividualRequest) _then;

/// Create a copy of RegisterIndividualRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? dateOfBirth = freezed,}) {
  return _then(_RegisterIndividualRequest(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$OtpResponse {

 bool get succeeded; List<String> get errors;
/// Create a copy of OtpResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpResponseCopyWith<OtpResponse> get copyWith => _$OtpResponseCopyWithImpl<OtpResponse>(this as OtpResponse, _$identity);

  /// Serializes this OtpResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpResponse&&(identical(other.succeeded, succeeded) || other.succeeded == succeeded)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,succeeded,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'OtpResponse(succeeded: $succeeded, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $OtpResponseCopyWith<$Res>  {
  factory $OtpResponseCopyWith(OtpResponse value, $Res Function(OtpResponse) _then) = _$OtpResponseCopyWithImpl;
@useResult
$Res call({
 bool succeeded, List<String> errors
});




}
/// @nodoc
class _$OtpResponseCopyWithImpl<$Res>
    implements $OtpResponseCopyWith<$Res> {
  _$OtpResponseCopyWithImpl(this._self, this._then);

  final OtpResponse _self;
  final $Res Function(OtpResponse) _then;

/// Create a copy of OtpResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? succeeded = null,Object? errors = null,}) {
  return _then(_self.copyWith(
succeeded: null == succeeded ? _self.succeeded : succeeded // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpResponse].
extension OtpResponsePatterns on OtpResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpResponse value)  $default,){
final _that = this;
switch (_that) {
case _OtpResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpResponse value)?  $default,){
final _that = this;
switch (_that) {
case _OtpResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool succeeded,  List<String> errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpResponse() when $default != null:
return $default(_that.succeeded,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool succeeded,  List<String> errors)  $default,) {final _that = this;
switch (_that) {
case _OtpResponse():
return $default(_that.succeeded,_that.errors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool succeeded,  List<String> errors)?  $default,) {final _that = this;
switch (_that) {
case _OtpResponse() when $default != null:
return $default(_that.succeeded,_that.errors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OtpResponse implements OtpResponse {
  const _OtpResponse({required this.succeeded, final  List<String> errors = const []}): _errors = errors;
  factory _OtpResponse.fromJson(Map<String, dynamic> json) => _$OtpResponseFromJson(json);

@override final  bool succeeded;
 final  List<String> _errors;
@override@JsonKey() List<String> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}


/// Create a copy of OtpResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpResponseCopyWith<_OtpResponse> get copyWith => __$OtpResponseCopyWithImpl<_OtpResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtpResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpResponse&&(identical(other.succeeded, succeeded) || other.succeeded == succeeded)&&const DeepCollectionEquality().equals(other._errors, _errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,succeeded,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'OtpResponse(succeeded: $succeeded, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$OtpResponseCopyWith<$Res> implements $OtpResponseCopyWith<$Res> {
  factory _$OtpResponseCopyWith(_OtpResponse value, $Res Function(_OtpResponse) _then) = __$OtpResponseCopyWithImpl;
@override @useResult
$Res call({
 bool succeeded, List<String> errors
});




}
/// @nodoc
class __$OtpResponseCopyWithImpl<$Res>
    implements _$OtpResponseCopyWith<$Res> {
  __$OtpResponseCopyWithImpl(this._self, this._then);

  final _OtpResponse _self;
  final $Res Function(_OtpResponse) _then;

/// Create a copy of OtpResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? succeeded = null,Object? errors = null,}) {
  return _then(_OtpResponse(
succeeded: null == succeeded ? _self.succeeded : succeeded // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$UserVerificationResponse {

 bool get succeeded; UserVerificationResult? get value; List<String> get errors;
/// Create a copy of UserVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserVerificationResponseCopyWith<UserVerificationResponse> get copyWith => _$UserVerificationResponseCopyWithImpl<UserVerificationResponse>(this as UserVerificationResponse, _$identity);

  /// Serializes this UserVerificationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserVerificationResponse&&(identical(other.succeeded, succeeded) || other.succeeded == succeeded)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,succeeded,value,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'UserVerificationResponse(succeeded: $succeeded, value: $value, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $UserVerificationResponseCopyWith<$Res>  {
  factory $UserVerificationResponseCopyWith(UserVerificationResponse value, $Res Function(UserVerificationResponse) _then) = _$UserVerificationResponseCopyWithImpl;
@useResult
$Res call({
 bool succeeded, UserVerificationResult? value, List<String> errors
});


$UserVerificationResultCopyWith<$Res>? get value;

}
/// @nodoc
class _$UserVerificationResponseCopyWithImpl<$Res>
    implements $UserVerificationResponseCopyWith<$Res> {
  _$UserVerificationResponseCopyWithImpl(this._self, this._then);

  final UserVerificationResponse _self;
  final $Res Function(UserVerificationResponse) _then;

/// Create a copy of UserVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? succeeded = null,Object? value = freezed,Object? errors = null,}) {
  return _then(_self.copyWith(
succeeded: null == succeeded ? _self.succeeded : succeeded // ignore: cast_nullable_to_non_nullable
as bool,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as UserVerificationResult?,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of UserVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserVerificationResultCopyWith<$Res>? get value {
    if (_self.value == null) {
    return null;
  }

  return $UserVerificationResultCopyWith<$Res>(_self.value!, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserVerificationResponse].
extension UserVerificationResponsePatterns on UserVerificationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserVerificationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserVerificationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserVerificationResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserVerificationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserVerificationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserVerificationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool succeeded,  UserVerificationResult? value,  List<String> errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserVerificationResponse() when $default != null:
return $default(_that.succeeded,_that.value,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool succeeded,  UserVerificationResult? value,  List<String> errors)  $default,) {final _that = this;
switch (_that) {
case _UserVerificationResponse():
return $default(_that.succeeded,_that.value,_that.errors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool succeeded,  UserVerificationResult? value,  List<String> errors)?  $default,) {final _that = this;
switch (_that) {
case _UserVerificationResponse() when $default != null:
return $default(_that.succeeded,_that.value,_that.errors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserVerificationResponse implements UserVerificationResponse {
  const _UserVerificationResponse({required this.succeeded, this.value, final  List<String> errors = const []}): _errors = errors;
  factory _UserVerificationResponse.fromJson(Map<String, dynamic> json) => _$UserVerificationResponseFromJson(json);

@override final  bool succeeded;
@override final  UserVerificationResult? value;
 final  List<String> _errors;
@override@JsonKey() List<String> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}


/// Create a copy of UserVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserVerificationResponseCopyWith<_UserVerificationResponse> get copyWith => __$UserVerificationResponseCopyWithImpl<_UserVerificationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserVerificationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserVerificationResponse&&(identical(other.succeeded, succeeded) || other.succeeded == succeeded)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other._errors, _errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,succeeded,value,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'UserVerificationResponse(succeeded: $succeeded, value: $value, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$UserVerificationResponseCopyWith<$Res> implements $UserVerificationResponseCopyWith<$Res> {
  factory _$UserVerificationResponseCopyWith(_UserVerificationResponse value, $Res Function(_UserVerificationResponse) _then) = __$UserVerificationResponseCopyWithImpl;
@override @useResult
$Res call({
 bool succeeded, UserVerificationResult? value, List<String> errors
});


@override $UserVerificationResultCopyWith<$Res>? get value;

}
/// @nodoc
class __$UserVerificationResponseCopyWithImpl<$Res>
    implements _$UserVerificationResponseCopyWith<$Res> {
  __$UserVerificationResponseCopyWithImpl(this._self, this._then);

  final _UserVerificationResponse _self;
  final $Res Function(_UserVerificationResponse) _then;

/// Create a copy of UserVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? succeeded = null,Object? value = freezed,Object? errors = null,}) {
  return _then(_UserVerificationResponse(
succeeded: null == succeeded ? _self.succeeded : succeeded // ignore: cast_nullable_to_non_nullable
as bool,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as UserVerificationResult?,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of UserVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserVerificationResultCopyWith<$Res>? get value {
    if (_self.value == null) {
    return null;
  }

  return $UserVerificationResultCopyWith<$Res>(_self.value!, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}


/// @nodoc
mixin _$UserVerificationResult {

 UserStatus get status; UserInfoModel? get user; EmployeeInfoModel? get employee; String? get accessToken; String? get refreshToken; DateTime? get tokenExpiresAt;
/// Create a copy of UserVerificationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserVerificationResultCopyWith<UserVerificationResult> get copyWith => _$UserVerificationResultCopyWithImpl<UserVerificationResult>(this as UserVerificationResult, _$identity);

  /// Serializes this UserVerificationResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserVerificationResult&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.tokenExpiresAt, tokenExpiresAt) || other.tokenExpiresAt == tokenExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,user,employee,accessToken,refreshToken,tokenExpiresAt);

@override
String toString() {
  return 'UserVerificationResult(status: $status, user: $user, employee: $employee, accessToken: $accessToken, refreshToken: $refreshToken, tokenExpiresAt: $tokenExpiresAt)';
}


}

/// @nodoc
abstract mixin class $UserVerificationResultCopyWith<$Res>  {
  factory $UserVerificationResultCopyWith(UserVerificationResult value, $Res Function(UserVerificationResult) _then) = _$UserVerificationResultCopyWithImpl;
@useResult
$Res call({
 UserStatus status, UserInfoModel? user, EmployeeInfoModel? employee, String? accessToken, String? refreshToken, DateTime? tokenExpiresAt
});


$UserInfoModelCopyWith<$Res>? get user;$EmployeeInfoModelCopyWith<$Res>? get employee;

}
/// @nodoc
class _$UserVerificationResultCopyWithImpl<$Res>
    implements $UserVerificationResultCopyWith<$Res> {
  _$UserVerificationResultCopyWithImpl(this._self, this._then);

  final UserVerificationResult _self;
  final $Res Function(UserVerificationResult) _then;

/// Create a copy of UserVerificationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? user = freezed,Object? employee = freezed,Object? accessToken = freezed,Object? refreshToken = freezed,Object? tokenExpiresAt = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserInfoModel?,employee: freezed == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as EmployeeInfoModel?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,tokenExpiresAt: freezed == tokenExpiresAt ? _self.tokenExpiresAt : tokenExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of UserVerificationResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserInfoModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserInfoModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of UserVerificationResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmployeeInfoModelCopyWith<$Res>? get employee {
    if (_self.employee == null) {
    return null;
  }

  return $EmployeeInfoModelCopyWith<$Res>(_self.employee!, (value) {
    return _then(_self.copyWith(employee: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserVerificationResult].
extension UserVerificationResultPatterns on UserVerificationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserVerificationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserVerificationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserVerificationResult value)  $default,){
final _that = this;
switch (_that) {
case _UserVerificationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserVerificationResult value)?  $default,){
final _that = this;
switch (_that) {
case _UserVerificationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserStatus status,  UserInfoModel? user,  EmployeeInfoModel? employee,  String? accessToken,  String? refreshToken,  DateTime? tokenExpiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserVerificationResult() when $default != null:
return $default(_that.status,_that.user,_that.employee,_that.accessToken,_that.refreshToken,_that.tokenExpiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserStatus status,  UserInfoModel? user,  EmployeeInfoModel? employee,  String? accessToken,  String? refreshToken,  DateTime? tokenExpiresAt)  $default,) {final _that = this;
switch (_that) {
case _UserVerificationResult():
return $default(_that.status,_that.user,_that.employee,_that.accessToken,_that.refreshToken,_that.tokenExpiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserStatus status,  UserInfoModel? user,  EmployeeInfoModel? employee,  String? accessToken,  String? refreshToken,  DateTime? tokenExpiresAt)?  $default,) {final _that = this;
switch (_that) {
case _UserVerificationResult() when $default != null:
return $default(_that.status,_that.user,_that.employee,_that.accessToken,_that.refreshToken,_that.tokenExpiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserVerificationResult implements UserVerificationResult {
  const _UserVerificationResult({required this.status, this.user, this.employee, this.accessToken, this.refreshToken, this.tokenExpiresAt});
  factory _UserVerificationResult.fromJson(Map<String, dynamic> json) => _$UserVerificationResultFromJson(json);

@override final  UserStatus status;
@override final  UserInfoModel? user;
@override final  EmployeeInfoModel? employee;
@override final  String? accessToken;
@override final  String? refreshToken;
@override final  DateTime? tokenExpiresAt;

/// Create a copy of UserVerificationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserVerificationResultCopyWith<_UserVerificationResult> get copyWith => __$UserVerificationResultCopyWithImpl<_UserVerificationResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserVerificationResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserVerificationResult&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.employee, employee) || other.employee == employee)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.tokenExpiresAt, tokenExpiresAt) || other.tokenExpiresAt == tokenExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,user,employee,accessToken,refreshToken,tokenExpiresAt);

@override
String toString() {
  return 'UserVerificationResult(status: $status, user: $user, employee: $employee, accessToken: $accessToken, refreshToken: $refreshToken, tokenExpiresAt: $tokenExpiresAt)';
}


}

/// @nodoc
abstract mixin class _$UserVerificationResultCopyWith<$Res> implements $UserVerificationResultCopyWith<$Res> {
  factory _$UserVerificationResultCopyWith(_UserVerificationResult value, $Res Function(_UserVerificationResult) _then) = __$UserVerificationResultCopyWithImpl;
@override @useResult
$Res call({
 UserStatus status, UserInfoModel? user, EmployeeInfoModel? employee, String? accessToken, String? refreshToken, DateTime? tokenExpiresAt
});


@override $UserInfoModelCopyWith<$Res>? get user;@override $EmployeeInfoModelCopyWith<$Res>? get employee;

}
/// @nodoc
class __$UserVerificationResultCopyWithImpl<$Res>
    implements _$UserVerificationResultCopyWith<$Res> {
  __$UserVerificationResultCopyWithImpl(this._self, this._then);

  final _UserVerificationResult _self;
  final $Res Function(_UserVerificationResult) _then;

/// Create a copy of UserVerificationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? user = freezed,Object? employee = freezed,Object? accessToken = freezed,Object? refreshToken = freezed,Object? tokenExpiresAt = freezed,}) {
  return _then(_UserVerificationResult(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserInfoModel?,employee: freezed == employee ? _self.employee : employee // ignore: cast_nullable_to_non_nullable
as EmployeeInfoModel?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,tokenExpiresAt: freezed == tokenExpiresAt ? _self.tokenExpiresAt : tokenExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of UserVerificationResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserInfoModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserInfoModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of UserVerificationResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmployeeInfoModelCopyWith<$Res>? get employee {
    if (_self.employee == null) {
    return null;
  }

  return $EmployeeInfoModelCopyWith<$Res>(_self.employee!, (value) {
    return _then(_self.copyWith(employee: value));
  });
}
}


/// @nodoc
mixin _$UserInfoModel {

 String get id; String get userId; String get email; String get firstName; String get lastName; String get phoneNumber; String get role; bool get isEmailConfirmed; DateTime get createdAt;
/// Create a copy of UserInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInfoModelCopyWith<UserInfoModel> get copyWith => _$UserInfoModelCopyWithImpl<UserInfoModel>(this as UserInfoModel, _$identity);

  /// Serializes this UserInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.isEmailConfirmed, isEmailConfirmed) || other.isEmailConfirmed == isEmailConfirmed)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,email,firstName,lastName,phoneNumber,role,isEmailConfirmed,createdAt);

@override
String toString() {
  return 'UserInfoModel(id: $id, userId: $userId, email: $email, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, role: $role, isEmailConfirmed: $isEmailConfirmed, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserInfoModelCopyWith<$Res>  {
  factory $UserInfoModelCopyWith(UserInfoModel value, $Res Function(UserInfoModel) _then) = _$UserInfoModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String email, String firstName, String lastName, String phoneNumber, String role, bool isEmailConfirmed, DateTime createdAt
});




}
/// @nodoc
class _$UserInfoModelCopyWithImpl<$Res>
    implements $UserInfoModelCopyWith<$Res> {
  _$UserInfoModelCopyWithImpl(this._self, this._then);

  final UserInfoModel _self;
  final $Res Function(UserInfoModel) _then;

/// Create a copy of UserInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? phoneNumber = null,Object? role = null,Object? isEmailConfirmed = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,isEmailConfirmed: null == isEmailConfirmed ? _self.isEmailConfirmed : isEmailConfirmed // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInfoModel].
extension UserInfoModelPatterns on UserInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _UserInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String email,  String firstName,  String lastName,  String phoneNumber,  String role,  bool isEmailConfirmed,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserInfoModel() when $default != null:
return $default(_that.id,_that.userId,_that.email,_that.firstName,_that.lastName,_that.phoneNumber,_that.role,_that.isEmailConfirmed,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String email,  String firstName,  String lastName,  String phoneNumber,  String role,  bool isEmailConfirmed,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserInfoModel():
return $default(_that.id,_that.userId,_that.email,_that.firstName,_that.lastName,_that.phoneNumber,_that.role,_that.isEmailConfirmed,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String email,  String firstName,  String lastName,  String phoneNumber,  String role,  bool isEmailConfirmed,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserInfoModel() when $default != null:
return $default(_that.id,_that.userId,_that.email,_that.firstName,_that.lastName,_that.phoneNumber,_that.role,_that.isEmailConfirmed,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserInfoModel implements UserInfoModel {
  const _UserInfoModel({required this.id, required this.userId, required this.email, required this.firstName, required this.lastName, required this.phoneNumber, required this.role, required this.isEmailConfirmed, required this.createdAt});
  factory _UserInfoModel.fromJson(Map<String, dynamic> json) => _$UserInfoModelFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String email;
@override final  String firstName;
@override final  String lastName;
@override final  String phoneNumber;
@override final  String role;
@override final  bool isEmailConfirmed;
@override final  DateTime createdAt;

/// Create a copy of UserInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserInfoModelCopyWith<_UserInfoModel> get copyWith => __$UserInfoModelCopyWithImpl<_UserInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.role, role) || other.role == role)&&(identical(other.isEmailConfirmed, isEmailConfirmed) || other.isEmailConfirmed == isEmailConfirmed)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,email,firstName,lastName,phoneNumber,role,isEmailConfirmed,createdAt);

@override
String toString() {
  return 'UserInfoModel(id: $id, userId: $userId, email: $email, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, role: $role, isEmailConfirmed: $isEmailConfirmed, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserInfoModelCopyWith<$Res> implements $UserInfoModelCopyWith<$Res> {
  factory _$UserInfoModelCopyWith(_UserInfoModel value, $Res Function(_UserInfoModel) _then) = __$UserInfoModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String email, String firstName, String lastName, String phoneNumber, String role, bool isEmailConfirmed, DateTime createdAt
});




}
/// @nodoc
class __$UserInfoModelCopyWithImpl<$Res>
    implements _$UserInfoModelCopyWith<$Res> {
  __$UserInfoModelCopyWithImpl(this._self, this._then);

  final _UserInfoModel _self;
  final $Res Function(_UserInfoModel) _then;

/// Create a copy of UserInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? phoneNumber = null,Object? role = null,Object? isEmailConfirmed = null,Object? createdAt = null,}) {
  return _then(_UserInfoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,isEmailConfirmed: null == isEmailConfirmed ? _self.isEmailConfirmed : isEmailConfirmed // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$EmployeeInfoModel {

 int get id; String get userId; String get email; String get firstName; String get lastName; String get phoneNumber; String get employeeId; String get department; String get position; OrganizationInfoModel get organization; double get availablePoints; bool get isActive;
/// Create a copy of EmployeeInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeInfoModelCopyWith<EmployeeInfoModel> get copyWith => _$EmployeeInfoModelCopyWithImpl<EmployeeInfoModel>(this as EmployeeInfoModel, _$identity);

  /// Serializes this EmployeeInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeeInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.availablePoints, availablePoints) || other.availablePoints == availablePoints)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,email,firstName,lastName,phoneNumber,employeeId,department,position,organization,availablePoints,isActive);

@override
String toString() {
  return 'EmployeeInfoModel(id: $id, userId: $userId, email: $email, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, employeeId: $employeeId, department: $department, position: $position, organization: $organization, availablePoints: $availablePoints, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $EmployeeInfoModelCopyWith<$Res>  {
  factory $EmployeeInfoModelCopyWith(EmployeeInfoModel value, $Res Function(EmployeeInfoModel) _then) = _$EmployeeInfoModelCopyWithImpl;
@useResult
$Res call({
 int id, String userId, String email, String firstName, String lastName, String phoneNumber, String employeeId, String department, String position, OrganizationInfoModel organization, double availablePoints, bool isActive
});


$OrganizationInfoModelCopyWith<$Res> get organization;

}
/// @nodoc
class _$EmployeeInfoModelCopyWithImpl<$Res>
    implements $EmployeeInfoModelCopyWith<$Res> {
  _$EmployeeInfoModelCopyWithImpl(this._self, this._then);

  final EmployeeInfoModel _self;
  final $Res Function(EmployeeInfoModel) _then;

/// Create a copy of EmployeeInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? phoneNumber = null,Object? employeeId = null,Object? department = null,Object? position = null,Object? organization = null,Object? availablePoints = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as OrganizationInfoModel,availablePoints: null == availablePoints ? _self.availablePoints : availablePoints // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of EmployeeInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizationInfoModelCopyWith<$Res> get organization {
  
  return $OrganizationInfoModelCopyWith<$Res>(_self.organization, (value) {
    return _then(_self.copyWith(organization: value));
  });
}
}


/// Adds pattern-matching-related methods to [EmployeeInfoModel].
extension EmployeeInfoModelPatterns on EmployeeInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeeInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeeInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeeInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _EmployeeInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeeInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeeInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String userId,  String email,  String firstName,  String lastName,  String phoneNumber,  String employeeId,  String department,  String position,  OrganizationInfoModel organization,  double availablePoints,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeeInfoModel() when $default != null:
return $default(_that.id,_that.userId,_that.email,_that.firstName,_that.lastName,_that.phoneNumber,_that.employeeId,_that.department,_that.position,_that.organization,_that.availablePoints,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String userId,  String email,  String firstName,  String lastName,  String phoneNumber,  String employeeId,  String department,  String position,  OrganizationInfoModel organization,  double availablePoints,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _EmployeeInfoModel():
return $default(_that.id,_that.userId,_that.email,_that.firstName,_that.lastName,_that.phoneNumber,_that.employeeId,_that.department,_that.position,_that.organization,_that.availablePoints,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String userId,  String email,  String firstName,  String lastName,  String phoneNumber,  String employeeId,  String department,  String position,  OrganizationInfoModel organization,  double availablePoints,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _EmployeeInfoModel() when $default != null:
return $default(_that.id,_that.userId,_that.email,_that.firstName,_that.lastName,_that.phoneNumber,_that.employeeId,_that.department,_that.position,_that.organization,_that.availablePoints,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeeInfoModel implements EmployeeInfoModel {
  const _EmployeeInfoModel({required this.id, required this.userId, required this.email, required this.firstName, required this.lastName, required this.phoneNumber, required this.employeeId, required this.department, required this.position, required this.organization, required this.availablePoints, required this.isActive});
  factory _EmployeeInfoModel.fromJson(Map<String, dynamic> json) => _$EmployeeInfoModelFromJson(json);

@override final  int id;
@override final  String userId;
@override final  String email;
@override final  String firstName;
@override final  String lastName;
@override final  String phoneNumber;
@override final  String employeeId;
@override final  String department;
@override final  String position;
@override final  OrganizationInfoModel organization;
@override final  double availablePoints;
@override final  bool isActive;

/// Create a copy of EmployeeInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeInfoModelCopyWith<_EmployeeInfoModel> get copyWith => __$EmployeeInfoModelCopyWithImpl<_EmployeeInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeeInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.department, department) || other.department == department)&&(identical(other.position, position) || other.position == position)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.availablePoints, availablePoints) || other.availablePoints == availablePoints)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,email,firstName,lastName,phoneNumber,employeeId,department,position,organization,availablePoints,isActive);

@override
String toString() {
  return 'EmployeeInfoModel(id: $id, userId: $userId, email: $email, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, employeeId: $employeeId, department: $department, position: $position, organization: $organization, availablePoints: $availablePoints, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$EmployeeInfoModelCopyWith<$Res> implements $EmployeeInfoModelCopyWith<$Res> {
  factory _$EmployeeInfoModelCopyWith(_EmployeeInfoModel value, $Res Function(_EmployeeInfoModel) _then) = __$EmployeeInfoModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String userId, String email, String firstName, String lastName, String phoneNumber, String employeeId, String department, String position, OrganizationInfoModel organization, double availablePoints, bool isActive
});


@override $OrganizationInfoModelCopyWith<$Res> get organization;

}
/// @nodoc
class __$EmployeeInfoModelCopyWithImpl<$Res>
    implements _$EmployeeInfoModelCopyWith<$Res> {
  __$EmployeeInfoModelCopyWithImpl(this._self, this._then);

  final _EmployeeInfoModel _self;
  final $Res Function(_EmployeeInfoModel) _then;

/// Create a copy of EmployeeInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? email = null,Object? firstName = null,Object? lastName = null,Object? phoneNumber = null,Object? employeeId = null,Object? department = null,Object? position = null,Object? organization = null,Object? availablePoints = null,Object? isActive = null,}) {
  return _then(_EmployeeInfoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as OrganizationInfoModel,availablePoints: null == availablePoints ? _self.availablePoints : availablePoints // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of EmployeeInfoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganizationInfoModelCopyWith<$Res> get organization {
  
  return $OrganizationInfoModelCopyWith<$Res>(_self.organization, (value) {
    return _then(_self.copyWith(organization: value));
  });
}
}


/// @nodoc
mixin _$OrganizationInfoModel {

 int get id; String get name; String? get logoUrl;
/// Create a copy of OrganizationInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganizationInfoModelCopyWith<OrganizationInfoModel> get copyWith => _$OrganizationInfoModelCopyWithImpl<OrganizationInfoModel>(this as OrganizationInfoModel, _$identity);

  /// Serializes this OrganizationInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganizationInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,logoUrl);

@override
String toString() {
  return 'OrganizationInfoModel(id: $id, name: $name, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class $OrganizationInfoModelCopyWith<$Res>  {
  factory $OrganizationInfoModelCopyWith(OrganizationInfoModel value, $Res Function(OrganizationInfoModel) _then) = _$OrganizationInfoModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? logoUrl
});




}
/// @nodoc
class _$OrganizationInfoModelCopyWithImpl<$Res>
    implements $OrganizationInfoModelCopyWith<$Res> {
  _$OrganizationInfoModelCopyWithImpl(this._self, this._then);

  final OrganizationInfoModel _self;
  final $Res Function(OrganizationInfoModel) _then;

/// Create a copy of OrganizationInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? logoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OrganizationInfoModel].
extension OrganizationInfoModelPatterns on OrganizationInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrganizationInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrganizationInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrganizationInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _OrganizationInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrganizationInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _OrganizationInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? logoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrganizationInfoModel() when $default != null:
return $default(_that.id,_that.name,_that.logoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? logoUrl)  $default,) {final _that = this;
switch (_that) {
case _OrganizationInfoModel():
return $default(_that.id,_that.name,_that.logoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? logoUrl)?  $default,) {final _that = this;
switch (_that) {
case _OrganizationInfoModel() when $default != null:
return $default(_that.id,_that.name,_that.logoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrganizationInfoModel implements OrganizationInfoModel {
  const _OrganizationInfoModel({required this.id, required this.name, this.logoUrl});
  factory _OrganizationInfoModel.fromJson(Map<String, dynamic> json) => _$OrganizationInfoModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? logoUrl;

/// Create a copy of OrganizationInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganizationInfoModelCopyWith<_OrganizationInfoModel> get copyWith => __$OrganizationInfoModelCopyWithImpl<_OrganizationInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrganizationInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrganizationInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,logoUrl);

@override
String toString() {
  return 'OrganizationInfoModel(id: $id, name: $name, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class _$OrganizationInfoModelCopyWith<$Res> implements $OrganizationInfoModelCopyWith<$Res> {
  factory _$OrganizationInfoModelCopyWith(_OrganizationInfoModel value, $Res Function(_OrganizationInfoModel) _then) = __$OrganizationInfoModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? logoUrl
});




}
/// @nodoc
class __$OrganizationInfoModelCopyWithImpl<$Res>
    implements _$OrganizationInfoModelCopyWith<$Res> {
  __$OrganizationInfoModelCopyWithImpl(this._self, this._then);

  final _OrganizationInfoModel _self;
  final $Res Function(_OrganizationInfoModel) _then;

/// Create a copy of OrganizationInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? logoUrl = freezed,}) {
  return _then(_OrganizationInfoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$IndividualRegistrationResponse {

 bool get succeeded; IndividualRegistrationResult? get value; List<String> get errors;
/// Create a copy of IndividualRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndividualRegistrationResponseCopyWith<IndividualRegistrationResponse> get copyWith => _$IndividualRegistrationResponseCopyWithImpl<IndividualRegistrationResponse>(this as IndividualRegistrationResponse, _$identity);

  /// Serializes this IndividualRegistrationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndividualRegistrationResponse&&(identical(other.succeeded, succeeded) || other.succeeded == succeeded)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,succeeded,value,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'IndividualRegistrationResponse(succeeded: $succeeded, value: $value, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $IndividualRegistrationResponseCopyWith<$Res>  {
  factory $IndividualRegistrationResponseCopyWith(IndividualRegistrationResponse value, $Res Function(IndividualRegistrationResponse) _then) = _$IndividualRegistrationResponseCopyWithImpl;
@useResult
$Res call({
 bool succeeded, IndividualRegistrationResult? value, List<String> errors
});


$IndividualRegistrationResultCopyWith<$Res>? get value;

}
/// @nodoc
class _$IndividualRegistrationResponseCopyWithImpl<$Res>
    implements $IndividualRegistrationResponseCopyWith<$Res> {
  _$IndividualRegistrationResponseCopyWithImpl(this._self, this._then);

  final IndividualRegistrationResponse _self;
  final $Res Function(IndividualRegistrationResponse) _then;

/// Create a copy of IndividualRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? succeeded = null,Object? value = freezed,Object? errors = null,}) {
  return _then(_self.copyWith(
succeeded: null == succeeded ? _self.succeeded : succeeded // ignore: cast_nullable_to_non_nullable
as bool,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as IndividualRegistrationResult?,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of IndividualRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IndividualRegistrationResultCopyWith<$Res>? get value {
    if (_self.value == null) {
    return null;
  }

  return $IndividualRegistrationResultCopyWith<$Res>(_self.value!, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}


/// Adds pattern-matching-related methods to [IndividualRegistrationResponse].
extension IndividualRegistrationResponsePatterns on IndividualRegistrationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IndividualRegistrationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IndividualRegistrationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IndividualRegistrationResponse value)  $default,){
final _that = this;
switch (_that) {
case _IndividualRegistrationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IndividualRegistrationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _IndividualRegistrationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool succeeded,  IndividualRegistrationResult? value,  List<String> errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IndividualRegistrationResponse() when $default != null:
return $default(_that.succeeded,_that.value,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool succeeded,  IndividualRegistrationResult? value,  List<String> errors)  $default,) {final _that = this;
switch (_that) {
case _IndividualRegistrationResponse():
return $default(_that.succeeded,_that.value,_that.errors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool succeeded,  IndividualRegistrationResult? value,  List<String> errors)?  $default,) {final _that = this;
switch (_that) {
case _IndividualRegistrationResponse() when $default != null:
return $default(_that.succeeded,_that.value,_that.errors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IndividualRegistrationResponse implements IndividualRegistrationResponse {
  const _IndividualRegistrationResponse({required this.succeeded, this.value, final  List<String> errors = const []}): _errors = errors;
  factory _IndividualRegistrationResponse.fromJson(Map<String, dynamic> json) => _$IndividualRegistrationResponseFromJson(json);

@override final  bool succeeded;
@override final  IndividualRegistrationResult? value;
 final  List<String> _errors;
@override@JsonKey() List<String> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}


/// Create a copy of IndividualRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IndividualRegistrationResponseCopyWith<_IndividualRegistrationResponse> get copyWith => __$IndividualRegistrationResponseCopyWithImpl<_IndividualRegistrationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IndividualRegistrationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IndividualRegistrationResponse&&(identical(other.succeeded, succeeded) || other.succeeded == succeeded)&&(identical(other.value, value) || other.value == value)&&const DeepCollectionEquality().equals(other._errors, _errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,succeeded,value,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'IndividualRegistrationResponse(succeeded: $succeeded, value: $value, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$IndividualRegistrationResponseCopyWith<$Res> implements $IndividualRegistrationResponseCopyWith<$Res> {
  factory _$IndividualRegistrationResponseCopyWith(_IndividualRegistrationResponse value, $Res Function(_IndividualRegistrationResponse) _then) = __$IndividualRegistrationResponseCopyWithImpl;
@override @useResult
$Res call({
 bool succeeded, IndividualRegistrationResult? value, List<String> errors
});


@override $IndividualRegistrationResultCopyWith<$Res>? get value;

}
/// @nodoc
class __$IndividualRegistrationResponseCopyWithImpl<$Res>
    implements _$IndividualRegistrationResponseCopyWith<$Res> {
  __$IndividualRegistrationResponseCopyWithImpl(this._self, this._then);

  final _IndividualRegistrationResponse _self;
  final $Res Function(_IndividualRegistrationResponse) _then;

/// Create a copy of IndividualRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? succeeded = null,Object? value = freezed,Object? errors = null,}) {
  return _then(_IndividualRegistrationResponse(
succeeded: null == succeeded ? _self.succeeded : succeeded // ignore: cast_nullable_to_non_nullable
as bool,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as IndividualRegistrationResult?,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of IndividualRegistrationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IndividualRegistrationResultCopyWith<$Res>? get value {
    if (_self.value == null) {
    return null;
  }

  return $IndividualRegistrationResultCopyWith<$Res>(_self.value!, (value) {
    return _then(_self.copyWith(value: value));
  });
}
}


/// @nodoc
mixin _$IndividualRegistrationResult {

 String get accessToken; String get refreshToken; DateTime get expiresAt; UserInfoModel get user;
/// Create a copy of IndividualRegistrationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndividualRegistrationResultCopyWith<IndividualRegistrationResult> get copyWith => _$IndividualRegistrationResultCopyWithImpl<IndividualRegistrationResult>(this as IndividualRegistrationResult, _$identity);

  /// Serializes this IndividualRegistrationResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndividualRegistrationResult&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,expiresAt,user);

@override
String toString() {
  return 'IndividualRegistrationResult(accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt, user: $user)';
}


}

/// @nodoc
abstract mixin class $IndividualRegistrationResultCopyWith<$Res>  {
  factory $IndividualRegistrationResultCopyWith(IndividualRegistrationResult value, $Res Function(IndividualRegistrationResult) _then) = _$IndividualRegistrationResultCopyWithImpl;
@useResult
$Res call({
 String accessToken, String refreshToken, DateTime expiresAt, UserInfoModel user
});


$UserInfoModelCopyWith<$Res> get user;

}
/// @nodoc
class _$IndividualRegistrationResultCopyWithImpl<$Res>
    implements $IndividualRegistrationResultCopyWith<$Res> {
  _$IndividualRegistrationResultCopyWithImpl(this._self, this._then);

  final IndividualRegistrationResult _self;
  final $Res Function(IndividualRegistrationResult) _then;

/// Create a copy of IndividualRegistrationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? refreshToken = null,Object? expiresAt = null,Object? user = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserInfoModel,
  ));
}
/// Create a copy of IndividualRegistrationResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserInfoModelCopyWith<$Res> get user {
  
  return $UserInfoModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [IndividualRegistrationResult].
extension IndividualRegistrationResultPatterns on IndividualRegistrationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IndividualRegistrationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IndividualRegistrationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IndividualRegistrationResult value)  $default,){
final _that = this;
switch (_that) {
case _IndividualRegistrationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IndividualRegistrationResult value)?  $default,){
final _that = this;
switch (_that) {
case _IndividualRegistrationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken,  String refreshToken,  DateTime expiresAt,  UserInfoModel user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IndividualRegistrationResult() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.expiresAt,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken,  String refreshToken,  DateTime expiresAt,  UserInfoModel user)  $default,) {final _that = this;
switch (_that) {
case _IndividualRegistrationResult():
return $default(_that.accessToken,_that.refreshToken,_that.expiresAt,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken,  String refreshToken,  DateTime expiresAt,  UserInfoModel user)?  $default,) {final _that = this;
switch (_that) {
case _IndividualRegistrationResult() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.expiresAt,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IndividualRegistrationResult implements IndividualRegistrationResult {
  const _IndividualRegistrationResult({required this.accessToken, required this.refreshToken, required this.expiresAt, required this.user});
  factory _IndividualRegistrationResult.fromJson(Map<String, dynamic> json) => _$IndividualRegistrationResultFromJson(json);

@override final  String accessToken;
@override final  String refreshToken;
@override final  DateTime expiresAt;
@override final  UserInfoModel user;

/// Create a copy of IndividualRegistrationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IndividualRegistrationResultCopyWith<_IndividualRegistrationResult> get copyWith => __$IndividualRegistrationResultCopyWithImpl<_IndividualRegistrationResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IndividualRegistrationResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IndividualRegistrationResult&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken,expiresAt,user);

@override
String toString() {
  return 'IndividualRegistrationResult(accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt, user: $user)';
}


}

/// @nodoc
abstract mixin class _$IndividualRegistrationResultCopyWith<$Res> implements $IndividualRegistrationResultCopyWith<$Res> {
  factory _$IndividualRegistrationResultCopyWith(_IndividualRegistrationResult value, $Res Function(_IndividualRegistrationResult) _then) = __$IndividualRegistrationResultCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, String refreshToken, DateTime expiresAt, UserInfoModel user
});


@override $UserInfoModelCopyWith<$Res> get user;

}
/// @nodoc
class __$IndividualRegistrationResultCopyWithImpl<$Res>
    implements _$IndividualRegistrationResultCopyWith<$Res> {
  __$IndividualRegistrationResultCopyWithImpl(this._self, this._then);

  final _IndividualRegistrationResult _self;
  final $Res Function(_IndividualRegistrationResult) _then;

/// Create a copy of IndividualRegistrationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,Object? expiresAt = null,Object? user = null,}) {
  return _then(_IndividualRegistrationResult(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserInfoModel,
  ));
}

/// Create a copy of IndividualRegistrationResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserInfoModelCopyWith<$Res> get user {
  
  return $UserInfoModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
