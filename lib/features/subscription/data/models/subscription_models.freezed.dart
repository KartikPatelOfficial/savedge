// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionPlanModel {

 int get id; String get name; String? get description; double get price;@JsonKey(name: 'durationMonths') int get durationMonths; String? get features;@JsonKey(name: 'imageUrl') String? get imageUrl; bool get isActive;
/// Create a copy of SubscriptionPlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionPlanModelCopyWith<SubscriptionPlanModel> get copyWith => _$SubscriptionPlanModelCopyWithImpl<SubscriptionPlanModel>(this as SubscriptionPlanModel, _$identity);

  /// Serializes this SubscriptionPlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionPlanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.durationMonths, durationMonths) || other.durationMonths == durationMonths)&&(identical(other.features, features) || other.features == features)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,durationMonths,features,imageUrl,isActive);

@override
String toString() {
  return 'SubscriptionPlanModel(id: $id, name: $name, description: $description, price: $price, durationMonths: $durationMonths, features: $features, imageUrl: $imageUrl, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $SubscriptionPlanModelCopyWith<$Res>  {
  factory $SubscriptionPlanModelCopyWith(SubscriptionPlanModel value, $Res Function(SubscriptionPlanModel) _then) = _$SubscriptionPlanModelCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? description, double price,@JsonKey(name: 'durationMonths') int durationMonths, String? features,@JsonKey(name: 'imageUrl') String? imageUrl, bool isActive
});




}
/// @nodoc
class _$SubscriptionPlanModelCopyWithImpl<$Res>
    implements $SubscriptionPlanModelCopyWith<$Res> {
  _$SubscriptionPlanModelCopyWithImpl(this._self, this._then);

  final SubscriptionPlanModel _self;
  final $Res Function(SubscriptionPlanModel) _then;

/// Create a copy of SubscriptionPlanModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? price = null,Object? durationMonths = null,Object? features = freezed,Object? imageUrl = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,durationMonths: null == durationMonths ? _self.durationMonths : durationMonths // ignore: cast_nullable_to_non_nullable
as int,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionPlanModel].
extension SubscriptionPlanModelPatterns on SubscriptionPlanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionPlanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionPlanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionPlanModel value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPlanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionPlanModel value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionPlanModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  double price, @JsonKey(name: 'durationMonths')  int durationMonths,  String? features, @JsonKey(name: 'imageUrl')  String? imageUrl,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionPlanModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.durationMonths,_that.features,_that.imageUrl,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? description,  double price, @JsonKey(name: 'durationMonths')  int durationMonths,  String? features, @JsonKey(name: 'imageUrl')  String? imageUrl,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionPlanModel():
return $default(_that.id,_that.name,_that.description,_that.price,_that.durationMonths,_that.features,_that.imageUrl,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? description,  double price, @JsonKey(name: 'durationMonths')  int durationMonths,  String? features, @JsonKey(name: 'imageUrl')  String? imageUrl,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionPlanModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.durationMonths,_that.features,_that.imageUrl,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionPlanModel implements SubscriptionPlanModel {
  const _SubscriptionPlanModel({required this.id, required this.name, this.description, required this.price, @JsonKey(name: 'durationMonths') required this.durationMonths, this.features, @JsonKey(name: 'imageUrl') this.imageUrl, this.isActive = true});
  factory _SubscriptionPlanModel.fromJson(Map<String, dynamic> json) => _$SubscriptionPlanModelFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? description;
@override final  double price;
@override@JsonKey(name: 'durationMonths') final  int durationMonths;
@override final  String? features;
@override@JsonKey(name: 'imageUrl') final  String? imageUrl;
@override@JsonKey() final  bool isActive;

/// Create a copy of SubscriptionPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionPlanModelCopyWith<_SubscriptionPlanModel> get copyWith => __$SubscriptionPlanModelCopyWithImpl<_SubscriptionPlanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionPlanModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionPlanModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.durationMonths, durationMonths) || other.durationMonths == durationMonths)&&(identical(other.features, features) || other.features == features)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,price,durationMonths,features,imageUrl,isActive);

@override
String toString() {
  return 'SubscriptionPlanModel(id: $id, name: $name, description: $description, price: $price, durationMonths: $durationMonths, features: $features, imageUrl: $imageUrl, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionPlanModelCopyWith<$Res> implements $SubscriptionPlanModelCopyWith<$Res> {
  factory _$SubscriptionPlanModelCopyWith(_SubscriptionPlanModel value, $Res Function(_SubscriptionPlanModel) _then) = __$SubscriptionPlanModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? description, double price,@JsonKey(name: 'durationMonths') int durationMonths, String? features,@JsonKey(name: 'imageUrl') String? imageUrl, bool isActive
});




}
/// @nodoc
class __$SubscriptionPlanModelCopyWithImpl<$Res>
    implements _$SubscriptionPlanModelCopyWith<$Res> {
  __$SubscriptionPlanModelCopyWithImpl(this._self, this._then);

  final _SubscriptionPlanModel _self;
  final $Res Function(_SubscriptionPlanModel) _then;

/// Create a copy of SubscriptionPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? price = null,Object? durationMonths = null,Object? features = freezed,Object? imageUrl = freezed,Object? isActive = null,}) {
  return _then(_SubscriptionPlanModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,durationMonths: null == durationMonths ? _self.durationMonths : durationMonths // ignore: cast_nullable_to_non_nullable
as int,features: freezed == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$UserSubscriptionModel {

@JsonKey(name: 'planId') int get planId;@JsonKey(name: 'planName') String get planName;@JsonKey(name: 'startDate') DateTime get startDate;@JsonKey(name: 'endDate') DateTime get endDate;@JsonKey(name: 'isActive') bool get isActive;@JsonKey(name: 'autoRenew') bool get autoRenew;
/// Create a copy of UserSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSubscriptionModelCopyWith<UserSubscriptionModel> get copyWith => _$UserSubscriptionModelCopyWithImpl<UserSubscriptionModel>(this as UserSubscriptionModel, _$identity);

  /// Serializes this UserSubscriptionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSubscriptionModel&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,planName,startDate,endDate,isActive,autoRenew);

@override
String toString() {
  return 'UserSubscriptionModel(planId: $planId, planName: $planName, startDate: $startDate, endDate: $endDate, isActive: $isActive, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class $UserSubscriptionModelCopyWith<$Res>  {
  factory $UserSubscriptionModelCopyWith(UserSubscriptionModel value, $Res Function(UserSubscriptionModel) _then) = _$UserSubscriptionModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'planId') int planId,@JsonKey(name: 'planName') String planName,@JsonKey(name: 'startDate') DateTime startDate,@JsonKey(name: 'endDate') DateTime endDate,@JsonKey(name: 'isActive') bool isActive,@JsonKey(name: 'autoRenew') bool autoRenew
});




}
/// @nodoc
class _$UserSubscriptionModelCopyWithImpl<$Res>
    implements $UserSubscriptionModelCopyWith<$Res> {
  _$UserSubscriptionModelCopyWithImpl(this._self, this._then);

  final UserSubscriptionModel _self;
  final $Res Function(UserSubscriptionModel) _then;

/// Create a copy of UserSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planId = null,Object? planName = null,Object? startDate = null,Object? endDate = null,Object? isActive = null,Object? autoRenew = null,}) {
  return _then(_self.copyWith(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSubscriptionModel].
extension UserSubscriptionModelPatterns on UserSubscriptionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSubscriptionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSubscriptionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSubscriptionModel value)  $default,){
final _that = this;
switch (_that) {
case _UserSubscriptionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSubscriptionModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserSubscriptionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'planName')  String planName, @JsonKey(name: 'startDate')  DateTime startDate, @JsonKey(name: 'endDate')  DateTime endDate, @JsonKey(name: 'isActive')  bool isActive, @JsonKey(name: 'autoRenew')  bool autoRenew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSubscriptionModel() when $default != null:
return $default(_that.planId,_that.planName,_that.startDate,_that.endDate,_that.isActive,_that.autoRenew);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'planName')  String planName, @JsonKey(name: 'startDate')  DateTime startDate, @JsonKey(name: 'endDate')  DateTime endDate, @JsonKey(name: 'isActive')  bool isActive, @JsonKey(name: 'autoRenew')  bool autoRenew)  $default,) {final _that = this;
switch (_that) {
case _UserSubscriptionModel():
return $default(_that.planId,_that.planName,_that.startDate,_that.endDate,_that.isActive,_that.autoRenew);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'planName')  String planName, @JsonKey(name: 'startDate')  DateTime startDate, @JsonKey(name: 'endDate')  DateTime endDate, @JsonKey(name: 'isActive')  bool isActive, @JsonKey(name: 'autoRenew')  bool autoRenew)?  $default,) {final _that = this;
switch (_that) {
case _UserSubscriptionModel() when $default != null:
return $default(_that.planId,_that.planName,_that.startDate,_that.endDate,_that.isActive,_that.autoRenew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSubscriptionModel implements UserSubscriptionModel {
  const _UserSubscriptionModel({@JsonKey(name: 'planId') required this.planId, @JsonKey(name: 'planName') required this.planName, @JsonKey(name: 'startDate') required this.startDate, @JsonKey(name: 'endDate') required this.endDate, @JsonKey(name: 'isActive') required this.isActive, @JsonKey(name: 'autoRenew') required this.autoRenew});
  factory _UserSubscriptionModel.fromJson(Map<String, dynamic> json) => _$UserSubscriptionModelFromJson(json);

@override@JsonKey(name: 'planId') final  int planId;
@override@JsonKey(name: 'planName') final  String planName;
@override@JsonKey(name: 'startDate') final  DateTime startDate;
@override@JsonKey(name: 'endDate') final  DateTime endDate;
@override@JsonKey(name: 'isActive') final  bool isActive;
@override@JsonKey(name: 'autoRenew') final  bool autoRenew;

/// Create a copy of UserSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSubscriptionModelCopyWith<_UserSubscriptionModel> get copyWith => __$UserSubscriptionModelCopyWithImpl<_UserSubscriptionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSubscriptionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSubscriptionModel&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,planName,startDate,endDate,isActive,autoRenew);

@override
String toString() {
  return 'UserSubscriptionModel(planId: $planId, planName: $planName, startDate: $startDate, endDate: $endDate, isActive: $isActive, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class _$UserSubscriptionModelCopyWith<$Res> implements $UserSubscriptionModelCopyWith<$Res> {
  factory _$UserSubscriptionModelCopyWith(_UserSubscriptionModel value, $Res Function(_UserSubscriptionModel) _then) = __$UserSubscriptionModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'planId') int planId,@JsonKey(name: 'planName') String planName,@JsonKey(name: 'startDate') DateTime startDate,@JsonKey(name: 'endDate') DateTime endDate,@JsonKey(name: 'isActive') bool isActive,@JsonKey(name: 'autoRenew') bool autoRenew
});




}
/// @nodoc
class __$UserSubscriptionModelCopyWithImpl<$Res>
    implements _$UserSubscriptionModelCopyWith<$Res> {
  __$UserSubscriptionModelCopyWithImpl(this._self, this._then);

  final _UserSubscriptionModel _self;
  final $Res Function(_UserSubscriptionModel) _then;

/// Create a copy of UserSubscriptionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planId = null,Object? planName = null,Object? startDate = null,Object? endDate = null,Object? isActive = null,Object? autoRenew = null,}) {
  return _then(_UserSubscriptionModel(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,planName: null == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PurchaseSubscriptionRequestModel {

@JsonKey(name: 'planId') int get planId;@JsonKey(name: 'autoRenew') bool get autoRenew;
/// Create a copy of PurchaseSubscriptionRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseSubscriptionRequestModelCopyWith<PurchaseSubscriptionRequestModel> get copyWith => _$PurchaseSubscriptionRequestModelCopyWithImpl<PurchaseSubscriptionRequestModel>(this as PurchaseSubscriptionRequestModel, _$identity);

  /// Serializes this PurchaseSubscriptionRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseSubscriptionRequestModel&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,autoRenew);

@override
String toString() {
  return 'PurchaseSubscriptionRequestModel(planId: $planId, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class $PurchaseSubscriptionRequestModelCopyWith<$Res>  {
  factory $PurchaseSubscriptionRequestModelCopyWith(PurchaseSubscriptionRequestModel value, $Res Function(PurchaseSubscriptionRequestModel) _then) = _$PurchaseSubscriptionRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'planId') int planId,@JsonKey(name: 'autoRenew') bool autoRenew
});




}
/// @nodoc
class _$PurchaseSubscriptionRequestModelCopyWithImpl<$Res>
    implements $PurchaseSubscriptionRequestModelCopyWith<$Res> {
  _$PurchaseSubscriptionRequestModelCopyWithImpl(this._self, this._then);

  final PurchaseSubscriptionRequestModel _self;
  final $Res Function(PurchaseSubscriptionRequestModel) _then;

/// Create a copy of PurchaseSubscriptionRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planId = null,Object? autoRenew = null,}) {
  return _then(_self.copyWith(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseSubscriptionRequestModel].
extension PurchaseSubscriptionRequestModelPatterns on PurchaseSubscriptionRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseSubscriptionRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseSubscriptionRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseSubscriptionRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseSubscriptionRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseSubscriptionRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseSubscriptionRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'autoRenew')  bool autoRenew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseSubscriptionRequestModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'autoRenew')  bool autoRenew)  $default,) {final _that = this;
switch (_that) {
case _PurchaseSubscriptionRequestModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'autoRenew')  bool autoRenew)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseSubscriptionRequestModel() when $default != null:
return $default(_that.planId,_that.autoRenew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PurchaseSubscriptionRequestModel implements PurchaseSubscriptionRequestModel {
  const _PurchaseSubscriptionRequestModel({@JsonKey(name: 'planId') required this.planId, @JsonKey(name: 'autoRenew') this.autoRenew = false});
  factory _PurchaseSubscriptionRequestModel.fromJson(Map<String, dynamic> json) => _$PurchaseSubscriptionRequestModelFromJson(json);

@override@JsonKey(name: 'planId') final  int planId;
@override@JsonKey(name: 'autoRenew') final  bool autoRenew;

/// Create a copy of PurchaseSubscriptionRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseSubscriptionRequestModelCopyWith<_PurchaseSubscriptionRequestModel> get copyWith => __$PurchaseSubscriptionRequestModelCopyWithImpl<_PurchaseSubscriptionRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchaseSubscriptionRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseSubscriptionRequestModel&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,autoRenew);

@override
String toString() {
  return 'PurchaseSubscriptionRequestModel(planId: $planId, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class _$PurchaseSubscriptionRequestModelCopyWith<$Res> implements $PurchaseSubscriptionRequestModelCopyWith<$Res> {
  factory _$PurchaseSubscriptionRequestModelCopyWith(_PurchaseSubscriptionRequestModel value, $Res Function(_PurchaseSubscriptionRequestModel) _then) = __$PurchaseSubscriptionRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'planId') int planId,@JsonKey(name: 'autoRenew') bool autoRenew
});




}
/// @nodoc
class __$PurchaseSubscriptionRequestModelCopyWithImpl<$Res>
    implements _$PurchaseSubscriptionRequestModelCopyWith<$Res> {
  __$PurchaseSubscriptionRequestModelCopyWithImpl(this._self, this._then);

  final _PurchaseSubscriptionRequestModel _self;
  final $Res Function(_PurchaseSubscriptionRequestModel) _then;

/// Create a copy of PurchaseSubscriptionRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planId = null,Object? autoRenew = null,}) {
  return _then(_PurchaseSubscriptionRequestModel(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PurchaseSubscriptionWithPointsRequestModel {

@JsonKey(name: 'planId') int get planId;@JsonKey(name: 'autoRenew') bool get autoRenew;
/// Create a copy of PurchaseSubscriptionWithPointsRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseSubscriptionWithPointsRequestModelCopyWith<PurchaseSubscriptionWithPointsRequestModel> get copyWith => _$PurchaseSubscriptionWithPointsRequestModelCopyWithImpl<PurchaseSubscriptionWithPointsRequestModel>(this as PurchaseSubscriptionWithPointsRequestModel, _$identity);

  /// Serializes this PurchaseSubscriptionWithPointsRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseSubscriptionWithPointsRequestModel&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,autoRenew);

@override
String toString() {
  return 'PurchaseSubscriptionWithPointsRequestModel(planId: $planId, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class $PurchaseSubscriptionWithPointsRequestModelCopyWith<$Res>  {
  factory $PurchaseSubscriptionWithPointsRequestModelCopyWith(PurchaseSubscriptionWithPointsRequestModel value, $Res Function(PurchaseSubscriptionWithPointsRequestModel) _then) = _$PurchaseSubscriptionWithPointsRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'planId') int planId,@JsonKey(name: 'autoRenew') bool autoRenew
});




}
/// @nodoc
class _$PurchaseSubscriptionWithPointsRequestModelCopyWithImpl<$Res>
    implements $PurchaseSubscriptionWithPointsRequestModelCopyWith<$Res> {
  _$PurchaseSubscriptionWithPointsRequestModelCopyWithImpl(this._self, this._then);

  final PurchaseSubscriptionWithPointsRequestModel _self;
  final $Res Function(PurchaseSubscriptionWithPointsRequestModel) _then;

/// Create a copy of PurchaseSubscriptionWithPointsRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planId = null,Object? autoRenew = null,}) {
  return _then(_self.copyWith(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseSubscriptionWithPointsRequestModel].
extension PurchaseSubscriptionWithPointsRequestModelPatterns on PurchaseSubscriptionWithPointsRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseSubscriptionWithPointsRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseSubscriptionWithPointsRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseSubscriptionWithPointsRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseSubscriptionWithPointsRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseSubscriptionWithPointsRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseSubscriptionWithPointsRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'autoRenew')  bool autoRenew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseSubscriptionWithPointsRequestModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'autoRenew')  bool autoRenew)  $default,) {final _that = this;
switch (_that) {
case _PurchaseSubscriptionWithPointsRequestModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'autoRenew')  bool autoRenew)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseSubscriptionWithPointsRequestModel() when $default != null:
return $default(_that.planId,_that.autoRenew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PurchaseSubscriptionWithPointsRequestModel implements PurchaseSubscriptionWithPointsRequestModel {
  const _PurchaseSubscriptionWithPointsRequestModel({@JsonKey(name: 'planId') required this.planId, @JsonKey(name: 'autoRenew') this.autoRenew = false});
  factory _PurchaseSubscriptionWithPointsRequestModel.fromJson(Map<String, dynamic> json) => _$PurchaseSubscriptionWithPointsRequestModelFromJson(json);

@override@JsonKey(name: 'planId') final  int planId;
@override@JsonKey(name: 'autoRenew') final  bool autoRenew;

/// Create a copy of PurchaseSubscriptionWithPointsRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseSubscriptionWithPointsRequestModelCopyWith<_PurchaseSubscriptionWithPointsRequestModel> get copyWith => __$PurchaseSubscriptionWithPointsRequestModelCopyWithImpl<_PurchaseSubscriptionWithPointsRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchaseSubscriptionWithPointsRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseSubscriptionWithPointsRequestModel&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,autoRenew);

@override
String toString() {
  return 'PurchaseSubscriptionWithPointsRequestModel(planId: $planId, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class _$PurchaseSubscriptionWithPointsRequestModelCopyWith<$Res> implements $PurchaseSubscriptionWithPointsRequestModelCopyWith<$Res> {
  factory _$PurchaseSubscriptionWithPointsRequestModelCopyWith(_PurchaseSubscriptionWithPointsRequestModel value, $Res Function(_PurchaseSubscriptionWithPointsRequestModel) _then) = __$PurchaseSubscriptionWithPointsRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'planId') int planId,@JsonKey(name: 'autoRenew') bool autoRenew
});




}
/// @nodoc
class __$PurchaseSubscriptionWithPointsRequestModelCopyWithImpl<$Res>
    implements _$PurchaseSubscriptionWithPointsRequestModelCopyWith<$Res> {
  __$PurchaseSubscriptionWithPointsRequestModelCopyWithImpl(this._self, this._then);

  final _PurchaseSubscriptionWithPointsRequestModel _self;
  final $Res Function(_PurchaseSubscriptionWithPointsRequestModel) _then;

/// Create a copy of PurchaseSubscriptionWithPointsRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planId = null,Object? autoRenew = null,}) {
  return _then(_PurchaseSubscriptionWithPointsRequestModel(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PurchaseWithPointsResponseModel {

 String get message;@JsonKey(name: 'pointsSpent') int get pointsSpent;@JsonKey(name: 'newBalance') int get newBalance;@JsonKey(name: 'subscriptionId') int get subscriptionId;
/// Create a copy of PurchaseWithPointsResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PurchaseWithPointsResponseModelCopyWith<PurchaseWithPointsResponseModel> get copyWith => _$PurchaseWithPointsResponseModelCopyWithImpl<PurchaseWithPointsResponseModel>(this as PurchaseWithPointsResponseModel, _$identity);

  /// Serializes this PurchaseWithPointsResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PurchaseWithPointsResponseModel&&(identical(other.message, message) || other.message == message)&&(identical(other.pointsSpent, pointsSpent) || other.pointsSpent == pointsSpent)&&(identical(other.newBalance, newBalance) || other.newBalance == newBalance)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,pointsSpent,newBalance,subscriptionId);

@override
String toString() {
  return 'PurchaseWithPointsResponseModel(message: $message, pointsSpent: $pointsSpent, newBalance: $newBalance, subscriptionId: $subscriptionId)';
}


}

/// @nodoc
abstract mixin class $PurchaseWithPointsResponseModelCopyWith<$Res>  {
  factory $PurchaseWithPointsResponseModelCopyWith(PurchaseWithPointsResponseModel value, $Res Function(PurchaseWithPointsResponseModel) _then) = _$PurchaseWithPointsResponseModelCopyWithImpl;
@useResult
$Res call({
 String message,@JsonKey(name: 'pointsSpent') int pointsSpent,@JsonKey(name: 'newBalance') int newBalance,@JsonKey(name: 'subscriptionId') int subscriptionId
});




}
/// @nodoc
class _$PurchaseWithPointsResponseModelCopyWithImpl<$Res>
    implements $PurchaseWithPointsResponseModelCopyWith<$Res> {
  _$PurchaseWithPointsResponseModelCopyWithImpl(this._self, this._then);

  final PurchaseWithPointsResponseModel _self;
  final $Res Function(PurchaseWithPointsResponseModel) _then;

/// Create a copy of PurchaseWithPointsResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? pointsSpent = null,Object? newBalance = null,Object? subscriptionId = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,pointsSpent: null == pointsSpent ? _self.pointsSpent : pointsSpent // ignore: cast_nullable_to_non_nullable
as int,newBalance: null == newBalance ? _self.newBalance : newBalance // ignore: cast_nullable_to_non_nullable
as int,subscriptionId: null == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PurchaseWithPointsResponseModel].
extension PurchaseWithPointsResponseModelPatterns on PurchaseWithPointsResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PurchaseWithPointsResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PurchaseWithPointsResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PurchaseWithPointsResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _PurchaseWithPointsResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PurchaseWithPointsResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _PurchaseWithPointsResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message, @JsonKey(name: 'pointsSpent')  int pointsSpent, @JsonKey(name: 'newBalance')  int newBalance, @JsonKey(name: 'subscriptionId')  int subscriptionId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PurchaseWithPointsResponseModel() when $default != null:
return $default(_that.message,_that.pointsSpent,_that.newBalance,_that.subscriptionId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message, @JsonKey(name: 'pointsSpent')  int pointsSpent, @JsonKey(name: 'newBalance')  int newBalance, @JsonKey(name: 'subscriptionId')  int subscriptionId)  $default,) {final _that = this;
switch (_that) {
case _PurchaseWithPointsResponseModel():
return $default(_that.message,_that.pointsSpent,_that.newBalance,_that.subscriptionId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message, @JsonKey(name: 'pointsSpent')  int pointsSpent, @JsonKey(name: 'newBalance')  int newBalance, @JsonKey(name: 'subscriptionId')  int subscriptionId)?  $default,) {final _that = this;
switch (_that) {
case _PurchaseWithPointsResponseModel() when $default != null:
return $default(_that.message,_that.pointsSpent,_that.newBalance,_that.subscriptionId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PurchaseWithPointsResponseModel implements PurchaseWithPointsResponseModel {
  const _PurchaseWithPointsResponseModel({required this.message, @JsonKey(name: 'pointsSpent') required this.pointsSpent, @JsonKey(name: 'newBalance') required this.newBalance, @JsonKey(name: 'subscriptionId') required this.subscriptionId});
  factory _PurchaseWithPointsResponseModel.fromJson(Map<String, dynamic> json) => _$PurchaseWithPointsResponseModelFromJson(json);

@override final  String message;
@override@JsonKey(name: 'pointsSpent') final  int pointsSpent;
@override@JsonKey(name: 'newBalance') final  int newBalance;
@override@JsonKey(name: 'subscriptionId') final  int subscriptionId;

/// Create a copy of PurchaseWithPointsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PurchaseWithPointsResponseModelCopyWith<_PurchaseWithPointsResponseModel> get copyWith => __$PurchaseWithPointsResponseModelCopyWithImpl<_PurchaseWithPointsResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PurchaseWithPointsResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PurchaseWithPointsResponseModel&&(identical(other.message, message) || other.message == message)&&(identical(other.pointsSpent, pointsSpent) || other.pointsSpent == pointsSpent)&&(identical(other.newBalance, newBalance) || other.newBalance == newBalance)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,pointsSpent,newBalance,subscriptionId);

@override
String toString() {
  return 'PurchaseWithPointsResponseModel(message: $message, pointsSpent: $pointsSpent, newBalance: $newBalance, subscriptionId: $subscriptionId)';
}


}

/// @nodoc
abstract mixin class _$PurchaseWithPointsResponseModelCopyWith<$Res> implements $PurchaseWithPointsResponseModelCopyWith<$Res> {
  factory _$PurchaseWithPointsResponseModelCopyWith(_PurchaseWithPointsResponseModel value, $Res Function(_PurchaseWithPointsResponseModel) _then) = __$PurchaseWithPointsResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String message,@JsonKey(name: 'pointsSpent') int pointsSpent,@JsonKey(name: 'newBalance') int newBalance,@JsonKey(name: 'subscriptionId') int subscriptionId
});




}
/// @nodoc
class __$PurchaseWithPointsResponseModelCopyWithImpl<$Res>
    implements _$PurchaseWithPointsResponseModelCopyWith<$Res> {
  __$PurchaseWithPointsResponseModelCopyWithImpl(this._self, this._then);

  final _PurchaseWithPointsResponseModel _self;
  final $Res Function(_PurchaseWithPointsResponseModel) _then;

/// Create a copy of PurchaseWithPointsResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? pointsSpent = null,Object? newBalance = null,Object? subscriptionId = null,}) {
  return _then(_PurchaseWithPointsResponseModel(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,pointsSpent: null == pointsSpent ? _self.pointsSpent : pointsSpent // ignore: cast_nullable_to_non_nullable
as int,newBalance: null == newBalance ? _self.newBalance : newBalance // ignore: cast_nullable_to_non_nullable
as int,subscriptionId: null == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CreatePaymentOrderRequestModel {

@JsonKey(name: 'planId') int get planId;@JsonKey(name: 'autoRenew') bool get autoRenew;
/// Create a copy of CreatePaymentOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePaymentOrderRequestModelCopyWith<CreatePaymentOrderRequestModel> get copyWith => _$CreatePaymentOrderRequestModelCopyWithImpl<CreatePaymentOrderRequestModel>(this as CreatePaymentOrderRequestModel, _$identity);

  /// Serializes this CreatePaymentOrderRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePaymentOrderRequestModel&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,autoRenew);

@override
String toString() {
  return 'CreatePaymentOrderRequestModel(planId: $planId, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class $CreatePaymentOrderRequestModelCopyWith<$Res>  {
  factory $CreatePaymentOrderRequestModelCopyWith(CreatePaymentOrderRequestModel value, $Res Function(CreatePaymentOrderRequestModel) _then) = _$CreatePaymentOrderRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'planId') int planId,@JsonKey(name: 'autoRenew') bool autoRenew
});




}
/// @nodoc
class _$CreatePaymentOrderRequestModelCopyWithImpl<$Res>
    implements $CreatePaymentOrderRequestModelCopyWith<$Res> {
  _$CreatePaymentOrderRequestModelCopyWithImpl(this._self, this._then);

  final CreatePaymentOrderRequestModel _self;
  final $Res Function(CreatePaymentOrderRequestModel) _then;

/// Create a copy of CreatePaymentOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planId = null,Object? autoRenew = null,}) {
  return _then(_self.copyWith(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatePaymentOrderRequestModel].
extension CreatePaymentOrderRequestModelPatterns on CreatePaymentOrderRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePaymentOrderRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePaymentOrderRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePaymentOrderRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _CreatePaymentOrderRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePaymentOrderRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePaymentOrderRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'autoRenew')  bool autoRenew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePaymentOrderRequestModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'autoRenew')  bool autoRenew)  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentOrderRequestModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'autoRenew')  bool autoRenew)?  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentOrderRequestModel() when $default != null:
return $default(_that.planId,_that.autoRenew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePaymentOrderRequestModel implements CreatePaymentOrderRequestModel {
  const _CreatePaymentOrderRequestModel({@JsonKey(name: 'planId') required this.planId, @JsonKey(name: 'autoRenew') this.autoRenew = false});
  factory _CreatePaymentOrderRequestModel.fromJson(Map<String, dynamic> json) => _$CreatePaymentOrderRequestModelFromJson(json);

@override@JsonKey(name: 'planId') final  int planId;
@override@JsonKey(name: 'autoRenew') final  bool autoRenew;

/// Create a copy of CreatePaymentOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePaymentOrderRequestModelCopyWith<_CreatePaymentOrderRequestModel> get copyWith => __$CreatePaymentOrderRequestModelCopyWithImpl<_CreatePaymentOrderRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePaymentOrderRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePaymentOrderRequestModel&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,autoRenew);

@override
String toString() {
  return 'CreatePaymentOrderRequestModel(planId: $planId, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class _$CreatePaymentOrderRequestModelCopyWith<$Res> implements $CreatePaymentOrderRequestModelCopyWith<$Res> {
  factory _$CreatePaymentOrderRequestModelCopyWith(_CreatePaymentOrderRequestModel value, $Res Function(_CreatePaymentOrderRequestModel) _then) = __$CreatePaymentOrderRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'planId') int planId,@JsonKey(name: 'autoRenew') bool autoRenew
});




}
/// @nodoc
class __$CreatePaymentOrderRequestModelCopyWithImpl<$Res>
    implements _$CreatePaymentOrderRequestModelCopyWith<$Res> {
  __$CreatePaymentOrderRequestModelCopyWithImpl(this._self, this._then);

  final _CreatePaymentOrderRequestModel _self;
  final $Res Function(_CreatePaymentOrderRequestModel) _then;

/// Create a copy of CreatePaymentOrderRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planId = null,Object? autoRenew = null,}) {
  return _then(_CreatePaymentOrderRequestModel(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CreatePaymentOrderResponseModel {

@JsonKey(name: 'orderId') String get orderId; int get amount; String get currency; String get receipt;@JsonKey(name: 'transactionId') int get transactionId;@JsonKey(name: 'planDetails') SubscriptionPlanModel get planDetails;
/// Create a copy of CreatePaymentOrderResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatePaymentOrderResponseModelCopyWith<CreatePaymentOrderResponseModel> get copyWith => _$CreatePaymentOrderResponseModelCopyWithImpl<CreatePaymentOrderResponseModel>(this as CreatePaymentOrderResponseModel, _$identity);

  /// Serializes this CreatePaymentOrderResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatePaymentOrderResponseModel&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.receipt, receipt) || other.receipt == receipt)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.planDetails, planDetails) || other.planDetails == planDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,amount,currency,receipt,transactionId,planDetails);

@override
String toString() {
  return 'CreatePaymentOrderResponseModel(orderId: $orderId, amount: $amount, currency: $currency, receipt: $receipt, transactionId: $transactionId, planDetails: $planDetails)';
}


}

/// @nodoc
abstract mixin class $CreatePaymentOrderResponseModelCopyWith<$Res>  {
  factory $CreatePaymentOrderResponseModelCopyWith(CreatePaymentOrderResponseModel value, $Res Function(CreatePaymentOrderResponseModel) _then) = _$CreatePaymentOrderResponseModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'orderId') String orderId, int amount, String currency, String receipt,@JsonKey(name: 'transactionId') int transactionId,@JsonKey(name: 'planDetails') SubscriptionPlanModel planDetails
});


$SubscriptionPlanModelCopyWith<$Res> get planDetails;

}
/// @nodoc
class _$CreatePaymentOrderResponseModelCopyWithImpl<$Res>
    implements $CreatePaymentOrderResponseModelCopyWith<$Res> {
  _$CreatePaymentOrderResponseModelCopyWithImpl(this._self, this._then);

  final CreatePaymentOrderResponseModel _self;
  final $Res Function(CreatePaymentOrderResponseModel) _then;

/// Create a copy of CreatePaymentOrderResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,Object? amount = null,Object? currency = null,Object? receipt = null,Object? transactionId = null,Object? planDetails = null,}) {
  return _then(_self.copyWith(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,receipt: null == receipt ? _self.receipt : receipt // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,planDetails: null == planDetails ? _self.planDetails : planDetails // ignore: cast_nullable_to_non_nullable
as SubscriptionPlanModel,
  ));
}
/// Create a copy of CreatePaymentOrderResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionPlanModelCopyWith<$Res> get planDetails {
  
  return $SubscriptionPlanModelCopyWith<$Res>(_self.planDetails, (value) {
    return _then(_self.copyWith(planDetails: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreatePaymentOrderResponseModel].
extension CreatePaymentOrderResponseModelPatterns on CreatePaymentOrderResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatePaymentOrderResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatePaymentOrderResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatePaymentOrderResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _CreatePaymentOrderResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatePaymentOrderResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreatePaymentOrderResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'orderId')  String orderId,  int amount,  String currency,  String receipt, @JsonKey(name: 'transactionId')  int transactionId, @JsonKey(name: 'planDetails')  SubscriptionPlanModel planDetails)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatePaymentOrderResponseModel() when $default != null:
return $default(_that.orderId,_that.amount,_that.currency,_that.receipt,_that.transactionId,_that.planDetails);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'orderId')  String orderId,  int amount,  String currency,  String receipt, @JsonKey(name: 'transactionId')  int transactionId, @JsonKey(name: 'planDetails')  SubscriptionPlanModel planDetails)  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentOrderResponseModel():
return $default(_that.orderId,_that.amount,_that.currency,_that.receipt,_that.transactionId,_that.planDetails);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'orderId')  String orderId,  int amount,  String currency,  String receipt, @JsonKey(name: 'transactionId')  int transactionId, @JsonKey(name: 'planDetails')  SubscriptionPlanModel planDetails)?  $default,) {final _that = this;
switch (_that) {
case _CreatePaymentOrderResponseModel() when $default != null:
return $default(_that.orderId,_that.amount,_that.currency,_that.receipt,_that.transactionId,_that.planDetails);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatePaymentOrderResponseModel implements CreatePaymentOrderResponseModel {
  const _CreatePaymentOrderResponseModel({@JsonKey(name: 'orderId') required this.orderId, required this.amount, required this.currency, required this.receipt, @JsonKey(name: 'transactionId') required this.transactionId, @JsonKey(name: 'planDetails') required this.planDetails});
  factory _CreatePaymentOrderResponseModel.fromJson(Map<String, dynamic> json) => _$CreatePaymentOrderResponseModelFromJson(json);

@override@JsonKey(name: 'orderId') final  String orderId;
@override final  int amount;
@override final  String currency;
@override final  String receipt;
@override@JsonKey(name: 'transactionId') final  int transactionId;
@override@JsonKey(name: 'planDetails') final  SubscriptionPlanModel planDetails;

/// Create a copy of CreatePaymentOrderResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatePaymentOrderResponseModelCopyWith<_CreatePaymentOrderResponseModel> get copyWith => __$CreatePaymentOrderResponseModelCopyWithImpl<_CreatePaymentOrderResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatePaymentOrderResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatePaymentOrderResponseModel&&(identical(other.orderId, orderId) || other.orderId == orderId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.receipt, receipt) || other.receipt == receipt)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.planDetails, planDetails) || other.planDetails == planDetails));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,orderId,amount,currency,receipt,transactionId,planDetails);

@override
String toString() {
  return 'CreatePaymentOrderResponseModel(orderId: $orderId, amount: $amount, currency: $currency, receipt: $receipt, transactionId: $transactionId, planDetails: $planDetails)';
}


}

/// @nodoc
abstract mixin class _$CreatePaymentOrderResponseModelCopyWith<$Res> implements $CreatePaymentOrderResponseModelCopyWith<$Res> {
  factory _$CreatePaymentOrderResponseModelCopyWith(_CreatePaymentOrderResponseModel value, $Res Function(_CreatePaymentOrderResponseModel) _then) = __$CreatePaymentOrderResponseModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'orderId') String orderId, int amount, String currency, String receipt,@JsonKey(name: 'transactionId') int transactionId,@JsonKey(name: 'planDetails') SubscriptionPlanModel planDetails
});


