// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionCard {

 String get id; String get title; int get videosCount; int get filesCount; String? get description;
/// Create a copy of SessionCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionCardCopyWith<SessionCard> get copyWith => _$SessionCardCopyWithImpl<SessionCard>(this as SessionCard, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionCard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionCard&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.videosCount, _this.videosCount) || other.videosCount == _this.videosCount)&&(identical(other.filesCount, _this.filesCount) || other.filesCount == _this.filesCount)&&(identical(other.description, _this.description) || other.description == _this.description));
}


@override
int get hashCode {
  final _this = this as SessionCard;
  return Object.hash(runtimeType,_this.id,_this.title,_this.videosCount,_this.filesCount,_this.description);
}

@override
String toString() {
  final _this = this as SessionCard;
  return 'SessionCard(id: ${_this.id}, title: ${_this.title}, videosCount: ${_this.videosCount}, filesCount: ${_this.filesCount}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $SessionCardCopyWith<$Res>  {
  factory $SessionCardCopyWith(SessionCard value, $Res Function(SessionCard) _then) = _$SessionCardCopyWithImpl;
@useResult
$Res call({
 String id, String title, int videosCount, int filesCount, String? description
});




}
/// @nodoc
class _$SessionCardCopyWithImpl<$Res>
    implements $SessionCardCopyWith<$Res> {
  _$SessionCardCopyWithImpl(this._self, this._then);

  final SessionCard _self;
  final $Res Function(SessionCard) _then;

/// Create a copy of SessionCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? videosCount = null,Object? filesCount = null,Object? description = freezed,}) {
  return _then(SessionCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,videosCount: null == videosCount ? _self.videosCount : videosCount // ignore: cast_nullable_to_non_nullable
as int,filesCount: null == filesCount ? _self.filesCount : filesCount // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionCard].
extension SessionCardPatterns on SessionCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionCard value)  $default,){
final _that = this;
switch (_that) {
case _SessionCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionCard value)?  $default,){
final _that = this;
switch (_that) {
case _SessionCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int videosCount,  int filesCount,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionCard() when $default != null:
return $default(_that.id,_that.title,_that.videosCount,_that.filesCount,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int videosCount,  int filesCount,  String? description)  $default,) {final _that = this;
switch (_that) {
case _SessionCard():
return $default(_that.id,_that.title,_that.videosCount,_that.filesCount,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int videosCount,  int filesCount,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _SessionCard() when $default != null:
return $default(_that.id,_that.title,_that.videosCount,_that.filesCount,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _SessionCard implements SessionCard {
  const _SessionCard({required this.id, required this.title, required this.videosCount, required this.filesCount, this.description});
  

@override final  String id;
@override final  String title;
@override final  int videosCount;
@override final  int filesCount;
@override final  String? description;

/// Create a copy of SessionCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionCardCopyWith<_SessionCard> get copyWith => __$SessionCardCopyWithImpl<_SessionCard>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionCard&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.videosCount, videosCount) || other.videosCount == videosCount)&&(identical(other.filesCount, filesCount) || other.filesCount == filesCount)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,videosCount,filesCount,description);
}

@override
String toString() {
    return 'SessionCard(id: $id, title: $title, videosCount: $videosCount, filesCount: $filesCount, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SessionCardCopyWith<$Res> implements $SessionCardCopyWith<$Res> {
  factory _$SessionCardCopyWith(_SessionCard value, $Res Function(_SessionCard) _then) = __$SessionCardCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int videosCount, int filesCount, String? description
});




}
/// @nodoc
class __$SessionCardCopyWithImpl<$Res>
    implements _$SessionCardCopyWith<$Res> {
  __$SessionCardCopyWithImpl(this._self, this._then);

  final _SessionCard _self;
  final $Res Function(_SessionCard) _then;

/// Create a copy of SessionCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? videosCount = null,Object? filesCount = null,Object? description = freezed,}) {
  return _then(_SessionCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,videosCount: null == videosCount ? _self.videosCount : videosCount // ignore: cast_nullable_to_non_nullable
as int,filesCount: null == filesCount ? _self.filesCount : filesCount // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SessionDetails {

 String get id; String get title; String get topicTitle; List<VideoItem> get videos; List<FileItem> get files; String? get description;
/// Create a copy of SessionDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionDetailsCopyWith<SessionDetails> get copyWith => _$SessionDetailsCopyWithImpl<SessionDetails>(this as SessionDetails, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SessionDetails;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionDetails&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.topicTitle, _this.topicTitle) || other.topicTitle == _this.topicTitle)&&const DeepCollectionEquality().equals(other.videos, _this.videos)&&const DeepCollectionEquality().equals(other.files, _this.files)&&(identical(other.description, _this.description) || other.description == _this.description));
}


@override
int get hashCode {
  final _this = this as SessionDetails;
  return Object.hash(runtimeType,_this.id,_this.title,_this.topicTitle,const DeepCollectionEquality().hash(_this.videos),const DeepCollectionEquality().hash(_this.files),_this.description);
}

@override
String toString() {
  final _this = this as SessionDetails;
  return 'SessionDetails(id: ${_this.id}, title: ${_this.title}, topicTitle: ${_this.topicTitle}, videos: ${_this.videos}, files: ${_this.files}, description: ${_this.description})';
}


}

/// @nodoc
abstract mixin class $SessionDetailsCopyWith<$Res>  {
  factory $SessionDetailsCopyWith(SessionDetails value, $Res Function(SessionDetails) _then) = _$SessionDetailsCopyWithImpl;
@useResult
$Res call({
 String id, String title, String topicTitle, List<VideoItem> videos, List<FileItem> files, String? description
});




}
/// @nodoc
class _$SessionDetailsCopyWithImpl<$Res>
    implements $SessionDetailsCopyWith<$Res> {
  _$SessionDetailsCopyWithImpl(this._self, this._then);

  final SessionDetails _self;
  final $Res Function(SessionDetails) _then;

/// Create a copy of SessionDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? topicTitle = null,Object? videos = null,Object? files = null,Object? description = freezed,}) {
  return _then(SessionDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,topicTitle: null == topicTitle ? _self.topicTitle : topicTitle // ignore: cast_nullable_to_non_nullable
as String,videos: null == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as List<VideoItem>,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as List<FileItem>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionDetails].
extension SessionDetailsPatterns on SessionDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionDetails value)  $default,){
final _that = this;
switch (_that) {
case _SessionDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionDetails value)?  $default,){
final _that = this;
switch (_that) {
case _SessionDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String topicTitle,  List<VideoItem> videos,  List<FileItem> files,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionDetails() when $default != null:
return $default(_that.id,_that.title,_that.topicTitle,_that.videos,_that.files,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String topicTitle,  List<VideoItem> videos,  List<FileItem> files,  String? description)  $default,) {final _that = this;
switch (_that) {
case _SessionDetails():
return $default(_that.id,_that.title,_that.topicTitle,_that.videos,_that.files,_that.description);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String topicTitle,  List<VideoItem> videos,  List<FileItem> files,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _SessionDetails() when $default != null:
return $default(_that.id,_that.title,_that.topicTitle,_that.videos,_that.files,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _SessionDetails implements SessionDetails {
  const _SessionDetails({required this.id, required this.title, required this.topicTitle, required  List<VideoItem> videos, required  List<FileItem> files, this.description}): _videos = videos,_files = files;
  

@override final  String id;
@override final  String title;
@override final  String topicTitle;
 final  List<VideoItem> _videos;
@override List<VideoItem> get videos {
  if (_videos is EqualUnmodifiableListView) return _videos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_videos);
}

 final  List<FileItem> _files;
@override List<FileItem> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}

@override final  String? description;

/// Create a copy of SessionDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionDetailsCopyWith<_SessionDetails> get copyWith => __$SessionDetailsCopyWithImpl<_SessionDetails>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.topicTitle, topicTitle) || other.topicTitle == topicTitle)&&const DeepCollectionEquality().equals(other.videos, _videos)&&const DeepCollectionEquality().equals(other.files, _files)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,topicTitle,const DeepCollectionEquality().hash(_videos),const DeepCollectionEquality().hash(_files),description);
}

@override
String toString() {
    return 'SessionDetails(id: $id, title: $title, topicTitle: $topicTitle, videos: $videos, files: $files, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SessionDetailsCopyWith<$Res> implements $SessionDetailsCopyWith<$Res> {
  factory _$SessionDetailsCopyWith(_SessionDetails value, $Res Function(_SessionDetails) _then) = __$SessionDetailsCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String topicTitle, List<VideoItem> videos, List<FileItem> files, String? description
});




}
/// @nodoc
class __$SessionDetailsCopyWithImpl<$Res>
    implements _$SessionDetailsCopyWith<$Res> {
  __$SessionDetailsCopyWithImpl(this._self, this._then);

  final _SessionDetails _self;
  final $Res Function(_SessionDetails) _then;

/// Create a copy of SessionDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? topicTitle = null,Object? videos = null,Object? files = null,Object? description = freezed,}) {
  return _then(_SessionDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,topicTitle: null == topicTitle ? _self.topicTitle : topicTitle // ignore: cast_nullable_to_non_nullable
as String,videos: null == videos ? _self._videos : videos // ignore: cast_nullable_to_non_nullable
as List<VideoItem>,files: null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<FileItem>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
