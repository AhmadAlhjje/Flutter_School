// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topic_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TopicCard {

 String get id; String get title; int get sessionsCount; String? get description;
/// Create a copy of TopicCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopicCardCopyWith<TopicCard> get copyWith => _$TopicCardCopyWithImpl<TopicCard>(this as TopicCard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TopicCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopicCard&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.sessionsCount, _this.sessionsCount) || other.sessionsCount == _this.sessionsCount)&&(identical(other.description, _this.description) || other.description == _this.description));
}


@override
int get hashCode {
  final _this = this as TopicCard;
  return Object.hash(runtimeType,_this.id,_this.title,_this.sessionsCount,_this.description);
}

@override
String toString() {
  final _this = this as TopicCard;
  return 'TopicCard(id: ${_this.id}, title: ${_this.title}, sessionsCount: ${_this.sessionsCount}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $TopicCardCopyWith<$Res>  {
  factory $TopicCardCopyWith(TopicCard value, $Res Function(TopicCard) _then) = _$TopicCardCopyWithImpl;
@useResult
$Res call({
 String id, String title, int sessionsCount, String? description
});




}
/// @nodoc
class _$TopicCardCopyWithImpl<$Res>
    implements $TopicCardCopyWith<$Res> {
  _$TopicCardCopyWithImpl(this._self, this._then);

  final TopicCard _self;
  final $Res Function(TopicCard) _then;

/// Create a copy of TopicCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? sessionsCount = null,Object? description = freezed,}) {
  return _then(TopicCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,sessionsCount: null == sessionsCount ? _self.sessionsCount : sessionsCount // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TopicCard].
extension TopicCardPatterns on TopicCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopicCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopicCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopicCard value)  $default,){
final _that = this;
switch (_that) {
case _TopicCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopicCard value)?  $default,){
final _that = this;
switch (_that) {
case _TopicCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int sessionsCount,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopicCard() when $default != null:
return $default(_that.id,_that.title,_that.sessionsCount,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int sessionsCount,  String? description)  $default,) {final _that = this;
switch (_that) {
case _TopicCard():
return $default(_that.id,_that.title,_that.sessionsCount,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int sessionsCount,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _TopicCard() when $default != null:
return $default(_that.id,_that.title,_that.sessionsCount,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _TopicCard implements TopicCard {
  const _TopicCard({required this.id, required this.title, required this.sessionsCount, this.description});
  

@override final  String id;
@override final  String title;
@override final  int sessionsCount;
@override final  String? description;

/// Create a copy of TopicCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopicCardCopyWith<_TopicCard> get copyWith => __$TopicCardCopyWithImpl<_TopicCard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopicCard&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.sessionsCount, sessionsCount) || other.sessionsCount == sessionsCount)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,sessionsCount,description);
}

@override
String toString() {
    return 'TopicCard(id: $id, title: $title, sessionsCount: $sessionsCount, description: $description)';
}


}

/// @nodoc
abstract mixin class _$TopicCardCopyWith<$Res> implements $TopicCardCopyWith<$Res> {
  factory _$TopicCardCopyWith(_TopicCard value, $Res Function(_TopicCard) _then) = __$TopicCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int sessionsCount, String? description
});




}
/// @nodoc
class __$TopicCardCopyWithImpl<$Res>
    implements _$TopicCardCopyWith<$Res> {
  __$TopicCardCopyWithImpl(this._self, this._then);

  final _TopicCard _self;
  final $Res Function(_TopicCard) _then;

/// Create a copy of TopicCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? sessionsCount = null,Object? description = freezed,}) {
  return _then(_TopicCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,sessionsCount: null == sessionsCount ? _self.sessionsCount : sessionsCount // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TopicDetails {

 String get id; String get title; String get subjectName; String get teacherName; List<SessionCard> get sessions; List<FileItem> get files; String? get description;
/// Create a copy of TopicDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopicDetailsCopyWith<TopicDetails> get copyWith => _$TopicDetailsCopyWithImpl<TopicDetails>(this as TopicDetails, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TopicDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopicDetails&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.teacherName, _this.teacherName) || other.teacherName == _this.teacherName)&&const DeepCollectionEquality().equals(other.sessions, _this.sessions)&&const DeepCollectionEquality().equals(other.files, _this.files)&&(identical(other.description, _this.description) || other.description == _this.description));
}


@override
int get hashCode {
  final _this = this as TopicDetails;
  return Object.hash(runtimeType,_this.id,_this.title,_this.subjectName,_this.teacherName,const DeepCollectionEquality().hash(_this.sessions),const DeepCollectionEquality().hash(_this.files),_this.description);
}

@override
String toString() {
  final _this = this as TopicDetails;
  return 'TopicDetails(id: ${_this.id}, title: ${_this.title}, subjectName: ${_this.subjectName}, teacherName: ${_this.teacherName}, sessions: ${_this.sessions}, files: ${_this.files}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $TopicDetailsCopyWith<$Res>  {
  factory $TopicDetailsCopyWith(TopicDetails value, $Res Function(TopicDetails) _then) = _$TopicDetailsCopyWithImpl;
@useResult
$Res call({
 String id, String title, String subjectName, String teacherName, List<SessionCard> sessions, List<FileItem> files, String? description
});




}
/// @nodoc
class _$TopicDetailsCopyWithImpl<$Res>
    implements $TopicDetailsCopyWith<$Res> {
  _$TopicDetailsCopyWithImpl(this._self, this._then);

  final TopicDetails _self;
  final $Res Function(TopicDetails) _then;

/// Create a copy of TopicDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subjectName = null,Object? teacherName = null,Object? sessions = null,Object? files = null,Object? description = freezed,}) {
  return _then(TopicDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subjectName: null == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String,teacherName: null == teacherName ? _self.teacherName : teacherName // ignore: cast_nullable_to_non_nullable
as String,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SessionCard>,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as List<FileItem>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TopicDetails].
extension TopicDetailsPatterns on TopicDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopicDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopicDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopicDetails value)  $default,){
final _that = this;
switch (_that) {
case _TopicDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopicDetails value)?  $default,){
final _that = this;
switch (_that) {
case _TopicDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String subjectName,  String teacherName,  List<SessionCard> sessions,  List<FileItem> files,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopicDetails() when $default != null:
return $default(_that.id,_that.title,_that.subjectName,_that.teacherName,_that.sessions,_that.files,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String subjectName,  String teacherName,  List<SessionCard> sessions,  List<FileItem> files,  String? description)  $default,) {final _that = this;
switch (_that) {
case _TopicDetails():
return $default(_that.id,_that.title,_that.subjectName,_that.teacherName,_that.sessions,_that.files,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String subjectName,  String teacherName,  List<SessionCard> sessions,  List<FileItem> files,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _TopicDetails() when $default != null:
return $default(_that.id,_that.title,_that.subjectName,_that.teacherName,_that.sessions,_that.files,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _TopicDetails implements TopicDetails {
  const _TopicDetails({required this.id, required this.title, required this.subjectName, required this.teacherName, required  List<SessionCard> sessions, required  List<FileItem> files, this.description}): _sessions = sessions,_files = files;
  

@override final  String id;
@override final  String title;
@override final  String subjectName;
@override final  String teacherName;
 final  List<SessionCard> _sessions;
@override List<SessionCard> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}

 final  List<FileItem> _files;
@override List<FileItem> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}

@override final  String? description;

/// Create a copy of TopicDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopicDetailsCopyWith<_TopicDetails> get copyWith => __$TopicDetailsCopyWithImpl<_TopicDetails>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopicDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.teacherName, teacherName) || other.teacherName == teacherName)&&const DeepCollectionEquality().equals(other.sessions, _sessions)&&const DeepCollectionEquality().equals(other.files, _files)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,subjectName,teacherName,const DeepCollectionEquality().hash(_sessions),const DeepCollectionEquality().hash(_files),description);
}

@override
String toString() {
    return 'TopicDetails(id: $id, title: $title, subjectName: $subjectName, teacherName: $teacherName, sessions: $sessions, files: $files, description: $description)';
}


}

/// @nodoc
abstract mixin class _$TopicDetailsCopyWith<$Res> implements $TopicDetailsCopyWith<$Res> {
  factory _$TopicDetailsCopyWith(_TopicDetails value, $Res Function(_TopicDetails) _then) = __$TopicDetailsCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String subjectName, String teacherName, List<SessionCard> sessions, List<FileItem> files, String? description
});




}
/// @nodoc
class __$TopicDetailsCopyWithImpl<$Res>
    implements _$TopicDetailsCopyWith<$Res> {
  __$TopicDetailsCopyWithImpl(this._self, this._then);

  final _TopicDetails _self;
  final $Res Function(_TopicDetails) _then;

/// Create a copy of TopicDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subjectName = null,Object? teacherName = null,Object? sessions = null,Object? files = null,Object? description = freezed,}) {
  return _then(_TopicDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subjectName: null == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String,teacherName: null == teacherName ? _self.teacherName : teacherName // ignore: cast_nullable_to_non_nullable
as String,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SessionCard>,files: null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<FileItem>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
