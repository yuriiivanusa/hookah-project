// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tobacco_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TobaccoFilter {

 String get query; String? get brandId; String? get leafType; String? get flavorCategory; int get minStrength; int get maxStrength; TobaccoSortOrder get sortOrder;
/// Create a copy of TobaccoFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TobaccoFilterCopyWith<TobaccoFilter> get copyWith => _$TobaccoFilterCopyWithImpl<TobaccoFilter>(this as TobaccoFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TobaccoFilter&&(identical(other.query, query) || other.query == query)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.leafType, leafType) || other.leafType == leafType)&&(identical(other.flavorCategory, flavorCategory) || other.flavorCategory == flavorCategory)&&(identical(other.minStrength, minStrength) || other.minStrength == minStrength)&&(identical(other.maxStrength, maxStrength) || other.maxStrength == maxStrength)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,query,brandId,leafType,flavorCategory,minStrength,maxStrength,sortOrder);

@override
String toString() {
  return 'TobaccoFilter(query: $query, brandId: $brandId, leafType: $leafType, flavorCategory: $flavorCategory, minStrength: $minStrength, maxStrength: $maxStrength, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $TobaccoFilterCopyWith<$Res>  {
  factory $TobaccoFilterCopyWith(TobaccoFilter value, $Res Function(TobaccoFilter) _then) = _$TobaccoFilterCopyWithImpl;
@useResult
$Res call({
 String query, String? brandId, String? leafType, String? flavorCategory, int minStrength, int maxStrength, TobaccoSortOrder sortOrder
});




}
/// @nodoc
class _$TobaccoFilterCopyWithImpl<$Res>
    implements $TobaccoFilterCopyWith<$Res> {
  _$TobaccoFilterCopyWithImpl(this._self, this._then);

  final TobaccoFilter _self;
  final $Res Function(TobaccoFilter) _then;

/// Create a copy of TobaccoFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? brandId = freezed,Object? leafType = freezed,Object? flavorCategory = freezed,Object? minStrength = null,Object? maxStrength = null,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String?,leafType: freezed == leafType ? _self.leafType : leafType // ignore: cast_nullable_to_non_nullable
as String?,flavorCategory: freezed == flavorCategory ? _self.flavorCategory : flavorCategory // ignore: cast_nullable_to_non_nullable
as String?,minStrength: null == minStrength ? _self.minStrength : minStrength // ignore: cast_nullable_to_non_nullable
as int,maxStrength: null == maxStrength ? _self.maxStrength : maxStrength // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as TobaccoSortOrder,
  ));
}

}


/// Adds pattern-matching-related methods to [TobaccoFilter].
extension TobaccoFilterPatterns on TobaccoFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TobaccoFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TobaccoFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TobaccoFilter value)  $default,){
final _that = this;
switch (_that) {
case _TobaccoFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TobaccoFilter value)?  $default,){
final _that = this;
switch (_that) {
case _TobaccoFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  String? brandId,  String? leafType,  String? flavorCategory,  int minStrength,  int maxStrength,  TobaccoSortOrder sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TobaccoFilter() when $default != null:
return $default(_that.query,_that.brandId,_that.leafType,_that.flavorCategory,_that.minStrength,_that.maxStrength,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  String? brandId,  String? leafType,  String? flavorCategory,  int minStrength,  int maxStrength,  TobaccoSortOrder sortOrder)  $default,) {final _that = this;
switch (_that) {
case _TobaccoFilter():
return $default(_that.query,_that.brandId,_that.leafType,_that.flavorCategory,_that.minStrength,_that.maxStrength,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  String? brandId,  String? leafType,  String? flavorCategory,  int minStrength,  int maxStrength,  TobaccoSortOrder sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _TobaccoFilter() when $default != null:
return $default(_that.query,_that.brandId,_that.leafType,_that.flavorCategory,_that.minStrength,_that.maxStrength,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _TobaccoFilter extends TobaccoFilter {
  const _TobaccoFilter({this.query = '', this.brandId, this.leafType, this.flavorCategory, this.minStrength = 1, this.maxStrength = 5, this.sortOrder = TobaccoSortOrder.popularityDesc}): super._();
  

@override@JsonKey() final  String query;
@override final  String? brandId;
@override final  String? leafType;
@override final  String? flavorCategory;
@override@JsonKey() final  int minStrength;
@override@JsonKey() final  int maxStrength;
@override@JsonKey() final  TobaccoSortOrder sortOrder;

/// Create a copy of TobaccoFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TobaccoFilterCopyWith<_TobaccoFilter> get copyWith => __$TobaccoFilterCopyWithImpl<_TobaccoFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TobaccoFilter&&(identical(other.query, query) || other.query == query)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.leafType, leafType) || other.leafType == leafType)&&(identical(other.flavorCategory, flavorCategory) || other.flavorCategory == flavorCategory)&&(identical(other.minStrength, minStrength) || other.minStrength == minStrength)&&(identical(other.maxStrength, maxStrength) || other.maxStrength == maxStrength)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,query,brandId,leafType,flavorCategory,minStrength,maxStrength,sortOrder);

@override
String toString() {
  return 'TobaccoFilter(query: $query, brandId: $brandId, leafType: $leafType, flavorCategory: $flavorCategory, minStrength: $minStrength, maxStrength: $maxStrength, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$TobaccoFilterCopyWith<$Res> implements $TobaccoFilterCopyWith<$Res> {
  factory _$TobaccoFilterCopyWith(_TobaccoFilter value, $Res Function(_TobaccoFilter) _then) = __$TobaccoFilterCopyWithImpl;
@override @useResult
$Res call({
 String query, String? brandId, String? leafType, String? flavorCategory, int minStrength, int maxStrength, TobaccoSortOrder sortOrder
});




}
/// @nodoc
class __$TobaccoFilterCopyWithImpl<$Res>
    implements _$TobaccoFilterCopyWith<$Res> {
  __$TobaccoFilterCopyWithImpl(this._self, this._then);

  final _TobaccoFilter _self;
  final $Res Function(_TobaccoFilter) _then;

/// Create a copy of TobaccoFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? brandId = freezed,Object? leafType = freezed,Object? flavorCategory = freezed,Object? minStrength = null,Object? maxStrength = null,Object? sortOrder = null,}) {
  return _then(_TobaccoFilter(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as String?,leafType: freezed == leafType ? _self.leafType : leafType // ignore: cast_nullable_to_non_nullable
as String?,flavorCategory: freezed == flavorCategory ? _self.flavorCategory : flavorCategory // ignore: cast_nullable_to_non_nullable
as String?,minStrength: null == minStrength ? _self.minStrength : minStrength // ignore: cast_nullable_to_non_nullable
as int,maxStrength: null == maxStrength ? _self.maxStrength : maxStrength // ignore: cast_nullable_to_non_nullable
as int,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as TobaccoSortOrder,
  ));
}


}

// dart format on
