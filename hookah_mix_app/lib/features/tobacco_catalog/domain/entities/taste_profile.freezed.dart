// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'taste_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TasteProfile {

 int get sweet; int get sour; int get fresh; int get spicy; int get bitter; int get floral;
/// Create a copy of TasteProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TasteProfileCopyWith<TasteProfile> get copyWith => _$TasteProfileCopyWithImpl<TasteProfile>(this as TasteProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TasteProfile&&(identical(other.sweet, sweet) || other.sweet == sweet)&&(identical(other.sour, sour) || other.sour == sour)&&(identical(other.fresh, fresh) || other.fresh == fresh)&&(identical(other.spicy, spicy) || other.spicy == spicy)&&(identical(other.bitter, bitter) || other.bitter == bitter)&&(identical(other.floral, floral) || other.floral == floral));
}


@override
int get hashCode => Object.hash(runtimeType,sweet,sour,fresh,spicy,bitter,floral);

@override
String toString() {
  return 'TasteProfile(sweet: $sweet, sour: $sour, fresh: $fresh, spicy: $spicy, bitter: $bitter, floral: $floral)';
}


}

/// @nodoc
abstract mixin class $TasteProfileCopyWith<$Res>  {
  factory $TasteProfileCopyWith(TasteProfile value, $Res Function(TasteProfile) _then) = _$TasteProfileCopyWithImpl;
@useResult
$Res call({
 int sweet, int sour, int fresh, int spicy, int bitter, int floral
});




}
/// @nodoc
class _$TasteProfileCopyWithImpl<$Res>
    implements $TasteProfileCopyWith<$Res> {
  _$TasteProfileCopyWithImpl(this._self, this._then);

  final TasteProfile _self;
  final $Res Function(TasteProfile) _then;

/// Create a copy of TasteProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sweet = null,Object? sour = null,Object? fresh = null,Object? spicy = null,Object? bitter = null,Object? floral = null,}) {
  return _then(_self.copyWith(
sweet: null == sweet ? _self.sweet : sweet // ignore: cast_nullable_to_non_nullable
as int,sour: null == sour ? _self.sour : sour // ignore: cast_nullable_to_non_nullable
as int,fresh: null == fresh ? _self.fresh : fresh // ignore: cast_nullable_to_non_nullable
as int,spicy: null == spicy ? _self.spicy : spicy // ignore: cast_nullable_to_non_nullable
as int,bitter: null == bitter ? _self.bitter : bitter // ignore: cast_nullable_to_non_nullable
as int,floral: null == floral ? _self.floral : floral // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TasteProfile].
extension TasteProfilePatterns on TasteProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TasteProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TasteProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TasteProfile value)  $default,){
final _that = this;
switch (_that) {
case _TasteProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TasteProfile value)?  $default,){
final _that = this;
switch (_that) {
case _TasteProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int sweet,  int sour,  int fresh,  int spicy,  int bitter,  int floral)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TasteProfile() when $default != null:
return $default(_that.sweet,_that.sour,_that.fresh,_that.spicy,_that.bitter,_that.floral);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int sweet,  int sour,  int fresh,  int spicy,  int bitter,  int floral)  $default,) {final _that = this;
switch (_that) {
case _TasteProfile():
return $default(_that.sweet,_that.sour,_that.fresh,_that.spicy,_that.bitter,_that.floral);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int sweet,  int sour,  int fresh,  int spicy,  int bitter,  int floral)?  $default,) {final _that = this;
switch (_that) {
case _TasteProfile() when $default != null:
return $default(_that.sweet,_that.sour,_that.fresh,_that.spicy,_that.bitter,_that.floral);case _:
  return null;

}
}

}

/// @nodoc


class _TasteProfile extends TasteProfile {
  const _TasteProfile({this.sweet = 0, this.sour = 0, this.fresh = 0, this.spicy = 0, this.bitter = 0, this.floral = 0}): super._();
  

@override@JsonKey() final  int sweet;
@override@JsonKey() final  int sour;
@override@JsonKey() final  int fresh;
@override@JsonKey() final  int spicy;
@override@JsonKey() final  int bitter;
@override@JsonKey() final  int floral;

/// Create a copy of TasteProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TasteProfileCopyWith<_TasteProfile> get copyWith => __$TasteProfileCopyWithImpl<_TasteProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TasteProfile&&(identical(other.sweet, sweet) || other.sweet == sweet)&&(identical(other.sour, sour) || other.sour == sour)&&(identical(other.fresh, fresh) || other.fresh == fresh)&&(identical(other.spicy, spicy) || other.spicy == spicy)&&(identical(other.bitter, bitter) || other.bitter == bitter)&&(identical(other.floral, floral) || other.floral == floral));
}


@override
int get hashCode => Object.hash(runtimeType,sweet,sour,fresh,spicy,bitter,floral);

@override
String toString() {
  return 'TasteProfile(sweet: $sweet, sour: $sour, fresh: $fresh, spicy: $spicy, bitter: $bitter, floral: $floral)';
}


}

/// @nodoc
abstract mixin class _$TasteProfileCopyWith<$Res> implements $TasteProfileCopyWith<$Res> {
  factory _$TasteProfileCopyWith(_TasteProfile value, $Res Function(_TasteProfile) _then) = __$TasteProfileCopyWithImpl;
@override @useResult
$Res call({
 int sweet, int sour, int fresh, int spicy, int bitter, int floral
});




}
/// @nodoc
class __$TasteProfileCopyWithImpl<$Res>
    implements _$TasteProfileCopyWith<$Res> {
  __$TasteProfileCopyWithImpl(this._self, this._then);

  final _TasteProfile _self;
  final $Res Function(_TasteProfile) _then;

/// Create a copy of TasteProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sweet = null,Object? sour = null,Object? fresh = null,Object? spicy = null,Object? bitter = null,Object? floral = null,}) {
  return _then(_TasteProfile(
sweet: null == sweet ? _self.sweet : sweet // ignore: cast_nullable_to_non_nullable
as int,sour: null == sour ? _self.sour : sour // ignore: cast_nullable_to_non_nullable
as int,fresh: null == fresh ? _self.fresh : fresh // ignore: cast_nullable_to_non_nullable
as int,spicy: null == spicy ? _self.spicy : spicy // ignore: cast_nullable_to_non_nullable
as int,bitter: null == bitter ? _self.bitter : bitter // ignore: cast_nullable_to_non_nullable
as int,floral: null == floral ? _self.floral : floral // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
