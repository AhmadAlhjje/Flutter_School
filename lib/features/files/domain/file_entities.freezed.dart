// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FileItem {

 String get id; String get title; FileKind get kind; String get extension; String get mimeType; int get sizeBytes;
/// Create a copy of FileItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileItemCopyWith<FileItem> get copyWith => _$FileItemCopyWithImpl<FileItem>(this as FileItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FileItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.extension, _this.extension) || other.extension == _this.extension)&&(identical(other.mimeType, _this.mimeType) || other.mimeType == _this.mimeType)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes));
}


@override
int get hashCode {
  final _this = this as FileItem;
  return Object.hash(runtimeType,_this.id,_this.title,_this.kind,_this.extension,_this.mimeType,_this.sizeBytes);
}

@override
String toString() {
  final _this = this as FileItem;
  return 'FileItem(id: ${_this.id}, title: ${_this.title}, kind: ${_this.kind}, extension: ${_this.extension}, mimeType: ${_this.mimeType}, sizeBytes: ${_this.sizeBytes})';
}


}

/// @nodoc
abstract mixin class $FileItemCopyWith<$Res>  {
  factory $FileItemCopyWith(FileItem value, $Res Function(FileItem) _then) = _$FileItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, FileKind kind, String extension, String mimeType, int sizeBytes
});




}
/// @nodoc
class _$FileItemCopyWithImpl<$Res>
    implements $FileItemCopyWith<$Res> {
  _$FileItemCopyWithImpl(this._self, this._then);

  final FileItem _self;
  final $Res Function(FileItem) _then;

/// Create a copy of FileItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? kind = null,Object? extension = null,Object? mimeType = null,Object? sizeBytes = null,}) {
  return _then(FileItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as FileKind,extension: null == extension ? _self.extension : extension // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FileItem].
extension FileItemPatterns on FileItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileItem value)  $default,){
final _that = this;
switch (_that) {
case _FileItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileItem value)?  $default,){
final _that = this;
switch (_that) {
case _FileItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  FileKind kind,  String extension,  String mimeType,  int sizeBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileItem() when $default != null:
return $default(_that.id,_that.title,_that.kind,_that.extension,_that.mimeType,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  FileKind kind,  String extension,  String mimeType,  int sizeBytes)  $default,) {final _that = this;
switch (_that) {
case _FileItem():
return $default(_that.id,_that.title,_that.kind,_that.extension,_that.mimeType,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  FileKind kind,  String extension,  String mimeType,  int sizeBytes)?  $default,) {final _that = this;
switch (_that) {
case _FileItem() when $default != null:
return $default(_that.id,_that.title,_that.kind,_that.extension,_that.mimeType,_that.sizeBytes);case _:
  return null;

}
}

}

/// @nodoc


class _FileItem implements FileItem {
  const _FileItem({required this.id, required this.title, required this.kind, required this.extension, required this.mimeType, required this.sizeBytes});
  

@override final  String id;
@override final  String title;
@override final  FileKind kind;
@override final  String extension;
@override final  String mimeType;
@override final  int sizeBytes;

/// Create a copy of FileItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileItemCopyWith<_FileItem> get copyWith => __$FileItemCopyWithImpl<_FileItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.extension, extension) || other.extension == extension)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,kind,extension,mimeType,sizeBytes);
}

@override
String toString() {
    return 'FileItem(id: $id, title: $title, kind: $kind, extension: $extension, mimeType: $mimeType, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class _$FileItemCopyWith<$Res> implements $FileItemCopyWith<$Res> {
  factory _$FileItemCopyWith(_FileItem value, $Res Function(_FileItem) _then) = __$FileItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, FileKind kind, String extension, String mimeType, int sizeBytes
});




}
/// @nodoc
class __$FileItemCopyWithImpl<$Res>
    implements _$FileItemCopyWith<$Res> {
  __$FileItemCopyWithImpl(this._self, this._then);

  final _FileItem _self;
  final $Res Function(_FileItem) _then;

/// Create a copy of FileItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? kind = null,Object? extension = null,Object? mimeType = null,Object? sizeBytes = null,}) {
  return _then(_FileItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as FileKind,extension: null == extension ? _self.extension : extension // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$FileGrant {

 String get fileId; String get title; FileKind get kind; String get extension; String get mimeType; String get url; DateTime get expiresAt;
/// Create a copy of FileGrant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileGrantCopyWith<FileGrant> get copyWith => _$FileGrantCopyWithImpl<FileGrant>(this as FileGrant, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FileGrant;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileGrant&&(identical(other.fileId, _this.fileId) || other.fileId == _this.fileId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.extension, _this.extension) || other.extension == _this.extension)&&(identical(other.mimeType, _this.mimeType) || other.mimeType == _this.mimeType)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt));
}


@override
int get hashCode {
  final _this = this as FileGrant;
  return Object.hash(runtimeType,_this.fileId,_this.title,_this.kind,_this.extension,_this.mimeType,_this.url,_this.expiresAt);
}

@override
String toString() {
  final _this = this as FileGrant;
  return 'FileGrant(fileId: ${_this.fileId}, title: ${_this.title}, kind: ${_this.kind}, extension: ${_this.extension}, mimeType: ${_this.mimeType}, url: ${_this.url}, expiresAt: ${_this.expiresAt})';
}


}

