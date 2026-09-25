// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubjectCard {

 String get id; String get name; String get gradeName; int get teachersCount; bool get locked; String? get description;
/// Create a copy of SubjectCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubjectCardCopyWith<SubjectCard> get copyWith => _$SubjectCardCopyWithImpl<SubjectCard>(this as SubjectCard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SubjectCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubjectCard&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.gradeName, _this.gradeName) || other.gradeName == _this.gradeName)&&(identical(other.teachersCount, _this.teachersCount) || other.teachersCount == _this.teachersCount)&&(identical(other.locked, _this.locked) || other.locked == _this.locked)&&(identical(other.description, _this.description) || other.description == _this.description));
}


@override
int get hashCode {
  final _this = this as SubjectCard;
  return Object.hash(runtimeType,_this.id,_this.name,_this.gradeName,_this.teachersCount,_this.locked,_this.description);
}

@override
String toString() {
  final _this = this as SubjectCard;
  return 'SubjectCard(id: ${_this.id}, name: ${_this.name}, gradeName: ${_this.gradeName}, teachersCount: ${_this.teachersCount}, locked: ${_this.locked}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $SubjectCardCopyWith<$Res>  {
  factory $SubjectCardCopyWith(SubjectCard value, $Res Function(SubjectCard) _then) = _$SubjectCardCopyWithImpl;
@useResult
$Res call({
 String id, String name, String gradeName, int teachersCount, bool locked, String? description
});




}
/// @nodoc
class _$SubjectCardCopyWithImpl<$Res>
    implements $SubjectCardCopyWith<$Res> {
  _$SubjectCardCopyWithImpl(this._self, this._then);

  final SubjectCard _self;
  final $Res Function(SubjectCard) _then;

/// Create a copy of SubjectCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? gradeName = null,Object? teachersCount = null,Object? locked = null,Object? description = freezed,}) {
  return _then(SubjectCard(
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


/// Adds pattern-matching-related methods to [SubjectCard].
extension SubjectCardPatterns on SubjectCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubjectCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubjectCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubjectCard value)  $default,){
final _that = this;
switch (_that) {
case _SubjectCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubjectCard value)?  $default,){
final _that = this;
switch (_that) {
case _SubjectCard() when $default != null:
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
case _SubjectCard() when $default != null:
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
case _SubjectCard():
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
case _SubjectCard() when $default != null:
return $default(_that.id,_that.name,_that.gradeName,_that.teachersCount,_that.locked,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _SubjectCard implements SubjectCard {
  const _SubjectCard({required this.id, required this.name, required this.gradeName, required this.teachersCount, required this.locked, this.description});
  

@override final  String id;
@override final  String name;
@override final  String gradeName;
@override final  int teachersCount;
@override final  bool locked;
@override final  String? description;

/// Create a copy of SubjectCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubjectCardCopyWith<_SubjectCard> get copyWith => __$SubjectCardCopyWithImpl<_SubjectCard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubjectCard&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.gradeName, gradeName) || other.gradeName == gradeName)&&(identical(other.teachersCount, teachersCount) || other.teachersCount == teachersCount)&&(identical(other.locked, locked) || other.locked == locked)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,gradeName,teachersCount,locked,description);
}

@override
String toString() {
    return 'SubjectCard(id: $id, name: $name, gradeName: $gradeName, teachersCount: $teachersCount, locked: $locked, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SubjectCardCopyWith<$Res> implements $SubjectCardCopyWith<$Res> {
  factory _$SubjectCardCopyWith(_SubjectCard value, $Res Function(_SubjectCard) _then) = __$SubjectCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String gradeName, int teachersCount, bool locked, String? description
});




}
/// @nodoc
class __$SubjectCardCopyWithImpl<$Res>
    implements _$SubjectCardCopyWith<$Res> {
  __$SubjectCardCopyWithImpl(this._self, this._then);

  final _SubjectCard _self;
  final $Res Function(_SubjectCard) _then;

/// Create a copy of SubjectCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? gradeName = null,Object? teachersCount = null,Object? locked = null,Object? description = freezed,}) {
  return _then(_SubjectCard(
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

/// @nodoc
mixin _$SubjectDetails {

 String get id; String get name; String get gradeName; bool get locked; List<TeacherCard> get teachers; List<FileItem> get files; String? get description;
/// Create a copy of SubjectDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubjectDetailsCopyWith<SubjectDetails> get copyWith => _$SubjectDetailsCopyWithImpl<SubjectDetails>(this as SubjectDetails, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SubjectDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubjectDetails&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.gradeName, _this.gradeName) || other.gradeName == _this.gradeName)&&(identical(other.locked, _this.locked) || other.locked == _this.locked)&&const DeepCollectionEquality().equals(other.teachers, _this.teachers)&&const DeepCollectionEquality().equals(other.files, _this.files)&&(identical(other.description, _this.description) || other.description == _this.description));
}


@override
int get hashCode {
  final _this = this as SubjectDetails;
  return Object.hash(runtimeType,_this.id,_this.name,_this.gradeName,_this.locked,const DeepCollectionEquality().hash(_this.teachers),const DeepCollectionEquality().hash(_this.files),_this.description);
}

@override
String toString() {
  final _this = this as SubjectDetails;
  return 'SubjectDetails(id: ${_this.id}, name: ${_this.name}, gradeName: ${_this.gradeName}, locked: ${_this.locked}, teachers: ${_this.teachers}, files: ${_this.files}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $SubjectDetailsCopyWith<$Res>  {
  factory $SubjectDetailsCopyWith(SubjectDetails value, $Res Function(SubjectDetails) _then) = _$SubjectDetailsCopyWithImpl;
@useResult
$Res call({
 String id, String name, String gradeName, bool locked, List<TeacherCard> teachers, List<FileItem> files, String? description
});




}
/// @nodoc
class _$SubjectDetailsCopyWithImpl<$Res>
    implements $SubjectDetailsCopyWith<$Res> {
  _$SubjectDetailsCopyWithImpl(this._self, this._then);

  final SubjectDetails _self;
  final $Res Function(SubjectDetails) _then;

/// Create a copy of SubjectDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? gradeName = null,Object? locked = null,Object? teachers = null,Object? files = null,Object? description = freezed,}) {
  return _then(SubjectDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gradeName: null == gradeName ? _self.gradeName : gradeName // ignore: cast_nullable_to_non_nullable
as String,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,teachers: null == teachers ? _self.teachers : teachers // ignore: cast_nullable_to_non_nullable
as List<TeacherCard>,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as List<FileItem>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubjectDetails].
extension SubjectDetailsPatterns on SubjectDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubjectDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubjectDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubjectDetails value)  $default,){
final _that = this;
switch (_that) {
case _SubjectDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubjectDetails value)?  $default,){
final _that = this;
switch (_that) {
case _SubjectDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String gradeName,  bool locked,  List<TeacherCard> teachers,  List<FileItem> files,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubjectDetails() when $default != null:
return $default(_that.id,_that.name,_that.gradeName,_that.locked,_that.teachers,_that.files,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String gradeName,  bool locked,  List<TeacherCard> teachers,  List<FileItem> files,  String? description)  $default,) {final _that = this;
switch (_that) {
case _SubjectDetails():
return $default(_that.id,_that.name,_that.gradeName,_that.locked,_that.teachers,_that.files,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String gradeName,  bool locked,  List<TeacherCard> teachers,  List<FileItem> files,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _SubjectDetails() when $default != null:
return $default(_that.id,_that.name,_that.gradeName,_that.locked,_that.teachers,_that.files,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _SubjectDetails implements SubjectDetails {
  const _SubjectDetails({required this.id, required this.name, required this.gradeName, required this.locked, required  List<TeacherCard> teachers, required  List<FileItem> files, this.description}): _teachers = teachers,_files = files;
  

@override final  String id;
@override final  String name;
@override final  String gradeName;
@override final  bool locked;
 final  List<TeacherCard> _teachers;
@override List<TeacherCard> get teachers {
  if (_teachers is EqualUnmodifiableListView) return _teachers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teachers);
}

 final  List<FileItem> _files;
@override List<FileItem> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}

@override final  String? description;

/// Create a copy of SubjectDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubjectDetailsCopyWith<_SubjectDetails> get copyWith => __$SubjectDetailsCopyWithImpl<_SubjectDetails>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubjectDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.gradeName, gradeName) || other.gradeName == gradeName)&&(identical(other.locked, locked) || other.locked == locked)&&const DeepCollectionEquality().equals(other.teachers, _teachers)&&const DeepCollectionEquality().equals(other.files, _files)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,gradeName,locked,const DeepCollectionEquality().hash(_teachers),const DeepCollectionEquality().hash(_files),description);
}

@override
String toString() {
    return 'SubjectDetails(id: $id, name: $name, gradeName: $gradeName, locked: $locked, teachers: $teachers, files: $files, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SubjectDetailsCopyWith<$Res> implements $SubjectDetailsCopyWith<$Res> {
  factory _$SubjectDetailsCopyWith(_SubjectDetails value, $Res Function(_SubjectDetails) _then) = __$SubjectDetailsCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String gradeName, bool locked, List<TeacherCard> teachers, List<FileItem> files, String? description
});




}
/// @nodoc
class __$SubjectDetailsCopyWithImpl<$Res>
    implements _$SubjectDetailsCopyWith<$Res> {
  __$SubjectDetailsCopyWithImpl(this._self, this._then);

  final _SubjectDetails _self;
  final $Res Function(_SubjectDetails) _then;

/// Create a copy of SubjectDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? gradeName = null,Object? locked = null,Object? teachers = null,Object? files = null,Object? description = freezed,}) {
  return _then(_SubjectDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,gradeName: null == gradeName ? _self.gradeName : gradeName // ignore: cast_nullable_to_non_nullable
as String,locked: null == locked ? _self.locked : locked // ignore: cast_nullable_to_non_nullable
as bool,teachers: null == teachers ? _self._teachers : teachers // ignore: cast_nullable_to_non_nullable
as List<TeacherCard>,files: null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<FileItem>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
