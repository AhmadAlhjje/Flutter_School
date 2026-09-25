// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoItemModel {

 String get id; String get title; String? get description; int? get durationSeconds;
/// Create a copy of VideoItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoItemModelCopyWith<VideoItemModel> get copyWith => _$VideoItemModelCopyWithImpl<VideoItemModel>(this as VideoItemModel, _$identity);

  /// Serializes this VideoItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as VideoItemModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoItemModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as VideoItemModel;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.durationSeconds);
}

@override
String toString() {
  final _this = this as VideoItemModel;
  return 'VideoItemModel(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, durationSeconds: ${_this.durationSeconds})';
}


}

/// @nodoc
abstract mixin class $VideoItemModelCopyWith<$Res>  {
  factory $VideoItemModelCopyWith(VideoItemModel value, $Res Function(VideoItemModel) _then) = _$VideoItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, int? durationSeconds
});




}
/// @nodoc
class _$VideoItemModelCopyWithImpl<$Res>
    implements $VideoItemModelCopyWith<$Res> {
  _$VideoItemModelCopyWithImpl(this._self, this._then);

  final VideoItemModel _self;
  final $Res Function(VideoItemModel) _then;

/// Create a copy of VideoItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? durationSeconds = freezed,}) {
  return _then(VideoItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoItemModel].
extension VideoItemModelPatterns on VideoItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoItemModel value)  $default,){
final _that = this;
switch (_that) {
case _VideoItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _VideoItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  int? durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoItemModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  int? durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _VideoItemModel():
return $default(_that.id,_that.title,_that.description,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  int? durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _VideoItemModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoItemModel extends VideoItemModel {
  const _VideoItemModel({required this.id, required this.title, this.description, this.durationSeconds}): super._();
  factory _VideoItemModel.fromJson(Map<String, dynamic> json) => _$VideoItemModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  int? durationSeconds;

/// Create a copy of VideoItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoItemModelCopyWith<_VideoItemModel> get copyWith => __$VideoItemModelCopyWithImpl<_VideoItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,durationSeconds);
}

@override
String toString() {
    return 'VideoItemModel(id: $id, title: $title, description: $description, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$VideoItemModelCopyWith<$Res> implements $VideoItemModelCopyWith<$Res> {
  factory _$VideoItemModelCopyWith(_VideoItemModel value, $Res Function(_VideoItemModel) _then) = __$VideoItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, int? durationSeconds
});




}
/// @nodoc
class __$VideoItemModelCopyWithImpl<$Res>
    implements _$VideoItemModelCopyWith<$Res> {
  __$VideoItemModelCopyWithImpl(this._self, this._then);

  final _VideoItemModel _self;
  final $Res Function(_VideoItemModel) _then;

/// Create a copy of VideoItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? durationSeconds = freezed,}) {
  return _then(_VideoItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
