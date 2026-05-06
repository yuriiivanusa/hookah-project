// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_mix.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserMix {

 String get id; String get userId; String get name; String get description; List<MixComponent> get components; TasteProfile? get tasteProfile; int get rating; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of UserMix
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserMixCopyWith<UserMix> get copyWith => _$UserMixCopyWithImpl<UserMix>(this as UserMix, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserMix&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.components, components)&&(identical(other.tasteProfile, tasteProfile) || other.tasteProfile == tasteProfile)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,name,description,const DeepCollectionEquality().hash(components),tasteProfile,rating,createdAt,updatedAt);

@override
String toString() {
  return 'UserMix(id: $id, userId: $userId, name: $name, description: $description, components: $components, tasteProfile: $tasteProfile, rating: $rating, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserMixCopyWith<$Res>  {
  factory $UserMixCopyWith(UserMix value, $Res Function(UserMix) _then) = _$UserMixCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String name, String description, List<MixComponent> components, TasteProfile? tasteProfile, int rating, DateTime createdAt, DateTime updatedAt
});


$TasteProfileCopyWith<$Res>? get tasteProfile;

}
/// @nodoc
class _$UserMixCopyWithImpl<$Res>
    implements $UserMixCopyWith<$Res> {
  _$UserMixCopyWithImpl(this._self, this._then);

  final UserMix _self;
  final $Res Function(UserMix) _then;

/// Create a copy of UserMix
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? description = null,Object? components = null,Object? tasteProfile = freezed,Object? rating = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,components: null == components ? _self.components : components // ignore: cast_nullable_to_non_nullable
as List<MixComponent>,tasteProfile: freezed == tasteProfile ? _self.tasteProfile : tasteProfile // ignore: cast_nullable_to_non_nullable
as TasteProfile?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of UserMix
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TasteProfileCopyWith<$Res>? get tasteProfile {
    if (_self.tasteProfile == null) {
    return null;
  }

  return $TasteProfileCopyWith<$Res>(_self.tasteProfile!, (value) {
    return _then(_self.copyWith(tasteProfile: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserMix].
extension UserMixPatterns on UserMix {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserMix value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserMix() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserMix value)  $default,){
final _that = this;
switch (_that) {
case _UserMix():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserMix value)?  $default,){
final _that = this;
switch (_that) {
case _UserMix() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  String description,  List<MixComponent> components,  TasteProfile? tasteProfile,  int rating,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserMix() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.description,_that.components,_that.tasteProfile,_that.rating,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String name,  String description,  List<MixComponent> components,  TasteProfile? tasteProfile,  int rating,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserMix():
return $default(_that.id,_that.userId,_that.name,_that.description,_that.components,_that.tasteProfile,_that.rating,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String name,  String description,  List<MixComponent> components,  TasteProfile? tasteProfile,  int rating,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserMix() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.description,_that.components,_that.tasteProfile,_that.rating,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _UserMix extends UserMix {
  const _UserMix({required this.id, required this.userId, required this.name, this.description = '', required final  List<MixComponent> components, this.tasteProfile, this.rating = 0, required this.createdAt, required this.updatedAt}): _components = components,super._();
  

@override final  String id;
@override final  String userId;
@override final  String name;
@override@JsonKey() final  String description;
 final  List<MixComponent> _components;
@override List<MixComponent> get components {
  if (_components is EqualUnmodifiableListView) return _components;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_components);
}

@override final  TasteProfile? tasteProfile;
@override@JsonKey() final  int rating;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of UserMix
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserMixCopyWith<_UserMix> get copyWith => __$UserMixCopyWithImpl<_UserMix>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserMix&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._components, _components)&&(identical(other.tasteProfile, tasteProfile) || other.tasteProfile == tasteProfile)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,name,description,const DeepCollectionEquality().hash(_components),tasteProfile,rating,createdAt,updatedAt);

@override
String toString() {
  return 'UserMix(id: $id, userId: $userId, name: $name, description: $description, components: $components, tasteProfile: $tasteProfile, rating: $rating, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserMixCopyWith<$Res> implements $UserMixCopyWith<$Res> {
  factory _$UserMixCopyWith(_UserMix value, $Res Function(_UserMix) _then) = __$UserMixCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String name, String description, List<MixComponent> components, TasteProfile? tasteProfile, int rating, DateTime createdAt, DateTime updatedAt
});


@override $TasteProfileCopyWith<$Res>? get tasteProfile;

}
/// @nodoc
class __$UserMixCopyWithImpl<$Res>
    implements _$UserMixCopyWith<$Res> {
  __$UserMixCopyWithImpl(this._self, this._then);

  final _UserMix _self;
  final $Res Function(_UserMix) _then;

/// Create a copy of UserMix
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? name = null,Object? description = null,Object? components = null,Object? tasteProfile = freezed,Object? rating = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_UserMix(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,components: null == components ? _self._components : components // ignore: cast_nullable_to_non_nullable
as List<MixComponent>,tasteProfile: freezed == tasteProfile ? _self.tasteProfile : tasteProfile // ignore: cast_nullable_to_non_nullable
as TasteProfile?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of UserMix
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TasteProfileCopyWith<$Res>? get tasteProfile {
    if (_self.tasteProfile == null) {
    return null;
  }

  return $TasteProfileCopyWith<$Res>(_self.tasteProfile!, (value) {
    return _then(_self.copyWith(tasteProfile: value));
  });
}
}

// dart format on
