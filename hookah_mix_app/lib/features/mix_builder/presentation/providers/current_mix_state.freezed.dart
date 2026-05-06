// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_mix_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CurrentMixState {

 String get name; String get description; List<MixComponent> get components; TasteProfile? get tasteProfile; int get rating; MixSaveStatus get saveStatus; String? get errorMessage; String? get editingMixId;
/// Create a copy of CurrentMixState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentMixStateCopyWith<CurrentMixState> get copyWith => _$CurrentMixStateCopyWithImpl<CurrentMixState>(this as CurrentMixState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentMixState&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.components, components)&&(identical(other.tasteProfile, tasteProfile) || other.tasteProfile == tasteProfile)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.editingMixId, editingMixId) || other.editingMixId == editingMixId));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,const DeepCollectionEquality().hash(components),tasteProfile,rating,saveStatus,errorMessage,editingMixId);

@override
String toString() {
  return 'CurrentMixState(name: $name, description: $description, components: $components, tasteProfile: $tasteProfile, rating: $rating, saveStatus: $saveStatus, errorMessage: $errorMessage, editingMixId: $editingMixId)';
}


}

/// @nodoc
abstract mixin class $CurrentMixStateCopyWith<$Res>  {
  factory $CurrentMixStateCopyWith(CurrentMixState value, $Res Function(CurrentMixState) _then) = _$CurrentMixStateCopyWithImpl;
@useResult
$Res call({
 String name, String description, List<MixComponent> components, TasteProfile? tasteProfile, int rating, MixSaveStatus saveStatus, String? errorMessage, String? editingMixId
});


$TasteProfileCopyWith<$Res>? get tasteProfile;

}
/// @nodoc
class _$CurrentMixStateCopyWithImpl<$Res>
    implements $CurrentMixStateCopyWith<$Res> {
  _$CurrentMixStateCopyWithImpl(this._self, this._then);

  final CurrentMixState _self;
  final $Res Function(CurrentMixState) _then;

/// Create a copy of CurrentMixState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? components = null,Object? tasteProfile = freezed,Object? rating = null,Object? saveStatus = null,Object? errorMessage = freezed,Object? editingMixId = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,components: null == components ? _self.components : components // ignore: cast_nullable_to_non_nullable
as List<MixComponent>,tasteProfile: freezed == tasteProfile ? _self.tasteProfile : tasteProfile // ignore: cast_nullable_to_non_nullable
as TasteProfile?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as MixSaveStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,editingMixId: freezed == editingMixId ? _self.editingMixId : editingMixId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CurrentMixState
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


/// Adds pattern-matching-related methods to [CurrentMixState].
extension CurrentMixStatePatterns on CurrentMixState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentMixState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentMixState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentMixState value)  $default,){
final _that = this;
switch (_that) {
case _CurrentMixState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentMixState value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentMixState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  List<MixComponent> components,  TasteProfile? tasteProfile,  int rating,  MixSaveStatus saveStatus,  String? errorMessage,  String? editingMixId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentMixState() when $default != null:
return $default(_that.name,_that.description,_that.components,_that.tasteProfile,_that.rating,_that.saveStatus,_that.errorMessage,_that.editingMixId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  List<MixComponent> components,  TasteProfile? tasteProfile,  int rating,  MixSaveStatus saveStatus,  String? errorMessage,  String? editingMixId)  $default,) {final _that = this;
switch (_that) {
case _CurrentMixState():
return $default(_that.name,_that.description,_that.components,_that.tasteProfile,_that.rating,_that.saveStatus,_that.errorMessage,_that.editingMixId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  List<MixComponent> components,  TasteProfile? tasteProfile,  int rating,  MixSaveStatus saveStatus,  String? errorMessage,  String? editingMixId)?  $default,) {final _that = this;
switch (_that) {
case _CurrentMixState() when $default != null:
return $default(_that.name,_that.description,_that.components,_that.tasteProfile,_that.rating,_that.saveStatus,_that.errorMessage,_that.editingMixId);case _:
  return null;

}
}

}

/// @nodoc


class _CurrentMixState extends CurrentMixState {
  const _CurrentMixState({this.name = '', this.description = '', final  List<MixComponent> components = const [], this.tasteProfile, this.rating = 0, this.saveStatus = MixSaveStatus.idle, this.errorMessage, this.editingMixId}): _components = components,super._();
  

@override@JsonKey() final  String name;
@override@JsonKey() final  String description;
 final  List<MixComponent> _components;
@override@JsonKey() List<MixComponent> get components {
  if (_components is EqualUnmodifiableListView) return _components;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_components);
}

@override final  TasteProfile? tasteProfile;
@override@JsonKey() final  int rating;
@override@JsonKey() final  MixSaveStatus saveStatus;
@override final  String? errorMessage;
@override final  String? editingMixId;

/// Create a copy of CurrentMixState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentMixStateCopyWith<_CurrentMixState> get copyWith => __$CurrentMixStateCopyWithImpl<_CurrentMixState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentMixState&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._components, _components)&&(identical(other.tasteProfile, tasteProfile) || other.tasteProfile == tasteProfile)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.editingMixId, editingMixId) || other.editingMixId == editingMixId));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,const DeepCollectionEquality().hash(_components),tasteProfile,rating,saveStatus,errorMessage,editingMixId);

@override
String toString() {
  return 'CurrentMixState(name: $name, description: $description, components: $components, tasteProfile: $tasteProfile, rating: $rating, saveStatus: $saveStatus, errorMessage: $errorMessage, editingMixId: $editingMixId)';
}


}

/// @nodoc
abstract mixin class _$CurrentMixStateCopyWith<$Res> implements $CurrentMixStateCopyWith<$Res> {
  factory _$CurrentMixStateCopyWith(_CurrentMixState value, $Res Function(_CurrentMixState) _then) = __$CurrentMixStateCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, List<MixComponent> components, TasteProfile? tasteProfile, int rating, MixSaveStatus saveStatus, String? errorMessage, String? editingMixId
});


@override $TasteProfileCopyWith<$Res>? get tasteProfile;

}
/// @nodoc
class __$CurrentMixStateCopyWithImpl<$Res>
    implements _$CurrentMixStateCopyWith<$Res> {
  __$CurrentMixStateCopyWithImpl(this._self, this._then);

  final _CurrentMixState _self;
  final $Res Function(_CurrentMixState) _then;

/// Create a copy of CurrentMixState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? components = null,Object? tasteProfile = freezed,Object? rating = null,Object? saveStatus = null,Object? errorMessage = freezed,Object? editingMixId = freezed,}) {
  return _then(_CurrentMixState(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,components: null == components ? _self._components : components // ignore: cast_nullable_to_non_nullable
as List<MixComponent>,tasteProfile: freezed == tasteProfile ? _self.tasteProfile : tasteProfile // ignore: cast_nullable_to_non_nullable
as TasteProfile?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as MixSaveStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,editingMixId: freezed == editingMixId ? _self.editingMixId : editingMixId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CurrentMixState
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