@override $SubscriptionPlanModelCopyWith<$Res> get planDetails;

}
/// @nodoc
class __$CreatePaymentOrderResponseModelCopyWithImpl<$Res>
    implements _$CreatePaymentOrderResponseModelCopyWith<$Res> {
  __$CreatePaymentOrderResponseModelCopyWithImpl(this._self, this._then);

  final _CreatePaymentOrderResponseModel _self;
  final $Res Function(_CreatePaymentOrderResponseModel) _then;

/// Create a copy of CreatePaymentOrderResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,Object? amount = null,Object? currency = null,Object? receipt = null,Object? transactionId = null,Object? planDetails = null,}) {
  return _then(_CreatePaymentOrderResponseModel(
orderId: null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,receipt: null == receipt ? _self.receipt : receipt // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,planDetails: null == planDetails ? _self.planDetails : planDetails // ignore: cast_nullable_to_non_nullable
as SubscriptionPlanModel,
  ));
}

/// Create a copy of CreatePaymentOrderResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionPlanModelCopyWith<$Res> get planDetails {
  
  return $SubscriptionPlanModelCopyWith<$Res>(_self.planDetails, (value) {
    return _then(_self.copyWith(planDetails: value));
  });
}
}


/// @nodoc
mixin _$VerifyPaymentRequestModel {

@JsonKey(name: 'transactionId') int get transactionId;@JsonKey(name: 'razorpayOrderId') String get razorpayOrderId;@JsonKey(name: 'razorpayPaymentId') String get razorpayPaymentId;@JsonKey(name: 'razorpaySignature') String get razorpaySignature;@JsonKey(name: 'autoRenew') bool get autoRenew;
/// Create a copy of VerifyPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyPaymentRequestModelCopyWith<VerifyPaymentRequestModel> get copyWith => _$VerifyPaymentRequestModelCopyWithImpl<VerifyPaymentRequestModel>(this as VerifyPaymentRequestModel, _$identity);

  /// Serializes this VerifyPaymentRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyPaymentRequestModel&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.razorpaySignature, razorpaySignature) || other.razorpaySignature == razorpaySignature)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,razorpayOrderId,razorpayPaymentId,razorpaySignature,autoRenew);

@override
String toString() {
  return 'VerifyPaymentRequestModel(transactionId: $transactionId, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, razorpaySignature: $razorpaySignature, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class $VerifyPaymentRequestModelCopyWith<$Res>  {
  factory $VerifyPaymentRequestModelCopyWith(VerifyPaymentRequestModel value, $Res Function(VerifyPaymentRequestModel) _then) = _$VerifyPaymentRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'transactionId') int transactionId,@JsonKey(name: 'razorpayOrderId') String razorpayOrderId,@JsonKey(name: 'razorpayPaymentId') String razorpayPaymentId,@JsonKey(name: 'razorpaySignature') String razorpaySignature,@JsonKey(name: 'autoRenew') bool autoRenew
});




}
/// @nodoc
class _$VerifyPaymentRequestModelCopyWithImpl<$Res>
    implements $VerifyPaymentRequestModelCopyWith<$Res> {
  _$VerifyPaymentRequestModelCopyWithImpl(this._self, this._then);

  final VerifyPaymentRequestModel _self;
  final $Res Function(VerifyPaymentRequestModel) _then;

/// Create a copy of VerifyPaymentRequestModel
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


/// Adds pattern-matching-related methods to [VerifyPaymentRequestModel].
extension VerifyPaymentRequestModelPatterns on VerifyPaymentRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyPaymentRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyPaymentRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyPaymentRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _VerifyPaymentRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyPaymentRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyPaymentRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'transactionId')  int transactionId, @JsonKey(name: 'razorpayOrderId')  String razorpayOrderId, @JsonKey(name: 'razorpayPaymentId')  String razorpayPaymentId, @JsonKey(name: 'razorpaySignature')  String razorpaySignature, @JsonKey(name: 'autoRenew')  bool autoRenew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyPaymentRequestModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'transactionId')  int transactionId, @JsonKey(name: 'razorpayOrderId')  String razorpayOrderId, @JsonKey(name: 'razorpayPaymentId')  String razorpayPaymentId, @JsonKey(name: 'razorpaySignature')  String razorpaySignature, @JsonKey(name: 'autoRenew')  bool autoRenew)  $default,) {final _that = this;
switch (_that) {
case _VerifyPaymentRequestModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'transactionId')  int transactionId, @JsonKey(name: 'razorpayOrderId')  String razorpayOrderId, @JsonKey(name: 'razorpayPaymentId')  String razorpayPaymentId, @JsonKey(name: 'razorpaySignature')  String razorpaySignature, @JsonKey(name: 'autoRenew')  bool autoRenew)?  $default,) {final _that = this;
switch (_that) {
case _VerifyPaymentRequestModel() when $default != null:
return $default(_that.transactionId,_that.razorpayOrderId,_that.razorpayPaymentId,_that.razorpaySignature,_that.autoRenew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyPaymentRequestModel implements VerifyPaymentRequestModel {
  const _VerifyPaymentRequestModel({@JsonKey(name: 'transactionId') required this.transactionId, @JsonKey(name: 'razorpayOrderId') required this.razorpayOrderId, @JsonKey(name: 'razorpayPaymentId') required this.razorpayPaymentId, @JsonKey(name: 'razorpaySignature') required this.razorpaySignature, @JsonKey(name: 'autoRenew') this.autoRenew = false});
  factory _VerifyPaymentRequestModel.fromJson(Map<String, dynamic> json) => _$VerifyPaymentRequestModelFromJson(json);

@override@JsonKey(name: 'transactionId') final  int transactionId;
@override@JsonKey(name: 'razorpayOrderId') final  String razorpayOrderId;
@override@JsonKey(name: 'razorpayPaymentId') final  String razorpayPaymentId;
@override@JsonKey(name: 'razorpaySignature') final  String razorpaySignature;
@override@JsonKey(name: 'autoRenew') final  bool autoRenew;

/// Create a copy of VerifyPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyPaymentRequestModelCopyWith<_VerifyPaymentRequestModel> get copyWith => __$VerifyPaymentRequestModelCopyWithImpl<_VerifyPaymentRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyPaymentRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyPaymentRequestModel&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.razorpaySignature, razorpaySignature) || other.razorpaySignature == razorpaySignature)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,razorpayOrderId,razorpayPaymentId,razorpaySignature,autoRenew);

@override
String toString() {
  return 'VerifyPaymentRequestModel(transactionId: $transactionId, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, razorpaySignature: $razorpaySignature, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class _$VerifyPaymentRequestModelCopyWith<$Res> implements $VerifyPaymentRequestModelCopyWith<$Res> {
  factory _$VerifyPaymentRequestModelCopyWith(_VerifyPaymentRequestModel value, $Res Function(_VerifyPaymentRequestModel) _then) = __$VerifyPaymentRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'transactionId') int transactionId,@JsonKey(name: 'razorpayOrderId') String razorpayOrderId,@JsonKey(name: 'razorpayPaymentId') String razorpayPaymentId,@JsonKey(name: 'razorpaySignature') String razorpaySignature,@JsonKey(name: 'autoRenew') bool autoRenew
});




}
/// @nodoc
class __$VerifyPaymentRequestModelCopyWithImpl<$Res>
    implements _$VerifyPaymentRequestModelCopyWith<$Res> {
  __$VerifyPaymentRequestModelCopyWithImpl(this._self, this._then);

  final _VerifyPaymentRequestModel _self;
  final $Res Function(_VerifyPaymentRequestModel) _then;

/// Create a copy of VerifyPaymentRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? razorpayOrderId = null,Object? razorpayPaymentId = null,Object? razorpaySignature = null,Object? autoRenew = null,}) {
  return _then(_VerifyPaymentRequestModel(
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
mixin _$VerifyPaymentResponseModel {

 bool get success; String get message;@JsonKey(name: 'subscriptionId') int get subscriptionId; UserSubscriptionModel get subscription;
/// Create a copy of VerifyPaymentResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyPaymentResponseModelCopyWith<VerifyPaymentResponseModel> get copyWith => _$VerifyPaymentResponseModelCopyWithImpl<VerifyPaymentResponseModel>(this as VerifyPaymentResponseModel, _$identity);

  /// Serializes this VerifyPaymentResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyPaymentResponseModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId)&&(identical(other.subscription, subscription) || other.subscription == subscription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,subscriptionId,subscription);

@override
String toString() {
  return 'VerifyPaymentResponseModel(success: $success, message: $message, subscriptionId: $subscriptionId, subscription: $subscription)';
}


}

/// @nodoc
abstract mixin class $VerifyPaymentResponseModelCopyWith<$Res>  {
  factory $VerifyPaymentResponseModelCopyWith(VerifyPaymentResponseModel value, $Res Function(VerifyPaymentResponseModel) _then) = _$VerifyPaymentResponseModelCopyWithImpl;
@useResult
$Res call({
 bool success, String message,@JsonKey(name: 'subscriptionId') int subscriptionId, UserSubscriptionModel subscription
});


$UserSubscriptionModelCopyWith<$Res> get subscription;

}
/// @nodoc
class _$VerifyPaymentResponseModelCopyWithImpl<$Res>
    implements $VerifyPaymentResponseModelCopyWith<$Res> {
  _$VerifyPaymentResponseModelCopyWithImpl(this._self, this._then);

  final VerifyPaymentResponseModel _self;
  final $Res Function(VerifyPaymentResponseModel) _then;

/// Create a copy of VerifyPaymentResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? subscriptionId = null,Object? subscription = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,subscriptionId: null == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as int,subscription: null == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as UserSubscriptionModel,
  ));
}
/// Create a copy of VerifyPaymentResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSubscriptionModelCopyWith<$Res> get subscription {
  
  return $UserSubscriptionModelCopyWith<$Res>(_self.subscription, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}
}


/// Adds pattern-matching-related methods to [VerifyPaymentResponseModel].
extension VerifyPaymentResponseModelPatterns on VerifyPaymentResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyPaymentResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyPaymentResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyPaymentResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _VerifyPaymentResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyPaymentResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyPaymentResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message, @JsonKey(name: 'subscriptionId')  int subscriptionId,  UserSubscriptionModel subscription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyPaymentResponseModel() when $default != null:
return $default(_that.success,_that.message,_that.subscriptionId,_that.subscription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message, @JsonKey(name: 'subscriptionId')  int subscriptionId,  UserSubscriptionModel subscription)  $default,) {final _that = this;
switch (_that) {
case _VerifyPaymentResponseModel():
return $default(_that.success,_that.message,_that.subscriptionId,_that.subscription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message, @JsonKey(name: 'subscriptionId')  int subscriptionId,  UserSubscriptionModel subscription)?  $default,) {final _that = this;
switch (_that) {
case _VerifyPaymentResponseModel() when $default != null:
return $default(_that.success,_that.message,_that.subscriptionId,_that.subscription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyPaymentResponseModel implements VerifyPaymentResponseModel {
  const _VerifyPaymentResponseModel({required this.success, required this.message, @JsonKey(name: 'subscriptionId') required this.subscriptionId, required this.subscription});
  factory _VerifyPaymentResponseModel.fromJson(Map<String, dynamic> json) => _$VerifyPaymentResponseModelFromJson(json);

@override final  bool success;
@override final  String message;
@override@JsonKey(name: 'subscriptionId') final  int subscriptionId;
@override final  UserSubscriptionModel subscription;

/// Create a copy of VerifyPaymentResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyPaymentResponseModelCopyWith<_VerifyPaymentResponseModel> get copyWith => __$VerifyPaymentResponseModelCopyWithImpl<_VerifyPaymentResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyPaymentResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyPaymentResponseModel&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId)&&(identical(other.subscription, subscription) || other.subscription == subscription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,subscriptionId,subscription);

@override
String toString() {
  return 'VerifyPaymentResponseModel(success: $success, message: $message, subscriptionId: $subscriptionId, subscription: $subscription)';
}


}

/// @nodoc
abstract mixin class _$VerifyPaymentResponseModelCopyWith<$Res> implements $VerifyPaymentResponseModelCopyWith<$Res> {
  factory _$VerifyPaymentResponseModelCopyWith(_VerifyPaymentResponseModel value, $Res Function(_VerifyPaymentResponseModel) _then) = __$VerifyPaymentResponseModelCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message,@JsonKey(name: 'subscriptionId') int subscriptionId, UserSubscriptionModel subscription
});


@override $UserSubscriptionModelCopyWith<$Res> get subscription;

}
/// @nodoc
class __$VerifyPaymentResponseModelCopyWithImpl<$Res>
    implements _$VerifyPaymentResponseModelCopyWith<$Res> {
  __$VerifyPaymentResponseModelCopyWithImpl(this._self, this._then);

  final _VerifyPaymentResponseModel _self;
  final $Res Function(_VerifyPaymentResponseModel) _then;

/// Create a copy of VerifyPaymentResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? subscriptionId = null,Object? subscription = null,}) {
  return _then(_VerifyPaymentResponseModel(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,subscriptionId: null == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as int,subscription: null == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as UserSubscriptionModel,
  ));
}

/// Create a copy of VerifyPaymentResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSubscriptionModelCopyWith<$Res> get subscription {
  
  return $UserSubscriptionModelCopyWith<$Res>(_self.subscription, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}
}


/// @nodoc
mixin _$PaymentTransactionModel {

@JsonKey(name: 'transactionId') int get transactionId; String get status; double get amount;@JsonKey(name: 'paymentReference') String? get paymentReference;@JsonKey(name: 'paymentGatewayOrderId') String? get paymentGatewayOrderId;@JsonKey(name: 'createdAt') DateTime get createdAt;@JsonKey(name: 'failureReason') String? get failureReason;@JsonKey(name: 'planName') String? get planName;
/// Create a copy of PaymentTransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentTransactionModelCopyWith<PaymentTransactionModel> get copyWith => _$PaymentTransactionModelCopyWithImpl<PaymentTransactionModel>(this as PaymentTransactionModel, _$identity);

  /// Serializes this PaymentTransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentTransactionModel&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.paymentGatewayOrderId, paymentGatewayOrderId) || other.paymentGatewayOrderId == paymentGatewayOrderId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.planName, planName) || other.planName == planName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,status,amount,paymentReference,paymentGatewayOrderId,createdAt,failureReason,planName);

@override
String toString() {
  return 'PaymentTransactionModel(transactionId: $transactionId, status: $status, amount: $amount, paymentReference: $paymentReference, paymentGatewayOrderId: $paymentGatewayOrderId, createdAt: $createdAt, failureReason: $failureReason, planName: $planName)';
}


}

/// @nodoc
abstract mixin class $PaymentTransactionModelCopyWith<$Res>  {
  factory $PaymentTransactionModelCopyWith(PaymentTransactionModel value, $Res Function(PaymentTransactionModel) _then) = _$PaymentTransactionModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'transactionId') int transactionId, String status, double amount,@JsonKey(name: 'paymentReference') String? paymentReference,@JsonKey(name: 'paymentGatewayOrderId') String? paymentGatewayOrderId,@JsonKey(name: 'createdAt') DateTime createdAt,@JsonKey(name: 'failureReason') String? failureReason,@JsonKey(name: 'planName') String? planName
});




}
/// @nodoc
class _$PaymentTransactionModelCopyWithImpl<$Res>
    implements $PaymentTransactionModelCopyWith<$Res> {
  _$PaymentTransactionModelCopyWithImpl(this._self, this._then);

  final PaymentTransactionModel _self;
  final $Res Function(PaymentTransactionModel) _then;

/// Create a copy of PaymentTransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactionId = null,Object? status = null,Object? amount = null,Object? paymentReference = freezed,Object? paymentGatewayOrderId = freezed,Object? createdAt = null,Object? failureReason = freezed,Object? planName = freezed,}) {
  return _then(_self.copyWith(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,paymentGatewayOrderId: freezed == paymentGatewayOrderId ? _self.paymentGatewayOrderId : paymentGatewayOrderId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentTransactionModel].
extension PaymentTransactionModelPatterns on PaymentTransactionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentTransactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentTransactionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentTransactionModel value)  $default,){
final _that = this;
switch (_that) {
case _PaymentTransactionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentTransactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentTransactionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'transactionId')  int transactionId,  String status,  double amount, @JsonKey(name: 'paymentReference')  String? paymentReference, @JsonKey(name: 'paymentGatewayOrderId')  String? paymentGatewayOrderId, @JsonKey(name: 'createdAt')  DateTime createdAt, @JsonKey(name: 'failureReason')  String? failureReason, @JsonKey(name: 'planName')  String? planName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentTransactionModel() when $default != null:
return $default(_that.transactionId,_that.status,_that.amount,_that.paymentReference,_that.paymentGatewayOrderId,_that.createdAt,_that.failureReason,_that.planName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'transactionId')  int transactionId,  String status,  double amount, @JsonKey(name: 'paymentReference')  String? paymentReference, @JsonKey(name: 'paymentGatewayOrderId')  String? paymentGatewayOrderId, @JsonKey(name: 'createdAt')  DateTime createdAt, @JsonKey(name: 'failureReason')  String? failureReason, @JsonKey(name: 'planName')  String? planName)  $default,) {final _that = this;
switch (_that) {
case _PaymentTransactionModel():
return $default(_that.transactionId,_that.status,_that.amount,_that.paymentReference,_that.paymentGatewayOrderId,_that.createdAt,_that.failureReason,_that.planName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'transactionId')  int transactionId,  String status,  double amount, @JsonKey(name: 'paymentReference')  String? paymentReference, @JsonKey(name: 'paymentGatewayOrderId')  String? paymentGatewayOrderId, @JsonKey(name: 'createdAt')  DateTime createdAt, @JsonKey(name: 'failureReason')  String? failureReason, @JsonKey(name: 'planName')  String? planName)?  $default,) {final _that = this;
switch (_that) {
case _PaymentTransactionModel() when $default != null:
return $default(_that.transactionId,_that.status,_that.amount,_that.paymentReference,_that.paymentGatewayOrderId,_that.createdAt,_that.failureReason,_that.planName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentTransactionModel implements PaymentTransactionModel {
  const _PaymentTransactionModel({@JsonKey(name: 'transactionId') required this.transactionId, required this.status, required this.amount, @JsonKey(name: 'paymentReference') this.paymentReference, @JsonKey(name: 'paymentGatewayOrderId') this.paymentGatewayOrderId, @JsonKey(name: 'createdAt') required this.createdAt, @JsonKey(name: 'failureReason') this.failureReason, @JsonKey(name: 'planName') this.planName});
  factory _PaymentTransactionModel.fromJson(Map<String, dynamic> json) => _$PaymentTransactionModelFromJson(json);

@override@JsonKey(name: 'transactionId') final  int transactionId;
@override final  String status;
@override final  double amount;
@override@JsonKey(name: 'paymentReference') final  String? paymentReference;
@override@JsonKey(name: 'paymentGatewayOrderId') final  String? paymentGatewayOrderId;
@override@JsonKey(name: 'createdAt') final  DateTime createdAt;
@override@JsonKey(name: 'failureReason') final  String? failureReason;
@override@JsonKey(name: 'planName') final  String? planName;

/// Create a copy of PaymentTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentTransactionModelCopyWith<_PaymentTransactionModel> get copyWith => __$PaymentTransactionModelCopyWithImpl<_PaymentTransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentTransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentTransactionModel&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.paymentGatewayOrderId, paymentGatewayOrderId) || other.paymentGatewayOrderId == paymentGatewayOrderId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.planName, planName) || other.planName == planName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transactionId,status,amount,paymentReference,paymentGatewayOrderId,createdAt,failureReason,planName);

@override
String toString() {
  return 'PaymentTransactionModel(transactionId: $transactionId, status: $status, amount: $amount, paymentReference: $paymentReference, paymentGatewayOrderId: $paymentGatewayOrderId, createdAt: $createdAt, failureReason: $failureReason, planName: $planName)';
}


}

/// @nodoc
abstract mixin class _$PaymentTransactionModelCopyWith<$Res> implements $PaymentTransactionModelCopyWith<$Res> {
  factory _$PaymentTransactionModelCopyWith(_PaymentTransactionModel value, $Res Function(_PaymentTransactionModel) _then) = __$PaymentTransactionModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'transactionId') int transactionId, String status, double amount,@JsonKey(name: 'paymentReference') String? paymentReference,@JsonKey(name: 'paymentGatewayOrderId') String? paymentGatewayOrderId,@JsonKey(name: 'createdAt') DateTime createdAt,@JsonKey(name: 'failureReason') String? failureReason,@JsonKey(name: 'planName') String? planName
});




}
/// @nodoc
class __$PaymentTransactionModelCopyWithImpl<$Res>
    implements _$PaymentTransactionModelCopyWith<$Res> {
  __$PaymentTransactionModelCopyWithImpl(this._self, this._then);

  final _PaymentTransactionModel _self;
  final $Res Function(_PaymentTransactionModel) _then;

/// Create a copy of PaymentTransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactionId = null,Object? status = null,Object? amount = null,Object? paymentReference = freezed,Object? paymentGatewayOrderId = freezed,Object? createdAt = null,Object? failureReason = freezed,Object? planName = freezed,}) {
  return _then(_PaymentTransactionModel(
transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,paymentGatewayOrderId: freezed == paymentGatewayOrderId ? _self.paymentGatewayOrderId : paymentGatewayOrderId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$InsufficientPointsErrorModel {

 String get message;@JsonKey(name: 'availablePoints') int get availablePoints;@JsonKey(name: 'requiredPoints') int get requiredPoints; int get shortfall;
/// Create a copy of InsufficientPointsErrorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InsufficientPointsErrorModelCopyWith<InsufficientPointsErrorModel> get copyWith => _$InsufficientPointsErrorModelCopyWithImpl<InsufficientPointsErrorModel>(this as InsufficientPointsErrorModel, _$identity);

  /// Serializes this InsufficientPointsErrorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InsufficientPointsErrorModel&&(identical(other.message, message) || other.message == message)&&(identical(other.availablePoints, availablePoints) || other.availablePoints == availablePoints)&&(identical(other.requiredPoints, requiredPoints) || other.requiredPoints == requiredPoints)&&(identical(other.shortfall, shortfall) || other.shortfall == shortfall));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,availablePoints,requiredPoints,shortfall);

@override
String toString() {
  return 'InsufficientPointsErrorModel(message: $message, availablePoints: $availablePoints, requiredPoints: $requiredPoints, shortfall: $shortfall)';
}


}

/// @nodoc
abstract mixin class $InsufficientPointsErrorModelCopyWith<$Res>  {
  factory $InsufficientPointsErrorModelCopyWith(InsufficientPointsErrorModel value, $Res Function(InsufficientPointsErrorModel) _then) = _$InsufficientPointsErrorModelCopyWithImpl;
@useResult
$Res call({
 String message,@JsonKey(name: 'availablePoints') int availablePoints,@JsonKey(name: 'requiredPoints') int requiredPoints, int shortfall
});




}
/// @nodoc
class _$InsufficientPointsErrorModelCopyWithImpl<$Res>
    implements $InsufficientPointsErrorModelCopyWith<$Res> {
  _$InsufficientPointsErrorModelCopyWithImpl(this._self, this._then);

  final InsufficientPointsErrorModel _self;
  final $Res Function(InsufficientPointsErrorModel) _then;

/// Create a copy of InsufficientPointsErrorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? availablePoints = null,Object? requiredPoints = null,Object? shortfall = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,availablePoints: null == availablePoints ? _self.availablePoints : availablePoints // ignore: cast_nullable_to_non_nullable
as int,requiredPoints: null == requiredPoints ? _self.requiredPoints : requiredPoints // ignore: cast_nullable_to_non_nullable
as int,shortfall: null == shortfall ? _self.shortfall : shortfall // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [InsufficientPointsErrorModel].
extension InsufficientPointsErrorModelPatterns on InsufficientPointsErrorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InsufficientPointsErrorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InsufficientPointsErrorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InsufficientPointsErrorModel value)  $default,){
final _that = this;
switch (_that) {
case _InsufficientPointsErrorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InsufficientPointsErrorModel value)?  $default,){
final _that = this;
switch (_that) {
case _InsufficientPointsErrorModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message, @JsonKey(name: 'availablePoints')  int availablePoints, @JsonKey(name: 'requiredPoints')  int requiredPoints,  int shortfall)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InsufficientPointsErrorModel() when $default != null:
return $default(_that.message,_that.availablePoints,_that.requiredPoints,_that.shortfall);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message, @JsonKey(name: 'availablePoints')  int availablePoints, @JsonKey(name: 'requiredPoints')  int requiredPoints,  int shortfall)  $default,) {final _that = this;
switch (_that) {
case _InsufficientPointsErrorModel():
return $default(_that.message,_that.availablePoints,_that.requiredPoints,_that.shortfall);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message, @JsonKey(name: 'availablePoints')  int availablePoints, @JsonKey(name: 'requiredPoints')  int requiredPoints,  int shortfall)?  $default,) {final _that = this;
switch (_that) {
case _InsufficientPointsErrorModel() when $default != null:
return $default(_that.message,_that.availablePoints,_that.requiredPoints,_that.shortfall);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InsufficientPointsErrorModel implements InsufficientPointsErrorModel {
  const _InsufficientPointsErrorModel({required this.message, @JsonKey(name: 'availablePoints') required this.availablePoints, @JsonKey(name: 'requiredPoints') required this.requiredPoints, required this.shortfall});
  factory _InsufficientPointsErrorModel.fromJson(Map<String, dynamic> json) => _$InsufficientPointsErrorModelFromJson(json);

@override final  String message;
@override@JsonKey(name: 'availablePoints') final  int availablePoints;
@override@JsonKey(name: 'requiredPoints') final  int requiredPoints;
@override final  int shortfall;

/// Create a copy of InsufficientPointsErrorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InsufficientPointsErrorModelCopyWith<_InsufficientPointsErrorModel> get copyWith => __$InsufficientPointsErrorModelCopyWithImpl<_InsufficientPointsErrorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InsufficientPointsErrorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InsufficientPointsErrorModel&&(identical(other.message, message) || other.message == message)&&(identical(other.availablePoints, availablePoints) || other.availablePoints == availablePoints)&&(identical(other.requiredPoints, requiredPoints) || other.requiredPoints == requiredPoints)&&(identical(other.shortfall, shortfall) || other.shortfall == shortfall));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,availablePoints,requiredPoints,shortfall);

@override
String toString() {
  return 'InsufficientPointsErrorModel(message: $message, availablePoints: $availablePoints, requiredPoints: $requiredPoints, shortfall: $shortfall)';
}


}

/// @nodoc
abstract mixin class _$InsufficientPointsErrorModelCopyWith<$Res> implements $InsufficientPointsErrorModelCopyWith<$Res> {
  factory _$InsufficientPointsErrorModelCopyWith(_InsufficientPointsErrorModel value, $Res Function(_InsufficientPointsErrorModel) _then) = __$InsufficientPointsErrorModelCopyWithImpl;
@override @useResult
$Res call({
 String message,@JsonKey(name: 'availablePoints') int availablePoints,@JsonKey(name: 'requiredPoints') int requiredPoints, int shortfall
});




}
/// @nodoc
class __$InsufficientPointsErrorModelCopyWithImpl<$Res>
    implements _$InsufficientPointsErrorModelCopyWith<$Res> {
  __$InsufficientPointsErrorModelCopyWithImpl(this._self, this._then);

  final _InsufficientPointsErrorModel _self;
  final $Res Function(_InsufficientPointsErrorModel) _then;

/// Create a copy of InsufficientPointsErrorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? availablePoints = null,Object? requiredPoints = null,Object? shortfall = null,}) {
  return _then(_InsufficientPointsErrorModel(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,availablePoints: null == availablePoints ? _self.availablePoints : availablePoints // ignore: cast_nullable_to_non_nullable
as int,requiredPoints: null == requiredPoints ? _self.requiredPoints : requiredPoints // ignore: cast_nullable_to_non_nullable
as int,shortfall: null == shortfall ? _self.shortfall : shortfall // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ExistingSubscriptionErrorModel {

 String get message;@JsonKey(name: 'activeSubscription') ExistingSubscriptionDetailsModel get activeSubscription;
/// Create a copy of ExistingSubscriptionErrorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExistingSubscriptionErrorModelCopyWith<ExistingSubscriptionErrorModel> get copyWith => _$ExistingSubscriptionErrorModelCopyWithImpl<ExistingSubscriptionErrorModel>(this as ExistingSubscriptionErrorModel, _$identity);

  /// Serializes this ExistingSubscriptionErrorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExistingSubscriptionErrorModel&&(identical(other.message, message) || other.message == message)&&(identical(other.activeSubscription, activeSubscription) || other.activeSubscription == activeSubscription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,activeSubscription);

@override
String toString() {
  return 'ExistingSubscriptionErrorModel(message: $message, activeSubscription: $activeSubscription)';
}


}

/// @nodoc
abstract mixin class $ExistingSubscriptionErrorModelCopyWith<$Res>  {
  factory $ExistingSubscriptionErrorModelCopyWith(ExistingSubscriptionErrorModel value, $Res Function(ExistingSubscriptionErrorModel) _then) = _$ExistingSubscriptionErrorModelCopyWithImpl;
@useResult
$Res call({
 String message,@JsonKey(name: 'activeSubscription') ExistingSubscriptionDetailsModel activeSubscription
});


$ExistingSubscriptionDetailsModelCopyWith<$Res> get activeSubscription;

}
/// @nodoc
class _$ExistingSubscriptionErrorModelCopyWithImpl<$Res>
    implements $ExistingSubscriptionErrorModelCopyWith<$Res> {
  _$ExistingSubscriptionErrorModelCopyWithImpl(this._self, this._then);

  final ExistingSubscriptionErrorModel _self;
  final $Res Function(ExistingSubscriptionErrorModel) _then;

/// Create a copy of ExistingSubscriptionErrorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? activeSubscription = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,activeSubscription: null == activeSubscription ? _self.activeSubscription : activeSubscription // ignore: cast_nullable_to_non_nullable
as ExistingSubscriptionDetailsModel,
  ));
}
/// Create a copy of ExistingSubscriptionErrorModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExistingSubscriptionDetailsModelCopyWith<$Res> get activeSubscription {
  
  return $ExistingSubscriptionDetailsModelCopyWith<$Res>(_self.activeSubscription, (value) {
    return _then(_self.copyWith(activeSubscription: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExistingSubscriptionErrorModel].
extension ExistingSubscriptionErrorModelPatterns on ExistingSubscriptionErrorModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExistingSubscriptionErrorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExistingSubscriptionErrorModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExistingSubscriptionErrorModel value)  $default,){
final _that = this;
switch (_that) {
case _ExistingSubscriptionErrorModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExistingSubscriptionErrorModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExistingSubscriptionErrorModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String message, @JsonKey(name: 'activeSubscription')  ExistingSubscriptionDetailsModel activeSubscription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExistingSubscriptionErrorModel() when $default != null:
return $default(_that.message,_that.activeSubscription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String message, @JsonKey(name: 'activeSubscription')  ExistingSubscriptionDetailsModel activeSubscription)  $default,) {final _that = this;
switch (_that) {
case _ExistingSubscriptionErrorModel():
return $default(_that.message,_that.activeSubscription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String message, @JsonKey(name: 'activeSubscription')  ExistingSubscriptionDetailsModel activeSubscription)?  $default,) {final _that = this;
switch (_that) {
case _ExistingSubscriptionErrorModel() when $default != null:
return $default(_that.message,_that.activeSubscription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExistingSubscriptionErrorModel implements ExistingSubscriptionErrorModel {
  const _ExistingSubscriptionErrorModel({required this.message, @JsonKey(name: 'activeSubscription') required this.activeSubscription});
  factory _ExistingSubscriptionErrorModel.fromJson(Map<String, dynamic> json) => _$ExistingSubscriptionErrorModelFromJson(json);

@override final  String message;
@override@JsonKey(name: 'activeSubscription') final  ExistingSubscriptionDetailsModel activeSubscription;

/// Create a copy of ExistingSubscriptionErrorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExistingSubscriptionErrorModelCopyWith<_ExistingSubscriptionErrorModel> get copyWith => __$ExistingSubscriptionErrorModelCopyWithImpl<_ExistingSubscriptionErrorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExistingSubscriptionErrorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExistingSubscriptionErrorModel&&(identical(other.message, message) || other.message == message)&&(identical(other.activeSubscription, activeSubscription) || other.activeSubscription == activeSubscription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,message,activeSubscription);

@override
String toString() {
  return 'ExistingSubscriptionErrorModel(message: $message, activeSubscription: $activeSubscription)';
}


}

/// @nodoc
abstract mixin class _$ExistingSubscriptionErrorModelCopyWith<$Res> implements $ExistingSubscriptionErrorModelCopyWith<$Res> {
  factory _$ExistingSubscriptionErrorModelCopyWith(_ExistingSubscriptionErrorModel value, $Res Function(_ExistingSubscriptionErrorModel) _then) = __$ExistingSubscriptionErrorModelCopyWithImpl;
@override @useResult
$Res call({
 String message,@JsonKey(name: 'activeSubscription') ExistingSubscriptionDetailsModel activeSubscription
});


@override $ExistingSubscriptionDetailsModelCopyWith<$Res> get activeSubscription;

}
/// @nodoc
class __$ExistingSubscriptionErrorModelCopyWithImpl<$Res>
    implements _$ExistingSubscriptionErrorModelCopyWith<$Res> {
  __$ExistingSubscriptionErrorModelCopyWithImpl(this._self, this._then);

  final _ExistingSubscriptionErrorModel _self;
  final $Res Function(_ExistingSubscriptionErrorModel) _then;

/// Create a copy of ExistingSubscriptionErrorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? activeSubscription = null,}) {
  return _then(_ExistingSubscriptionErrorModel(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,activeSubscription: null == activeSubscription ? _self.activeSubscription : activeSubscription // ignore: cast_nullable_to_non_nullable
as ExistingSubscriptionDetailsModel,
  ));
}

/// Create a copy of ExistingSubscriptionErrorModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExistingSubscriptionDetailsModelCopyWith<$Res> get activeSubscription {
  
  return $ExistingSubscriptionDetailsModelCopyWith<$Res>(_self.activeSubscription, (value) {
    return _then(_self.copyWith(activeSubscription: value));
  });
}
}


/// @nodoc
mixin _$ExistingSubscriptionDetailsModel {

@JsonKey(name: 'planId') int get planId;@JsonKey(name: 'endDate') DateTime get endDate;
/// Create a copy of ExistingSubscriptionDetailsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExistingSubscriptionDetailsModelCopyWith<ExistingSubscriptionDetailsModel> get copyWith => _$ExistingSubscriptionDetailsModelCopyWithImpl<ExistingSubscriptionDetailsModel>(this as ExistingSubscriptionDetailsModel, _$identity);

  /// Serializes this ExistingSubscriptionDetailsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExistingSubscriptionDetailsModel&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,endDate);

@override
String toString() {
  return 'ExistingSubscriptionDetailsModel(planId: $planId, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $ExistingSubscriptionDetailsModelCopyWith<$Res>  {
  factory $ExistingSubscriptionDetailsModelCopyWith(ExistingSubscriptionDetailsModel value, $Res Function(ExistingSubscriptionDetailsModel) _then) = _$ExistingSubscriptionDetailsModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'planId') int planId,@JsonKey(name: 'endDate') DateTime endDate
});




}
/// @nodoc
class _$ExistingSubscriptionDetailsModelCopyWithImpl<$Res>
    implements $ExistingSubscriptionDetailsModelCopyWith<$Res> {
  _$ExistingSubscriptionDetailsModelCopyWithImpl(this._self, this._then);

  final ExistingSubscriptionDetailsModel _self;
  final $Res Function(ExistingSubscriptionDetailsModel) _then;

/// Create a copy of ExistingSubscriptionDetailsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? planId = null,Object? endDate = null,}) {
  return _then(_self.copyWith(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ExistingSubscriptionDetailsModel].
extension ExistingSubscriptionDetailsModelPatterns on ExistingSubscriptionDetailsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExistingSubscriptionDetailsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExistingSubscriptionDetailsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExistingSubscriptionDetailsModel value)  $default,){
final _that = this;
switch (_that) {
case _ExistingSubscriptionDetailsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExistingSubscriptionDetailsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ExistingSubscriptionDetailsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'endDate')  DateTime endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExistingSubscriptionDetailsModel() when $default != null:
return $default(_that.planId,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'endDate')  DateTime endDate)  $default,) {final _that = this;
switch (_that) {
case _ExistingSubscriptionDetailsModel():
return $default(_that.planId,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'planId')  int planId, @JsonKey(name: 'endDate')  DateTime endDate)?  $default,) {final _that = this;
switch (_that) {
case _ExistingSubscriptionDetailsModel() when $default != null:
return $default(_that.planId,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExistingSubscriptionDetailsModel implements ExistingSubscriptionDetailsModel {
  const _ExistingSubscriptionDetailsModel({@JsonKey(name: 'planId') required this.planId, @JsonKey(name: 'endDate') required this.endDate});
  factory _ExistingSubscriptionDetailsModel.fromJson(Map<String, dynamic> json) => _$ExistingSubscriptionDetailsModelFromJson(json);

@override@JsonKey(name: 'planId') final  int planId;
@override@JsonKey(name: 'endDate') final  DateTime endDate;

/// Create a copy of ExistingSubscriptionDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExistingSubscriptionDetailsModelCopyWith<_ExistingSubscriptionDetailsModel> get copyWith => __$ExistingSubscriptionDetailsModelCopyWithImpl<_ExistingSubscriptionDetailsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExistingSubscriptionDetailsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExistingSubscriptionDetailsModel&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,planId,endDate);

@override
String toString() {
  return 'ExistingSubscriptionDetailsModel(planId: $planId, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$ExistingSubscriptionDetailsModelCopyWith<$Res> implements $ExistingSubscriptionDetailsModelCopyWith<$Res> {
  factory _$ExistingSubscriptionDetailsModelCopyWith(_ExistingSubscriptionDetailsModel value, $Res Function(_ExistingSubscriptionDetailsModel) _then) = __$ExistingSubscriptionDetailsModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'planId') int planId,@JsonKey(name: 'endDate') DateTime endDate
});




}
/// @nodoc
class __$ExistingSubscriptionDetailsModelCopyWithImpl<$Res>
    implements _$ExistingSubscriptionDetailsModelCopyWith<$Res> {
  __$ExistingSubscriptionDetailsModelCopyWithImpl(this._self, this._then);

  final _ExistingSubscriptionDetailsModel _self;
  final $Res Function(_ExistingSubscriptionDetailsModel) _then;

/// Create a copy of ExistingSubscriptionDetailsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? planId = null,Object? endDate = null,}) {
  return _then(_ExistingSubscriptionDetailsModel(
planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
