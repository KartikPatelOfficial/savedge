// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points_payment_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InitiatePointsPaymentRequest {

 int get vendorProfileId; double get amount; int get pointsToUse;
/// Create a copy of InitiatePointsPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitiatePointsPaymentRequestCopyWith<InitiatePointsPaymentRequest> get copyWith => _$InitiatePointsPaymentRequestCopyWithImpl<InitiatePointsPaymentRequest>(this as InitiatePointsPaymentRequest, _$identity);

  /// Serializes this InitiatePointsPaymentRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitiatePointsPaymentRequest&&(identical(other.vendorProfileId, vendorProfileId) || other.vendorProfileId == vendorProfileId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.pointsToUse, pointsToUse) || other.pointsToUse == pointsToUse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vendorProfileId,amount,pointsToUse);

@override
String toString() {
  return 'InitiatePointsPaymentRequest(vendorProfileId: $vendorProfileId, amount: $amount, pointsToUse: $pointsToUse)';
}


}

/// @nodoc
abstract mixin class $InitiatePointsPaymentRequestCopyWith<$Res>  {
  factory $InitiatePointsPaymentRequestCopyWith(InitiatePointsPaymentRequest value, $Res Function(InitiatePointsPaymentRequest) _then) = _$InitiatePointsPaymentRequestCopyWithImpl;
@useResult
$Res call({
 int vendorProfileId, double amount, int pointsToUse
});




}
/// @nodoc
class _$InitiatePointsPaymentRequestCopyWithImpl<$Res>
    implements $InitiatePointsPaymentRequestCopyWith<$Res> {
  _$InitiatePointsPaymentRequestCopyWithImpl(this._self, this._then);

  final InitiatePointsPaymentRequest _self;
  final $Res Function(InitiatePointsPaymentRequest) _then;

/// Create a copy of InitiatePointsPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? vendorProfileId = null,Object? amount = null,Object? pointsToUse = null,}) {
  return _then(_self.copyWith(
vendorProfileId: null == vendorProfileId ? _self.vendorProfileId : vendorProfileId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,pointsToUse: null == pointsToUse ? _self.pointsToUse : pointsToUse // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [InitiatePointsPaymentRequest].
extension InitiatePointsPaymentRequestPatterns on InitiatePointsPaymentRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InitiatePointsPaymentRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitiatePointsPaymentRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InitiatePointsPaymentRequest value)  $default,){
final _that = this;
switch (_that) {
case _InitiatePointsPaymentRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InitiatePointsPaymentRequest value)?  $default,){
final _that = this;
switch (_that) {
case _InitiatePointsPaymentRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int vendorProfileId,  double amount,  int pointsToUse)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitiatePointsPaymentRequest() when $default != null:
return $default(_that.vendorProfileId,_that.amount,_that.pointsToUse);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int vendorProfileId,  double amount,  int pointsToUse)  $default,) {final _that = this;
switch (_that) {
case _InitiatePointsPaymentRequest():
return $default(_that.vendorProfileId,_that.amount,_that.pointsToUse);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int vendorProfileId,  double amount,  int pointsToUse)?  $default,) {final _that = this;
switch (_that) {
case _InitiatePointsPaymentRequest() when $default != null:
return $default(_that.vendorProfileId,_that.amount,_that.pointsToUse);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InitiatePointsPaymentRequest implements InitiatePointsPaymentRequest {
  const _InitiatePointsPaymentRequest({required this.vendorProfileId, required this.amount, required this.pointsToUse});
  factory _InitiatePointsPaymentRequest.fromJson(Map<String, dynamic> json) => _$InitiatePointsPaymentRequestFromJson(json);

@override final  int vendorProfileId;
@override final  double amount;
@override final  int pointsToUse;

/// Create a copy of InitiatePointsPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitiatePointsPaymentRequestCopyWith<_InitiatePointsPaymentRequest> get copyWith => __$InitiatePointsPaymentRequestCopyWithImpl<_InitiatePointsPaymentRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InitiatePointsPaymentRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitiatePointsPaymentRequest&&(identical(other.vendorProfileId, vendorProfileId) || other.vendorProfileId == vendorProfileId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.pointsToUse, pointsToUse) || other.pointsToUse == pointsToUse));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,vendorProfileId,amount,pointsToUse);

@override
String toString() {
  return 'InitiatePointsPaymentRequest(vendorProfileId: $vendorProfileId, amount: $amount, pointsToUse: $pointsToUse)';
}


}

/// @nodoc
abstract mixin class _$InitiatePointsPaymentRequestCopyWith<$Res> implements $InitiatePointsPaymentRequestCopyWith<$Res> {
  factory _$InitiatePointsPaymentRequestCopyWith(_InitiatePointsPaymentRequest value, $Res Function(_InitiatePointsPaymentRequest) _then) = __$InitiatePointsPaymentRequestCopyWithImpl;
@override @useResult
$Res call({
 int vendorProfileId, double amount, int pointsToUse
});




}
/// @nodoc
class __$InitiatePointsPaymentRequestCopyWithImpl<$Res>
    implements _$InitiatePointsPaymentRequestCopyWith<$Res> {
  __$InitiatePointsPaymentRequestCopyWithImpl(this._self, this._then);

  final _InitiatePointsPaymentRequest _self;
  final $Res Function(_InitiatePointsPaymentRequest) _then;

/// Create a copy of InitiatePointsPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? vendorProfileId = null,Object? amount = null,Object? pointsToUse = null,}) {
  return _then(_InitiatePointsPaymentRequest(
vendorProfileId: null == vendorProfileId ? _self.vendorProfileId : vendorProfileId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,pointsToUse: null == pointsToUse ? _self.pointsToUse : pointsToUse // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$InitiatePointsPaymentResponse {

 String get paymentId; String get transactionReference; int get pointsToUse; double get pointsValue; double get billAmount; double get remainingAmount;
/// Create a copy of InitiatePointsPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitiatePointsPaymentResponseCopyWith<InitiatePointsPaymentResponse> get copyWith => _$InitiatePointsPaymentResponseCopyWithImpl<InitiatePointsPaymentResponse>(this as InitiatePointsPaymentResponse, _$identity);

  /// Serializes this InitiatePointsPaymentResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitiatePointsPaymentResponse&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.pointsToUse, pointsToUse) || other.pointsToUse == pointsToUse)&&(identical(other.pointsValue, pointsValue) || other.pointsValue == pointsValue)&&(identical(other.billAmount, billAmount) || other.billAmount == billAmount)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,transactionReference,pointsToUse,pointsValue,billAmount,remainingAmount);

@override
String toString() {
  return 'InitiatePointsPaymentResponse(paymentId: $paymentId, transactionReference: $transactionReference, pointsToUse: $pointsToUse, pointsValue: $pointsValue, billAmount: $billAmount, remainingAmount: $remainingAmount)';
}


}

/// @nodoc
abstract mixin class $InitiatePointsPaymentResponseCopyWith<$Res>  {
  factory $InitiatePointsPaymentResponseCopyWith(InitiatePointsPaymentResponse value, $Res Function(InitiatePointsPaymentResponse) _then) = _$InitiatePointsPaymentResponseCopyWithImpl;
@useResult
$Res call({
 String paymentId, String transactionReference, int pointsToUse, double pointsValue, double billAmount, double remainingAmount
});




}
/// @nodoc
class _$InitiatePointsPaymentResponseCopyWithImpl<$Res>
    implements $InitiatePointsPaymentResponseCopyWith<$Res> {
  _$InitiatePointsPaymentResponseCopyWithImpl(this._self, this._then);

  final InitiatePointsPaymentResponse _self;
  final $Res Function(InitiatePointsPaymentResponse) _then;

/// Create a copy of InitiatePointsPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = null,Object? transactionReference = null,Object? pointsToUse = null,Object? pointsValue = null,Object? billAmount = null,Object? remainingAmount = null,}) {
  return _then(_self.copyWith(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,transactionReference: null == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as String,pointsToUse: null == pointsToUse ? _self.pointsToUse : pointsToUse // ignore: cast_nullable_to_non_nullable
as int,pointsValue: null == pointsValue ? _self.pointsValue : pointsValue // ignore: cast_nullable_to_non_nullable
as double,billAmount: null == billAmount ? _self.billAmount : billAmount // ignore: cast_nullable_to_non_nullable
as double,remainingAmount: null == remainingAmount ? _self.remainingAmount : remainingAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [InitiatePointsPaymentResponse].
extension InitiatePointsPaymentResponsePatterns on InitiatePointsPaymentResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InitiatePointsPaymentResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitiatePointsPaymentResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InitiatePointsPaymentResponse value)  $default,){
final _that = this;
switch (_that) {
case _InitiatePointsPaymentResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InitiatePointsPaymentResponse value)?  $default,){
final _that = this;
switch (_that) {
case _InitiatePointsPaymentResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentId,  String transactionReference,  int pointsToUse,  double pointsValue,  double billAmount,  double remainingAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitiatePointsPaymentResponse() when $default != null:
return $default(_that.paymentId,_that.transactionReference,_that.pointsToUse,_that.pointsValue,_that.billAmount,_that.remainingAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentId,  String transactionReference,  int pointsToUse,  double pointsValue,  double billAmount,  double remainingAmount)  $default,) {final _that = this;
switch (_that) {
case _InitiatePointsPaymentResponse():
return $default(_that.paymentId,_that.transactionReference,_that.pointsToUse,_that.pointsValue,_that.billAmount,_that.remainingAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentId,  String transactionReference,  int pointsToUse,  double pointsValue,  double billAmount,  double remainingAmount)?  $default,) {final _that = this;
switch (_that) {
case _InitiatePointsPaymentResponse() when $default != null:
return $default(_that.paymentId,_that.transactionReference,_that.pointsToUse,_that.pointsValue,_that.billAmount,_that.remainingAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InitiatePointsPaymentResponse implements InitiatePointsPaymentResponse {
  const _InitiatePointsPaymentResponse({required this.paymentId, required this.transactionReference, required this.pointsToUse, required this.pointsValue, required this.billAmount, required this.remainingAmount});
  factory _InitiatePointsPaymentResponse.fromJson(Map<String, dynamic> json) => _$InitiatePointsPaymentResponseFromJson(json);

@override final  String paymentId;
@override final  String transactionReference;
@override final  int pointsToUse;
@override final  double pointsValue;
@override final  double billAmount;
@override final  double remainingAmount;

/// Create a copy of InitiatePointsPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitiatePointsPaymentResponseCopyWith<_InitiatePointsPaymentResponse> get copyWith => __$InitiatePointsPaymentResponseCopyWithImpl<_InitiatePointsPaymentResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InitiatePointsPaymentResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitiatePointsPaymentResponse&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.pointsToUse, pointsToUse) || other.pointsToUse == pointsToUse)&&(identical(other.pointsValue, pointsValue) || other.pointsValue == pointsValue)&&(identical(other.billAmount, billAmount) || other.billAmount == billAmount)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,transactionReference,pointsToUse,pointsValue,billAmount,remainingAmount);

@override
String toString() {
  return 'InitiatePointsPaymentResponse(paymentId: $paymentId, transactionReference: $transactionReference, pointsToUse: $pointsToUse, pointsValue: $pointsValue, billAmount: $billAmount, remainingAmount: $remainingAmount)';
}


}

/// @nodoc
abstract mixin class _$InitiatePointsPaymentResponseCopyWith<$Res> implements $InitiatePointsPaymentResponseCopyWith<$Res> {
  factory _$InitiatePointsPaymentResponseCopyWith(_InitiatePointsPaymentResponse value, $Res Function(_InitiatePointsPaymentResponse) _then) = __$InitiatePointsPaymentResponseCopyWithImpl;
@override @useResult
$Res call({
 String paymentId, String transactionReference, int pointsToUse, double pointsValue, double billAmount, double remainingAmount
});




}
/// @nodoc
class __$InitiatePointsPaymentResponseCopyWithImpl<$Res>
    implements _$InitiatePointsPaymentResponseCopyWith<$Res> {
  __$InitiatePointsPaymentResponseCopyWithImpl(this._self, this._then);

  final _InitiatePointsPaymentResponse _self;
  final $Res Function(_InitiatePointsPaymentResponse) _then;

/// Create a copy of InitiatePointsPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? transactionReference = null,Object? pointsToUse = null,Object? pointsValue = null,Object? billAmount = null,Object? remainingAmount = null,}) {
  return _then(_InitiatePointsPaymentResponse(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,transactionReference: null == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as String,pointsToUse: null == pointsToUse ? _self.pointsToUse : pointsToUse // ignore: cast_nullable_to_non_nullable
as int,pointsValue: null == pointsValue ? _self.pointsValue : pointsValue // ignore: cast_nullable_to_non_nullable
as double,billAmount: null == billAmount ? _self.billAmount : billAmount // ignore: cast_nullable_to_non_nullable
as double,remainingAmount: null == remainingAmount ? _self.remainingAmount : remainingAmount // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$VerifyPointsPaymentOtpRequest {

 String get paymentId; String get otpCode;
/// Create a copy of VerifyPointsPaymentOtpRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyPointsPaymentOtpRequestCopyWith<VerifyPointsPaymentOtpRequest> get copyWith => _$VerifyPointsPaymentOtpRequestCopyWithImpl<VerifyPointsPaymentOtpRequest>(this as VerifyPointsPaymentOtpRequest, _$identity);

  /// Serializes this VerifyPointsPaymentOtpRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyPointsPaymentOtpRequest&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,otpCode);

@override
String toString() {
  return 'VerifyPointsPaymentOtpRequest(paymentId: $paymentId, otpCode: $otpCode)';
}


}

/// @nodoc
abstract mixin class $VerifyPointsPaymentOtpRequestCopyWith<$Res>  {
  factory $VerifyPointsPaymentOtpRequestCopyWith(VerifyPointsPaymentOtpRequest value, $Res Function(VerifyPointsPaymentOtpRequest) _then) = _$VerifyPointsPaymentOtpRequestCopyWithImpl;
@useResult
$Res call({
 String paymentId, String otpCode
});




}
/// @nodoc
class _$VerifyPointsPaymentOtpRequestCopyWithImpl<$Res>
    implements $VerifyPointsPaymentOtpRequestCopyWith<$Res> {
  _$VerifyPointsPaymentOtpRequestCopyWithImpl(this._self, this._then);

  final VerifyPointsPaymentOtpRequest _self;
  final $Res Function(VerifyPointsPaymentOtpRequest) _then;

/// Create a copy of VerifyPointsPaymentOtpRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = null,Object? otpCode = null,}) {
  return _then(_self.copyWith(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyPointsPaymentOtpRequest].
extension VerifyPointsPaymentOtpRequestPatterns on VerifyPointsPaymentOtpRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyPointsPaymentOtpRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyPointsPaymentOtpRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyPointsPaymentOtpRequest value)  $default,){
final _that = this;
switch (_that) {
case _VerifyPointsPaymentOtpRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyPointsPaymentOtpRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyPointsPaymentOtpRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentId,  String otpCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyPointsPaymentOtpRequest() when $default != null:
return $default(_that.paymentId,_that.otpCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentId,  String otpCode)  $default,) {final _that = this;
switch (_that) {
case _VerifyPointsPaymentOtpRequest():
return $default(_that.paymentId,_that.otpCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentId,  String otpCode)?  $default,) {final _that = this;
switch (_that) {
case _VerifyPointsPaymentOtpRequest() when $default != null:
return $default(_that.paymentId,_that.otpCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyPointsPaymentOtpRequest implements VerifyPointsPaymentOtpRequest {
  const _VerifyPointsPaymentOtpRequest({required this.paymentId, required this.otpCode});
  factory _VerifyPointsPaymentOtpRequest.fromJson(Map<String, dynamic> json) => _$VerifyPointsPaymentOtpRequestFromJson(json);

@override final  String paymentId;
@override final  String otpCode;

/// Create a copy of VerifyPointsPaymentOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyPointsPaymentOtpRequestCopyWith<_VerifyPointsPaymentOtpRequest> get copyWith => __$VerifyPointsPaymentOtpRequestCopyWithImpl<_VerifyPointsPaymentOtpRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyPointsPaymentOtpRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyPointsPaymentOtpRequest&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,otpCode);

@override
String toString() {
  return 'VerifyPointsPaymentOtpRequest(paymentId: $paymentId, otpCode: $otpCode)';
}


}

/// @nodoc
abstract mixin class _$VerifyPointsPaymentOtpRequestCopyWith<$Res> implements $VerifyPointsPaymentOtpRequestCopyWith<$Res> {
  factory _$VerifyPointsPaymentOtpRequestCopyWith(_VerifyPointsPaymentOtpRequest value, $Res Function(_VerifyPointsPaymentOtpRequest) _then) = __$VerifyPointsPaymentOtpRequestCopyWithImpl;
@override @useResult
$Res call({
 String paymentId, String otpCode
});




}
/// @nodoc
class __$VerifyPointsPaymentOtpRequestCopyWithImpl<$Res>
    implements _$VerifyPointsPaymentOtpRequestCopyWith<$Res> {
  __$VerifyPointsPaymentOtpRequestCopyWithImpl(this._self, this._then);

  final _VerifyPointsPaymentOtpRequest _self;
  final $Res Function(_VerifyPointsPaymentOtpRequest) _then;

/// Create a copy of VerifyPointsPaymentOtpRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? otpCode = null,}) {
  return _then(_VerifyPointsPaymentOtpRequest(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$VerifyPointsPaymentOtpResponse {

 String get paymentId; String get transactionReference; int get pointsUsed; double get pointsValue; double get billAmount; double get paidAmount; double get remainingAmount; String get vendorName; DateTime get completedAt;
/// Create a copy of VerifyPointsPaymentOtpResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyPointsPaymentOtpResponseCopyWith<VerifyPointsPaymentOtpResponse> get copyWith => _$VerifyPointsPaymentOtpResponseCopyWithImpl<VerifyPointsPaymentOtpResponse>(this as VerifyPointsPaymentOtpResponse, _$identity);

  /// Serializes this VerifyPointsPaymentOtpResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyPointsPaymentOtpResponse&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.pointsUsed, pointsUsed) || other.pointsUsed == pointsUsed)&&(identical(other.pointsValue, pointsValue) || other.pointsValue == pointsValue)&&(identical(other.billAmount, billAmount) || other.billAmount == billAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,transactionReference,pointsUsed,pointsValue,billAmount,paidAmount,remainingAmount,vendorName,completedAt);

@override
String toString() {
  return 'VerifyPointsPaymentOtpResponse(paymentId: $paymentId, transactionReference: $transactionReference, pointsUsed: $pointsUsed, pointsValue: $pointsValue, billAmount: $billAmount, paidAmount: $paidAmount, remainingAmount: $remainingAmount, vendorName: $vendorName, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $VerifyPointsPaymentOtpResponseCopyWith<$Res>  {
  factory $VerifyPointsPaymentOtpResponseCopyWith(VerifyPointsPaymentOtpResponse value, $Res Function(VerifyPointsPaymentOtpResponse) _then) = _$VerifyPointsPaymentOtpResponseCopyWithImpl;
@useResult
$Res call({
 String paymentId, String transactionReference, int pointsUsed, double pointsValue, double billAmount, double paidAmount, double remainingAmount, String vendorName, DateTime completedAt
});




}
/// @nodoc
class _$VerifyPointsPaymentOtpResponseCopyWithImpl<$Res>
    implements $VerifyPointsPaymentOtpResponseCopyWith<$Res> {
  _$VerifyPointsPaymentOtpResponseCopyWithImpl(this._self, this._then);

  final VerifyPointsPaymentOtpResponse _self;
  final $Res Function(VerifyPointsPaymentOtpResponse) _then;

/// Create a copy of VerifyPointsPaymentOtpResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = null,Object? transactionReference = null,Object? pointsUsed = null,Object? pointsValue = null,Object? billAmount = null,Object? paidAmount = null,Object? remainingAmount = null,Object? vendorName = null,Object? completedAt = null,}) {
  return _then(_self.copyWith(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,transactionReference: null == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as String,pointsUsed: null == pointsUsed ? _self.pointsUsed : pointsUsed // ignore: cast_nullable_to_non_nullable
as int,pointsValue: null == pointsValue ? _self.pointsValue : pointsValue // ignore: cast_nullable_to_non_nullable
as double,billAmount: null == billAmount ? _self.billAmount : billAmount // ignore: cast_nullable_to_non_nullable
as double,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as double,remainingAmount: null == remainingAmount ? _self.remainingAmount : remainingAmount // ignore: cast_nullable_to_non_nullable
as double,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyPointsPaymentOtpResponse].
extension VerifyPointsPaymentOtpResponsePatterns on VerifyPointsPaymentOtpResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyPointsPaymentOtpResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyPointsPaymentOtpResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyPointsPaymentOtpResponse value)  $default,){
final _that = this;
switch (_that) {
case _VerifyPointsPaymentOtpResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyPointsPaymentOtpResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyPointsPaymentOtpResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentId,  String transactionReference,  int pointsUsed,  double pointsValue,  double billAmount,  double paidAmount,  double remainingAmount,  String vendorName,  DateTime completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyPointsPaymentOtpResponse() when $default != null:
return $default(_that.paymentId,_that.transactionReference,_that.pointsUsed,_that.pointsValue,_that.billAmount,_that.paidAmount,_that.remainingAmount,_that.vendorName,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentId,  String transactionReference,  int pointsUsed,  double pointsValue,  double billAmount,  double paidAmount,  double remainingAmount,  String vendorName,  DateTime completedAt)  $default,) {final _that = this;
switch (_that) {
case _VerifyPointsPaymentOtpResponse():
return $default(_that.paymentId,_that.transactionReference,_that.pointsUsed,_that.pointsValue,_that.billAmount,_that.paidAmount,_that.remainingAmount,_that.vendorName,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentId,  String transactionReference,  int pointsUsed,  double pointsValue,  double billAmount,  double paidAmount,  double remainingAmount,  String vendorName,  DateTime completedAt)?  $default,) {final _that = this;
switch (_that) {
case _VerifyPointsPaymentOtpResponse() when $default != null:
return $default(_that.paymentId,_that.transactionReference,_that.pointsUsed,_that.pointsValue,_that.billAmount,_that.paidAmount,_that.remainingAmount,_that.vendorName,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyPointsPaymentOtpResponse implements VerifyPointsPaymentOtpResponse {
  const _VerifyPointsPaymentOtpResponse({required this.paymentId, required this.transactionReference, required this.pointsUsed, required this.pointsValue, required this.billAmount, required this.paidAmount, required this.remainingAmount, required this.vendorName, required this.completedAt});
  factory _VerifyPointsPaymentOtpResponse.fromJson(Map<String, dynamic> json) => _$VerifyPointsPaymentOtpResponseFromJson(json);

@override final  String paymentId;
@override final  String transactionReference;
@override final  int pointsUsed;
@override final  double pointsValue;
@override final  double billAmount;
@override final  double paidAmount;
@override final  double remainingAmount;
@override final  String vendorName;
@override final  DateTime completedAt;

/// Create a copy of VerifyPointsPaymentOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyPointsPaymentOtpResponseCopyWith<_VerifyPointsPaymentOtpResponse> get copyWith => __$VerifyPointsPaymentOtpResponseCopyWithImpl<_VerifyPointsPaymentOtpResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyPointsPaymentOtpResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyPointsPaymentOtpResponse&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.pointsUsed, pointsUsed) || other.pointsUsed == pointsUsed)&&(identical(other.pointsValue, pointsValue) || other.pointsValue == pointsValue)&&(identical(other.billAmount, billAmount) || other.billAmount == billAmount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,transactionReference,pointsUsed,pointsValue,billAmount,paidAmount,remainingAmount,vendorName,completedAt);

@override
String toString() {
  return 'VerifyPointsPaymentOtpResponse(paymentId: $paymentId, transactionReference: $transactionReference, pointsUsed: $pointsUsed, pointsValue: $pointsValue, billAmount: $billAmount, paidAmount: $paidAmount, remainingAmount: $remainingAmount, vendorName: $vendorName, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$VerifyPointsPaymentOtpResponseCopyWith<$Res> implements $VerifyPointsPaymentOtpResponseCopyWith<$Res> {
  factory _$VerifyPointsPaymentOtpResponseCopyWith(_VerifyPointsPaymentOtpResponse value, $Res Function(_VerifyPointsPaymentOtpResponse) _then) = __$VerifyPointsPaymentOtpResponseCopyWithImpl;
@override @useResult
$Res call({
 String paymentId, String transactionReference, int pointsUsed, double pointsValue, double billAmount, double paidAmount, double remainingAmount, String vendorName, DateTime completedAt
});




}
/// @nodoc
class __$VerifyPointsPaymentOtpResponseCopyWithImpl<$Res>
    implements _$VerifyPointsPaymentOtpResponseCopyWith<$Res> {
  __$VerifyPointsPaymentOtpResponseCopyWithImpl(this._self, this._then);

  final _VerifyPointsPaymentOtpResponse _self;
  final $Res Function(_VerifyPointsPaymentOtpResponse) _then;

/// Create a copy of VerifyPointsPaymentOtpResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? transactionReference = null,Object? pointsUsed = null,Object? pointsValue = null,Object? billAmount = null,Object? paidAmount = null,Object? remainingAmount = null,Object? vendorName = null,Object? completedAt = null,}) {
  return _then(_VerifyPointsPaymentOtpResponse(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,transactionReference: null == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as String,pointsUsed: null == pointsUsed ? _self.pointsUsed : pointsUsed // ignore: cast_nullable_to_non_nullable
as int,pointsValue: null == pointsValue ? _self.pointsValue : pointsValue // ignore: cast_nullable_to_non_nullable
as double,billAmount: null == billAmount ? _self.billAmount : billAmount // ignore: cast_nullable_to_non_nullable
as double,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as double,remainingAmount: null == remainingAmount ? _self.remainingAmount : remainingAmount // ignore: cast_nullable_to_non_nullable
as double,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,completedAt: null == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$UserPointsBalanceResponse {

 int get availablePoints; int get usedPoints; int get expiringPoints; List<PointTransactionDto> get recentTransactions;
/// Create a copy of UserPointsBalanceResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPointsBalanceResponseCopyWith<UserPointsBalanceResponse> get copyWith => _$UserPointsBalanceResponseCopyWithImpl<UserPointsBalanceResponse>(this as UserPointsBalanceResponse, _$identity);

  /// Serializes this UserPointsBalanceResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPointsBalanceResponse&&(identical(other.availablePoints, availablePoints) || other.availablePoints == availablePoints)&&(identical(other.usedPoints, usedPoints) || other.usedPoints == usedPoints)&&(identical(other.expiringPoints, expiringPoints) || other.expiringPoints == expiringPoints)&&const DeepCollectionEquality().equals(other.recentTransactions, recentTransactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,availablePoints,usedPoints,expiringPoints,const DeepCollectionEquality().hash(recentTransactions));

@override
String toString() {
  return 'UserPointsBalanceResponse(availablePoints: $availablePoints, usedPoints: $usedPoints, expiringPoints: $expiringPoints, recentTransactions: $recentTransactions)';
}


}

/// @nodoc
abstract mixin class $UserPointsBalanceResponseCopyWith<$Res>  {
  factory $UserPointsBalanceResponseCopyWith(UserPointsBalanceResponse value, $Res Function(UserPointsBalanceResponse) _then) = _$UserPointsBalanceResponseCopyWithImpl;
@useResult
$Res call({
 int availablePoints, int usedPoints, int expiringPoints, List<PointTransactionDto> recentTransactions
});




}
/// @nodoc
class _$UserPointsBalanceResponseCopyWithImpl<$Res>
    implements $UserPointsBalanceResponseCopyWith<$Res> {
  _$UserPointsBalanceResponseCopyWithImpl(this._self, this._then);

  final UserPointsBalanceResponse _self;
  final $Res Function(UserPointsBalanceResponse) _then;

/// Create a copy of UserPointsBalanceResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? availablePoints = null,Object? usedPoints = null,Object? expiringPoints = null,Object? recentTransactions = null,}) {
  return _then(_self.copyWith(
availablePoints: null == availablePoints ? _self.availablePoints : availablePoints // ignore: cast_nullable_to_non_nullable
as int,usedPoints: null == usedPoints ? _self.usedPoints : usedPoints // ignore: cast_nullable_to_non_nullable
as int,expiringPoints: null == expiringPoints ? _self.expiringPoints : expiringPoints // ignore: cast_nullable_to_non_nullable
as int,recentTransactions: null == recentTransactions ? _self.recentTransactions : recentTransactions // ignore: cast_nullable_to_non_nullable
as List<PointTransactionDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPointsBalanceResponse].
extension UserPointsBalanceResponsePatterns on UserPointsBalanceResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPointsBalanceResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPointsBalanceResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPointsBalanceResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserPointsBalanceResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPointsBalanceResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserPointsBalanceResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int availablePoints,  int usedPoints,  int expiringPoints,  List<PointTransactionDto> recentTransactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPointsBalanceResponse() when $default != null:
return $default(_that.availablePoints,_that.usedPoints,_that.expiringPoints,_that.recentTransactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int availablePoints,  int usedPoints,  int expiringPoints,  List<PointTransactionDto> recentTransactions)  $default,) {final _that = this;
switch (_that) {
case _UserPointsBalanceResponse():
return $default(_that.availablePoints,_that.usedPoints,_that.expiringPoints,_that.recentTransactions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int availablePoints,  int usedPoints,  int expiringPoints,  List<PointTransactionDto> recentTransactions)?  $default,) {final _that = this;
switch (_that) {
case _UserPointsBalanceResponse() when $default != null:
return $default(_that.availablePoints,_that.usedPoints,_that.expiringPoints,_that.recentTransactions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPointsBalanceResponse implements UserPointsBalanceResponse {
  const _UserPointsBalanceResponse({required this.availablePoints, required this.usedPoints, required this.expiringPoints, required final  List<PointTransactionDto> recentTransactions}): _recentTransactions = recentTransactions;
  factory _UserPointsBalanceResponse.fromJson(Map<String, dynamic> json) => _$UserPointsBalanceResponseFromJson(json);

@override final  int availablePoints;
@override final  int usedPoints;
@override final  int expiringPoints;
 final  List<PointTransactionDto> _recentTransactions;
@override List<PointTransactionDto> get recentTransactions {
  if (_recentTransactions is EqualUnmodifiableListView) return _recentTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentTransactions);
}


/// Create a copy of UserPointsBalanceResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPointsBalanceResponseCopyWith<_UserPointsBalanceResponse> get copyWith => __$UserPointsBalanceResponseCopyWithImpl<_UserPointsBalanceResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPointsBalanceResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPointsBalanceResponse&&(identical(other.availablePoints, availablePoints) || other.availablePoints == availablePoints)&&(identical(other.usedPoints, usedPoints) || other.usedPoints == usedPoints)&&(identical(other.expiringPoints, expiringPoints) || other.expiringPoints == expiringPoints)&&const DeepCollectionEquality().equals(other._recentTransactions, _recentTransactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,availablePoints,usedPoints,expiringPoints,const DeepCollectionEquality().hash(_recentTransactions));

@override
String toString() {
  return 'UserPointsBalanceResponse(availablePoints: $availablePoints, usedPoints: $usedPoints, expiringPoints: $expiringPoints, recentTransactions: $recentTransactions)';
}


}

/// @nodoc
abstract mixin class _$UserPointsBalanceResponseCopyWith<$Res> implements $UserPointsBalanceResponseCopyWith<$Res> {
  factory _$UserPointsBalanceResponseCopyWith(_UserPointsBalanceResponse value, $Res Function(_UserPointsBalanceResponse) _then) = __$UserPointsBalanceResponseCopyWithImpl;
@override @useResult
$Res call({
 int availablePoints, int usedPoints, int expiringPoints, List<PointTransactionDto> recentTransactions
});




}
/// @nodoc
class __$UserPointsBalanceResponseCopyWithImpl<$Res>
    implements _$UserPointsBalanceResponseCopyWith<$Res> {
  __$UserPointsBalanceResponseCopyWithImpl(this._self, this._then);

  final _UserPointsBalanceResponse _self;
  final $Res Function(_UserPointsBalanceResponse) _then;

/// Create a copy of UserPointsBalanceResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? availablePoints = null,Object? usedPoints = null,Object? expiringPoints = null,Object? recentTransactions = null,}) {
  return _then(_UserPointsBalanceResponse(
availablePoints: null == availablePoints ? _self.availablePoints : availablePoints // ignore: cast_nullable_to_non_nullable
as int,usedPoints: null == usedPoints ? _self.usedPoints : usedPoints // ignore: cast_nullable_to_non_nullable
as int,expiringPoints: null == expiringPoints ? _self.expiringPoints : expiringPoints // ignore: cast_nullable_to_non_nullable
as int,recentTransactions: null == recentTransactions ? _self._recentTransactions : recentTransactions // ignore: cast_nullable_to_non_nullable
as List<PointTransactionDto>,
  ));
}


}


/// @nodoc
mixin _$PointTransactionDto {

 int get transactionId; int get points; String get description; String get transactionType; DateTime get transactionDate; DateTime? get expiryDate;
/// Create a copy of PointTransactionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointTransactionDtoCopyWith<PointTransactionDto> get copyWith => _$PointTransactionDtoCopyWithImpl<PointTransactionDto>(this as PointTransactionDto, _$identity);

  /// Serializes this PointTransactionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointTransactionDto&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.points, points) || other.points == points)&&(identical(other.description, description) || other.description == description)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,points,description,transactionType,transactionDate,expiryDate);

@override
String toString() {
  return 'PointTransactionDto(transactionId: $transactionId, points: $points, description: $description, transactionType: $transactionType, transactionDate: $transactionDate, expiryDate: $expiryDate)';
}


}

/// @nodoc
abstract mixin class $PointTransactionDtoCopyWith<$Res>  {
  factory $PointTransactionDtoCopyWith(PointTransactionDto value, $Res Function(PointTransactionDto) _then) = _$PointTransactionDtoCopyWithImpl;
@useResult
$Res call({
 int transactionId, int points, String description, String transactionType, DateTime transactionDate, DateTime? expiryDate
});




}
/// @nodoc
class _$PointTransactionDtoCopyWithImpl<$Res>
    implements $PointTransactionDtoCopyWith<$Res> {
  _$PointTransactionDtoCopyWithImpl(this._self, this._then);

  final PointTransactionDto _self;
  final $Res Function(PointTransactionDto) _then;

/// Create a copy of PointTransactionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? points = null,Object? description = null,Object? transactionType = null,Object? transactionDate = null,Object? expiryDate = freezed,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,transactionType: null == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as String,transactionDate: null == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PointTransactionDto].
extension PointTransactionDtoPatterns on PointTransactionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointTransactionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointTransactionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointTransactionDto value)  $default,){
final _that = this;
switch (_that) {
case _PointTransactionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointTransactionDto value)?  $default,){
final _that = this;
switch (_that) {
case _PointTransactionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int transactionId,  int points,  String description,  String transactionType,  DateTime transactionDate,  DateTime? expiryDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointTransactionDto() when $default != null:
return $default(_that.transactionId,_that.points,_that.description,_that.transactionType,_that.transactionDate,_that.expiryDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int transactionId,  int points,  String description,  String transactionType,  DateTime transactionDate,  DateTime? expiryDate)  $default,) {final _that = this;
switch (_that) {
case _PointTransactionDto():
return $default(_that.transactionId,_that.points,_that.description,_that.transactionType,_that.transactionDate,_that.expiryDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int transactionId,  int points,  String description,  String transactionType,  DateTime transactionDate,  DateTime? expiryDate)?  $default,) {final _that = this;
switch (_that) {
case _PointTransactionDto() when $default != null:
return $default(_that.transactionId,_that.points,_that.description,_that.transactionType,_that.transactionDate,_that.expiryDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PointTransactionDto implements PointTransactionDto {
  const _PointTransactionDto({required this.transactionId, required this.points, required this.description, required this.transactionType, required this.transactionDate, this.expiryDate});
  factory _PointTransactionDto.fromJson(Map<String, dynamic> json) => _$PointTransactionDtoFromJson(json);

@override final  int transactionId;
@override final  int points;
@override final  String description;
@override final  String transactionType;
@override final  DateTime transactionDate;
@override final  DateTime? expiryDate;

/// Create a copy of PointTransactionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointTransactionDtoCopyWith<_PointTransactionDto> get copyWith => __$PointTransactionDtoCopyWithImpl<_PointTransactionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PointTransactionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointTransactionDto&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.points, points) || other.points == points)&&(identical(other.description, description) || other.description == description)&&(identical(other.transactionType, transactionType) || other.transactionType == transactionType)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,points,description,transactionType,transactionDate,expiryDate);

@override
String toString() {
  return 'PointTransactionDto(transactionId: $transactionId, points: $points, description: $description, transactionType: $transactionType, transactionDate: $transactionDate, expiryDate: $expiryDate)';
}


}

/// @nodoc
abstract mixin class _$PointTransactionDtoCopyWith<$Res> implements $PointTransactionDtoCopyWith<$Res> {
  factory _$PointTransactionDtoCopyWith(_PointTransactionDto value, $Res Function(_PointTransactionDto) _then) = __$PointTransactionDtoCopyWithImpl;
@override @useResult
$Res call({
 int transactionId, int points, String description, String transactionType, DateTime transactionDate, DateTime? expiryDate
});




}
/// @nodoc
class __$PointTransactionDtoCopyWithImpl<$Res>
    implements _$PointTransactionDtoCopyWith<$Res> {
  __$PointTransactionDtoCopyWithImpl(this._self, this._then);

  final _PointTransactionDto _self;
  final $Res Function(_PointTransactionDto) _then;

/// Create a copy of PointTransactionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? points = null,Object? description = null,Object? transactionType = null,Object? transactionDate = null,Object? expiryDate = freezed,}) {
  return _then(_PointTransactionDto(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,transactionType: null == transactionType ? _self.transactionType : transactionType // ignore: cast_nullable_to_non_nullable
as String,transactionDate: null == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PointsPaymentDetailsResponse {

 String get paymentId; String get transactionReference; String get customerName; String get customerEmail; String get vendorName; String get vendorEmail; double get billAmount; int get pointsUsed; double get conversionRate; double get pointsValue; double get remainingAmount; String get status; DateTime get createdAt; DateTime? get completedAt; bool get isSettled; String? get settlementId;
/// Create a copy of PointsPaymentDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointsPaymentDetailsResponseCopyWith<PointsPaymentDetailsResponse> get copyWith => _$PointsPaymentDetailsResponseCopyWithImpl<PointsPaymentDetailsResponse>(this as PointsPaymentDetailsResponse, _$identity);

  /// Serializes this PointsPaymentDetailsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointsPaymentDetailsResponse&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.vendorEmail, vendorEmail) || other.vendorEmail == vendorEmail)&&(identical(other.billAmount, billAmount) || other.billAmount == billAmount)&&(identical(other.pointsUsed, pointsUsed) || other.pointsUsed == pointsUsed)&&(identical(other.conversionRate, conversionRate) || other.conversionRate == conversionRate)&&(identical(other.pointsValue, pointsValue) || other.pointsValue == pointsValue)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.isSettled, isSettled) || other.isSettled == isSettled)&&(identical(other.settlementId, settlementId) || other.settlementId == settlementId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,transactionReference,customerName,customerEmail,vendorName,vendorEmail,billAmount,pointsUsed,conversionRate,pointsValue,remainingAmount,status,createdAt,completedAt,isSettled,settlementId);

@override
String toString() {
  return 'PointsPaymentDetailsResponse(paymentId: $paymentId, transactionReference: $transactionReference, customerName: $customerName, customerEmail: $customerEmail, vendorName: $vendorName, vendorEmail: $vendorEmail, billAmount: $billAmount, pointsUsed: $pointsUsed, conversionRate: $conversionRate, pointsValue: $pointsValue, remainingAmount: $remainingAmount, status: $status, createdAt: $createdAt, completedAt: $completedAt, isSettled: $isSettled, settlementId: $settlementId)';
}


}

/// @nodoc
abstract mixin class $PointsPaymentDetailsResponseCopyWith<$Res>  {
  factory $PointsPaymentDetailsResponseCopyWith(PointsPaymentDetailsResponse value, $Res Function(PointsPaymentDetailsResponse) _then) = _$PointsPaymentDetailsResponseCopyWithImpl;
@useResult
$Res call({
 String paymentId, String transactionReference, String customerName, String customerEmail, String vendorName, String vendorEmail, double billAmount, int pointsUsed, double conversionRate, double pointsValue, double remainingAmount, String status, DateTime createdAt, DateTime? completedAt, bool isSettled, String? settlementId
});




}
/// @nodoc
class _$PointsPaymentDetailsResponseCopyWithImpl<$Res>
    implements $PointsPaymentDetailsResponseCopyWith<$Res> {
  _$PointsPaymentDetailsResponseCopyWithImpl(this._self, this._then);

  final PointsPaymentDetailsResponse _self;
  final $Res Function(PointsPaymentDetailsResponse) _then;

/// Create a copy of PointsPaymentDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentId = null,Object? transactionReference = null,Object? customerName = null,Object? customerEmail = null,Object? vendorName = null,Object? vendorEmail = null,Object? billAmount = null,Object? pointsUsed = null,Object? conversionRate = null,Object? pointsValue = null,Object? remainingAmount = null,Object? status = null,Object? createdAt = null,Object? completedAt = freezed,Object? isSettled = null,Object? settlementId = freezed,}) {
  return _then(_self.copyWith(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,transactionReference: null == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerEmail: null == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,vendorEmail: null == vendorEmail ? _self.vendorEmail : vendorEmail // ignore: cast_nullable_to_non_nullable
as String,billAmount: null == billAmount ? _self.billAmount : billAmount // ignore: cast_nullable_to_non_nullable
as double,pointsUsed: null == pointsUsed ? _self.pointsUsed : pointsUsed // ignore: cast_nullable_to_non_nullable
as int,conversionRate: null == conversionRate ? _self.conversionRate : conversionRate // ignore: cast_nullable_to_non_nullable
as double,pointsValue: null == pointsValue ? _self.pointsValue : pointsValue // ignore: cast_nullable_to_non_nullable
as double,remainingAmount: null == remainingAmount ? _self.remainingAmount : remainingAmount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSettled: null == isSettled ? _self.isSettled : isSettled // ignore: cast_nullable_to_non_nullable
as bool,settlementId: freezed == settlementId ? _self.settlementId : settlementId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PointsPaymentDetailsResponse].
extension PointsPaymentDetailsResponsePatterns on PointsPaymentDetailsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointsPaymentDetailsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointsPaymentDetailsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointsPaymentDetailsResponse value)  $default,){
final _that = this;
switch (_that) {
case _PointsPaymentDetailsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointsPaymentDetailsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PointsPaymentDetailsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String paymentId,  String transactionReference,  String customerName,  String customerEmail,  String vendorName,  String vendorEmail,  double billAmount,  int pointsUsed,  double conversionRate,  double pointsValue,  double remainingAmount,  String status,  DateTime createdAt,  DateTime? completedAt,  bool isSettled,  String? settlementId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointsPaymentDetailsResponse() when $default != null:
return $default(_that.paymentId,_that.transactionReference,_that.customerName,_that.customerEmail,_that.vendorName,_that.vendorEmail,_that.billAmount,_that.pointsUsed,_that.conversionRate,_that.pointsValue,_that.remainingAmount,_that.status,_that.createdAt,_that.completedAt,_that.isSettled,_that.settlementId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String paymentId,  String transactionReference,  String customerName,  String customerEmail,  String vendorName,  String vendorEmail,  double billAmount,  int pointsUsed,  double conversionRate,  double pointsValue,  double remainingAmount,  String status,  DateTime createdAt,  DateTime? completedAt,  bool isSettled,  String? settlementId)  $default,) {final _that = this;
switch (_that) {
case _PointsPaymentDetailsResponse():
return $default(_that.paymentId,_that.transactionReference,_that.customerName,_that.customerEmail,_that.vendorName,_that.vendorEmail,_that.billAmount,_that.pointsUsed,_that.conversionRate,_that.pointsValue,_that.remainingAmount,_that.status,_that.createdAt,_that.completedAt,_that.isSettled,_that.settlementId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String paymentId,  String transactionReference,  String customerName,  String customerEmail,  String vendorName,  String vendorEmail,  double billAmount,  int pointsUsed,  double conversionRate,  double pointsValue,  double remainingAmount,  String status,  DateTime createdAt,  DateTime? completedAt,  bool isSettled,  String? settlementId)?  $default,) {final _that = this;
switch (_that) {
case _PointsPaymentDetailsResponse() when $default != null:
return $default(_that.paymentId,_that.transactionReference,_that.customerName,_that.customerEmail,_that.vendorName,_that.vendorEmail,_that.billAmount,_that.pointsUsed,_that.conversionRate,_that.pointsValue,_that.remainingAmount,_that.status,_that.createdAt,_that.completedAt,_that.isSettled,_that.settlementId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PointsPaymentDetailsResponse implements PointsPaymentDetailsResponse {
  const _PointsPaymentDetailsResponse({required this.paymentId, required this.transactionReference, required this.customerName, required this.customerEmail, required this.vendorName, required this.vendorEmail, required this.billAmount, required this.pointsUsed, required this.conversionRate, required this.pointsValue, required this.remainingAmount, required this.status, required this.createdAt, this.completedAt, required this.isSettled, this.settlementId});
  factory _PointsPaymentDetailsResponse.fromJson(Map<String, dynamic> json) => _$PointsPaymentDetailsResponseFromJson(json);

@override final  String paymentId;
@override final  String transactionReference;
@override final  String customerName;
@override final  String customerEmail;
@override final  String vendorName;
@override final  String vendorEmail;
@override final  double billAmount;
@override final  int pointsUsed;
@override final  double conversionRate;
@override final  double pointsValue;
@override final  double remainingAmount;
@override final  String status;
@override final  DateTime createdAt;
@override final  DateTime? completedAt;
@override final  bool isSettled;
@override final  String? settlementId;

/// Create a copy of PointsPaymentDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointsPaymentDetailsResponseCopyWith<_PointsPaymentDetailsResponse> get copyWith => __$PointsPaymentDetailsResponseCopyWithImpl<_PointsPaymentDetailsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PointsPaymentDetailsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointsPaymentDetailsResponse&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.transactionReference, transactionReference) || other.transactionReference == transactionReference)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&(identical(other.vendorName, vendorName) || other.vendorName == vendorName)&&(identical(other.vendorEmail, vendorEmail) || other.vendorEmail == vendorEmail)&&(identical(other.billAmount, billAmount) || other.billAmount == billAmount)&&(identical(other.pointsUsed, pointsUsed) || other.pointsUsed == pointsUsed)&&(identical(other.conversionRate, conversionRate) || other.conversionRate == conversionRate)&&(identical(other.pointsValue, pointsValue) || other.pointsValue == pointsValue)&&(identical(other.remainingAmount, remainingAmount) || other.remainingAmount == remainingAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.isSettled, isSettled) || other.isSettled == isSettled)&&(identical(other.settlementId, settlementId) || other.settlementId == settlementId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,paymentId,transactionReference,customerName,customerEmail,vendorName,vendorEmail,billAmount,pointsUsed,conversionRate,pointsValue,remainingAmount,status,createdAt,completedAt,isSettled,settlementId);

@override
String toString() {
  return 'PointsPaymentDetailsResponse(paymentId: $paymentId, transactionReference: $transactionReference, customerName: $customerName, customerEmail: $customerEmail, vendorName: $vendorName, vendorEmail: $vendorEmail, billAmount: $billAmount, pointsUsed: $pointsUsed, conversionRate: $conversionRate, pointsValue: $pointsValue, remainingAmount: $remainingAmount, status: $status, createdAt: $createdAt, completedAt: $completedAt, isSettled: $isSettled, settlementId: $settlementId)';
}


}

/// @nodoc
abstract mixin class _$PointsPaymentDetailsResponseCopyWith<$Res> implements $PointsPaymentDetailsResponseCopyWith<$Res> {
  factory _$PointsPaymentDetailsResponseCopyWith(_PointsPaymentDetailsResponse value, $Res Function(_PointsPaymentDetailsResponse) _then) = __$PointsPaymentDetailsResponseCopyWithImpl;
@override @useResult
$Res call({
 String paymentId, String transactionReference, String customerName, String customerEmail, String vendorName, String vendorEmail, double billAmount, int pointsUsed, double conversionRate, double pointsValue, double remainingAmount, String status, DateTime createdAt, DateTime? completedAt, bool isSettled, String? settlementId
});




}
/// @nodoc
class __$PointsPaymentDetailsResponseCopyWithImpl<$Res>
    implements _$PointsPaymentDetailsResponseCopyWith<$Res> {
  __$PointsPaymentDetailsResponseCopyWithImpl(this._self, this._then);

  final _PointsPaymentDetailsResponse _self;
  final $Res Function(_PointsPaymentDetailsResponse) _then;

/// Create a copy of PointsPaymentDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentId = null,Object? transactionReference = null,Object? customerName = null,Object? customerEmail = null,Object? vendorName = null,Object? vendorEmail = null,Object? billAmount = null,Object? pointsUsed = null,Object? conversionRate = null,Object? pointsValue = null,Object? remainingAmount = null,Object? status = null,Object? createdAt = null,Object? completedAt = freezed,Object? isSettled = null,Object? settlementId = freezed,}) {
  return _then(_PointsPaymentDetailsResponse(
paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,transactionReference: null == transactionReference ? _self.transactionReference : transactionReference // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerEmail: null == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String,vendorName: null == vendorName ? _self.vendorName : vendorName // ignore: cast_nullable_to_non_nullable
as String,vendorEmail: null == vendorEmail ? _self.vendorEmail : vendorEmail // ignore: cast_nullable_to_non_nullable
as String,billAmount: null == billAmount ? _self.billAmount : billAmount // ignore: cast_nullable_to_non_nullable
as double,pointsUsed: null == pointsUsed ? _self.pointsUsed : pointsUsed // ignore: cast_nullable_to_non_nullable
as int,conversionRate: null == conversionRate ? _self.conversionRate : conversionRate // ignore: cast_nullable_to_non_nullable
as double,pointsValue: null == pointsValue ? _self.pointsValue : pointsValue // ignore: cast_nullable_to_non_nullable
as double,remainingAmount: null == remainingAmount ? _self.remainingAmount : remainingAmount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isSettled: null == isSettled ? _self.isSettled : isSettled // ignore: cast_nullable_to_non_nullable
as bool,settlementId: freezed == settlementId ? _self.settlementId : settlementId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
