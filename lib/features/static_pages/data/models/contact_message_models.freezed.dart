// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_message_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubmitContactMessageRequest {

 String get fullName; String get email; String? get subject; String get message; String? get source;
/// Create a copy of SubmitContactMessageRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitContactMessageRequestCopyWith<SubmitContactMessageRequest> get copyWith => _$SubmitContactMessageRequestCopyWithImpl<SubmitContactMessageRequest>(this as SubmitContactMessageRequest, _$identity);

  /// Serializes this SubmitContactMessageRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitContactMessageRequest&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.message, message) || other.message == message)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,subject,message,source);

@override
String toString() {
  return 'SubmitContactMessageRequest(fullName: $fullName, email: $email, subject: $subject, message: $message, source: $source)';
}


}

/// @nodoc
abstract mixin class $SubmitContactMessageRequestCopyWith<$Res>  {
  factory $SubmitContactMessageRequestCopyWith(SubmitContactMessageRequest value, $Res Function(SubmitContactMessageRequest) _then) = _$SubmitContactMessageRequestCopyWithImpl;
@useResult
$Res call({
 String fullName, String email, String? subject, String message, String? source
});




}
/// @nodoc
class _$SubmitContactMessageRequestCopyWithImpl<$Res>
    implements $SubmitContactMessageRequestCopyWith<$Res> {
  _$SubmitContactMessageRequestCopyWithImpl(this._self, this._then);

  final SubmitContactMessageRequest _self;
  final $Res Function(SubmitContactMessageRequest) _then;

/// Create a copy of SubmitContactMessageRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? email = null,Object? subject = freezed,Object? message = null,Object? source = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubmitContactMessageRequest].
extension SubmitContactMessageRequestPatterns on SubmitContactMessageRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubmitContactMessageRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmitContactMessageRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubmitContactMessageRequest value)  $default,){
final _that = this;
switch (_that) {
case _SubmitContactMessageRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubmitContactMessageRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SubmitContactMessageRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String email,  String? subject,  String message,  String? source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmitContactMessageRequest() when $default != null:
return $default(_that.fullName,_that.email,_that.subject,_that.message,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String email,  String? subject,  String message,  String? source)  $default,) {final _that = this;
switch (_that) {
case _SubmitContactMessageRequest():
return $default(_that.fullName,_that.email,_that.subject,_that.message,_that.source);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String email,  String? subject,  String message,  String? source)?  $default,) {final _that = this;
switch (_that) {
case _SubmitContactMessageRequest() when $default != null:
return $default(_that.fullName,_that.email,_that.subject,_that.message,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubmitContactMessageRequest implements SubmitContactMessageRequest {
  const _SubmitContactMessageRequest({required this.fullName, required this.email, this.subject, required this.message, this.source});
  factory _SubmitContactMessageRequest.fromJson(Map<String, dynamic> json) => _$SubmitContactMessageRequestFromJson(json);

@override final  String fullName;
@override final  String email;
@override final  String? subject;
@override final  String message;
@override final  String? source;

/// Create a copy of SubmitContactMessageRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmitContactMessageRequestCopyWith<_SubmitContactMessageRequest> get copyWith => __$SubmitContactMessageRequestCopyWithImpl<_SubmitContactMessageRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubmitContactMessageRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmitContactMessageRequest&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.message, message) || other.message == message)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,subject,message,source);

@override
String toString() {
  return 'SubmitContactMessageRequest(fullName: $fullName, email: $email, subject: $subject, message: $message, source: $source)';
}


}

/// @nodoc
abstract mixin class _$SubmitContactMessageRequestCopyWith<$Res> implements $SubmitContactMessageRequestCopyWith<$Res> {
  factory _$SubmitContactMessageRequestCopyWith(_SubmitContactMessageRequest value, $Res Function(_SubmitContactMessageRequest) _then) = __$SubmitContactMessageRequestCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String email, String? subject, String message, String? source
});




}
/// @nodoc
class __$SubmitContactMessageRequestCopyWithImpl<$Res>
    implements _$SubmitContactMessageRequestCopyWith<$Res> {
  __$SubmitContactMessageRequestCopyWithImpl(this._self, this._then);

  final _SubmitContactMessageRequest _self;
  final $Res Function(_SubmitContactMessageRequest) _then;

/// Create a copy of SubmitContactMessageRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? email = null,Object? subject = freezed,Object? message = null,Object? source = freezed,}) {
  return _then(_SubmitContactMessageRequest(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,subject: freezed == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ContactMessageResponse {

 int get id;
/// Create a copy of ContactMessageResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactMessageResponseCopyWith<ContactMessageResponse> get copyWith => _$ContactMessageResponseCopyWithImpl<ContactMessageResponse>(this as ContactMessageResponse, _$identity);

  /// Serializes this ContactMessageResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactMessageResponse&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ContactMessageResponse(id: $id)';
}


}

/// @nodoc
abstract mixin class $ContactMessageResponseCopyWith<$Res>  {
  factory $ContactMessageResponseCopyWith(ContactMessageResponse value, $Res Function(ContactMessageResponse) _then) = _$ContactMessageResponseCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$ContactMessageResponseCopyWithImpl<$Res>
    implements $ContactMessageResponseCopyWith<$Res> {
  _$ContactMessageResponseCopyWithImpl(this._self, this._then);

  final ContactMessageResponse _self;
  final $Res Function(ContactMessageResponse) _then;

/// Create a copy of ContactMessageResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactMessageResponse].
extension ContactMessageResponsePatterns on ContactMessageResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContactMessageResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContactMessageResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContactMessageResponse value)  $default,){
final _that = this;
switch (_that) {
case _ContactMessageResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContactMessageResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ContactMessageResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContactMessageResponse() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id)  $default,) {final _that = this;
switch (_that) {
case _ContactMessageResponse():
return $default(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id)?  $default,) {final _that = this;
switch (_that) {
case _ContactMessageResponse() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContactMessageResponse implements ContactMessageResponse {
  const _ContactMessageResponse({required this.id});
  factory _ContactMessageResponse.fromJson(Map<String, dynamic> json) => _$ContactMessageResponseFromJson(json);

@override final  int id;

/// Create a copy of ContactMessageResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContactMessageResponseCopyWith<_ContactMessageResponse> get copyWith => __$ContactMessageResponseCopyWithImpl<_ContactMessageResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContactMessageResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContactMessageResponse&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'ContactMessageResponse(id: $id)';
}


}

/// @nodoc
abstract mixin class _$ContactMessageResponseCopyWith<$Res> implements $ContactMessageResponseCopyWith<$Res> {
  factory _$ContactMessageResponseCopyWith(_ContactMessageResponse value, $Res Function(_ContactMessageResponse) _then) = __$ContactMessageResponseCopyWithImpl;
@override @useResult
$Res call({
 int id
});




}
/// @nodoc
class __$ContactMessageResponseCopyWithImpl<$Res>
    implements _$ContactMessageResponseCopyWith<$Res> {
  __$ContactMessageResponseCopyWithImpl(this._self, this._then);

  final _ContactMessageResponse _self;
  final $Res Function(_ContactMessageResponse) _then;

/// Create a copy of ContactMessageResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_ContactMessageResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
