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

 int get planId; bool get autoRenew;
/// Create a copy of CreatePaymentOrderRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePaymentOrderRequestCopyWith<CreatePaymentOrderRequest> get copyWith => _$CreatePaymentOrderRequestCopyWithImpl<CreatePaymentOrderRequest>(this as CreatePaymentOrderRequest, _$identity);

  /// Serializes this CreatePaymentOrderRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePaymentOrderRequest&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,autoRenew);

@override
String toString() {
  return 'CreatePaymentOrderRequest(planId: $planId, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class $CreatePaymentOrderRequestCopyWith<$Res>  {
  factory $CreatePaymentOrderRequestCopyWith(CreatePaymentOrderRequest value, $Res Function(CreatePaymentOrderRequest) _then) = _$CreatePaymentOrderRequestCopyWithImpl;
@useResult
$Res call({
 int planId, bool autoRenew
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
@pragma('vm:prefer-inline') @override $Res call({Object? planId = null,Object? autoRenew = null,}) {
  return _then(_self.copyWith(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int planId,  bool autoRenew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePaymentOrderRequest() when $default != null:
return $default(_that.planId,_that.autoRenew);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int planId,  bool autoRenew)  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentOrderRequest():
return $default(_that.planId,_that.autoRenew);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int planId,  bool autoRenew)?  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentOrderRequest() when $default != null:
return $default(_that.planId,_that.autoRenew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePaymentOrderRequest implements CreatePaymentOrderRequest {
  const _CreatePaymentOrderRequest({required this.planId, this.autoRenew = false});
  factory _CreatePaymentOrderRequest.fromJson(Map<String, dynamic> json) => _$CreatePaymentOrderRequestFromJson(json);

@override final  int planId;
@override@JsonKey() final  bool autoRenew;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePaymentOrderRequest&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,autoRenew);

@override
String toString() {
  return 'CreatePaymentOrderRequest(planId: $planId, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class _$CreatePaymentOrderRequestCopyWith<$Res> implements $CreatePaymentOrderRequestCopyWith<$Res> {
  factory _$CreatePaymentOrderRequestCopyWith(_CreatePaymentOrderRequest value, $Res Function(_CreatePaymentOrderRequest) _then) = __$CreatePaymentOrderRequestCopyWithImpl;
@override @useResult
$Res call({
 int planId, bool autoRenew
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
@override @pragma('vm:prefer-inline') $Res call({Object? planId = null,Object? autoRenew = null,}) {
  return _then(_CreatePaymentOrderRequest(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CreatePaymentOrderResponse {

 String get orderId; int get amount; String get currency; String get receipt; int get transactionId; String get razorpayKeyId; PlanDetailsDto? get planDetails;
/// Create a copy of CreatePaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePaymentOrderResponseCopyWith<CreatePaymentOrderResponse> get copyWith => _$CreatePaymentOrderResponseCopyWithImpl<CreatePaymentOrderResponse>(this as CreatePaymentOrderResponse, _$identity);

  /// Serializes this CreatePaymentOrderResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePaymentOrderResponse&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.receipt, receipt) || other.receipt == receipt)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.razorpayKeyId, razorpayKeyId) || other.razorpayKeyId == razorpayKeyId)&&(identical(other.planDetails, planDetails) || other.planDetails == planDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,amount,currency,receipt,transactionId,razorpayKeyId,planDetails);

@override
String toString() {
  return 'CreatePaymentOrderResponse(orderId: $orderId, amount: $amount, currency: $currency, receipt: $receipt, transactionId: $transactionId, razorpayKeyId: $razorpayKeyId, planDetails: $planDetails)';
}


}

/// @nodoc
abstract mixin class $CreatePaymentOrderResponseCopyWith<$Res>  {
  factory $CreatePaymentOrderResponseCopyWith(CreatePaymentOrderResponse value, $Res Function(CreatePaymentOrderResponse) _then) = _$CreatePaymentOrderResponseCopyWithImpl;
@useResult
$Res call({
 String orderId, int amount, String currency, String receipt, int transactionId, String razorpayKeyId, PlanDetailsDto? planDetails
});


$PlanDetailsDtoCopyWith<$Res>? get planDetails;

}
/// @nodoc
class _$CreatePaymentOrderResponseCopyWithImpl<$Res>
    implements $CreatePaymentOrderResponseCopyWith<$Res> {
  _$CreatePaymentOrderResponseCopyWithImpl(this._self, this._then);

  final CreatePaymentOrderResponse _self;
  final $Res Function(CreatePaymentOrderResponse) _then;

/// Create a copy of CreatePaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? amount = null,Object? currency = null,Object? receipt = null,Object? transactionId = null,Object? razorpayKeyId = null,Object? planDetails = freezed,}) {
  return _then(_self.copyWith(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,receipt: null == receipt ? _self.receipt : receipt // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,razorpayKeyId: null == razorpayKeyId ? _self.razorpayKeyId : razorpayKeyId // ignore: cast_nullable_to_non_nullable
as String,planDetails: freezed == planDetails ? _self.planDetails : planDetails // ignore: cast_nullable_to_non_nullable
as PlanDetailsDto?,
  ));
}
/// Create a copy of CreatePaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanDetailsDtoCopyWith<$Res>? get planDetails {
    if (_self.planDetails == null) {
    return null;
  }

  return $PlanDetailsDtoCopyWith<$Res>(_self.planDetails!, (value) {
    return _then(_self.copyWith(planDetails: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String orderId,  int amount,  String currency,  String receipt,  int transactionId,  String razorpayKeyId,  PlanDetailsDto? planDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePaymentOrderResponse() when $default != null:
return $default(_that.orderId,_that.amount,_that.currency,_that.receipt,_that.transactionId,_that.razorpayKeyId,_that.planDetails);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String orderId,  int amount,  String currency,  String receipt,  int transactionId,  String razorpayKeyId,  PlanDetailsDto? planDetails)  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentOrderResponse():
return $default(_that.orderId,_that.amount,_that.currency,_that.receipt,_that.transactionId,_that.razorpayKeyId,_that.planDetails);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String orderId,  int amount,  String currency,  String receipt,  int transactionId,  String razorpayKeyId,  PlanDetailsDto? planDetails)?  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentOrderResponse() when $default != null:
return $default(_that.orderId,_that.amount,_that.currency,_that.receipt,_that.transactionId,_that.razorpayKeyId,_that.planDetails);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePaymentOrderResponse implements CreatePaymentOrderResponse {
  const _CreatePaymentOrderResponse({required this.orderId, required this.amount, required this.currency, required this.receipt, required this.transactionId, required this.razorpayKeyId, this.planDetails});
  factory _CreatePaymentOrderResponse.fromJson(Map<String, dynamic> json) => _$CreatePaymentOrderResponseFromJson(json);

@override final  String orderId;
@override final  int amount;
@override final  String currency;
@override final  String receipt;
@override final  int transactionId;
@override final  String razorpayKeyId;
@override final  PlanDetailsDto? planDetails;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePaymentOrderResponse&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.receipt, receipt) || other.receipt == receipt)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.razorpayKeyId, razorpayKeyId) || other.razorpayKeyId == razorpayKeyId)&&(identical(other.planDetails, planDetails) || other.planDetails == planDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,amount,currency,receipt,transactionId,razorpayKeyId,planDetails);

@override
String toString() {
  return 'CreatePaymentOrderResponse(orderId: $orderId, amount: $amount, currency: $currency, receipt: $receipt, transactionId: $transactionId, razorpayKeyId: $razorpayKeyId, planDetails: $planDetails)';
}


}

/// @nodoc
abstract mixin class _$CreatePaymentOrderResponseCopyWith<$Res> implements $CreatePaymentOrderResponseCopyWith<$Res> {
  factory _$CreatePaymentOrderResponseCopyWith(_CreatePaymentOrderResponse value, $Res Function(_CreatePaymentOrderResponse) _then) = __$CreatePaymentOrderResponseCopyWithImpl;
@override @useResult
$Res call({
 String orderId, int amount, String currency, String receipt, int transactionId, String razorpayKeyId, PlanDetailsDto? planDetails
});


@override $PlanDetailsDtoCopyWith<$Res>? get planDetails;

}
/// @nodoc
class __$CreatePaymentOrderResponseCopyWithImpl<$Res>
    implements _$CreatePaymentOrderResponseCopyWith<$Res> {
  __$CreatePaymentOrderResponseCopyWithImpl(this._self, this._then);

  final _CreatePaymentOrderResponse _self;
  final $Res Function(_CreatePaymentOrderResponse) _then;

/// Create a copy of CreatePaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? amount = null,Object? currency = null,Object? receipt = null,Object? transactionId = null,Object? razorpayKeyId = null,Object? planDetails = freezed,}) {
  return _then(_CreatePaymentOrderResponse(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,receipt: null == receipt ? _self.receipt : receipt // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,razorpayKeyId: null == razorpayKeyId ? _self.razorpayKeyId : razorpayKeyId // ignore: cast_nullable_to_non_nullable
as String,planDetails: freezed == planDetails ? _self.planDetails : planDetails // ignore: cast_nullable_to_non_nullable
as PlanDetailsDto?,
  ));
}

/// Create a copy of CreatePaymentOrderResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanDetailsDtoCopyWith<$Res>? get planDetails {
    if (_self.planDetails == null) {
    return null;
  }

  return $PlanDetailsDtoCopyWith<$Res>(_self.planDetails!, (value) {
    return _then(_self.copyWith(planDetails: value));
  });
}
}


/// @nodoc
mixin _$PlanDetailsDto {

 int get id; String get name; String? get description; double get price; int get durationMonths; String? get features; String? get imageUrl;
/// Create a copy of PlanDetailsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanDetailsDtoCopyWith<PlanDetailsDto> get copyWith => _$PlanDetailsDtoCopyWithImpl<PlanDetailsDto>(this as PlanDetailsDto, _$identity);

  /// Serializes this PlanDetailsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanDetailsDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.durationMonths, durationMonths) || other.durationMonths == durationMonths)&&(identical(other.features, features) || other.features == features)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,durationMonths,features,imageUrl);

@override
String toString() {
  return 'PlanDetailsDto(id: $id, name: $name, description: $description, price: $price, durationMonths: $durationMonths, features: $features, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $PlanDetailsDtoCopyWith<$Res>  {
  factory $PlanDetailsDtoCopyWith(PlanDetailsDto value, $Res Function(PlanDetailsDto) _then) = _$PlanDetailsDtoCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, double price, int durationMonths, String? features, String? imageUrl
});




}
/// @nodoc
class _$PlanDetailsDtoCopyWithImpl<$Res>
    implements $PlanDetailsDtoCopyWith<$Res> {
  _$PlanDetailsDtoCopyWithImpl(this._self, this._then);

  final PlanDetailsDto _self;
  final $Res Function(PlanDetailsDto) _then;

/// Create a copy of PlanDetailsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? price = null,Object? durationMonths = null,Object? features = freezed,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,durationMonths: null == durationMonths ? _self.durationMonths : durationMonths // ignore: cast_nullable_to_non_nullable
as int,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanDetailsDto].
extension PlanDetailsDtoPatterns on PlanDetailsDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanDetailsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanDetailsDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanDetailsDto value)  $default,){
final _that = this;
switch (_that) {
case _PlanDetailsDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanDetailsDto value)?  $default,){
final _that = this;
switch (_that) {
case _PlanDetailsDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  double price,  int durationMonths,  String? features,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanDetailsDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.durationMonths,_that.features,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  double price,  int durationMonths,  String? features,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _PlanDetailsDto():
return $default(_that.id,_that.name,_that.description,_that.price,_that.durationMonths,_that.features,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  double price,  int durationMonths,  String? features,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _PlanDetailsDto() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.durationMonths,_that.features,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanDetailsDto implements PlanDetailsDto {
  const _PlanDetailsDto({required this.id, required this.name, this.description, required this.price, required this.durationMonths, this.features, this.imageUrl});
  factory _PlanDetailsDto.fromJson(Map<String, dynamic> json) => _$PlanDetailsDtoFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override final  double price;
@override final  int durationMonths;
@override final  String? features;
@override final  String? imageUrl;

/// Create a copy of PlanDetailsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanDetailsDtoCopyWith<_PlanDetailsDto> get copyWith => __$PlanDetailsDtoCopyWithImpl<_PlanDetailsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanDetailsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanDetailsDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.durationMonths, durationMonths) || other.durationMonths == durationMonths)&&(identical(other.features, features) || other.features == features)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,durationMonths,features,imageUrl);

@override
String toString() {
  return 'PlanDetailsDto(id: $id, name: $name, description: $description, price: $price, durationMonths: $durationMonths, features: $features, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$PlanDetailsDtoCopyWith<$Res> implements $PlanDetailsDtoCopyWith<$Res> {
  factory _$PlanDetailsDtoCopyWith(_PlanDetailsDto value, $Res Function(_PlanDetailsDto) _then) = __$PlanDetailsDtoCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, double price, int durationMonths, String? features, String? imageUrl
});




}
/// @nodoc
class __$PlanDetailsDtoCopyWithImpl<$Res>
    implements _$PlanDetailsDtoCopyWith<$Res> {
  __$PlanDetailsDtoCopyWithImpl(this._self, this._then);

  final _PlanDetailsDto _self;
  final $Res Function(_PlanDetailsDto) _then;

/// Create a copy of PlanDetailsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? price = null,Object? durationMonths = null,Object? features = freezed,Object? imageUrl = freezed,}) {
  return _then(_PlanDetailsDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,durationMonths: null == durationMonths ? _self.durationMonths : durationMonths // ignore: cast_nullable_to_non_nullable
as int,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$VerifyPaymentRequest {

 int get transactionId; String get razorpayOrderId; String get razorpayPaymentId; String get razorpaySignature; bool get autoRenew;
/// Create a copy of VerifyPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyPaymentRequestCopyWith<VerifyPaymentRequest> get copyWith => _$VerifyPaymentRequestCopyWithImpl<VerifyPaymentRequest>(this as VerifyPaymentRequest, _$identity);

  /// Serializes this VerifyPaymentRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyPaymentRequest&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.razorpaySignature, razorpaySignature) || other.razorpaySignature == razorpaySignature)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,razorpayOrderId,razorpayPaymentId,razorpaySignature,autoRenew);

@override
String toString() {
  return 'VerifyPaymentRequest(transactionId: $transactionId, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, razorpaySignature: $razorpaySignature, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class $VerifyPaymentRequestCopyWith<$Res>  {
  factory $VerifyPaymentRequestCopyWith(VerifyPaymentRequest value, $Res Function(VerifyPaymentRequest) _then) = _$VerifyPaymentRequestCopyWithImpl;
@useResult
$Res call({
 int transactionId, String razorpayOrderId, String razorpayPaymentId, String razorpaySignature, bool autoRenew
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
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? razorpayOrderId = null,Object? razorpayPaymentId = null,Object? razorpaySignature = null,Object? autoRenew = null,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,razorpayOrderId: null == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String,razorpayPaymentId: null == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String,razorpaySignature: null == razorpaySignature ? _self.razorpaySignature : razorpaySignature // ignore: cast_nullable_to_non_nullable
as String,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int transactionId,  String razorpayOrderId,  String razorpayPaymentId,  String razorpaySignature,  bool autoRenew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyPaymentRequest() when $default != null:
return $default(_that.transactionId,_that.razorpayOrderId,_that.razorpayPaymentId,_that.razorpaySignature,_that.autoRenew);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int transactionId,  String razorpayOrderId,  String razorpayPaymentId,  String razorpaySignature,  bool autoRenew)  $default,) {final _that = this;
switch (_that) {
case _VerifyPaymentRequest():
return $default(_that.transactionId,_that.razorpayOrderId,_that.razorpayPaymentId,_that.razorpaySignature,_that.autoRenew);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int transactionId,  String razorpayOrderId,  String razorpayPaymentId,  String razorpaySignature,  bool autoRenew)?  $default,) {final _that = this;
switch (_that) {
case _VerifyPaymentRequest() when $default != null:
return $default(_that.transactionId,_that.razorpayOrderId,_that.razorpayPaymentId,_that.razorpaySignature,_that.autoRenew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyPaymentRequest implements VerifyPaymentRequest {
  const _VerifyPaymentRequest({required this.transactionId, required this.razorpayOrderId, required this.razorpayPaymentId, required this.razorpaySignature, this.autoRenew = false});
  factory _VerifyPaymentRequest.fromJson(Map<String, dynamic> json) => _$VerifyPaymentRequestFromJson(json);

@override final  int transactionId;
@override final  String razorpayOrderId;
@override final  String razorpayPaymentId;
@override final  String razorpaySignature;
@override@JsonKey() final  bool autoRenew;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyPaymentRequest&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.razorpaySignature, razorpaySignature) || other.razorpaySignature == razorpaySignature)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,razorpayOrderId,razorpayPaymentId,razorpaySignature,autoRenew);

@override
String toString() {
  return 'VerifyPaymentRequest(transactionId: $transactionId, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, razorpaySignature: $razorpaySignature, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class _$VerifyPaymentRequestCopyWith<$Res> implements $VerifyPaymentRequestCopyWith<$Res> {
  factory _$VerifyPaymentRequestCopyWith(_VerifyPaymentRequest value, $Res Function(_VerifyPaymentRequest) _then) = __$VerifyPaymentRequestCopyWithImpl;
@override @useResult
$Res call({
 int transactionId, String razorpayOrderId, String razorpayPaymentId, String razorpaySignature, bool autoRenew
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
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? razorpayOrderId = null,Object? razorpayPaymentId = null,Object? razorpaySignature = null,Object? autoRenew = null,}) {
  return _then(_VerifyPaymentRequest(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,razorpayOrderId: null == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String,razorpayPaymentId: null == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String,razorpaySignature: null == razorpaySignature ? _self.razorpaySignature : razorpaySignature // ignore: cast_nullable_to_non_nullable
as String,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$VerifyPaymentResponse {

 bool get success; String get message; int? get subscriptionId;
/// Create a copy of VerifyPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyPaymentResponseCopyWith<VerifyPaymentResponse> get copyWith => _$VerifyPaymentResponseCopyWithImpl<VerifyPaymentResponse>(this as VerifyPaymentResponse, _$identity);

  /// Serializes this VerifyPaymentResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyPaymentResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,subscriptionId);

@override
String toString() {
  return 'VerifyPaymentResponse(success: $success, message: $message, subscriptionId: $subscriptionId)';
}


}

/// @nodoc
abstract mixin class $VerifyPaymentResponseCopyWith<$Res>  {
  factory $VerifyPaymentResponseCopyWith(VerifyPaymentResponse value, $Res Function(VerifyPaymentResponse) _then) = _$VerifyPaymentResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, int? subscriptionId
});




}
/// @nodoc
class _$VerifyPaymentResponseCopyWithImpl<$Res>
    implements $VerifyPaymentResponseCopyWith<$Res> {
  _$VerifyPaymentResponseCopyWithImpl(this._self, this._then);

  final VerifyPaymentResponse _self;
  final $Res Function(VerifyPaymentResponse) _then;

/// Create a copy of VerifyPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? subscriptionId = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyPaymentResponse].
extension VerifyPaymentResponsePatterns on VerifyPaymentResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyPaymentResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyPaymentResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyPaymentResponse value)  $default,){
final _that = this;
switch (_that) {
case _VerifyPaymentResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyPaymentResponse value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyPaymentResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  int? subscriptionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyPaymentResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  int? subscriptionId)  $default,) {final _that = this;
switch (_that) {
case _VerifyPaymentResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  int? subscriptionId)?  $default,) {final _that = this;
switch (_that) {
case _VerifyPaymentResponse() when $default != null:
return $default(_that.success,_that.message,_that.subscriptionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyPaymentResponse implements VerifyPaymentResponse {
  const _VerifyPaymentResponse({required this.success, required this.message, this.subscriptionId});
  factory _VerifyPaymentResponse.fromJson(Map<String, dynamic> json) => _$VerifyPaymentResponseFromJson(json);

@override final  bool success;
@override final  String message;
@override final  int? subscriptionId;

/// Create a copy of VerifyPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyPaymentResponseCopyWith<_VerifyPaymentResponse> get copyWith => __$VerifyPaymentResponseCopyWithImpl<_VerifyPaymentResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyPaymentResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyPaymentResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,subscriptionId);

@override
String toString() {
  return 'VerifyPaymentResponse(success: $success, message: $message, subscriptionId: $subscriptionId)';
}


}

/// @nodoc
abstract mixin class _$VerifyPaymentResponseCopyWith<$Res> implements $VerifyPaymentResponseCopyWith<$Res> {
  factory _$VerifyPaymentResponseCopyWith(_VerifyPaymentResponse value, $Res Function(_VerifyPaymentResponse) _then) = __$VerifyPaymentResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, int? subscriptionId
});




}
/// @nodoc
class __$VerifyPaymentResponseCopyWithImpl<$Res>
    implements _$VerifyPaymentResponseCopyWith<$Res> {
  __$VerifyPaymentResponseCopyWithImpl(this._self, this._then);

  final _VerifyPaymentResponse _self;
  final $Res Function(_VerifyPaymentResponse) _then;

/// Create a copy of VerifyPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? subscriptionId = freezed,}) {
  return _then(_VerifyPaymentResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$PaymentStatusResponse {

 int get transactionId; String get status; double get amount; String? get paymentReference; String? get paymentOrderId; DateTime get createdAt; String? get failureReason; String? get planName;
/// Create a copy of PaymentStatusResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentStatusResponseCopyWith<PaymentStatusResponse> get copyWith => _$PaymentStatusResponseCopyWithImpl<PaymentStatusResponse>(this as PaymentStatusResponse, _$identity);

  /// Serializes this PaymentStatusResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentStatusResponse&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.paymentOrderId, paymentOrderId) || other.paymentOrderId == paymentOrderId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.planName, planName) || other.planName == planName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,status,amount,paymentReference,paymentOrderId,createdAt,failureReason,planName);

@override
String toString() {
  return 'PaymentStatusResponse(transactionId: $transactionId, status: $status, amount: $amount, paymentReference: $paymentReference, paymentOrderId: $paymentOrderId, createdAt: $createdAt, failureReason: $failureReason, planName: $planName)';
}


}

/// @nodoc
abstract mixin class $PaymentStatusResponseCopyWith<$Res>  {
  factory $PaymentStatusResponseCopyWith(PaymentStatusResponse value, $Res Function(PaymentStatusResponse) _then) = _$PaymentStatusResponseCopyWithImpl;
@useResult
$Res call({
 int transactionId, String status, double amount, String? paymentReference, String? paymentOrderId, DateTime createdAt, String? failureReason, String? planName
});




}
/// @nodoc
class _$PaymentStatusResponseCopyWithImpl<$Res>
    implements $PaymentStatusResponseCopyWith<$Res> {
  _$PaymentStatusResponseCopyWithImpl(this._self, this._then);

  final PaymentStatusResponse _self;
  final $Res Function(PaymentStatusResponse) _then;

/// Create a copy of PaymentStatusResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? status = null,Object? amount = null,Object? paymentReference = freezed,Object? paymentOrderId = freezed,Object? createdAt = null,Object? failureReason = freezed,Object? planName = freezed,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,paymentOrderId: freezed == paymentOrderId ? _self.paymentOrderId : paymentOrderId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentStatusResponse].
extension PaymentStatusResponsePatterns on PaymentStatusResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentStatusResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentStatusResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentStatusResponse value)  $default,){
final _that = this;
switch (_that) {
case _PaymentStatusResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentStatusResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentStatusResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int transactionId,  String status,  double amount,  String? paymentReference,  String? paymentOrderId,  DateTime createdAt,  String? failureReason,  String? planName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentStatusResponse() when $default != null:
return $default(_that.transactionId,_that.status,_that.amount,_that.paymentReference,_that.paymentOrderId,_that.createdAt,_that.failureReason,_that.planName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int transactionId,  String status,  double amount,  String? paymentReference,  String? paymentOrderId,  DateTime createdAt,  String? failureReason,  String? planName)  $default,) {final _that = this;
switch (_that) {
case _PaymentStatusResponse():
return $default(_that.transactionId,_that.status,_that.amount,_that.paymentReference,_that.paymentOrderId,_that.createdAt,_that.failureReason,_that.planName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int transactionId,  String status,  double amount,  String? paymentReference,  String? paymentOrderId,  DateTime createdAt,  String? failureReason,  String? planName)?  $default,) {final _that = this;
switch (_that) {
case _PaymentStatusResponse() when $default != null:
return $default(_that.transactionId,_that.status,_that.amount,_that.paymentReference,_that.paymentOrderId,_that.createdAt,_that.failureReason,_that.planName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentStatusResponse implements PaymentStatusResponse {
  const _PaymentStatusResponse({required this.transactionId, required this.status, required this.amount, this.paymentReference, this.paymentOrderId, required this.createdAt, this.failureReason, this.planName});
  factory _PaymentStatusResponse.fromJson(Map<String, dynamic> json) => _$PaymentStatusResponseFromJson(json);

@override final  int transactionId;
@override final  String status;
@override final  double amount;
@override final  String? paymentReference;
@override final  String? paymentOrderId;
@override final  DateTime createdAt;
@override final  String? failureReason;
@override final  String? planName;

/// Create a copy of PaymentStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentStatusResponseCopyWith<_PaymentStatusResponse> get copyWith => __$PaymentStatusResponseCopyWithImpl<_PaymentStatusResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentStatusResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentStatusResponse&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.paymentOrderId, paymentOrderId) || other.paymentOrderId == paymentOrderId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.planName, planName) || other.planName == planName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,status,amount,paymentReference,paymentOrderId,createdAt,failureReason,planName);

@override
String toString() {
  return 'PaymentStatusResponse(transactionId: $transactionId, status: $status, amount: $amount, paymentReference: $paymentReference, paymentOrderId: $paymentOrderId, createdAt: $createdAt, failureReason: $failureReason, planName: $planName)';
}


}

/// @nodoc
abstract mixin class _$PaymentStatusResponseCopyWith<$Res> implements $PaymentStatusResponseCopyWith<$Res> {
  factory _$PaymentStatusResponseCopyWith(_PaymentStatusResponse value, $Res Function(_PaymentStatusResponse) _then) = __$PaymentStatusResponseCopyWithImpl;
@override @useResult
$Res call({
 int transactionId, String status, double amount, String? paymentReference, String? paymentOrderId, DateTime createdAt, String? failureReason, String? planName
});




}
/// @nodoc
class __$PaymentStatusResponseCopyWithImpl<$Res>
    implements _$PaymentStatusResponseCopyWith<$Res> {
  __$PaymentStatusResponseCopyWithImpl(this._self, this._then);

  final _PaymentStatusResponse _self;
  final $Res Function(_PaymentStatusResponse) _then;

/// Create a copy of PaymentStatusResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? status = null,Object? amount = null,Object? paymentReference = freezed,Object? paymentOrderId = freezed,Object? createdAt = null,Object? failureReason = freezed,Object? planName = freezed,}) {
  return _then(_PaymentStatusResponse(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,paymentOrderId: freezed == paymentOrderId ? _self.paymentOrderId : paymentOrderId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
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
