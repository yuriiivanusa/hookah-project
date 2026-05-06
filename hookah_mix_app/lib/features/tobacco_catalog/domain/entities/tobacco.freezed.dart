// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tobacco.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Tobacco {

 String get id; String get brandId; String get brandName; String get brandCountry; String get nameEn; String get nameUk; String get leafType; int get strength; List<String> get flavorCategories; List<String> get tasteNotes; TasteProfile get tasteProfile; String get descriptionEn; String get descriptionUk; String? get imageUrl; int get popularity;
/// Create a copy of Tobacco
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TobaccoCopyWith<Tobacco> get copyWith => _$TobaccoCopyWithImpl<Tobacco>(this as Tobacco, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Tobacco&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandCountry, brandCountry) || other.brandCountry == brandCountry)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameUk, nameUk) || other.nameUk == nameUk)&&(identical(other.leafType, leafType) || other.leafType == leafType)&&(identical(other.strength, strength) || other.strength == strength)&&const DeepCollectionEquality().equals(other.flavorCategories, flavorCategories)&&const DeepCollectionEquality().equals(other.tasteNotes, tasteNotes)&&(identical(other.tasteProfile, tasteProfile) || other.tasteProfile == tasteProfile)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionUk, descriptionUk) || other.descriptionUk == descriptionUk)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.popularity, popularity) || other.popularity == popularity));
}


@override
int get hashCode => Object.hash(runtimeType,id,brandId,brandName,brandCountry,nameEn,nameUk,leafType,strength,const DeepCollectionEquality().hash(flavorCategories),const DeepCollectionEquality().hash(tasteNotes),tasteProfile,descriptionEn,descriptionUk,imageUrl,popularity);

@override
String toString() {
  return 'Tobacco(id: $id, brandId: $brandId, brandName: $brandName, brandCountry: $brandCountry, nameEn: $nameEn, nameUk: $nameUk, leafType: $leafType, strength: $strength, flavorCategories: $flavorCategories, tasteNotes: $tasteNotes, tasteProfile: $tasteProfile, descriptionEn: $descriptionEn, descriptionUk: $descriptionUk, imageUrl: $imageUrl, popularity: $popularity)';
}


}

/// @nodoc
abstract mixin class $TobaccoCopyWith<$Res>  {
  factory $TobaccoCopyWith(Tobacco value, $Res Function(Tobacco) _then) = _$TobaccoCopyWithImpl;
@useResult
$Res call({
 String id, String brandId, String brandName, String brandCountry, String nameEn, String nameUk, String leafType, int strength, List<String> flavorCategories, List<String> tasteNotes, TasteProfile tasteProfile, String descriptionEn, String descriptionUk, String? imageUrl, int popularity
});


$TasteProfileCopyWith<$Res> get tasteProfile;

}
/// @nodoc
class _$TobaccoCopyWithImpl<$Res>
    implements $TobaccoCopyWith<$Res> {
  _$TobaccoCopyWithImpl(this._self, this._then);

  final Tobacco _self;
  final $Res Function(Tobacco) _then;

/// Create a copy of Tobacco
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? brandId = null,Object? brandName = null,Object? brandCountry = null,Object? nameEn = null,Object? nameUk = null,Object? leafType = null,Object? strength = null,Object? flavorCategories = null,Object? tasteNotes = null,Object? tasteProfile = null,Object? descriptionEn = null,Object? descriptionUk = null,Object? imageUrl = freezed,Object? popularity = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,brandCountry: null == brandCountry ? _self.brandCountry : brandCountry // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameUk: null == nameUk ? _self.nameUk : nameUk // ignore: cast_nullable_to_non_nullable
as String,leafType: null == leafType ? _self.leafType : leafType // ignore: cast_nullable_to_non_nullable
as String,strength: null == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as int,flavorCategories: null == flavorCategories ? _self.flavorCategories : flavorCategories // ignore: cast_nullable_to_non_nullable
as List<String>,tasteNotes: null == tasteNotes ? _self.tasteNotes : tasteNotes // ignore: cast_nullable_to_non_nullable
as List<String>,tasteProfile: null == tasteProfile ? _self.tasteProfile : tasteProfile // ignore: cast_nullable_to_non_nullable
as TasteProfile,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionUk: null == descriptionUk ? _self.descriptionUk : descriptionUk // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,popularity: null == popularity ? _self.popularity : popularity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of Tobacco
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TasteProfileCopyWith<$Res> get tasteProfile {
  
  return $TasteProfileCopyWith<$Res>(_self.tasteProfile, (value) {
    return _then(_self.copyWith(tasteProfile: value));
  });
}
}


