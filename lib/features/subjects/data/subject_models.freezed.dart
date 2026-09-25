// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubjectCardModel {

 String get id; String get name; String get gradeName; int get teachersCount; bool get locked; String? get description;
/// Create a copy of SubjectCardModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubjectCardModelCopyWith<SubjectCardModel> get copyWith => _$SubjectCardModelCopyWithImpl<SubjectCardModel>(this as SubjectCardModel, _$identity);

  /// Serializes this SubjectCardModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SubjectCardModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubjectCardModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.gradeName, _this.gradeName) || other.gradeName == _this.gradeName)&&(identical(other.teachersCount, _this.teachersCount) || other.teachersCount == _this.teachersCount)&&(identical(other.locked, _this.locked) || other.locked == _this.locked)&&(identical(other.description, _this.description) || other.description == _this.description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SubjectCardModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.gradeName,_this.teachersCount,_this.locked,_this.description);
}

@override
String toString() {
  final _this = this as SubjectCardModel;
  return 'SubjectCardModel(id: ${_this.id}, name: ${_this.name}, gradeName: ${_this.gradeName}, teachersCount: ${_this.teachersCount}, locked: ${_this.locked}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $SubjectCardModelCopyWith<$Res>  {
  factory $SubjectCardModelCopyWith(SubjectCardModel value, $Res Function(SubjectCardModel) _then) = _$SubjectCardModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String gradeName, int teachersCount, bool locked, String? description
});




}
/// @nodoc
class _$SubjectCardModelCopyWithImpl<$Res>
    implements $SubjectCardModelCopyWith<$Res> {
  _$SubjectCardModelCopyWithImpl(this._self, this._then);

  final SubjectCardModel _self;
  final $Res Function(SubjectCardModel) _then;

/// Create a copy of SubjectCardModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? gradeName = null,Object? teachersCount = null,Object? locked = null,Object? description = freezed,}) {
  return _then(SubjectCardModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gradeName: null == gradeName ? _self.gradeName : gradeName // ignore: cast_nullable_to_non_nullable
as String,teachersCount: null == teachersCount ? _self.teachersCount : teachersCount // ignore: cast_nullable_to_non_nullable
as int,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubjectCardModel].
extension SubjectCardModelPatterns on SubjectCardModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubjectCardModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubjectCardModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubjectCardModel value)  $default,){
final _that = this;
switch (_that) {
case _SubjectCardModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubjectCardModel value)?  $default,){
final _that = this;
switch (_that) {
case _SubjectCardModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String gradeName,  int teachersCount,  bool locked,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubjectCardModel() when $default != null:
return $default(_that.id,_that.name,_that.gradeName,_that.teachersCount,_that.locked,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String gradeName,  int teachersCount,  bool locked,  String? description)  $default,) {final _that = this;
switch (_that) {
case _SubjectCardModel():
return $default(_that.id,_that.name,_that.gradeName,_that.teachersCount,_that.locked,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String gradeName,  int teachersCount,  bool locked,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _SubjectCardModel() when $default != null:
return $default(_that.id,_that.name,_that.gradeName,_that.teachersCount,_that.locked,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubjectCardModel extends SubjectCardModel {
  const _SubjectCardModel({required this.id, required this.name, required this.gradeName, required this.teachersCount, required this.locked, this.description}): super._();
  factory _SubjectCardModel.fromJson(Map<String, dynamic> json) => _$SubjectCardModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String gradeName;
@override final  int teachersCount;
@override final  bool locked;
@override final  String? description;

/// Create a copy of SubjectCardModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubjectCardModelCopyWith<_SubjectCardModel> get copyWith => __$SubjectCardModelCopyWithImpl<_SubjectCardModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubjectCardModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubjectCardModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.gradeName, gradeName) || other.gradeName == gradeName)&&(identical(other.teachersCount, teachersCount) || other.teachersCount == teachersCount)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,gradeName,teachersCount,locked,description);
}

@override
String toString() {
    return 'SubjectCardModel(id: $id, name: $name, gradeName: $gradeName, teachersCount: $teachersCount, locked: $locked, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SubjectCardModelCopyWith<$Res> implements $SubjectCardModelCopyWith<$Res> {
  factory _$SubjectCardModelCopyWith(_SubjectCardModel value, $Res Function(_SubjectCardModel) _then) = __$SubjectCardModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String gradeName, int teachersCount, bool locked, String? description
});




}
/// @nodoc
class __$SubjectCardModelCopyWithImpl<$Res>
    implements _$SubjectCardModelCopyWith<$Res> {
  __$SubjectCardModelCopyWithImpl(this._self, this._then);

  final _SubjectCardModel _self;
  final $Res Function(_SubjectCardModel) _then;

/// Create a copy of SubjectCardModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? gradeName = null,Object? teachersCount = null,Object? locked = null,Object? description = freezed,}) {
  return _then(_SubjectCardModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gradeName: null == gradeName ? _self.gradeName : gradeName // ignore: cast_nullable_to_non_nullable
as String,teachersCount: null == teachersCount ? _self.teachersCount : teachersCount // ignore: cast_nullable_to_non_nullable
as int,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
