// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'curated_mix.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CuratedMix {

 String get id; String get nameEn; String get nameUk; List<MixComponent> get components; TasteProfile get expectedProfile; int get strengthLevel; String get difficulty; String get descriptionEn; String get descriptionUk; String get targetPersona; List<String> get tags; int get popularity;
/// Create a copy of CuratedMix
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CuratedMixCopyWith<CuratedMix> get copyWith => _$CuratedMixCopyWithImpl<CuratedMix>(this as CuratedMix, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CuratedMix&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameUk, nameUk) || other.nameUk == nameUk)&&const DeepCollectionEquality().equals(other.components, components)&&(identical(other.expectedProfile, expectedProfile) || other.expectedProfile == expectedProfile)&&(identical(other.strengthLevel, strengthLevel) || other.strengthLevel == strengthLevel)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionUk, descriptionUk) || other.descriptionUk == descriptionUk)&&(identical(other.targetPersona, targetPersona) || other.targetPersona == targetPersona)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.popularity, popularity) || other.popularity == popularity));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameUk,const DeepCollectionEquality().hash(components),expectedProfile,strengthLevel,difficulty,descriptionEn,descriptionUk,targetPersona,const DeepCollectionEquality().hash(tags),popularity);

@override
String toString() {
  return 'CuratedMix(id: $id, nameEn: $nameEn, nameUk: $nameUk, components: $components, expectedProfile: $expectedProfile, strengthLevel: $strengthLevel, difficulty: $difficulty, descriptionEn: $descriptionEn, descriptionUk: $descriptionUk, targetPersona: $targetPersona, tags: $tags, popularity: $popularity)';
}


}

/// @nodoc
abstract mixin class $CuratedMixCopyWith<$Res>  {
  factory $CuratedMixCopyWith(CuratedMix value, $Res Function(CuratedMix) _then) = _$CuratedMixCopyWithImpl;
@useResult
$Res call({
 String id, String nameEn, String nameUk, List<MixComponent> components, TasteProfile expectedProfile, int strengthLevel, String difficulty, String descriptionEn, String descriptionUk, String targetPersona, List<String> tags, int popularity
});


$TasteProfileCopyWith<$Res> get expectedProfile;

}
/// @nodoc
class _$CuratedMixCopyWithImpl<$Res>
    implements $CuratedMixCopyWith<$Res> {
  _$CuratedMixCopyWithImpl(this._self, this._then);

  final CuratedMix _self;
  final $Res Function(CuratedMix) _then;

/// Create a copy of CuratedMix
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameEn = null,Object? nameUk = null,Object? components = null,Object? expectedProfile = null,Object? strengthLevel = null,Object? difficulty = null,Object? descriptionEn = null,Object? descriptionUk = null,Object? targetPersona = null,Object? tags = null,Object? popularity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameUk: null == nameUk ? _self.nameUk : nameUk // ignore: cast_nullable_to_non_nullable
as String,components: null == components ? _self.components : components // ignore: cast_nullable_to_non_nullable
as List<MixComponent>,expectedProfile: null == expectedProfile ? _self.expectedProfile : expectedProfile // ignore: cast_nullable_to_non_nullable
as TasteProfile,strengthLevel: null == strengthLevel ? _self.strengthLevel : strengthLevel // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionUk: null == descriptionUk ? _self.descriptionUk : descriptionUk // ignore: cast_nullable_to_non_nullable
as String,targetPersona: null == targetPersona ? _self.targetPersona : targetPersona // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,popularity: null == popularity ? _self.popularity : popularity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of CuratedMix
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TasteProfileCopyWith<$Res> get expectedProfile {
  
  return $TasteProfileCopyWith<$Res>(_self.expectedProfile, (value) {
    return _then(_self.copyWith(expectedProfile: value));
  });
}
}


/// Adds pattern-matching-related methods to [CuratedMix].
extension CuratedMixPatterns on CuratedMix {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CuratedMix value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CuratedMix() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CuratedMix value)  $default,){
final _that = this;
switch (_that) {
case _CuratedMix():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CuratedMix value)?  $default,){
final _that = this;
switch (_that) {
case _CuratedMix() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String nameEn,  String nameUk,  List<MixComponent> components,  TasteProfile expectedProfile,  int strengthLevel,  String difficulty,  String descriptionEn,  String descriptionUk,  String targetPersona,  List<String> tags,  int popularity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CuratedMix() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameUk,_that.components,_that.expectedProfile,_that.strengthLevel,_that.difficulty,_that.descriptionEn,_that.descriptionUk,_that.targetPersona,_that.tags,_that.popularity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String nameEn,  String nameUk,  List<MixComponent> components,  TasteProfile expectedProfile,  int strengthLevel,  String difficulty,  String descriptionEn,  String descriptionUk,  String targetPersona,  List<String> tags,  int popularity)  $default,) {final _that = this;
switch (_that) {
case _CuratedMix():
return $default(_that.id,_that.nameEn,_that.nameUk,_that.components,_that.expectedProfile,_that.strengthLevel,_that.difficulty,_that.descriptionEn,_that.descriptionUk,_that.targetPersona,_that.tags,_that.popularity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String nameEn,  String nameUk,  List<MixComponent> components,  TasteProfile expectedProfile,  int strengthLevel,  String difficulty,  String descriptionEn,  String descriptionUk,  String targetPersona,  List<String> tags,  int popularity)?  $default,) {final _that = this;
switch (_that) {
case _CuratedMix() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameUk,_that.components,_that.expectedProfile,_that.strengthLevel,_that.difficulty,_that.descriptionEn,_that.descriptionUk,_that.targetPersona,_that.tags,_that.popularity);case _:
  return null;

}
}

}