/// Adds pattern-matching-related methods to [Tobacco].
extension TobaccoPatterns on Tobacco {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Tobacco value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Tobacco() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Tobacco value)  $default,){
final _that = this;
switch (_that) {
case _Tobacco():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Tobacco value)?  $default,){
final _that = this;
switch (_that) {
case _Tobacco() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String brandId,  String brandName,  String brandCountry,  String nameEn,  String nameUk,  String leafType,  int strength,  List<String> flavorCategories,  List<String> tasteNotes,  TasteProfile tasteProfile,  String descriptionEn,  String descriptionUk,  String? imageUrl,  int popularity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Tobacco() when $default != null:
return $default(_that.id,_that.brandId,_that.brandName,_that.brandCountry,_that.nameEn,_that.nameUk,_that.leafType,_that.strength,_that.flavorCategories,_that.tasteNotes,_that.tasteProfile,_that.descriptionEn,_that.descriptionUk,_that.imageUrl,_that.popularity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String brandId,  String brandName,  String brandCountry,  String nameEn,  String nameUk,  String leafType,  int strength,  List<String> flavorCategories,  List<String> tasteNotes,  TasteProfile tasteProfile,  String descriptionEn,  String descriptionUk,  String? imageUrl,  int popularity)  $default,) {final _that = this;
switch (_that) {
case _Tobacco():
return $default(_that.id,_that.brandId,_that.brandName,_that.brandCountry,_that.nameEn,_that.nameUk,_that.leafType,_that.strength,_that.flavorCategories,_that.tasteNotes,_that.tasteProfile,_that.descriptionEn,_that.descriptionUk,_that.imageUrl,_that.popularity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String brandId,  String brandName,  String brandCountry,  String nameEn,  String nameUk,  String leafType,  int strength,  List<String> flavorCategories,  List<String> tasteNotes,  TasteProfile tasteProfile,  String descriptionEn,  String descriptionUk,  String? imageUrl,  int popularity)?  $default,) {final _that = this;
switch (_that) {
case _Tobacco() when $default != null:
return $default(_that.id,_that.brandId,_that.brandName,_that.brandCountry,_that.nameEn,_that.nameUk,_that.leafType,_that.strength,_that.flavorCategories,_that.tasteNotes,_that.tasteProfile,_that.descriptionEn,_that.descriptionUk,_that.imageUrl,_that.popularity);case _:
  return null;

}
}

}

/// @nodoc


class _Tobacco extends Tobacco {
  const _Tobacco({required this.id, required this.brandId, required this.brandName, required this.brandCountry, required this.nameEn, required this.nameUk, required this.leafType, required this.strength, required final  List<String> flavorCategories, required final  List<String> tasteNotes, required this.tasteProfile, required this.descriptionEn, required this.descriptionUk, this.imageUrl, required this.popularity}): _flavorCategories = flavorCategories,_tasteNotes = tasteNotes,super._();
  

@override final  String id;
@override final  String brandId;
@override final  String brandName;
@override final  String brandCountry;
@override final  String nameEn;
@override final  String nameUk;
@override final  String leafType;
@override final  int strength;
 final  List<String> _flavorCategories;
@override List<String> get flavorCategories {
  if (_flavorCategories is EqualUnmodifiableListView) return _flavorCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flavorCategories);
}

 final  List<String> _tasteNotes;
@override List<String> get tasteNotes {
  if (_tasteNotes is EqualUnmodifiableListView) return _tasteNotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tasteNotes);
}

@override final  TasteProfile tasteProfile;
@override final  String descriptionEn;
@override final  String descriptionUk;
@override final  String? imageUrl;
@override final  int popularity;

