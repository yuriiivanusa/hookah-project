// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mix_component.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MixComponent {

 String get tobaccoId; String get tobaccoName; int get percentage;
/// Create a copy of MixComponent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MixComponentCopyWith<MixComponent> get copyWith => _$MixComponentCopyWithImpl<MixComponent>(this as MixComponent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MixComponent&&(identical(other.tobaccoId, tobaccoId) || other.tobaccoId == tobaccoId)&&(identical(other.tobaccoName, tobaccoName) || other.tobaccoName == tobaccoName)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}


@override
int get hashCode => Object.hash(runtimeType,tobaccoId,tobaccoName,percentage);

@override
String toString() {
  return 'MixComponent(tobaccoId: $tobaccoId, tobaccoName: $tobaccoName, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class $MixComponentCopyWith<$Res>  {
  factory $MixComponentCopyWith(MixComponent value, $Res Function(MixComponent) _then) = _$MixComponentCopyWithImpl;
@useResult
$Res call({
 String tobaccoId, String tobaccoName, int percentage
});




}
/// @nodoc
class _$MixComponentCopyWithImpl<$Res>
    implements $MixComponentCopyWith<$Res> {
  _$MixComponentCopyWithImpl(this._self, this._then);

  final MixComponent _self;
  final $Res Function(MixComponent) _then;

/// Create a copy of MixComponent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tobaccoId = null,Object? tobaccoName = null,Object? percentage = null,}) {
  return _then(_self.copyWith(
tobaccoId: null == tobaccoId ? _self.tobaccoId : tobaccoId // ignore: cast_nullable_to_non_nullable
as String,tobaccoName: null == tobaccoName ? _self.tobaccoName : tobaccoName // ignore: cast_nullable_to_non_nullable
as String,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MixComponent].
extension MixComponentPatterns on MixComponent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MixComponent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MixComponent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MixComponent value)  $default,){
final _that = this;
switch (_that) {
case _MixComponent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MixComponent value)?  $default,){
final _that = this;
switch (_that) {
case _MixComponent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tobaccoId,  String tobaccoName,  int percentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MixComponent() when $default != null:
return $default(_that.tobaccoId,_that.tobaccoName,_that.percentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tobaccoId,  String tobaccoName,  int percentage)  $default,) {final _that = this;
switch (_that) {
case _MixComponent():
return $default(_that.tobaccoId,_that.tobaccoName,_that.percentage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tobaccoId,  String tobaccoName,  int percentage)?  $default,) {final _that = this;
switch (_that) {
case _MixComponent() when $default != null:
return $default(_that.tobaccoId,_that.tobaccoName,_that.percentage);case _:
  return null;

}
}

}

/// @nodoc


class _MixComponent implements MixComponent {
  const _MixComponent({required this.tobaccoId, required this.tobaccoName, required this.percentage});
  

@override final  String tobaccoId;
@override final  String tobaccoName;
@override final  int percentage;

/// Create a copy of MixComponent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MixComponentCopyWith<_MixComponent> get copyWith => __$MixComponentCopyWithImpl<_MixComponent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MixComponent&&(identical(other.tobaccoId, tobaccoId) || other.tobaccoId == tobaccoId)&&(identical(other.tobaccoName, tobaccoName) || other.tobaccoName == tobaccoName)&&(identical(other.percentage, percentage) || other.percentage == percentage));
}


@override
int get hashCode => Object.hash(runtimeType,tobaccoId,tobaccoName,percentage);

@override
String toString() {
  return 'MixComponent(tobaccoId: $tobaccoId, tobaccoName: $tobaccoName, percentage: $percentage)';
}


}

/// @nodoc
abstract mixin class _$MixComponentCopyWith<$Res> implements $MixComponentCopyWith<$Res> {
  factory _$MixComponentCopyWith(_MixComponent value, $Res Function(_MixComponent) _then) = __$MixComponentCopyWithImpl;
@override @useResult
$Res call({
 String tobaccoId, String tobaccoName, int percentage
});




}
/// @nodoc
class __$MixComponentCopyWithImpl<$Res>
    implements _$MixComponentCopyWith<$Res> {
  __$MixComponentCopyWithImpl(this._self, this._then);

  final _MixComponent _self;
  final $Res Function(_MixComponent) _then;

/// Create a copy of MixComponent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tobaccoId = null,Object? tobaccoName = null,Object? percentage = null,}) {
  return _then(_MixComponent(
tobaccoId: null == tobaccoId ? _self.tobaccoId : tobaccoId // ignore: cast_nullable_to_non_nullable
as String,tobaccoName: null == tobaccoName ? _self.tobaccoName : tobaccoName // ignore: cast_nullable_to_non_nullable
as String,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
