// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teacher_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TeacherCard {

 String get subjectTeacherId; String get teacherId; String get name; int get topicsCount; bool get locked; String? get description; String? get imagePath;
/// Create a copy of TeacherCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeacherCardCopyWith<TeacherCard> get copyWith => _$TeacherCardCopyWithImpl<TeacherCard>(this as TeacherCard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TeacherCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherCard&&(identical(other.subjectTeacherId, _this.subjectTeacherId) || other.subjectTeacherId == _this.subjectTeacherId)&&(identical(other.teacherId, _this.teacherId) || other.teacherId == _this.teacherId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.topicsCount, _this.topicsCount) || other.topicsCount == _this.topicsCount)&&(identical(other.locked, _this.locked) || other.locked == _this.locked)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.imagePath, _this.imagePath) || other.imagePath == _this.imagePath));
}


@override
int get hashCode {
  final _this = this as TeacherCard;
  return Object.hash(runtimeType,_this.subjectTeacherId,_this.teacherId,_this.name,_this.topicsCount,_this.locked,_this.description,_this.imagePath);
}

@override
String toString() {
  final _this = this as TeacherCard;
  return 'TeacherCard(subjectTeacherId: ${_this.subjectTeacherId}, teacherId: ${_this.teacherId}, name: ${_this.name}, topicsCount: ${_this.topicsCount}, locked: ${_this.locked}, description: ${_this.description}, imagePath: ${_this.imagePath})';
}


}