/// @nodoc


class _CuratedMix extends CuratedMix {
  const _CuratedMix({required this.id, required this.nameEn, required this.nameUk, required final  List<MixComponent> components, required this.expectedProfile, required this.strengthLevel, required this.difficulty, required this.descriptionEn, required this.descriptionUk, required this.targetPersona, required final  List<String> tags, required this.popularity}): _components = components,_tags = tags,super._();
  

@override final  String id;
@override final  String nameEn;
@override final  String nameUk;
 final  List<MixComponent> _components;
@override List<MixComponent> get components {
  if (_components is EqualUnmodifiableListView) return _components;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_components);
}

@override final  TasteProfile expectedProfile;
@override final  int strengthLevel;
@override final  String difficulty;
@override final  String descriptionEn;
@override final  String descriptionUk;
@override final  String targetPersona;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  int popularity;

/// Create a copy of CuratedMix
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CuratedMixCopyWith<_CuratedMix> get copyWith => __$CuratedMixCopyWithImpl<_CuratedMix>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CuratedMix&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameUk, nameUk) || other.nameUk == nameUk)&&const DeepCollectionEquality().equals(other._components, _components)&&(identical(other.expectedProfile, expectedProfile) || other.expectedProfile == expectedProfile)&&(identical(other.strengthLevel, strengthLevel) || other.strengthLevel == strengthLevel)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionUk, descriptionUk) || other.descriptionUk == descriptionUk)&&(identical(other.targetPersona, targetPersona) || other.targetPersona == targetPersona)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.popularity, popularity) || other.popularity == popularity));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameUk,const DeepCollectionEquality().hash(_components),expectedProfile,strengthLevel,difficulty,descriptionEn,descriptionUk,targetPersona,const DeepCollectionEquality().hash(_tags),popularity);

@override
String toString() {
  return 'CuratedMix(id: $id, nameEn: $nameEn, nameUk: $nameUk, components: $components, expectedProfile: $expectedProfile, strengthLevel: $strengthLevel, difficulty: $difficulty, descriptionEn: $descriptionEn, descriptionUk: $descriptionUk, targetPersona: $targetPersona, tags: $tags, popularity: $popularity)';
}


}

/// @nodoc
abstract mixin class _$CuratedMixCopyWith<$Res> implements $CuratedMixCopyWith<$Res> {
  factory _$CuratedMixCopyWith(_CuratedMix value, $Res Function(_CuratedMix) _then) = __$CuratedMixCopyWithImpl;
@override @useResult
$Res call({
 String id, String nameEn, String nameUk, List<MixComponent> components, TasteProfile expectedProfile, int strengthLevel, String difficulty, String descriptionEn, String descriptionUk, String targetPersona, List<String> tags, int popularity
});


@override $TasteProfileCopyWith<$Res> get expectedProfile;

}
/// @nodoc
class __$CuratedMixCopyWithImpl<$Res>
    implements _$CuratedMixCopyWith<$Res> {
  __$CuratedMixCopyWithImpl(this._self, this._then);

  final _CuratedMix _self;
  final $Res Function(_CuratedMix) _then;

/// Create a copy of CuratedMix
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameEn = null,Object? nameUk = null,Object? components = null,Object? expectedProfile = null,Object? strengthLevel = null,Object? difficulty = null,Object? descriptionEn = null,Object? descriptionUk = null,Object? targetPersona = null,Object? tags = null,Object? popularity = null,}) {
  return _then(_CuratedMix(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameUk: null == nameUk ? _self.nameUk : nameUk // ignore: cast_nullable_to_non_nullable
as String,components: null == components ? _self._components : components // ignore: cast_nullable_to_non_nullable
as List<MixComponent>,expectedProfile: null == expectedProfile ? _self.expectedProfile : expectedProfile // ignore: cast_nullable_to_non_nullable
as TasteProfile,strengthLevel: null == strengthLevel ? _self.strengthLevel : strengthLevel // ignore: cast_nullable_to_non_nullable
as int,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionUk: null == descriptionUk ? _self.descriptionUk : descriptionUk // ignore: cast_nullable_to_non_nullable
as String,targetPersona: null == targetPersona ? _self.targetPersona : targetPersona // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,popularity: null == popularity ? _self.popularity : popularity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of CuratedMix
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TasteProfileCopyWith<$Res> get expectedProfile {
  
  return $TasteProfileCopyWith<$Res>(_self.expectedProfile, (value) {
    return _then(_self.copyWith(expectedProfile: value));
  });
}
}

// dart format on
