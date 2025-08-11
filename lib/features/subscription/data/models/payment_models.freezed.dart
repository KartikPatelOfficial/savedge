// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreatePaymentOrderRequest {

 int get planId; double get amount; String get currency;
/// Create a copy of CreatePaymentOrderRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePaymentOrderRequestCopyWith<CreatePaymentOrderRequest> get copyWith => _$CreatePaymentOrderRequestCopyWithImpl<CreatePaymentOrderRequest>(this as CreatePaymentOrderRequest, _$identity);

  /// Serializes this CreatePaymentOrderRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePaymentOrderRequest&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,amount,currency);

@override
String toString() {
  return 'CreatePaymentOrderRequest(planId: $planId, amount: $amount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $CreatePaymentOrderRequestCopyWith<$Res>  {
  factory $CreatePaymentOrderRequestCopyWith(CreatePaymentOrderRequest value, $Res Function(CreatePaymentOrderRequest) _then) = _$CreatePaymentOrderRequestCopyWithImpl;
@useResult
$Res call({
 int planId, double amount, String currency
});




}
/// @nodoc
class _$CreatePaymentOrderRequestCopyWithImpl<$Res>
    implements $CreatePaymentOrderRequestCopyWith<$Res> {
  _$CreatePaymentOrderRequestCopyWithImpl(this._self, this._then);

  final CreatePaymentOrderRequest _self;
  final $Res Function(CreatePaymentOrderRequest) _then;

/// Create a copy of CreatePaymentOrderRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planId = null,Object? amount = null,Object? currency = null,}) {
  return _then(_self.copyWith(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePaymentOrderRequest].
extension CreatePaymentOrderRequestPatterns on CreatePaymentOrderRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePaymentOrderRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePaymentOrderRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePaymentOrderRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreatePaymentOrderRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePaymentOrderRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePaymentOrderRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int planId,  double amount,  String currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePaymentOrderRequest() when $default != null:
return $default(_that.planId,_that.amount,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int planId,  double amount,  String currency)  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentOrderRequest():
return $default(_that.planId,_that.amount,_that.currency);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int planId,  double amount,  String currency)?  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentOrderRequest() when $default != null:
return $default(_that.planId,_that.amount,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePaymentOrderRequest implements CreatePaymentOrderRequest {
  const _CreatePaymentOrderRequest({required this.planId, required this.amount, required this.currency});
  factory _CreatePaymentOrderRequest.fromJson(Map<String, dynamic> json) => _$CreatePaymentOrderRequestFromJson(json);

@override final  int planId;
@override final  double amount;
@override final  String currency;

/// Create a copy of CreatePaymentOrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePaymentOrderRequestCopyWith<_CreatePaymentOrderRequest> get copyWith => __$CreatePaymentOrderRequestCopyWithImpl<_CreatePaymentOrderRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePaymentOrderRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePaymentOrderRequest&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,amount,currency);

@override
String toString() {
  return 'CreatePaymentOrderRequest(planId: $planId, amount: $amount, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$CreatePaymentOrderRequestCopyWith<$Res> implements $CreatePaymentOrderRequestCopyWith<$Res> {
  factory _$CreatePaymentOrderRequestCopyWith(_CreatePaymentOrderRequest value, $Res Function(_CreatePaymentOrderRequest) _then) = __$CreatePaymentOrderRequestCopyWithImpl;
@override @useResult
$Res call({
 int planId, double amount, String currency
});




}
/// @nodoc
class __$CreatePaymentOrderRequestCopyWithImpl<$Res>
    implements _$CreatePaymentOrderRequestCopyWith<$Res> {
  __$CreatePaymentOrderRequestCopyWithImpl(this._self, this._then);

  final _CreatePaymentOrderRequest _self;
  final $Res Function(_CreatePaymentOrderRequest) _then;

/// Create a copy of CreatePaymentOrderRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planId = null,Object? amount = null,Object? currency = null,}) {
  return _then(_CreatePaymentOrderRequest(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CreatePaymentOrderResponse {

 String get orderId; String get razorpayOrderId; double get amount; String get currency; String get key; int get transactionId;
/// Create a copy of CreatePaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePaymentOrderResponseCopyWith<CreatePaymentOrderResponse> get copyWith => _$CreatePaymentOrderResponseCopyWithImpl<CreatePaymentOrderResponse>(this as CreatePaymentOrderResponse, _$identity);

  /// Serializes this CreatePaymentOrderResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePaymentOrderResponse&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.key, key) || other.key == key)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,razorpayOrderId,amount,currency,key,transactionId);

@override
String toString() {
  return 'CreatePaymentOrderResponse(orderId: $orderId, razorpayOrderId: $razorpayOrderId, amount: $amount, currency: $currency, key: $key, transactionId: $transactionId)';
}


}

/// @nodoc
abstract mixin class $CreatePaymentOrderResponseCopyWith<$Res>  {
  factory $CreatePaymentOrderResponseCopyWith(CreatePaymentOrderResponse value, $Res Function(CreatePaymentOrderResponse) _then) = _$CreatePaymentOrderResponseCopyWithImpl;
@useResult
$Res call({
 String orderId, String razorpayOrderId, double amount, String currency, String key, int transactionId
});




}
/// @nodoc
class _$CreatePaymentOrderResponseCopyWithImpl<$Res>
    implements $CreatePaymentOrderResponseCopyWith<$Res> {
  _$CreatePaymentOrderResponseCopyWithImpl(this._self, this._then);

  final CreatePaymentOrderResponse _self;
  final $Res Function(CreatePaymentOrderResponse) _then;

/// Create a copy of CreatePaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? razorpayOrderId = null,Object? amount = null,Object? currency = null,Object? key = null,Object? transactionId = null,}) {
  return _then(_self.copyWith(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,razorpayOrderId: null == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePaymentOrderResponse].
extension CreatePaymentOrderResponsePatterns on CreatePaymentOrderResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePaymentOrderResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePaymentOrderResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePaymentOrderResponse value)  $default,){
final _that = this;
switch (_that) {
case _CreatePaymentOrderResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePaymentOrderResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePaymentOrderResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orderId,  String razorpayOrderId,  double amount,  String currency,  String key,  int transactionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePaymentOrderResponse() when $default != null:
return $default(_that.orderId,_that.razorpayOrderId,_that.amount,_that.currency,_that.key,_that.transactionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orderId,  String razorpayOrderId,  double amount,  String currency,  String key,  int transactionId)  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentOrderResponse():
return $default(_that.orderId,_that.razorpayOrderId,_that.amount,_that.currency,_that.key,_that.transactionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orderId,  String razorpayOrderId,  double amount,  String currency,  String key,  int transactionId)?  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentOrderResponse() when $default != null:
return $default(_that.orderId,_that.razorpayOrderId,_that.amount,_that.currency,_that.key,_that.transactionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePaymentOrderResponse implements CreatePaymentOrderResponse {
  const _CreatePaymentOrderResponse({required this.orderId, required this.razorpayOrderId, required this.amount, required this.currency, required this.key, required this.transactionId});
  factory _CreatePaymentOrderResponse.fromJson(Map<String, dynamic> json) => _$CreatePaymentOrderResponseFromJson(json);

@override final  String orderId;
@override final  String razorpayOrderId;
@override final  double amount;
@override final  String currency;
@override final  String key;
@override final  int transactionId;

/// Create a copy of CreatePaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePaymentOrderResponseCopyWith<_CreatePaymentOrderResponse> get copyWith => __$CreatePaymentOrderResponseCopyWithImpl<_CreatePaymentOrderResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePaymentOrderResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePaymentOrderResponse&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.key, key) || other.key == key)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,razorpayOrderId,amount,currency,key,transactionId);

@override
String toString() {
  return 'CreatePaymentOrderResponse(orderId: $orderId, razorpayOrderId: $razorpayOrderId, amount: $amount, currency: $currency, key: $key, transactionId: $transactionId)';
}


}

/// @nodoc
abstract mixin class _$CreatePaymentOrderResponseCopyWith<$Res> implements $CreatePaymentOrderResponseCopyWith<$Res> {
  factory _$CreatePaymentOrderResponseCopyWith(_CreatePaymentOrderResponse value, $Res Function(_CreatePaymentOrderResponse) _then) = __$CreatePaymentOrderResponseCopyWithImpl;
@override @useResult
$Res call({
 String orderId, String razorpayOrderId, double amount, String currency, String key, int transactionId
});




}
/// @nodoc
class __$CreatePaymentOrderResponseCopyWithImpl<$Res>
    implements _$CreatePaymentOrderResponseCopyWith<$Res> {
  __$CreatePaymentOrderResponseCopyWithImpl(this._self, this._then);

  final _CreatePaymentOrderResponse _self;
  final $Res Function(_CreatePaymentOrderResponse) _then;

/// Create a copy of CreatePaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? razorpayOrderId = null,Object? amount = null,Object? currency = null,Object? key = null,Object? transactionId = null,}) {
  return _then(_CreatePaymentOrderResponse(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,razorpayOrderId: null == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$VerifyPaymentRequest {

 String get razorpayPaymentId; String get razorpayOrderId; String get razorpaySignature; int get transactionId;
/// Create a copy of VerifyPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyPaymentRequestCopyWith<VerifyPaymentRequest> get copyWith => _$VerifyPaymentRequestCopyWithImpl<VerifyPaymentRequest>(this as VerifyPaymentRequest, _$identity);

  /// Serializes this VerifyPaymentRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyPaymentRequest&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpaySignature, razorpaySignature) || other.razorpaySignature == razorpaySignature)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,razorpayPaymentId,razorpayOrderId,razorpaySignature,transactionId);

@override
String toString() {
  return 'VerifyPaymentRequest(razorpayPaymentId: $razorpayPaymentId, razorpayOrderId: $razorpayOrderId, razorpaySignature: $razorpaySignature, transactionId: $transactionId)';
}


}

/// @nodoc
abstract mixin class $VerifyPaymentRequestCopyWith<$Res>  {
  factory $VerifyPaymentRequestCopyWith(VerifyPaymentRequest value, $Res Function(VerifyPaymentRequest) _then) = _$VerifyPaymentRequestCopyWithImpl;
@useResult
$Res call({
 String razorpayPaymentId, String razorpayOrderId, String razorpaySignature, int transactionId
});




}
/// @nodoc
class _$VerifyPaymentRequestCopyWithImpl<$Res>
    implements $VerifyPaymentRequestCopyWith<$Res> {
  _$VerifyPaymentRequestCopyWithImpl(this._self, this._then);

  final VerifyPaymentRequest _self;
  final $Res Function(VerifyPaymentRequest) _then;

/// Create a copy of VerifyPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? razorpayPaymentId = null,Object? razorpayOrderId = null,Object? razorpaySignature = null,Object? transactionId = null,}) {
  return _then(_self.copyWith(
razorpayPaymentId: null == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String,razorpayOrderId: null == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String,razorpaySignature: null == razorpaySignature ? _self.razorpaySignature : razorpaySignature // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyPaymentRequest].
extension VerifyPaymentRequestPatterns on VerifyPaymentRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyPaymentRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyPaymentRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyPaymentRequest value)  $default,){
final _that = this;
switch (_that) {
case _VerifyPaymentRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyPaymentRequest value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyPaymentRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String razorpayPaymentId,  String razorpayOrderId,  String razorpaySignature,  int transactionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyPaymentRequest() when $default != null:
return $default(_that.razorpayPaymentId,_that.razorpayOrderId,_that.razorpaySignature,_that.transactionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String razorpayPaymentId,  String razorpayOrderId,  String razorpaySignature,  int transactionId)  $default,) {final _that = this;
switch (_that) {
case _VerifyPaymentRequest():
return $default(_that.razorpayPaymentId,_that.razorpayOrderId,_that.razorpaySignature,_that.transactionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String razorpayPaymentId,  String razorpayOrderId,  String razorpaySignature,  int transactionId)?  $default,) {final _that = this;
switch (_that) {
case _VerifyPaymentRequest() when $default != null:
return $default(_that.razorpayPaymentId,_that.razorpayOrderId,_that.razorpaySignature,_that.transactionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyPaymentRequest implements VerifyPaymentRequest {
  const _VerifyPaymentRequest({required this.razorpayPaymentId, required this.razorpayOrderId, required this.razorpaySignature, required this.transactionId});
  factory _VerifyPaymentRequest.fromJson(Map<String, dynamic> json) => _$VerifyPaymentRequestFromJson(json);

@override final  String razorpayPaymentId;
@override final  String razorpayOrderId;
@override final  String razorpaySignature;
@override final  int transactionId;

/// Create a copy of VerifyPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyPaymentRequestCopyWith<_VerifyPaymentRequest> get copyWith => __$VerifyPaymentRequestCopyWithImpl<_VerifyPaymentRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyPaymentRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyPaymentRequest&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpaySignature, razorpaySignature) || other.razorpaySignature == razorpaySignature)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,razorpayPaymentId,razorpayOrderId,razorpaySignature,transactionId);

@override
String toString() {
  return 'VerifyPaymentRequest(razorpayPaymentId: $razorpayPaymentId, razorpayOrderId: $razorpayOrderId, razorpaySignature: $razorpaySignature, transactionId: $transactionId)';
}


}

/// @nodoc
abstract mixin class _$VerifyPaymentRequestCopyWith<$Res> implements $VerifyPaymentRequestCopyWith<$Res> {
  factory _$VerifyPaymentRequestCopyWith(_VerifyPaymentRequest value, $Res Function(_VerifyPaymentRequest) _then) = __$VerifyPaymentRequestCopyWithImpl;
@override @useResult
$Res call({
 String razorpayPaymentId, String razorpayOrderId, String razorpaySignature, int transactionId
});




}
/// @nodoc
class __$VerifyPaymentRequestCopyWithImpl<$Res>
    implements _$VerifyPaymentRequestCopyWith<$Res> {
  __$VerifyPaymentRequestCopyWithImpl(this._self, this._then);

  final _VerifyPaymentRequest _self;
  final $Res Function(_VerifyPaymentRequest) _then;

/// Create a copy of VerifyPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? razorpayPaymentId = null,Object? razorpayOrderId = null,Object? razorpaySignature = null,Object? transactionId = null,}) {
  return _then(_VerifyPaymentRequest(
razorpayPaymentId: null == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String,razorpayOrderId: null == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String,razorpaySignature: null == razorpaySignature ? _self.razorpaySignature : razorpaySignature // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PaymentVerificationResponse {

 bool get success; String get message; String? get subscriptionId;
/// Create a copy of PaymentVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentVerificationResponseCopyWith<PaymentVerificationResponse> get copyWith => _$PaymentVerificationResponseCopyWithImpl<PaymentVerificationResponse>(this as PaymentVerificationResponse, _$identity);

  /// Serializes this PaymentVerificationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentVerificationResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,subscriptionId);

@override
String toString() {
  return 'PaymentVerificationResponse(success: $success, message: $message, subscriptionId: $subscriptionId)';
}


}

/// @nodoc
abstract mixin class $PaymentVerificationResponseCopyWith<$Res>  {
  factory $PaymentVerificationResponseCopyWith(PaymentVerificationResponse value, $Res Function(PaymentVerificationResponse) _then) = _$PaymentVerificationResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, String? subscriptionId
});




}
/// @nodoc
class _$PaymentVerificationResponseCopyWithImpl<$Res>
    implements $PaymentVerificationResponseCopyWith<$Res> {
  _$PaymentVerificationResponseCopyWithImpl(this._self, this._then);

  final PaymentVerificationResponse _self;
  final $Res Function(PaymentVerificationResponse) _then;

/// Create a copy of PaymentVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? subscriptionId = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentVerificationResponse].
extension PaymentVerificationResponsePatterns on PaymentVerificationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentVerificationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentVerificationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentVerificationResponse value)  $default,){
final _that = this;
switch (_that) {
case _PaymentVerificationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentVerificationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentVerificationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  String? subscriptionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentVerificationResponse() when $default != null:
return $default(_that.success,_that.message,_that.subscriptionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  String? subscriptionId)  $default,) {final _that = this;
switch (_that) {
case _PaymentVerificationResponse():
return $default(_that.success,_that.message,_that.subscriptionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  String? subscriptionId)?  $default,) {final _that = this;
switch (_that) {
case _PaymentVerificationResponse() when $default != null:
return $default(_that.success,_that.message,_that.subscriptionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentVerificationResponse implements PaymentVerificationResponse {
  const _PaymentVerificationResponse({required this.success, required this.message, this.subscriptionId});
  factory _PaymentVerificationResponse.fromJson(Map<String, dynamic> json) => _$PaymentVerificationResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  String? subscriptionId;

/// Create a copy of PaymentVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentVerificationResponseCopyWith<_PaymentVerificationResponse> get copyWith => __$PaymentVerificationResponseCopyWithImpl<_PaymentVerificationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentVerificationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentVerificationResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,subscriptionId);

@override
String toString() {
  return 'PaymentVerificationResponse(success: $success, message: $message, subscriptionId: $subscriptionId)';
}


}

/// @nodoc
abstract mixin class _$PaymentVerificationResponseCopyWith<$Res> implements $PaymentVerificationResponseCopyWith<$Res> {
  factory _$PaymentVerificationResponseCopyWith(_PaymentVerificationResponse value, $Res Function(_PaymentVerificationResponse) _then) = __$PaymentVerificationResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, String? subscriptionId
});




}
/// @nodoc
class __$PaymentVerificationResponseCopyWithImpl<$Res>
    implements _$PaymentVerificationResponseCopyWith<$Res> {
  __$PaymentVerificationResponseCopyWithImpl(this._self, this._then);

  final _PaymentVerificationResponse _self;
  final $Res Function(_PaymentVerificationResponse) _then;

/// Create a copy of PaymentVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? subscriptionId = freezed,}) {
  return _then(_PaymentVerificationResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PurchaseSubscriptionRequest {

 int get planId; bool get autoRenew; String? get paymentMethod;
/// Create a copy of PurchaseSubscriptionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseSubscriptionRequestCopyWith<PurchaseSubscriptionRequest> get copyWith => _$PurchaseSubscriptionRequestCopyWithImpl<PurchaseSubscriptionRequest>(this as PurchaseSubscriptionRequest, _$identity);

  /// Serializes this PurchaseSubscriptionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseSubscriptionRequest&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,autoRenew,paymentMethod);

@override
String toString() {
  return 'PurchaseSubscriptionRequest(planId: $planId, autoRenew: $autoRenew, paymentMethod: $paymentMethod)';
}


}

/// @nodoc
abstract mixin class $PurchaseSubscriptionRequestCopyWith<$Res>  {
  factory $PurchaseSubscriptionRequestCopyWith(PurchaseSubscriptionRequest value, $Res Function(PurchaseSubscriptionRequest) _then) = _$PurchaseSubscriptionRequestCopyWithImpl;
@useResult
$Res call({
 int planId, bool autoRenew, String? paymentMethod
});




}
/// @nodoc
class _$PurchaseSubscriptionRequestCopyWithImpl<$Res>
    implements $PurchaseSubscriptionRequestCopyWith<$Res> {
  _$PurchaseSubscriptionRequestCopyWithImpl(this._self, this._then);

  final PurchaseSubscriptionRequest _self;
  final $Res Function(PurchaseSubscriptionRequest) _then;

/// Create a copy of PurchaseSubscriptionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planId = null,Object? autoRenew = null,Object? paymentMethod = freezed,}) {
  return _then(_self.copyWith(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseSubscriptionRequest].
extension PurchaseSubscriptionRequestPatterns on PurchaseSubscriptionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseSubscriptionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseSubscriptionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseSubscriptionRequest value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseSubscriptionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseSubscriptionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseSubscriptionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int planId,  bool autoRenew,  String? paymentMethod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseSubscriptionRequest() when $default != null:
return $default(_that.planId,_that.autoRenew,_that.paymentMethod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int planId,  bool autoRenew,  String? paymentMethod)  $default,) {final _that = this;
switch (_that) {
case _PurchaseSubscriptionRequest():
return $default(_that.planId,_that.autoRenew,_that.paymentMethod);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int planId,  bool autoRenew,  String? paymentMethod)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseSubscriptionRequest() when $default != null:
return $default(_that.planId,_that.autoRenew,_that.paymentMethod);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PurchaseSubscriptionRequest implements PurchaseSubscriptionRequest {
  const _PurchaseSubscriptionRequest({required this.planId, this.autoRenew = false, this.paymentMethod});
  factory _PurchaseSubscriptionRequest.fromJson(Map<String, dynamic> json) => _$PurchaseSubscriptionRequestFromJson(json);

@override final  int planId;
@override@JsonKey() final  bool autoRenew;
@override final  String? paymentMethod;

/// Create a copy of PurchaseSubscriptionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseSubscriptionRequestCopyWith<_PurchaseSubscriptionRequest> get copyWith => __$PurchaseSubscriptionRequestCopyWithImpl<_PurchaseSubscriptionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchaseSubscriptionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseSubscriptionRequest&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,autoRenew,paymentMethod);

@override
String toString() {
  return 'PurchaseSubscriptionRequest(planId: $planId, autoRenew: $autoRenew, paymentMethod: $paymentMethod)';
}


}

/// @nodoc
abstract mixin class _$PurchaseSubscriptionRequestCopyWith<$Res> implements $PurchaseSubscriptionRequestCopyWith<$Res> {
  factory _$PurchaseSubscriptionRequestCopyWith(_PurchaseSubscriptionRequest value, $Res Function(_PurchaseSubscriptionRequest) _then) = __$PurchaseSubscriptionRequestCopyWithImpl;
@override @useResult
$Res call({
 int planId, bool autoRenew, String? paymentMethod
});




}
/// @nodoc
class __$PurchaseSubscriptionRequestCopyWithImpl<$Res>
    implements _$PurchaseSubscriptionRequestCopyWith<$Res> {
  __$PurchaseSubscriptionRequestCopyWithImpl(this._self, this._then);

  final _PurchaseSubscriptionRequest _self;
  final $Res Function(_PurchaseSubscriptionRequest) _then;

/// Create a copy of PurchaseSubscriptionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planId = null,Object? autoRenew = null,Object? paymentMethod = freezed,}) {
  return _then(_PurchaseSubscriptionRequest(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PurchaseSubscriptionResponse {

 bool get success; String get message; String? get subscriptionId; DateTime? get startDate; DateTime? get endDate;
/// Create a copy of PurchaseSubscriptionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseSubscriptionResponseCopyWith<PurchaseSubscriptionResponse> get copyWith => _$PurchaseSubscriptionResponseCopyWithImpl<PurchaseSubscriptionResponse>(this as PurchaseSubscriptionResponse, _$identity);

  /// Serializes this PurchaseSubscriptionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseSubscriptionResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,subscriptionId,startDate,endDate);

@override
String toString() {
  return 'PurchaseSubscriptionResponse(success: $success, message: $message, subscriptionId: $subscriptionId, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $PurchaseSubscriptionResponseCopyWith<$Res>  {
  factory $PurchaseSubscriptionResponseCopyWith(PurchaseSubscriptionResponse value, $Res Function(PurchaseSubscriptionResponse) _then) = _$PurchaseSubscriptionResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, String? subscriptionId, DateTime? startDate, DateTime? endDate
});




}
/// @nodoc
class _$PurchaseSubscriptionResponseCopyWithImpl<$Res>
    implements $PurchaseSubscriptionResponseCopyWith<$Res> {
  _$PurchaseSubscriptionResponseCopyWithImpl(this._self, this._then);

  final PurchaseSubscriptionResponse _self;
  final $Res Function(PurchaseSubscriptionResponse) _then;

/// Create a copy of PurchaseSubscriptionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? subscriptionId = freezed,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseSubscriptionResponse].
extension PurchaseSubscriptionResponsePatterns on PurchaseSubscriptionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseSubscriptionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseSubscriptionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseSubscriptionResponse value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseSubscriptionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseSubscriptionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseSubscriptionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  String? subscriptionId,  DateTime? startDate,  DateTime? endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseSubscriptionResponse() when $default != null:
return $default(_that.success,_that.message,_that.subscriptionId,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  String? subscriptionId,  DateTime? startDate,  DateTime? endDate)  $default,) {final _that = this;
switch (_that) {
case _PurchaseSubscriptionResponse():
return $default(_that.success,_that.message,_that.subscriptionId,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  String? subscriptionId,  DateTime? startDate,  DateTime? endDate)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseSubscriptionResponse() when $default != null:
return $default(_that.success,_that.message,_that.subscriptionId,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PurchaseSubscriptionResponse implements PurchaseSubscriptionResponse {
  const _PurchaseSubscriptionResponse({required this.success, required this.message, this.subscriptionId, this.startDate, this.endDate});
  factory _PurchaseSubscriptionResponse.fromJson(Map<String, dynamic> json) => _$PurchaseSubscriptionResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  String? subscriptionId;
@override final  DateTime? startDate;
@override final  DateTime? endDate;

/// Create a copy of PurchaseSubscriptionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseSubscriptionResponseCopyWith<_PurchaseSubscriptionResponse> get copyWith => __$PurchaseSubscriptionResponseCopyWithImpl<_PurchaseSubscriptionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchaseSubscriptionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseSubscriptionResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,subscriptionId,startDate,endDate);

@override
String toString() {
  return 'PurchaseSubscriptionResponse(success: $success, message: $message, subscriptionId: $subscriptionId, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$PurchaseSubscriptionResponseCopyWith<$Res> implements $PurchaseSubscriptionResponseCopyWith<$Res> {
  factory _$PurchaseSubscriptionResponseCopyWith(_PurchaseSubscriptionResponse value, $Res Function(_PurchaseSubscriptionResponse) _then) = __$PurchaseSubscriptionResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, String? subscriptionId, DateTime? startDate, DateTime? endDate
});




}
/// @nodoc
class __$PurchaseSubscriptionResponseCopyWithImpl<$Res>
    implements _$PurchaseSubscriptionResponseCopyWith<$Res> {
  __$PurchaseSubscriptionResponseCopyWithImpl(this._self, this._then);

  final _PurchaseSubscriptionResponse _self;
  final $Res Function(_PurchaseSubscriptionResponse) _then;

/// Create a copy of PurchaseSubscriptionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? subscriptionId = freezed,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_PurchaseSubscriptionResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