/// @nodoc
abstract mixin class $TeacherCardCopyWith<$Res>  {
  factory $TeacherCardCopyWith(TeacherCard value, $Res Function(TeacherCard) _then) = _$TeacherCardCopyWithImpl;
@useResult
$Res call({
 String subjectTeacherId, String teacherId, String name, int topicsCount, bool locked, String? description, String? imagePath
});




}
/// @nodoc
class _$TeacherCardCopyWithImpl<$Res>
    implements $TeacherCardCopyWith<$Res> {
  _$TeacherCardCopyWithImpl(this._self, this._then);

  final TeacherCard _self;
  final $Res Function(TeacherCard) _then;

/// Create a copy of TeacherCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subjectTeacherId = null,Object? teacherId = null,Object? name = null,Object? topicsCount = null,Object? locked = null,Object? description = freezed,Object? imagePath = freezed,}) {
  return _then(TeacherCard(
subjectTeacherId: null == subjectTeacherId ? _self.subjectTeacherId : subjectTeacherId // ignore: cast_nullable_to_non_nullable
as String,teacherId: null == teacherId ? _self.teacherId : teacherId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,topicsCount: null == topicsCount ? _self.topicsCount : topicsCount // ignore: cast_nullable_to_non_nullable
as int,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TeacherCard].
extension TeacherCardPatterns on TeacherCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeacherCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeacherCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeacherCard value)  $default,){
final _that = this;
switch (_that) {
case _TeacherCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeacherCard value)?  $default,){
final _that = this;
switch (_that) {
case _TeacherCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String subjectTeacherId,  String teacherId,  String name,  int topicsCount,  bool locked,  String? description,  String? imagePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeacherCard() when $default != null:
return $default(_that.subjectTeacherId,_that.teacherId,_that.name,_that.topicsCount,_that.locked,_that.description,_that.imagePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String subjectTeacherId,  String teacherId,  String name,  int topicsCount,  bool locked,  String? description,  String? imagePath)  $default,) {final _that = this;
switch (_that) {
case _TeacherCard():
return $default(_that.subjectTeacherId,_that.teacherId,_that.name,_that.topicsCount,_that.locked,_that.description,_that.imagePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String subjectTeacherId,  String teacherId,  String name,  int topicsCount,  bool locked,  String? description,  String? imagePath)?  $default,) {final _that = this;
switch (_that) {
case _TeacherCard() when $default != null:
return $default(_that.subjectTeacherId,_that.teacherId,_that.name,_that.topicsCount,_that.locked,_that.description,_that.imagePath);case _:
  return null;

}
}

}

/// @nodoc


class _TeacherCard implements TeacherCard {
  const _TeacherCard({required this.subjectTeacherId, required this.teacherId, required this.name, required this.topicsCount, required this.locked, this.description, this.imagePath});
  

@override final  String subjectTeacherId;
@override final  String teacherId;
@override final  String name;
@override final  int topicsCount;
@override final  bool locked;
@override final  String? description;
@override final  String? imagePath;

/// Create a copy of TeacherCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeacherCardCopyWith<_TeacherCard> get copyWith => __$TeacherCardCopyWithImpl<_TeacherCard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeacherCard&&(identical(other.subjectTeacherId, subjectTeacherId) || other.subjectTeacherId == subjectTeacherId)&&(identical(other.teacherId, teacherId) || other.teacherId == teacherId)&&(identical(other.name, name) || other.name == name)&&(identical(other.topicsCount, topicsCount) || other.topicsCount == topicsCount)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.description, description) || other.description == description)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}


@override
int get hashCode {
    return Object.hash(runtimeType,subjectTeacherId,teacherId,name,topicsCount,locked,description,imagePath);
}

@override
String toString() {
    return 'TeacherCard(subjectTeacherId: $subjectTeacherId, teacherId: $teacherId, name: $name, topicsCount: $topicsCount, locked: $locked, description: $description, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class _$TeacherCardCopyWith<$Res> implements $TeacherCardCopyWith<$Res> {
  factory _$TeacherCardCopyWith(_TeacherCard value, $Res Function(_TeacherCard) _then) = __$TeacherCardCopyWithImpl;
@override @useResult
$Res call({
 String subjectTeacherId, String teacherId, String name, int topicsCount, bool locked, String? description, String? imagePath
});




}
/// @nodoc
class __$TeacherCardCopyWithImpl<$Res>
    implements _$TeacherCardCopyWith<$Res> {
  __$TeacherCardCopyWithImpl(this._self, this._then);

  final _TeacherCard _self;
  final $Res Function(_TeacherCard) _then;

/// Create a copy of TeacherCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subjectTeacherId = null,Object? teacherId = null,Object? name = null,Object? topicsCount = null,Object? locked = null,Object? description = freezed,Object? imagePath = freezed,}) {
  return _then(_TeacherCard(
subjectTeacherId: null == subjectTeacherId ? _self.subjectTeacherId : subjectTeacherId // ignore: cast_nullable_to_non_nullable
as String,teacherId: null == teacherId ? _self.teacherId : teacherId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,topicsCount: null == topicsCount ? _self.topicsCount : topicsCount // ignore: cast_nullable_to_non_nullable
as int,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TeacherSpace {

 String get subjectTeacherId; String get subjectName; String get teacherName; List<TopicCard> get topics; List<FileItem> get files; String? get description; String? get imagePath;
/// Create a copy of TeacherSpace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeacherSpaceCopyWith<TeacherSpace> get copyWith => _$TeacherSpaceCopyWithImpl<TeacherSpace>(this as TeacherSpace, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TeacherSpace;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeacherSpace&&(identical(other.subjectTeacherId, _this.subjectTeacherId) || other.subjectTeacherId == _this.subjectTeacherId)&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.teacherName, _this.teacherName) || other.teacherName == _this.teacherName)&&const DeepCollectionEquality().equals(other.topics, _this.topics)&&const DeepCollectionEquality().equals(other.files, _this.files)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.imagePath, _this.imagePath) || other.imagePath == _this.imagePath));
}


@override
int get hashCode {
  final _this = this as TeacherSpace;
  return Object.hash(runtimeType,_this.subjectTeacherId,_this.subjectName,_this.teacherName,const DeepCollectionEquality().hash(_this.topics),const DeepCollectionEquality().hash(_this.files),_this.description,_this.imagePath);
}

@override
String toString() {
  final _this = this as TeacherSpace;
  return 'TeacherSpace(subjectTeacherId: ${_this.subjectTeacherId}, subjectName: ${_this.subjectName}, teacherName: ${_this.teacherName}, topics: ${_this.topics}, files: ${_this.files}, description: ${_this.description}, imagePath: ${_this.imagePath})';
}


}

/// @nodoc
abstract mixin class $TeacherSpaceCopyWith<$Res>  {
  factory $TeacherSpaceCopyWith(TeacherSpace value, $Res Function(TeacherSpace) _then) = _$TeacherSpaceCopyWithImpl;
@useResult
$Res call({
 String subjectTeacherId, String subjectName, String teacherName, List<TopicCard> topics, List<FileItem> files, String? description, String? imagePath
});




}
/// @nodoc
class _$TeacherSpaceCopyWithImpl<$Res>
    implements $TeacherSpaceCopyWith<$Res> {
  _$TeacherSpaceCopyWithImpl(this._self, this._then);

  final TeacherSpace _self;
  final $Res Function(TeacherSpace) _then;

/// Create a copy of TeacherSpace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subjectTeacherId = null,Object? subjectName = null,Object? teacherName = null,Object? topics = null,Object? files = null,Object? description = freezed,Object? imagePath = freezed,}) {
  return _then(TeacherSpace(
subjectTeacherId: null == subjectTeacherId ? _self.subjectTeacherId : subjectTeacherId // ignore: cast_nullable_to_non_nullable
as String,subjectName: null == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String,teacherName: null == teacherName ? _self.teacherName : teacherName // ignore: cast_nullable_to_non_nullable
as String,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<TopicCard>,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as List<FileItem>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TeacherSpace].
extension TeacherSpacePatterns on TeacherSpace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeacherSpace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeacherSpace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeacherSpace value)  $default,){
final _that = this;
switch (_that) {
case _TeacherSpace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeacherSpace value)?  $default,){
final _that = this;
switch (_that) {
case _TeacherSpace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String subjectTeacherId,  String subjectName,  String teacherName,  List<TopicCard> topics,  List<FileItem> files,  String? description,  String? imagePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeacherSpace() when $default != null:
return $default(_that.subjectTeacherId,_that.subjectName,_that.teacherName,_that.topics,_that.files,_that.description,_that.imagePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String subjectTeacherId,  String subjectName,  String teacherName,  List<TopicCard> topics,  List<FileItem> files,  String? description,  String? imagePath)  $default,) {final _that = this;
switch (_that) {
case _TeacherSpace():
return $default(_that.subjectTeacherId,_that.subjectName,_that.teacherName,_that.topics,_that.files,_that.description,_that.imagePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String subjectTeacherId,  String subjectName,  String teacherName,  List<TopicCard> topics,  List<FileItem> files,  String? description,  String? imagePath)?  $default,) {final _that = this;
switch (_that) {
case _TeacherSpace() when $default != null:
return $default(_that.subjectTeacherId,_that.subjectName,_that.teacherName,_that.topics,_that.files,_that.description,_that.imagePath);case _:
  return null;

}
}

}

/// @nodoc


class _TeacherSpace implements TeacherSpace {
  const _TeacherSpace({required this.subjectTeacherId, required this.subjectName, required this.teacherName, required  List<TopicCard> topics, required  List<FileItem> files, this.description, this.imagePath}): _topics = topics,_files = files;
  

@override final  String subjectTeacherId;
@override final  String subjectName;
@override final  String teacherName;
 final  List<TopicCard> _topics;
@override List<TopicCard> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}

 final  List<FileItem> _files;
@override List<FileItem> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}

@override final  String? description;
@override final  String? imagePath;

/// Create a copy of TeacherSpace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeacherSpaceCopyWith<_TeacherSpace> get copyWith => __$TeacherSpaceCopyWithImpl<_TeacherSpace>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeacherSpace&&(identical(other.subjectTeacherId, subjectTeacherId) || other.subjectTeacherId == subjectTeacherId)&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.teacherName, teacherName) || other.teacherName == teacherName)&&const DeepCollectionEquality().equals(other.topics, _topics)&&const DeepCollectionEquality().equals(other.files, _files)&&(identical(other.description, description) || other.description == description)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}


@override
int get hashCode {
    return Object.hash(runtimeType,subjectTeacherId,subjectName,teacherName,const DeepCollectionEquality().hash(_topics),const DeepCollectionEquality().hash(_files),description,imagePath);
}

@override
String toString() {
    return 'TeacherSpace(subjectTeacherId: $subjectTeacherId, subjectName: $subjectName, teacherName: $teacherName, topics: $topics, files: $files, description: $description, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class _$TeacherSpaceCopyWith<$Res> implements $TeacherSpaceCopyWith<$Res> {
  factory _$TeacherSpaceCopyWith(_TeacherSpace value, $Res Function(_TeacherSpace) _then) = __$TeacherSpaceCopyWithImpl;
@override @useResult
$Res call({
 String subjectTeacherId, String subjectName, String teacherName, List<TopicCard> topics, List<FileItem> files, String? description, String? imagePath
});




}
/// @nodoc
class __$TeacherSpaceCopyWithImpl<$Res>
    implements _$TeacherSpaceCopyWith<$Res> {
  __$TeacherSpaceCopyWithImpl(this._self, this._then);

  final _TeacherSpace _self;
  final $Res Function(_TeacherSpace) _then;

/// Create a copy of TeacherSpace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subjectTeacherId = null,Object? subjectName = null,Object? teacherName = null,Object? topics = null,Object? files = null,Object? description = freezed,Object? imagePath = freezed,}) {
  return _then(_TeacherSpace(
subjectTeacherId: null == subjectTeacherId ? _self.subjectTeacherId : subjectTeacherId // ignore: cast_nullable_to_non_nullable
as String,subjectName: null == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String,teacherName: null == teacherName ? _self.teacherName : teacherName // ignore: cast_nullable_to_non_nullable
as String,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<TopicCard>,files: null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<FileItem>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