/// Create a copy of Tobacco
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TobaccoCopyWith<_Tobacco> get copyWith => __$TobaccoCopyWithImpl<_Tobacco>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tobacco&&(identical(other.id, id) || other.id == id)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brandName, brandName) || other.brandName == brandName)&&(identical(other.brandCountry, brandCountry) || other.brandCountry == brandCountry)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameUk, nameUk) || other.nameUk == nameUk)&&(identical(other.leafType, leafType) || other.leafType == leafType)&&(identical(other.strength, strength) || other.strength == strength)&&const DeepCollectionEquality().equals(other._flavorCategories, _flavorCategories)&&const DeepCollectionEquality().equals(other._tasteNotes, _tasteNotes)&&(identical(other.tasteProfile, tasteProfile) || other.tasteProfile == tasteProfile)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.descriptionUk, descriptionUk) || other.descriptionUk == descriptionUk)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.popularity, popularity) || other.popularity == popularity));
}


@override
int get hashCode => Object.hash(runtimeType,id,brandId,brandName,brandCountry,nameEn,nameUk,leafType,strength,const DeepCollectionEquality().hash(_flavorCategories),const DeepCollectionEquality().hash(_tasteNotes),tasteProfile,descriptionEn,descriptionUk,imageUrl,popularity);

@override
String toString() {
  return 'Tobacco(id: $id, brandId: $brandId, brandName: $brandName, brandCountry: $brandCountry, nameEn: $nameEn, nameUk: $nameUk, leafType: $leafType, strength: $strength, flavorCategories: $flavorCategories, tasteNotes: $tasteNotes, tasteProfile: $tasteProfile, descriptionEn: $descriptionEn, descriptionUk: $descriptionUk, imageUrl: $imageUrl, popularity: $popularity)';
}


}

/// @nodoc
abstract mixin class _$TobaccoCopyWith<$Res> implements $TobaccoCopyWith<$Res> {
  factory _$TobaccoCopyWith(_Tobacco value, $Res Function(_Tobacco) _then) = __$TobaccoCopyWithImpl;
@override @useResult
$Res call({
 String id, String brandId, String brandName, String brandCountry, String nameEn, String nameUk, String leafType, int strength, List<String> flavorCategories, List<String> tasteNotes, TasteProfile tasteProfile, String descriptionEn, String descriptionUk, String? imageUrl, int popularity
});


@override $TasteProfileCopyWith<$Res> get tasteProfile;

}
/// @nodoc
class __$TobaccoCopyWithImpl<$Res>
    implements _$TobaccoCopyWith<$Res> {
  __$TobaccoCopyWithImpl(this._self, this._then);

  final _Tobacco _self;
  final $Res Function(_Tobacco) _then;

/// Create a copy of Tobacco
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brandId = null,Object? brandName = null,Object? brandCountry = null,Object? nameEn = null,Object? nameUk = null,Object? leafType = null,Object? strength = null,Object? flavorCategories = null,Object? tasteNotes = null,Object? tasteProfile = null,Object? descriptionEn = null,Object? descriptionUk = null,Object? imageUrl = freezed,Object? popularity = null,}) {
  return _then(_Tobacco(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brandId: null == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String,brandName: null == brandName ? _self.brandName : brandName // ignore: cast_nullable_to_non_nullable
as String,brandCountry: null == brandCountry ? _self.brandCountry : brandCountry // ignore: cast_nullable_to_non_nullable
as String,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameUk: null == nameUk ? _self.nameUk : nameUk // ignore: cast_nullable_to_non_nullable
as String,leafType: null == leafType ? _self.leafType : leafType // ignore: cast_nullable_to_non_nullable
as String,strength: null == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as int,flavorCategories: null == flavorCategories ? _self._flavorCategories : flavorCategories // ignore: cast_nullable_to_non_nullable
as List<String>,tasteNotes: null == tasteNotes ? _self._tasteNotes : tasteNotes // ignore: cast_nullable_to_non_nullable
as List<String>,tasteProfile: null == tasteProfile ? _self.tasteProfile : tasteProfile // ignore: cast_nullable_to_non_nullable
as TasteProfile,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,descriptionUk: null == descriptionUk ? _self.descriptionUk : descriptionUk // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,popularity: null == popularity ? _self.popularity : popularity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of Tobacco
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TasteProfileCopyWith<$Res> get tasteProfile {
  
  return $TasteProfileCopyWith<$Res>(_self.tasteProfile, (value) {
    return _then(_self.copyWith(tasteProfile: value));
  });
}
}

// dart format on