/// @nodoc
abstract mixin class $FileGrantCopyWith<$Res>  {
  factory $FileGrantCopyWith(FileGrant value, $Res Function(FileGrant) _then) = _$FileGrantCopyWithImpl;
@useResult
$Res call({
 String fileId, String title, FileKind kind, String extension, String mimeType, String url, DateTime expiresAt
});




}
/// @nodoc
class _$FileGrantCopyWithImpl<$Res>
    implements $FileGrantCopyWith<$Res> {
  _$FileGrantCopyWithImpl(this._self, this._then);

  final FileGrant _self;
  final $Res Function(FileGrant) _then;

/// Create a copy of FileGrant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileId = null,Object? title = null,Object? kind = null,Object? extension = null,Object? mimeType = null,Object? url = null,Object? expiresAt = null,}) {
  return _then(FileGrant(
fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as FileKind,extension: null == extension ? _self.extension : extension // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FileGrant].
extension FileGrantPatterns on FileGrant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileGrant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileGrant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileGrant value)  $default,){
final _that = this;
switch (_that) {
case _FileGrant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileGrant value)?  $default,){
final _that = this;
switch (_that) {
case _FileGrant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileId,  String title,  FileKind kind,  String extension,  String mimeType,  String url,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileGrant() when $default != null:
return $default(_that.fileId,_that.title,_that.kind,_that.extension,_that.mimeType,_that.url,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileId,  String title,  FileKind kind,  String extension,  String mimeType,  String url,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _FileGrant():
return $default(_that.fileId,_that.title,_that.kind,_that.extension,_that.mimeType,_that.url,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileId,  String title,  FileKind kind,  String extension,  String mimeType,  String url,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _FileGrant() when $default != null:
return $default(_that.fileId,_that.title,_that.kind,_that.extension,_that.mimeType,_that.url,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc


class _FileGrant implements FileGrant {
  const _FileGrant({required this.fileId, required this.title, required this.kind, required this.extension, required this.mimeType, required this.url, required this.expiresAt});
  

@override final  String fileId;
@override final  String title;
@override final  FileKind kind;
@override final  String extension;
@override final  String mimeType;
@override final  String url;
@override final  DateTime expiresAt;

/// Create a copy of FileGrant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileGrantCopyWith<_FileGrant> get copyWith => __$FileGrantCopyWithImpl<_FileGrant>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileGrant&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.title, title) || other.title == title)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.extension, extension) || other.extension == extension)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.url, url) || other.url == url)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,fileId,title,kind,extension,mimeType,url,expiresAt);
}

@override
String toString() {
    return 'FileGrant(fileId: $fileId, title: $title, kind: $kind, extension: $extension, mimeType: $mimeType, url: $url, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$FileGrantCopyWith<$Res> implements $FileGrantCopyWith<$Res> {
  factory _$FileGrantCopyWith(_FileGrant value, $Res Function(_FileGrant) _then) = __$FileGrantCopyWithImpl;
@override @useResult
$Res call({
 String fileId, String title, FileKind kind, String extension, String mimeType, String url, DateTime expiresAt
});




}
/// @nodoc
class __$FileGrantCopyWithImpl<$Res>
    implements _$FileGrantCopyWith<$Res> {
  __$FileGrantCopyWithImpl(this._self, this._then);

  final _FileGrant _self;
  final $Res Function(_FileGrant) _then;

/// Create a copy of FileGrant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileId = null,Object? title = null,Object? kind = null,Object? extension = null,Object? mimeType = null,Object? url = null,Object? expiresAt = null,}) {
  return _then(_FileGrant(
fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as FileKind,extension: null == extension ? _self.extension : extension // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
