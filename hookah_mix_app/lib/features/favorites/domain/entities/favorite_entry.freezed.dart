// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoriteEntry {

 String get id; FavoriteType get type; String get refId; String get displayName; DateTime get addedAt;
/// Create a copy of FavoriteEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteEntryCopyWith<FavoriteEntry> get copyWith => _$FavoriteEntryCopyWithImpl<FavoriteEntry>(this as FavoriteEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.refId, refId) || other.refId == refId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,refId,displayName,addedAt);

@override
String toString() {
  return 'FavoriteEntry(id: $id, type: $type, refId: $refId, displayName: $displayName, addedAt: $addedAt)';
}


}

/// @nodoc
abstract mixin class $FavoriteEntryCopyWith<$Res>  {
  factory $FavoriteEntryCopyWith(FavoriteEntry value, $Res Function(FavoriteEntry) _then) = _$FavoriteEntryCopyWithImpl;
@useResult
$Res call({
 String id, FavoriteType type, String refId, String displayName, DateTime addedAt
});




}
/// @nodoc
class _$FavoriteEntryCopyWithImpl<$Res>
    implements $FavoriteEntryCopyWith<$Res> {
  _$FavoriteEntryCopyWithImpl(this._self, this._then);

  final FavoriteEntry _self;
  final $Res Function(FavoriteEntry) _then;

/// Create a copy of FavoriteEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? refId = null,Object? displayName = null,Object? addedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FavoriteType,refId: null == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FavoriteEntry].
extension FavoriteEntryPatterns on FavoriteEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FavoriteEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FavoriteEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FavoriteEntry value)  $default,){
final _that = this;
switch (_that) {
case _FavoriteEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FavoriteEntry value)?  $default,){
final _that = this;
switch (_that) {
case _FavoriteEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  FavoriteType type,  String refId,  String displayName,  DateTime addedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FavoriteEntry() when $default != null:
return $default(_that.id,_that.type,_that.refId,_that.displayName,_that.addedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  FavoriteType type,  String refId,  String displayName,  DateTime addedAt)  $default,) {final _that = this;
switch (_that) {
case _FavoriteEntry():
return $default(_that.id,_that.type,_that.refId,_that.displayName,_that.addedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  FavoriteType type,  String refId,  String displayName,  DateTime addedAt)?  $default,) {final _that = this;
switch (_that) {
case _FavoriteEntry() when $default != null:
return $default(_that.id,_that.type,_that.refId,_that.displayName,_that.addedAt);case _:
  return null;

}
}

}

/// @nodoc


class _FavoriteEntry implements FavoriteEntry {
  const _FavoriteEntry({required this.id, required this.type, required this.refId, required this.displayName, required this.addedAt});
  

@override final  String id;
@override final  FavoriteType type;
@override final  String refId;
@override final  String displayName;
@override final  DateTime addedAt;

/// Create a copy of FavoriteEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FavoriteEntryCopyWith<_FavoriteEntry> get copyWith => __$FavoriteEntryCopyWithImpl<_FavoriteEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FavoriteEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.refId, refId) || other.refId == refId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,refId,displayName,addedAt);

@override
String toString() {
  return 'FavoriteEntry(id: $id, type: $type, refId: $refId, displayName: $displayName, addedAt: $addedAt)';
}


}

/// @nodoc
abstract mixin class _$FavoriteEntryCopyWith<$Res> implements $FavoriteEntryCopyWith<$Res> {
  factory _$FavoriteEntryCopyWith(_FavoriteEntry value, $Res Function(_FavoriteEntry) _then) = __$FavoriteEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, FavoriteType type, String refId, String displayName, DateTime addedAt
});




}
/// @nodoc
class __$FavoriteEntryCopyWithImpl<$Res>
    implements _$FavoriteEntryCopyWith<$Res> {
  __$FavoriteEntryCopyWithImpl(this._self, this._then);

  final _FavoriteEntry _self;
  final $Res Function(_FavoriteEntry) _then;

/// Create a copy of FavoriteEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? refId = null,Object? displayName = null,Object? addedAt = null,}) {
  return _then(_FavoriteEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FavoriteType,refId: null == refId ? _self.refId : refId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,addedAt: null == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
