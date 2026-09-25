// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VideoItem {

 String get id; String get title; String? get description; int? get durationSeconds;
/// Create a copy of VideoItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoItemCopyWith<VideoItem> get copyWith => _$VideoItemCopyWithImpl<VideoItem>(this as VideoItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as VideoItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds));
}


@override
int get hashCode {
  final _this = this as VideoItem;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.durationSeconds);
}

@override
String toString() {
  final _this = this as VideoItem;
  return 'VideoItem(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, durationSeconds: ${_this.durationSeconds})';
}


}

/// @nodoc
abstract mixin class $VideoItemCopyWith<$Res>  {
  factory $VideoItemCopyWith(VideoItem value, $Res Function(VideoItem) _then) = _$VideoItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, int? durationSeconds
});




}
/// @nodoc
class _$VideoItemCopyWithImpl<$Res>
    implements $VideoItemCopyWith<$Res> {
  _$VideoItemCopyWithImpl(this._self, this._then);

  final VideoItem _self;
  final $Res Function(VideoItem) _then;

/// Create a copy of VideoItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? durationSeconds = freezed,}) {
  return _then(VideoItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoItem].
extension VideoItemPatterns on VideoItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoItem value)  $default,){
final _that = this;
switch (_that) {
case _VideoItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoItem value)?  $default,){
final _that = this;
switch (_that) {
case _VideoItem() when $default != null:
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
case _VideoItem() when $default != null:
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
case _VideoItem():
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
case _VideoItem() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc


class _VideoItem implements VideoItem {
  const _VideoItem({required this.id, required this.title, this.description, this.durationSeconds});
  

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  int? durationSeconds;

/// Create a copy of VideoItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoItemCopyWith<_VideoItem> get copyWith => __$VideoItemCopyWithImpl<_VideoItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,durationSeconds);
}

@override
String toString() {
    return 'VideoItem(id: $id, title: $title, description: $description, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$VideoItemCopyWith<$Res> implements $VideoItemCopyWith<$Res> {
  factory _$VideoItemCopyWith(_VideoItem value, $Res Function(_VideoItem) _then) = __$VideoItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, int? durationSeconds
});




}
/// @nodoc
class __$VideoItemCopyWithImpl<$Res>
    implements _$VideoItemCopyWith<$Res> {
  __$VideoItemCopyWithImpl(this._self, this._then);

  final _VideoItem _self;
  final $Res Function(_VideoItem) _then;

/// Create a copy of VideoItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? durationSeconds = freezed,}) {
  return _then(_VideoItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$PlaybackGrant {

 String get videoId; String get title; Uri get manifestUrl; DateTime get expiresAt; int? get durationSeconds;
/// Create a copy of PlaybackGrant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackGrantCopyWith<PlaybackGrant> get copyWith => _$PlaybackGrantCopyWithImpl<PlaybackGrant>(this as PlaybackGrant, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlaybackGrant;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackGrant&&(identical(other.videoId, _this.videoId) || other.videoId == _this.videoId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.manifestUrl, _this.manifestUrl) || other.manifestUrl == _this.manifestUrl)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds));
}


@override
int get hashCode {
  final _this = this as PlaybackGrant;
  return Object.hash(runtimeType,_this.videoId,_this.title,_this.manifestUrl,_this.expiresAt,_this.durationSeconds);
}

@override
String toString() {
  final _this = this as PlaybackGrant;
  return 'PlaybackGrant(videoId: ${_this.videoId}, title: ${_this.title}, manifestUrl: ${_this.manifestUrl}, expiresAt: ${_this.expiresAt}, durationSeconds: ${_this.durationSeconds})';
}


}

/// @nodoc
abstract mixin class $PlaybackGrantCopyWith<$Res>  {
  factory $PlaybackGrantCopyWith(PlaybackGrant value, $Res Function(PlaybackGrant) _then) = _$PlaybackGrantCopyWithImpl;
@useResult
$Res call({
 String videoId, String title, Uri manifestUrl, DateTime expiresAt, int? durationSeconds
});




}
/// @nodoc
class _$PlaybackGrantCopyWithImpl<$Res>
    implements $PlaybackGrantCopyWith<$Res> {
  _$PlaybackGrantCopyWithImpl(this._self, this._then);

  final PlaybackGrant _self;
  final $Res Function(PlaybackGrant) _then;

/// Create a copy of PlaybackGrant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? videoId = null,Object? title = null,Object? manifestUrl = null,Object? expiresAt = null,Object? durationSeconds = freezed,}) {
  return _then(PlaybackGrant(
videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,manifestUrl: null == manifestUrl ? _self.manifestUrl : manifestUrl // ignore: cast_nullable_to_non_nullable
as Uri,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaybackGrant].
extension PlaybackGrantPatterns on PlaybackGrant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaybackGrant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaybackGrant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaybackGrant value)  $default,){
final _that = this;
switch (_that) {
case _PlaybackGrant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaybackGrant value)?  $default,){
final _that = this;
switch (_that) {
case _PlaybackGrant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String videoId,  String title,  Uri manifestUrl,  DateTime expiresAt,  int? durationSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaybackGrant() when $default != null:
return $default(_that.videoId,_that.title,_that.manifestUrl,_that.expiresAt,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String videoId,  String title,  Uri manifestUrl,  DateTime expiresAt,  int? durationSeconds)  $default,) {final _that = this;
switch (_that) {
case _PlaybackGrant():
return $default(_that.videoId,_that.title,_that.manifestUrl,_that.expiresAt,_that.durationSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String videoId,  String title,  Uri manifestUrl,  DateTime expiresAt,  int? durationSeconds)?  $default,) {final _that = this;
switch (_that) {
case _PlaybackGrant() when $default != null:
return $default(_that.videoId,_that.title,_that.manifestUrl,_that.expiresAt,_that.durationSeconds);case _:
  return null;

}
}

}

/// @nodoc


class _PlaybackGrant implements PlaybackGrant {
  const _PlaybackGrant({required this.videoId, required this.title, required this.manifestUrl, required this.expiresAt, this.durationSeconds});
  

@override final  String videoId;
@override final  String title;
@override final  Uri manifestUrl;
@override final  DateTime expiresAt;
@override final  int? durationSeconds;

/// Create a copy of PlaybackGrant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaybackGrantCopyWith<_PlaybackGrant> get copyWith => __$PlaybackGrantCopyWithImpl<_PlaybackGrant>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaybackGrant&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.title, title) || other.title == title)&&(identical(other.manifestUrl, manifestUrl) || other.manifestUrl == manifestUrl)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds));
}


@override
int get hashCode {
    return Object.hash(runtimeType,videoId,title,manifestUrl,expiresAt,durationSeconds);
}

@override
String toString() {
    return 'PlaybackGrant(videoId: $videoId, title: $title, manifestUrl: $manifestUrl, expiresAt: $expiresAt, durationSeconds: $durationSeconds)';
}


}

/// @nodoc
abstract mixin class _$PlaybackGrantCopyWith<$Res> implements $PlaybackGrantCopyWith<$Res> {
  factory _$PlaybackGrantCopyWith(_PlaybackGrant value, $Res Function(_PlaybackGrant) _then) = __$PlaybackGrantCopyWithImpl;
@override @useResult
$Res call({
 String videoId, String title, Uri manifestUrl, DateTime expiresAt, int? durationSeconds
});




}
/// @nodoc
class __$PlaybackGrantCopyWithImpl<$Res>
    implements _$PlaybackGrantCopyWith<$Res> {
  __$PlaybackGrantCopyWithImpl(this._self, this._then);

  final _PlaybackGrant _self;
  final $Res Function(_PlaybackGrant) _then;

/// Create a copy of PlaybackGrant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? videoId = null,Object? title = null,Object? manifestUrl = null,Object? expiresAt = null,Object? durationSeconds = freezed,}) {
  return _then(_PlaybackGrant(
videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,manifestUrl: null == manifestUrl ? _self.manifestUrl : manifestUrl // ignore: cast_nullable_to_non_nullable
as Uri,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$OfflineVideo {

 String get licenseId; String get videoId; String get title; DateTime get expiresAt; DateTime get downloadedAt; int get sizeBytes; int? get durationSeconds; String? get subjectName; String? get teacherName; String? get topicTitle; String? get sessionTitle;
/// Create a copy of OfflineVideo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfflineVideoCopyWith<OfflineVideo> get copyWith => _$OfflineVideoCopyWithImpl<OfflineVideo>(this as OfflineVideo, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OfflineVideo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfflineVideo&&(identical(other.licenseId, _this.licenseId) || other.licenseId == _this.licenseId)&&(identical(other.videoId, _this.videoId) || other.videoId == _this.videoId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.downloadedAt, _this.downloadedAt) || other.downloadedAt == _this.downloadedAt)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&(identical(other.durationSeconds, _this.durationSeconds) || other.durationSeconds == _this.durationSeconds)&&(identical(other.subjectName, _this.subjectName) || other.subjectName == _this.subjectName)&&(identical(other.teacherName, _this.teacherName) || other.teacherName == _this.teacherName)&&(identical(other.topicTitle, _this.topicTitle) || other.topicTitle == _this.topicTitle)&&(identical(other.sessionTitle, _this.sessionTitle) || other.sessionTitle == _this.sessionTitle));
}


@override
int get hashCode {
  final _this = this as OfflineVideo;
  return Object.hash(runtimeType,_this.licenseId,_this.videoId,_this.title,_this.expiresAt,_this.downloadedAt,_this.sizeBytes,_this.durationSeconds,_this.subjectName,_this.teacherName,_this.topicTitle,_this.sessionTitle);
}

@override
String toString() {
  final _this = this as OfflineVideo;
  return 'OfflineVideo(licenseId: ${_this.licenseId}, videoId: ${_this.videoId}, title: ${_this.title}, expiresAt: ${_this.expiresAt}, downloadedAt: ${_this.downloadedAt}, sizeBytes: ${_this.sizeBytes}, durationSeconds: ${_this.durationSeconds}, subjectName: ${_this.subjectName}, teacherName: ${_this.teacherName}, topicTitle: ${_this.topicTitle}, sessionTitle: ${_this.sessionTitle})';
}


}

/// @nodoc
abstract mixin class $OfflineVideoCopyWith<$Res>  {
  factory $OfflineVideoCopyWith(OfflineVideo value, $Res Function(OfflineVideo) _then) = _$OfflineVideoCopyWithImpl;
@useResult
$Res call({
 String licenseId, String videoId, String title, DateTime expiresAt, DateTime downloadedAt, int sizeBytes, int? durationSeconds, String? subjectName, String? teacherName, String? topicTitle, String? sessionTitle
});




}
/// @nodoc
class _$OfflineVideoCopyWithImpl<$Res>
    implements $OfflineVideoCopyWith<$Res> {
  _$OfflineVideoCopyWithImpl(this._self, this._then);

  final OfflineVideo _self;
  final $Res Function(OfflineVideo) _then;

/// Create a copy of OfflineVideo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? licenseId = null,Object? videoId = null,Object? title = null,Object? expiresAt = null,Object? downloadedAt = null,Object? sizeBytes = null,Object? durationSeconds = freezed,Object? subjectName = freezed,Object? teacherName = freezed,Object? topicTitle = freezed,Object? sessionTitle = freezed,}) {
  return _then(OfflineVideo(
licenseId: null == licenseId ? _self.licenseId : licenseId // ignore: cast_nullable_to_non_nullable
as String,videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,downloadedAt: null == downloadedAt ? _self.downloadedAt : downloadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,teacherName: freezed == teacherName ? _self.teacherName : teacherName // ignore: cast_nullable_to_non_nullable
as String?,topicTitle: freezed == topicTitle ? _self.topicTitle : topicTitle // ignore: cast_nullable_to_non_nullable
as String?,sessionTitle: freezed == sessionTitle ? _self.sessionTitle : sessionTitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OfflineVideo].
extension OfflineVideoPatterns on OfflineVideo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OfflineVideo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OfflineVideo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OfflineVideo value)  $default,){
final _that = this;
switch (_that) {
case _OfflineVideo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OfflineVideo value)?  $default,){
final _that = this;
switch (_that) {
case _OfflineVideo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String licenseId,  String videoId,  String title,  DateTime expiresAt,  DateTime downloadedAt,  int sizeBytes,  int? durationSeconds,  String? subjectName,  String? teacherName,  String? topicTitle,  String? sessionTitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OfflineVideo() when $default != null:
return $default(_that.licenseId,_that.videoId,_that.title,_that.expiresAt,_that.downloadedAt,_that.sizeBytes,_that.durationSeconds,_that.subjectName,_that.teacherName,_that.topicTitle,_that.sessionTitle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String licenseId,  String videoId,  String title,  DateTime expiresAt,  DateTime downloadedAt,  int sizeBytes,  int? durationSeconds,  String? subjectName,  String? teacherName,  String? topicTitle,  String? sessionTitle)  $default,) {final _that = this;
switch (_that) {
case _OfflineVideo():
return $default(_that.licenseId,_that.videoId,_that.title,_that.expiresAt,_that.downloadedAt,_that.sizeBytes,_that.durationSeconds,_that.subjectName,_that.teacherName,_that.topicTitle,_that.sessionTitle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String licenseId,  String videoId,  String title,  DateTime expiresAt,  DateTime downloadedAt,  int sizeBytes,  int? durationSeconds,  String? subjectName,  String? teacherName,  String? topicTitle,  String? sessionTitle)?  $default,) {final _that = this;
switch (_that) {
case _OfflineVideo() when $default != null:
return $default(_that.licenseId,_that.videoId,_that.title,_that.expiresAt,_that.downloadedAt,_that.sizeBytes,_that.durationSeconds,_that.subjectName,_that.teacherName,_that.topicTitle,_that.sessionTitle);case _:
  return null;

}
}

}

/// @nodoc


class _OfflineVideo extends OfflineVideo {
  const _OfflineVideo({required this.licenseId, required this.videoId, required this.title, required this.expiresAt, required this.downloadedAt, required this.sizeBytes, this.durationSeconds, this.subjectName, this.teacherName, this.topicTitle, this.sessionTitle}): super._();
  

@override final  String licenseId;
@override final  String videoId;
@override final  String title;
@override final  DateTime expiresAt;
@override final  DateTime downloadedAt;
@override final  int sizeBytes;
@override final  int? durationSeconds;
@override final  String? subjectName;
@override final  String? teacherName;
@override final  String? topicTitle;
@override final  String? sessionTitle;

/// Create a copy of OfflineVideo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfflineVideoCopyWith<_OfflineVideo> get copyWith => __$OfflineVideoCopyWithImpl<_OfflineVideo>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OfflineVideo&&(identical(other.licenseId, licenseId) || other.licenseId == licenseId)&&(identical(other.videoId, videoId) || other.videoId == videoId)&&(identical(other.title, title) || other.title == title)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.downloadedAt, downloadedAt) || other.downloadedAt == downloadedAt)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.teacherName, teacherName) || other.teacherName == teacherName)&&(identical(other.topicTitle, topicTitle) || other.topicTitle == topicTitle)&&(identical(other.sessionTitle, sessionTitle) || other.sessionTitle == sessionTitle));
}


@override
int get hashCode {
    return Object.hash(runtimeType,licenseId,videoId,title,expiresAt,downloadedAt,sizeBytes,durationSeconds,subjectName,teacherName,topicTitle,sessionTitle);
}

@override
String toString() {
    return 'OfflineVideo(licenseId: $licenseId, videoId: $videoId, title: $title, expiresAt: $expiresAt, downloadedAt: $downloadedAt, sizeBytes: $sizeBytes, durationSeconds: $durationSeconds, subjectName: $subjectName, teacherName: $teacherName, topicTitle: $topicTitle, sessionTitle: $sessionTitle)';
}


}

/// @nodoc
abstract mixin class _$OfflineVideoCopyWith<$Res> implements $OfflineVideoCopyWith<$Res> {
  factory _$OfflineVideoCopyWith(_OfflineVideo value, $Res Function(_OfflineVideo) _then) = __$OfflineVideoCopyWithImpl;
@override @useResult
$Res call({
 String licenseId, String videoId, String title, DateTime expiresAt, DateTime downloadedAt, int sizeBytes, int? durationSeconds, String? subjectName, String? teacherName, String? topicTitle, String? sessionTitle
});




}
/// @nodoc
class __$OfflineVideoCopyWithImpl<$Res>
    implements _$OfflineVideoCopyWith<$Res> {
  __$OfflineVideoCopyWithImpl(this._self, this._then);

  final _OfflineVideo _self;
  final $Res Function(_OfflineVideo) _then;

/// Create a copy of OfflineVideo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? licenseId = null,Object? videoId = null,Object? title = null,Object? expiresAt = null,Object? downloadedAt = null,Object? sizeBytes = null,Object? durationSeconds = freezed,Object? subjectName = freezed,Object? teacherName = freezed,Object? topicTitle = freezed,Object? sessionTitle = freezed,}) {
  return _then(_OfflineVideo(
licenseId: null == licenseId ? _self.licenseId : licenseId // ignore: cast_nullable_to_non_nullable
as String,videoId: null == videoId ? _self.videoId : videoId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,downloadedAt: null == downloadedAt ? _self.downloadedAt : downloadedAt // ignore: cast_nullable_to_non_nullable
as DateTime,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,subjectName: freezed == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String?,teacherName: freezed == teacherName ? _self.teacherName : teacherName // ignore: cast_nullable_to_non_nullable
as String?,topicTitle: freezed == topicTitle ? _self.topicTitle : topicTitle // ignore: cast_nullable_to_non_nullable
as String?,sessionTitle: freezed == sessionTitle ? _self.sessionTitle : sessionTitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
