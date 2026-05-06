// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wizard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WizardState {

 int get step; Set<String> get selectedFlavors; int get strengthPreference; String get persona; bool get submitted;
/// Create a copy of WizardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WizardStateCopyWith<WizardState> get copyWith => _$WizardStateCopyWithImpl<WizardState>(this as WizardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WizardState&&(identical(other.step, step) || other.step == step)&&const DeepCollectionEquality().equals(other.selectedFlavors, selectedFlavors)&&(identical(other.strengthPreference, strengthPreference) || other.strengthPreference == strengthPreference)&&(identical(other.persona, persona) || other.persona == persona)&&(identical(other.submitted, submitted) || other.submitted == submitted));
}


@override
int get hashCode => Object.hash(runtimeType,step,const DeepCollectionEquality().hash(selectedFlavors),strengthPreference,persona,submitted);

@override
String toString() {
  return 'WizardState(step: $step, selectedFlavors: $selectedFlavors, strengthPreference: $strengthPreference, persona: $persona, submitted: $submitted)';
}


}

/// @nodoc
abstract mixin class $WizardStateCopyWith<$Res>  {
  factory $WizardStateCopyWith(WizardState value, $Res Function(WizardState) _then) = _$WizardStateCopyWithImpl;
@useResult
$Res call({
 int step, Set<String> selectedFlavors, int strengthPreference, String persona, bool submitted
});




}
/// @nodoc
class _$WizardStateCopyWithImpl<$Res>
    implements $WizardStateCopyWith<$Res> {
  _$WizardStateCopyWithImpl(this._self, this._then);

  final WizardState _self;
  final $Res Function(WizardState) _then;

/// Create a copy of WizardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? selectedFlavors = null,Object? strengthPreference = null,Object? persona = null,Object? submitted = null,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,selectedFlavors: null == selectedFlavors ? _self.selectedFlavors : selectedFlavors // ignore: cast_nullable_to_non_nullable
as Set<String>,strengthPreference: null == strengthPreference ? _self.strengthPreference : strengthPreference // ignore: cast_nullable_to_non_nullable
as int,persona: null == persona ? _self.persona : persona // ignore: cast_nullable_to_non_nullable
as String,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [WizardState].
extension WizardStatePatterns on WizardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WizardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WizardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WizardState value)  $default,){
final _that = this;
switch (_that) {
case _WizardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WizardState value)?  $default,){
final _that = this;
switch (_that) {
case _WizardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int step,  Set<String> selectedFlavors,  int strengthPreference,  String persona,  bool submitted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WizardState() when $default != null:
return $default(_that.step,_that.selectedFlavors,_that.strengthPreference,_that.persona,_that.submitted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int step,  Set<String> selectedFlavors,  int strengthPreference,  String persona,  bool submitted)  $default,) {final _that = this;
switch (_that) {
case _WizardState():
return $default(_that.step,_that.selectedFlavors,_that.strengthPreference,_that.persona,_that.submitted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int step,  Set<String> selectedFlavors,  int strengthPreference,  String persona,  bool submitted)?  $default,) {final _that = this;
switch (_that) {
case _WizardState() when $default != null:
return $default(_that.step,_that.selectedFlavors,_that.strengthPreference,_that.persona,_that.submitted);case _:
  return null;

}
}

}

/// @nodoc


class _WizardState extends WizardState {
  const _WizardState({this.step = 0, final  Set<String> selectedFlavors = const {}, this.strengthPreference = 3, this.persona = '', this.submitted = false}): _selectedFlavors = selectedFlavors,super._();
  

@override@JsonKey() final  int step;
 final  Set<String> _selectedFlavors;
@override@JsonKey() Set<String> get selectedFlavors {
  if (_selectedFlavors is EqualUnmodifiableSetView) return _selectedFlavors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedFlavors);
}

@override@JsonKey() final  int strengthPreference;
@override@JsonKey() final  String persona;
@override@JsonKey() final  bool submitted;

/// Create a copy of WizardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WizardStateCopyWith<_WizardState> get copyWith => __$WizardStateCopyWithImpl<_WizardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WizardState&&(identical(other.step, step) || other.step == step)&&const DeepCollectionEquality().equals(other._selectedFlavors, _selectedFlavors)&&(identical(other.strengthPreference, strengthPreference) || other.strengthPreference == strengthPreference)&&(identical(other.persona, persona) || other.persona == persona)&&(identical(other.submitted, submitted) || other.submitted == submitted));
}


@override
int get hashCode => Object.hash(runtimeType,step,const DeepCollectionEquality().hash(_selectedFlavors),strengthPreference,persona,submitted);

@override
String toString() {
  return 'WizardState(step: $step, selectedFlavors: $selectedFlavors, strengthPreference: $strengthPreference, persona: $persona, submitted: $submitted)';
}


}

/// @nodoc
abstract mixin class _$WizardStateCopyWith<$Res> implements $WizardStateCopyWith<$Res> {
  factory _$WizardStateCopyWith(_WizardState value, $Res Function(_WizardState) _then) = __$WizardStateCopyWithImpl;
@override @useResult
$Res call({
 int step, Set<String> selectedFlavors, int strengthPreference, String persona, bool submitted
});




}
/// @nodoc
class __$WizardStateCopyWithImpl<$Res>
    implements _$WizardStateCopyWith<$Res> {
  __$WizardStateCopyWithImpl(this._self, this._then);

  final _WizardState _self;
  final $Res Function(_WizardState) _then;

/// Create a copy of WizardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? selectedFlavors = null,Object? strengthPreference = null,Object? persona = null,Object? submitted = null,}) {
  return _then(_WizardState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,selectedFlavors: null == selectedFlavors ? _self._selectedFlavors : selectedFlavors // ignore: cast_nullable_to_non_nullable
as Set<String>,strengthPreference: null == strengthPreference ? _self.strengthPreference : strengthPreference // ignore: cast_nullable_to_non_nullable
as int,persona: null == persona ? _self.persona : persona // ignore: cast_nullable_to_non_nullable
as String,submitted: null == submitted ? _self.submitted : submitted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
