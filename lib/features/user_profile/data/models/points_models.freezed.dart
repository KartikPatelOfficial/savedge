// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPointsResponseModel {

@JsonKey(name: 'pointsBalance') int get pointsBalance;@JsonKey(name: 'pointsExpiry') DateTime? get pointsExpiry;
/// Create a copy of UserPointsResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPointsResponseModelCopyWith<UserPointsResponseModel> get copyWith => _$UserPointsResponseModelCopyWithImpl<UserPointsResponseModel>(this as UserPointsResponseModel, _$identity);

  /// Serializes this UserPointsResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPointsResponseModel&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pointsBalance,pointsExpiry);

@override
String toString() {
  return 'UserPointsResponseModel(pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry)';
}


}

/// @nodoc
abstract mixin class $UserPointsResponseModelCopyWith<$Res>  {
  factory $UserPointsResponseModelCopyWith(UserPointsResponseModel value, $Res Function(UserPointsResponseModel) _then) = _$UserPointsResponseModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'pointsBalance') int pointsBalance,@JsonKey(name: 'pointsExpiry') DateTime? pointsExpiry
});




}
/// @nodoc
class _$UserPointsResponseModelCopyWithImpl<$Res>
    implements $UserPointsResponseModelCopyWith<$Res> {
  _$UserPointsResponseModelCopyWithImpl(this._self, this._then);

  final UserPointsResponseModel _self;
  final $Res Function(UserPointsResponseModel) _then;

/// Create a copy of UserPointsResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pointsBalance = null,Object? pointsExpiry = freezed,}) {
  return _then(_self.copyWith(
pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,pointsExpiry: freezed == pointsExpiry ? _self.pointsExpiry : pointsExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPointsResponseModel].
extension UserPointsResponseModelPatterns on UserPointsResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPointsResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPointsResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPointsResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _UserPointsResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPointsResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserPointsResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'pointsBalance')  int pointsBalance, @JsonKey(name: 'pointsExpiry')  DateTime? pointsExpiry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPointsResponseModel() when $default != null:
return $default(_that.pointsBalance,_that.pointsExpiry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'pointsBalance')  int pointsBalance, @JsonKey(name: 'pointsExpiry')  DateTime? pointsExpiry)  $default,) {final _that = this;
switch (_that) {
case _UserPointsResponseModel():
return $default(_that.pointsBalance,_that.pointsExpiry);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'pointsBalance')  int pointsBalance, @JsonKey(name: 'pointsExpiry')  DateTime? pointsExpiry)?  $default,) {final _that = this;
switch (_that) {
case _UserPointsResponseModel() when $default != null:
return $default(_that.pointsBalance,_that.pointsExpiry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPointsResponseModel implements UserPointsResponseModel {
  const _UserPointsResponseModel({@JsonKey(name: 'pointsBalance') required this.pointsBalance, @JsonKey(name: 'pointsExpiry') this.pointsExpiry});
  factory _UserPointsResponseModel.fromJson(Map<String, dynamic> json) => _$UserPointsResponseModelFromJson(json);

@override@JsonKey(name: 'pointsBalance') final  int pointsBalance;
@override@JsonKey(name: 'pointsExpiry') final  DateTime? pointsExpiry;

/// Create a copy of UserPointsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPointsResponseModelCopyWith<_UserPointsResponseModel> get copyWith => __$UserPointsResponseModelCopyWithImpl<_UserPointsResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPointsResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPointsResponseModel&&(identical(other.pointsBalance, pointsBalance) || other.pointsBalance == pointsBalance)&&(identical(other.pointsExpiry, pointsExpiry) || other.pointsExpiry == pointsExpiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pointsBalance,pointsExpiry);

@override
String toString() {
  return 'UserPointsResponseModel(pointsBalance: $pointsBalance, pointsExpiry: $pointsExpiry)';
}


}

/// @nodoc
abstract mixin class _$UserPointsResponseModelCopyWith<$Res> implements $UserPointsResponseModelCopyWith<$Res> {
  factory _$UserPointsResponseModelCopyWith(_UserPointsResponseModel value, $Res Function(_UserPointsResponseModel) _then) = __$UserPointsResponseModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'pointsBalance') int pointsBalance,@JsonKey(name: 'pointsExpiry') DateTime? pointsExpiry
});




}
/// @nodoc
class __$UserPointsResponseModelCopyWithImpl<$Res>
    implements _$UserPointsResponseModelCopyWith<$Res> {
  __$UserPointsResponseModelCopyWithImpl(this._self, this._then);

  final _UserPointsResponseModel _self;
  final $Res Function(_UserPointsResponseModel) _then;

/// Create a copy of UserPointsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pointsBalance = null,Object? pointsExpiry = freezed,}) {
  return _then(_UserPointsResponseModel(
pointsBalance: null == pointsBalance ? _self.pointsBalance : pointsBalance // ignore: cast_nullable_to_non_nullable
as int,pointsExpiry: freezed == pointsExpiry ? _self.pointsExpiry : pointsExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PointTransactionModel {

 int get id;@JsonKey(name: 'pointsDelta') int get pointsDelta; String get type; String get description;@JsonKey(name: 'transactionDate') DateTime get transactionDate;@JsonKey(name: 'expiryDate') DateTime? get expiryDate;@JsonKey(name: 'relatedCouponId') int? get relatedCouponId;@JsonKey(name: 'relatedSubscriptionId') int? get relatedSubscriptionId;@JsonKey(name: 'referenceId') String? get referenceId;
/// Create a copy of PointTransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointTransactionModelCopyWith<PointTransactionModel> get copyWith => _$PointTransactionModelCopyWithImpl<PointTransactionModel>(this as PointTransactionModel, _$identity);

  /// Serializes this PointTransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointTransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.pointsDelta, pointsDelta) || other.pointsDelta == pointsDelta)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.relatedCouponId, relatedCouponId) || other.relatedCouponId == relatedCouponId)&&(identical(other.relatedSubscriptionId, relatedSubscriptionId) || other.relatedSubscriptionId == relatedSubscriptionId)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pointsDelta,type,description,transactionDate,expiryDate,relatedCouponId,relatedSubscriptionId,referenceId);

@override
String toString() {
  return 'PointTransactionModel(id: $id, pointsDelta: $pointsDelta, type: $type, description: $description, transactionDate: $transactionDate, expiryDate: $expiryDate, relatedCouponId: $relatedCouponId, relatedSubscriptionId: $relatedSubscriptionId, referenceId: $referenceId)';
}


}

/// @nodoc
abstract mixin class $PointTransactionModelCopyWith<$Res>  {
  factory $PointTransactionModelCopyWith(PointTransactionModel value, $Res Function(PointTransactionModel) _then) = _$PointTransactionModelCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'pointsDelta') int pointsDelta, String type, String description,@JsonKey(name: 'transactionDate') DateTime transactionDate,@JsonKey(name: 'expiryDate') DateTime? expiryDate,@JsonKey(name: 'relatedCouponId') int? relatedCouponId,@JsonKey(name: 'relatedSubscriptionId') int? relatedSubscriptionId,@JsonKey(name: 'referenceId') String? referenceId
});




}
/// @nodoc
class _$PointTransactionModelCopyWithImpl<$Res>
    implements $PointTransactionModelCopyWith<$Res> {
  _$PointTransactionModelCopyWithImpl(this._self, this._then);

  final PointTransactionModel _self;
  final $Res Function(PointTransactionModel) _then;

/// Create a copy of PointTransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? pointsDelta = null,Object? type = null,Object? description = null,Object? transactionDate = null,Object? expiryDate = freezed,Object? relatedCouponId = freezed,Object? relatedSubscriptionId = freezed,Object? referenceId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pointsDelta: null == pointsDelta ? _self.pointsDelta : pointsDelta // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,transactionDate: null == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,relatedCouponId: freezed == relatedCouponId ? _self.relatedCouponId : relatedCouponId // ignore: cast_nullable_to_non_nullable
as int?,relatedSubscriptionId: freezed == relatedSubscriptionId ? _self.relatedSubscriptionId : relatedSubscriptionId // ignore: cast_nullable_to_non_nullable
as int?,referenceId: freezed == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PointTransactionModel].
extension PointTransactionModelPatterns on PointTransactionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointTransactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointTransactionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointTransactionModel value)  $default,){
final _that = this;
switch (_that) {
case _PointTransactionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointTransactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _PointTransactionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'pointsDelta')  int pointsDelta,  String type,  String description, @JsonKey(name: 'transactionDate')  DateTime transactionDate, @JsonKey(name: 'expiryDate')  DateTime? expiryDate, @JsonKey(name: 'relatedCouponId')  int? relatedCouponId, @JsonKey(name: 'relatedSubscriptionId')  int? relatedSubscriptionId, @JsonKey(name: 'referenceId')  String? referenceId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointTransactionModel() when $default != null:
return $default(_that.id,_that.pointsDelta,_that.type,_that.description,_that.transactionDate,_that.expiryDate,_that.relatedCouponId,_that.relatedSubscriptionId,_that.referenceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'pointsDelta')  int pointsDelta,  String type,  String description, @JsonKey(name: 'transactionDate')  DateTime transactionDate, @JsonKey(name: 'expiryDate')  DateTime? expiryDate, @JsonKey(name: 'relatedCouponId')  int? relatedCouponId, @JsonKey(name: 'relatedSubscriptionId')  int? relatedSubscriptionId, @JsonKey(name: 'referenceId')  String? referenceId)  $default,) {final _that = this;
switch (_that) {
case _PointTransactionModel():
return $default(_that.id,_that.pointsDelta,_that.type,_that.description,_that.transactionDate,_that.expiryDate,_that.relatedCouponId,_that.relatedSubscriptionId,_that.referenceId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'pointsDelta')  int pointsDelta,  String type,  String description, @JsonKey(name: 'transactionDate')  DateTime transactionDate, @JsonKey(name: 'expiryDate')  DateTime? expiryDate, @JsonKey(name: 'relatedCouponId')  int? relatedCouponId, @JsonKey(name: 'relatedSubscriptionId')  int? relatedSubscriptionId, @JsonKey(name: 'referenceId')  String? referenceId)?  $default,) {final _that = this;
switch (_that) {
case _PointTransactionModel() when $default != null:
return $default(_that.id,_that.pointsDelta,_that.type,_that.description,_that.transactionDate,_that.expiryDate,_that.relatedCouponId,_that.relatedSubscriptionId,_that.referenceId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PointTransactionModel implements PointTransactionModel {
  const _PointTransactionModel({required this.id, @JsonKey(name: 'pointsDelta') required this.pointsDelta, required this.type, required this.description, @JsonKey(name: 'transactionDate') required this.transactionDate, @JsonKey(name: 'expiryDate') this.expiryDate, @JsonKey(name: 'relatedCouponId') this.relatedCouponId, @JsonKey(name: 'relatedSubscriptionId') this.relatedSubscriptionId, @JsonKey(name: 'referenceId') this.referenceId});
  factory _PointTransactionModel.fromJson(Map<String, dynamic> json) => _$PointTransactionModelFromJson(json);

@override final  int id;
@override@JsonKey(name: 'pointsDelta') final  int pointsDelta;
@override final  String type;
@override final  String description;
@override@JsonKey(name: 'transactionDate') final  DateTime transactionDate;
@override@JsonKey(name: 'expiryDate') final  DateTime? expiryDate;
@override@JsonKey(name: 'relatedCouponId') final  int? relatedCouponId;
@override@JsonKey(name: 'relatedSubscriptionId') final  int? relatedSubscriptionId;
@override@JsonKey(name: 'referenceId') final  String? referenceId;

/// Create a copy of PointTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointTransactionModelCopyWith<_PointTransactionModel> get copyWith => __$PointTransactionModelCopyWithImpl<_PointTransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PointTransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointTransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.pointsDelta, pointsDelta) || other.pointsDelta == pointsDelta)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.relatedCouponId, relatedCouponId) || other.relatedCouponId == relatedCouponId)&&(identical(other.relatedSubscriptionId, relatedSubscriptionId) || other.relatedSubscriptionId == relatedSubscriptionId)&&(identical(other.referenceId, referenceId) || other.referenceId == referenceId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,pointsDelta,type,description,transactionDate,expiryDate,relatedCouponId,relatedSubscriptionId,referenceId);

@override
String toString() {
  return 'PointTransactionModel(id: $id, pointsDelta: $pointsDelta, type: $type, description: $description, transactionDate: $transactionDate, expiryDate: $expiryDate, relatedCouponId: $relatedCouponId, relatedSubscriptionId: $relatedSubscriptionId, referenceId: $referenceId)';
}


}

/// @nodoc
abstract mixin class _$PointTransactionModelCopyWith<$Res> implements $PointTransactionModelCopyWith<$Res> {
  factory _$PointTransactionModelCopyWith(_PointTransactionModel value, $Res Function(_PointTransactionModel) _then) = __$PointTransactionModelCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'pointsDelta') int pointsDelta, String type, String description,@JsonKey(name: 'transactionDate') DateTime transactionDate,@JsonKey(name: 'expiryDate') DateTime? expiryDate,@JsonKey(name: 'relatedCouponId') int? relatedCouponId,@JsonKey(name: 'relatedSubscriptionId') int? relatedSubscriptionId,@JsonKey(name: 'referenceId') String? referenceId
});




}
/// @nodoc
class __$PointTransactionModelCopyWithImpl<$Res>
    implements _$PointTransactionModelCopyWith<$Res> {
  __$PointTransactionModelCopyWithImpl(this._self, this._then);

  final _PointTransactionModel _self;
  final $Res Function(_PointTransactionModel) _then;

/// Create a copy of PointTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pointsDelta = null,Object? type = null,Object? description = null,Object? transactionDate = null,Object? expiryDate = freezed,Object? relatedCouponId = freezed,Object? relatedSubscriptionId = freezed,Object? referenceId = freezed,}) {
  return _then(_PointTransactionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,pointsDelta: null == pointsDelta ? _self.pointsDelta : pointsDelta // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,transactionDate: null == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime,expiryDate: freezed == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,relatedCouponId: freezed == relatedCouponId ? _self.relatedCouponId : relatedCouponId // ignore: cast_nullable_to_non_nullable
as int?,relatedSubscriptionId: freezed == relatedSubscriptionId ? _self.relatedSubscriptionId : relatedSubscriptionId // ignore: cast_nullable_to_non_nullable
as int?,referenceId: freezed == referenceId ? _self.referenceId : referenceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AllocatePointsRequestModel {

 int get employeeId; int get points; String? get description; DateTime? get customExpiryDate;
/// Create a copy of AllocatePointsRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AllocatePointsRequestModelCopyWith<AllocatePointsRequestModel> get copyWith => _$AllocatePointsRequestModelCopyWithImpl<AllocatePointsRequestModel>(this as AllocatePointsRequestModel, _$identity);

  /// Serializes this AllocatePointsRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AllocatePointsRequestModel&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.points, points) || other.points == points)&&(identical(other.description, description) || other.description == description)&&(identical(other.customExpiryDate, customExpiryDate) || other.customExpiryDate == customExpiryDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,points,description,customExpiryDate);

@override
String toString() {
  return 'AllocatePointsRequestModel(employeeId: $employeeId, points: $points, description: $description, customExpiryDate: $customExpiryDate)';
}


}

/// @nodoc
abstract mixin class $AllocatePointsRequestModelCopyWith<$Res>  {
  factory $AllocatePointsRequestModelCopyWith(AllocatePointsRequestModel value, $Res Function(AllocatePointsRequestModel) _then) = _$AllocatePointsRequestModelCopyWithImpl;
@useResult
$Res call({
 int employeeId, int points, String? description, DateTime? customExpiryDate
});




}
/// @nodoc
class _$AllocatePointsRequestModelCopyWithImpl<$Res>
    implements $AllocatePointsRequestModelCopyWith<$Res> {
  _$AllocatePointsRequestModelCopyWithImpl(this._self, this._then);

  final AllocatePointsRequestModel _self;
  final $Res Function(AllocatePointsRequestModel) _then;

/// Create a copy of AllocatePointsRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeId = null,Object? points = null,Object? description = freezed,Object? customExpiryDate = freezed,}) {
  return _then(_self.copyWith(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,customExpiryDate: freezed == customExpiryDate ? _self.customExpiryDate : customExpiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AllocatePointsRequestModel].
extension AllocatePointsRequestModelPatterns on AllocatePointsRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AllocatePointsRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AllocatePointsRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AllocatePointsRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _AllocatePointsRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AllocatePointsRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _AllocatePointsRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int employeeId,  int points,  String? description,  DateTime? customExpiryDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AllocatePointsRequestModel() when $default != null:
return $default(_that.employeeId,_that.points,_that.description,_that.customExpiryDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int employeeId,  int points,  String? description,  DateTime? customExpiryDate)  $default,) {final _that = this;
switch (_that) {
case _AllocatePointsRequestModel():
return $default(_that.employeeId,_that.points,_that.description,_that.customExpiryDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int employeeId,  int points,  String? description,  DateTime? customExpiryDate)?  $default,) {final _that = this;
switch (_that) {
case _AllocatePointsRequestModel() when $default != null:
return $default(_that.employeeId,_that.points,_that.description,_that.customExpiryDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AllocatePointsRequestModel implements AllocatePointsRequestModel {
  const _AllocatePointsRequestModel({required this.employeeId, required this.points, this.description, this.customExpiryDate});
  factory _AllocatePointsRequestModel.fromJson(Map<String, dynamic> json) => _$AllocatePointsRequestModelFromJson(json);

@override final  int employeeId;
@override final  int points;
@override final  String? description;
@override final  DateTime? customExpiryDate;

/// Create a copy of AllocatePointsRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AllocatePointsRequestModelCopyWith<_AllocatePointsRequestModel> get copyWith => __$AllocatePointsRequestModelCopyWithImpl<_AllocatePointsRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AllocatePointsRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AllocatePointsRequestModel&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.points, points) || other.points == points)&&(identical(other.description, description) || other.description == description)&&(identical(other.customExpiryDate, customExpiryDate) || other.customExpiryDate == customExpiryDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,points,description,customExpiryDate);

@override
String toString() {
  return 'AllocatePointsRequestModel(employeeId: $employeeId, points: $points, description: $description, customExpiryDate: $customExpiryDate)';
}


}

/// @nodoc
abstract mixin class _$AllocatePointsRequestModelCopyWith<$Res> implements $AllocatePointsRequestModelCopyWith<$Res> {
  factory _$AllocatePointsRequestModelCopyWith(_AllocatePointsRequestModel value, $Res Function(_AllocatePointsRequestModel) _then) = __$AllocatePointsRequestModelCopyWithImpl;
@override @useResult
$Res call({
 int employeeId, int points, String? description, DateTime? customExpiryDate
});




}
/// @nodoc
class __$AllocatePointsRequestModelCopyWithImpl<$Res>
    implements _$AllocatePointsRequestModelCopyWith<$Res> {
  __$AllocatePointsRequestModelCopyWithImpl(this._self, this._then);

  final _AllocatePointsRequestModel _self;
  final $Res Function(_AllocatePointsRequestModel) _then;

/// Create a copy of AllocatePointsRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? points = null,Object? description = freezed,Object? customExpiryDate = freezed,}) {
  return _then(_AllocatePointsRequestModel(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,customExpiryDate: freezed == customExpiryDate ? _self.customExpiryDate : customExpiryDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$EmployeePointsResponseModel {

 int get employeeId; int get currentBalance; int get totalAllocated; int get totalSpent; DateTime? get nextExpiry; List<PointTransactionModel> get recentTransactions;
/// Create a copy of EmployeePointsResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeePointsResponseModelCopyWith<EmployeePointsResponseModel> get copyWith => _$EmployeePointsResponseModelCopyWithImpl<EmployeePointsResponseModel>(this as EmployeePointsResponseModel, _$identity);

  /// Serializes this EmployeePointsResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmployeePointsResponseModel&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance)&&(identical(other.totalAllocated, totalAllocated) || other.totalAllocated == totalAllocated)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.nextExpiry, nextExpiry) || other.nextExpiry == nextExpiry)&&const DeepCollectionEquality().equals(other.recentTransactions, recentTransactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,currentBalance,totalAllocated,totalSpent,nextExpiry,const DeepCollectionEquality().hash(recentTransactions));

@override
String toString() {
  return 'EmployeePointsResponseModel(employeeId: $employeeId, currentBalance: $currentBalance, totalAllocated: $totalAllocated, totalSpent: $totalSpent, nextExpiry: $nextExpiry, recentTransactions: $recentTransactions)';
}


}

/// @nodoc
abstract mixin class $EmployeePointsResponseModelCopyWith<$Res>  {
  factory $EmployeePointsResponseModelCopyWith(EmployeePointsResponseModel value, $Res Function(EmployeePointsResponseModel) _then) = _$EmployeePointsResponseModelCopyWithImpl;
@useResult
$Res call({
 int employeeId, int currentBalance, int totalAllocated, int totalSpent, DateTime? nextExpiry, List<PointTransactionModel> recentTransactions
});




}
/// @nodoc
class _$EmployeePointsResponseModelCopyWithImpl<$Res>
    implements $EmployeePointsResponseModelCopyWith<$Res> {
  _$EmployeePointsResponseModelCopyWithImpl(this._self, this._then);

  final EmployeePointsResponseModel _self;
  final $Res Function(EmployeePointsResponseModel) _then;

/// Create a copy of EmployeePointsResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? employeeId = null,Object? currentBalance = null,Object? totalAllocated = null,Object? totalSpent = null,Object? nextExpiry = freezed,Object? recentTransactions = null,}) {
  return _then(_self.copyWith(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as int,currentBalance: null == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as int,totalAllocated: null == totalAllocated ? _self.totalAllocated : totalAllocated // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,nextExpiry: freezed == nextExpiry ? _self.nextExpiry : nextExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,recentTransactions: null == recentTransactions ? _self.recentTransactions : recentTransactions // ignore: cast_nullable_to_non_nullable
as List<PointTransactionModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [EmployeePointsResponseModel].
extension EmployeePointsResponseModelPatterns on EmployeePointsResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmployeePointsResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmployeePointsResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmployeePointsResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _EmployeePointsResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmployeePointsResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _EmployeePointsResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int employeeId,  int currentBalance,  int totalAllocated,  int totalSpent,  DateTime? nextExpiry,  List<PointTransactionModel> recentTransactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmployeePointsResponseModel() when $default != null:
return $default(_that.employeeId,_that.currentBalance,_that.totalAllocated,_that.totalSpent,_that.nextExpiry,_that.recentTransactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int employeeId,  int currentBalance,  int totalAllocated,  int totalSpent,  DateTime? nextExpiry,  List<PointTransactionModel> recentTransactions)  $default,) {final _that = this;
switch (_that) {
case _EmployeePointsResponseModel():
return $default(_that.employeeId,_that.currentBalance,_that.totalAllocated,_that.totalSpent,_that.nextExpiry,_that.recentTransactions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int employeeId,  int currentBalance,  int totalAllocated,  int totalSpent,  DateTime? nextExpiry,  List<PointTransactionModel> recentTransactions)?  $default,) {final _that = this;
switch (_that) {
case _EmployeePointsResponseModel() when $default != null:
return $default(_that.employeeId,_that.currentBalance,_that.totalAllocated,_that.totalSpent,_that.nextExpiry,_that.recentTransactions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmployeePointsResponseModel implements EmployeePointsResponseModel {
  const _EmployeePointsResponseModel({required this.employeeId, required this.currentBalance, required this.totalAllocated, required this.totalSpent, this.nextExpiry, final  List<PointTransactionModel> recentTransactions = const []}): _recentTransactions = recentTransactions;
  factory _EmployeePointsResponseModel.fromJson(Map<String, dynamic> json) => _$EmployeePointsResponseModelFromJson(json);

@override final  int employeeId;
@override final  int currentBalance;
@override final  int totalAllocated;
@override final  int totalSpent;
@override final  DateTime? nextExpiry;
 final  List<PointTransactionModel> _recentTransactions;
@override@JsonKey() List<PointTransactionModel> get recentTransactions {
  if (_recentTransactions is EqualUnmodifiableListView) return _recentTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentTransactions);
}


/// Create a copy of EmployeePointsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeePointsResponseModelCopyWith<_EmployeePointsResponseModel> get copyWith => __$EmployeePointsResponseModelCopyWithImpl<_EmployeePointsResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeePointsResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmployeePointsResponseModel&&(identical(other.employeeId, employeeId) || other.employeeId == employeeId)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance)&&(identical(other.totalAllocated, totalAllocated) || other.totalAllocated == totalAllocated)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.nextExpiry, nextExpiry) || other.nextExpiry == nextExpiry)&&const DeepCollectionEquality().equals(other._recentTransactions, _recentTransactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,employeeId,currentBalance,totalAllocated,totalSpent,nextExpiry,const DeepCollectionEquality().hash(_recentTransactions));

@override
String toString() {
  return 'EmployeePointsResponseModel(employeeId: $employeeId, currentBalance: $currentBalance, totalAllocated: $totalAllocated, totalSpent: $totalSpent, nextExpiry: $nextExpiry, recentTransactions: $recentTransactions)';
}


}

/// @nodoc
abstract mixin class _$EmployeePointsResponseModelCopyWith<$Res> implements $EmployeePointsResponseModelCopyWith<$Res> {
  factory _$EmployeePointsResponseModelCopyWith(_EmployeePointsResponseModel value, $Res Function(_EmployeePointsResponseModel) _then) = __$EmployeePointsResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int employeeId, int currentBalance, int totalAllocated, int totalSpent, DateTime? nextExpiry, List<PointTransactionModel> recentTransactions
});




}
/// @nodoc
class __$EmployeePointsResponseModelCopyWithImpl<$Res>
    implements _$EmployeePointsResponseModelCopyWith<$Res> {
  __$EmployeePointsResponseModelCopyWithImpl(this._self, this._then);

  final _EmployeePointsResponseModel _self;
  final $Res Function(_EmployeePointsResponseModel) _then;

/// Create a copy of EmployeePointsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? employeeId = null,Object? currentBalance = null,Object? totalAllocated = null,Object? totalSpent = null,Object? nextExpiry = freezed,Object? recentTransactions = null,}) {
  return _then(_EmployeePointsResponseModel(
employeeId: null == employeeId ? _self.employeeId : employeeId // ignore: cast_nullable_to_non_nullable
as int,currentBalance: null == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as int,totalAllocated: null == totalAllocated ? _self.totalAllocated : totalAllocated // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as int,nextExpiry: freezed == nextExpiry ? _self.nextExpiry : nextExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,recentTransactions: null == recentTransactions ? _self._recentTransactions : recentTransactions // ignore: cast_nullable_to_non_nullable
as List<PointTransactionModel>,
  ));
}


}


/// @nodoc
mixin _$PointsExpirationInfoModel {

 int get days; int get expiringPoints;
/// Create a copy of PointsExpirationInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointsExpirationInfoModelCopyWith<PointsExpirationInfoModel> get copyWith => _$PointsExpirationInfoModelCopyWithImpl<PointsExpirationInfoModel>(this as PointsExpirationInfoModel, _$identity);

  /// Serializes this PointsExpirationInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointsExpirationInfoModel&&(identical(other.days, days) || other.days == days)&&(identical(other.expiringPoints, expiringPoints) || other.expiringPoints == expiringPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,days,expiringPoints);

@override
String toString() {
  return 'PointsExpirationInfoModel(days: $days, expiringPoints: $expiringPoints)';
}


}

/// @nodoc
abstract mixin class $PointsExpirationInfoModelCopyWith<$Res>  {
  factory $PointsExpirationInfoModelCopyWith(PointsExpirationInfoModel value, $Res Function(PointsExpirationInfoModel) _then) = _$PointsExpirationInfoModelCopyWithImpl;
@useResult
$Res call({
 int days, int expiringPoints
});




}
/// @nodoc
class _$PointsExpirationInfoModelCopyWithImpl<$Res>
    implements $PointsExpirationInfoModelCopyWith<$Res> {
  _$PointsExpirationInfoModelCopyWithImpl(this._self, this._then);

  final PointsExpirationInfoModel _self;
  final $Res Function(PointsExpirationInfoModel) _then;

/// Create a copy of PointsExpirationInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? days = null,Object? expiringPoints = null,}) {
  return _then(_self.copyWith(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,expiringPoints: null == expiringPoints ? _self.expiringPoints : expiringPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PointsExpirationInfoModel].
extension PointsExpirationInfoModelPatterns on PointsExpirationInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointsExpirationInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointsExpirationInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointsExpirationInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _PointsExpirationInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointsExpirationInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _PointsExpirationInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int days,  int expiringPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointsExpirationInfoModel() when $default != null:
return $default(_that.days,_that.expiringPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int days,  int expiringPoints)  $default,) {final _that = this;
switch (_that) {
case _PointsExpirationInfoModel():
return $default(_that.days,_that.expiringPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int days,  int expiringPoints)?  $default,) {final _that = this;
switch (_that) {
case _PointsExpirationInfoModel() when $default != null:
return $default(_that.days,_that.expiringPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PointsExpirationInfoModel implements PointsExpirationInfoModel {
  const _PointsExpirationInfoModel({required this.days, required this.expiringPoints});
  factory _PointsExpirationInfoModel.fromJson(Map<String, dynamic> json) => _$PointsExpirationInfoModelFromJson(json);

@override final  int days;
@override final  int expiringPoints;

/// Create a copy of PointsExpirationInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointsExpirationInfoModelCopyWith<_PointsExpirationInfoModel> get copyWith => __$PointsExpirationInfoModelCopyWithImpl<_PointsExpirationInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PointsExpirationInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointsExpirationInfoModel&&(identical(other.days, days) || other.days == days)&&(identical(other.expiringPoints, expiringPoints) || other.expiringPoints == expiringPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,days,expiringPoints);

@override
String toString() {
  return 'PointsExpirationInfoModel(days: $days, expiringPoints: $expiringPoints)';
}


}

/// @nodoc
abstract mixin class _$PointsExpirationInfoModelCopyWith<$Res> implements $PointsExpirationInfoModelCopyWith<$Res> {
  factory _$PointsExpirationInfoModelCopyWith(_PointsExpirationInfoModel value, $Res Function(_PointsExpirationInfoModel) _then) = __$PointsExpirationInfoModelCopyWithImpl;
@override @useResult
$Res call({
 int days, int expiringPoints
});




}
/// @nodoc
class __$PointsExpirationInfoModelCopyWithImpl<$Res>
    implements _$PointsExpirationInfoModelCopyWith<$Res> {
  __$PointsExpirationInfoModelCopyWithImpl(this._self, this._then);

  final _PointsExpirationInfoModel _self;
  final $Res Function(_PointsExpirationInfoModel) _then;

/// Create a copy of PointsExpirationInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? days = null,Object? expiringPoints = null,}) {
  return _then(_PointsExpirationInfoModel(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,expiringPoints: null == expiringPoints ? _self.expiringPoints : expiringPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ExpiredPointsCountModel {

@JsonKey(name: 'expiredPointsCount') int get expiredPointsCount;
/// Create a copy of ExpiredPointsCountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpiredPointsCountModelCopyWith<ExpiredPointsCountModel> get copyWith => _$ExpiredPointsCountModelCopyWithImpl<ExpiredPointsCountModel>(this as ExpiredPointsCountModel, _$identity);

  /// Serializes this ExpiredPointsCountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpiredPointsCountModel&&(identical(other.expiredPointsCount, expiredPointsCount) || other.expiredPointsCount == expiredPointsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expiredPointsCount);

@override
String toString() {
  return 'ExpiredPointsCountModel(expiredPointsCount: $expiredPointsCount)';
}


}

/// @nodoc
abstract mixin class $ExpiredPointsCountModelCopyWith<$Res>  {
  factory $ExpiredPointsCountModelCopyWith(ExpiredPointsCountModel value, $Res Function(ExpiredPointsCountModel) _then) = _$ExpiredPointsCountModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'expiredPointsCount') int expiredPointsCount
});




}
/// @nodoc
class _$ExpiredPointsCountModelCopyWithImpl<$Res>
    implements $ExpiredPointsCountModelCopyWith<$Res> {
  _$ExpiredPointsCountModelCopyWithImpl(this._self, this._then);

  final ExpiredPointsCountModel _self;
  final $Res Function(ExpiredPointsCountModel) _then;

/// Create a copy of ExpiredPointsCountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expiredPointsCount = null,}) {
  return _then(_self.copyWith(
expiredPointsCount: null == expiredPointsCount ? _self.expiredPointsCount : expiredPointsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpiredPointsCountModel].
extension ExpiredPointsCountModelPatterns on ExpiredPointsCountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpiredPointsCountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpiredPointsCountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpiredPointsCountModel value)  $default,){
final _that = this;
switch (_that) {
case _ExpiredPointsCountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpiredPointsCountModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExpiredPointsCountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'expiredPointsCount')  int expiredPointsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpiredPointsCountModel() when $default != null:
return $default(_that.expiredPointsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'expiredPointsCount')  int expiredPointsCount)  $default,) {final _that = this;
switch (_that) {
case _ExpiredPointsCountModel():
return $default(_that.expiredPointsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'expiredPointsCount')  int expiredPointsCount)?  $default,) {final _that = this;
switch (_that) {
case _ExpiredPointsCountModel() when $default != null:
return $default(_that.expiredPointsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpiredPointsCountModel implements ExpiredPointsCountModel {
  const _ExpiredPointsCountModel({@JsonKey(name: 'expiredPointsCount') required this.expiredPointsCount});
  factory _ExpiredPointsCountModel.fromJson(Map<String, dynamic> json) => _$ExpiredPointsCountModelFromJson(json);

@override@JsonKey(name: 'expiredPointsCount') final  int expiredPointsCount;

/// Create a copy of ExpiredPointsCountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpiredPointsCountModelCopyWith<_ExpiredPointsCountModel> get copyWith => __$ExpiredPointsCountModelCopyWithImpl<_ExpiredPointsCountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpiredPointsCountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpiredPointsCountModel&&(identical(other.expiredPointsCount, expiredPointsCount) || other.expiredPointsCount == expiredPointsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,expiredPointsCount);

@override
String toString() {
  return 'ExpiredPointsCountModel(expiredPointsCount: $expiredPointsCount)';
}


}

/// @nodoc
abstract mixin class _$ExpiredPointsCountModelCopyWith<$Res> implements $ExpiredPointsCountModelCopyWith<$Res> {
  factory _$ExpiredPointsCountModelCopyWith(_ExpiredPointsCountModel value, $Res Function(_ExpiredPointsCountModel) _then) = __$ExpiredPointsCountModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'expiredPointsCount') int expiredPointsCount
});




}
/// @nodoc
class __$ExpiredPointsCountModelCopyWithImpl<$Res>
    implements _$ExpiredPointsCountModelCopyWith<$Res> {
  __$ExpiredPointsCountModelCopyWithImpl(this._self, this._then);

  final _ExpiredPointsCountModel _self;
  final $Res Function(_ExpiredPointsCountModel) _then;

/// Create a copy of ExpiredPointsCountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expiredPointsCount = null,}) {
  return _then(_ExpiredPointsCountModel(
expiredPointsCount: null == expiredPointsCount ? _self.expiredPointsCount : expiredPointsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
