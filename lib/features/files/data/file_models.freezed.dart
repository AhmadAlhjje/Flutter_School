// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FileItemModel {

 String get id; String get title; String get kind; String get extension; String get mimeType; int get sizeBytes;
/// Create a copy of FileItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileItemModelCopyWith<FileItemModel> get copyWith => _$FileItemModelCopyWithImpl<FileItemModel>(this as FileItemModel, _$identity);

  /// Serializes this FileItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FileItemModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileItemModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.extension, _this.extension) || other.extension == _this.extension)&&(identical(other.mimeType, _this.mimeType) || other.mimeType == _this.mimeType)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FileItemModel;
  return Object.hash(runtimeType,_this.id,_this.title,_this.kind,_this.extension,_this.mimeType,_this.sizeBytes);
}

@override
String toString() {
  final _this = this as FileItemModel;
  return 'FileItemModel(id: ${_this.id}, title: ${_this.title}, kind: ${_this.kind}, extension: ${_this.extension}, mimeType: ${_this.mimeType}, sizeBytes: ${_this.sizeBytes})';
}


}

/// @nodoc
abstract mixin class $FileItemModelCopyWith<$Res>  {
  factory $FileItemModelCopyWith(FileItemModel value, $Res Function(FileItemModel) _then) = _$FileItemModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String kind, String extension, String mimeType, int sizeBytes
});




}
/// @nodoc
class _$FileItemModelCopyWithImpl<$Res>
    implements $FileItemModelCopyWith<$Res> {
  _$FileItemModelCopyWithImpl(this._self, this._then);

  final FileItemModel _self;
  final $Res Function(FileItemModel) _then;

/// Create a copy of FileItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? kind = null,Object? extension = null,Object? mimeType = null,Object? sizeBytes = null,}) {
  return _then(FileItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,extension: null == extension ? _self.extension : extension // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FileItemModel].
extension FileItemModelPatterns on FileItemModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileItemModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileItemModel value)  $default,){
final _that = this;
switch (_that) {
case _FileItemModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _FileItemModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String kind,  String extension,  String mimeType,  int sizeBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileItemModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String kind,  String extension,  String mimeType,  int sizeBytes)  $default,) {final _that = this;
switch (_that) {
case _FileItemModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String kind,  String extension,  String mimeType,  int sizeBytes)?  $default,) {final _that = this;
switch (_that) {
case _FileItemModel() when $default != null:
return $default(_that.id,_that.title,_that.kind,_that.extension,_that.mimeType,_that.sizeBytes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FileItemModel extends FileItemModel {
  const _FileItemModel({required this.id, required this.title, required this.kind, required this.extension, required this.mimeType, required this.sizeBytes}): super._();
  factory _FileItemModel.fromJson(Map<String, dynamic> json) => _$FileItemModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String kind;
@override final  String extension;
@override final  String mimeType;
@override final  int sizeBytes;

/// Create a copy of FileItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileItemModelCopyWith<_FileItemModel> get copyWith => __$FileItemModelCopyWithImpl<_FileItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileItemModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.extension, extension) || other.extension == extension)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,title,kind,extension,mimeType,sizeBytes);
}

@override
String toString() {
    return 'FileItemModel(id: $id, title: $title, kind: $kind, extension: $extension, mimeType: $mimeType, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class _$FileItemModelCopyWith<$Res> implements $FileItemModelCopyWith<$Res> {
  factory _$FileItemModelCopyWith(_FileItemModel value, $Res Function(_FileItemModel) _then) = __$FileItemModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String kind, String extension, String mimeType, int sizeBytes
});




}
/// @nodoc
class __$FileItemModelCopyWithImpl<$Res>
    implements _$FileItemModelCopyWith<$Res> {
  __$FileItemModelCopyWithImpl(this._self, this._then);

  final _FileItemModel _self;
  final $Res Function(_FileItemModel) _then;

/// Create a copy of FileItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? kind = null,Object? extension = null,Object? mimeType = null,Object? sizeBytes = null,}) {
  return _then(_FileItemModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,extension: null == extension ? _self.extension : extension // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FileGrantModel {

 String get fileId; String get title; String get kind; String get extension; String get mimeType; String get url; DateTime get expiresAt;
/// Create a copy of FileGrantModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileGrantModelCopyWith<FileGrantModel> get copyWith => _$FileGrantModelCopyWithImpl<FileGrantModel>(this as FileGrantModel, _$identity);

  /// Serializes this FileGrantModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FileGrantModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileGrantModel&&(identical(other.fileId, _this.fileId) || other.fileId == _this.fileId)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.extension, _this.extension) || other.extension == _this.extension)&&(identical(other.mimeType, _this.mimeType) || other.mimeType == _this.mimeType)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FileGrantModel;
  return Object.hash(runtimeType,_this.fileId,_this.title,_this.kind,_this.extension,_this.mimeType,_this.url,_this.expiresAt);
}

@override
String toString() {
  final _this = this as FileGrantModel;
  return 'FileGrantModel(fileId: ${_this.fileId}, title: ${_this.title}, kind: ${_this.kind}, extension: ${_this.extension}, mimeType: ${_this.mimeType}, url: ${_this.url}, expiresAt: ${_this.expiresAt})';
}


}

/// @nodoc
abstract mixin class $FileGrantModelCopyWith<$Res>  {
  factory $FileGrantModelCopyWith(FileGrantModel value, $Res Function(FileGrantModel) _then) = _$FileGrantModelCopyWithImpl;
@useResult
$Res call({
 String fileId, String title, String kind, String extension, String mimeType, String url, DateTime expiresAt
});




}
/// @nodoc
class _$FileGrantModelCopyWithImpl<$Res>
    implements $FileGrantModelCopyWith<$Res> {
  _$FileGrantModelCopyWithImpl(this._self, this._then);

  final FileGrantModel _self;
  final $Res Function(FileGrantModel) _then;

/// Create a copy of FileGrantModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileId = null,Object? title = null,Object? kind = null,Object? extension = null,Object? mimeType = null,Object? url = null,Object? expiresAt = null,}) {
  return _then(FileGrantModel(
fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,extension: null == extension ? _self.extension : extension // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FileGrantModel].
extension FileGrantModelPatterns on FileGrantModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FileGrantModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FileGrantModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FileGrantModel value)  $default,){
final _that = this;
switch (_that) {
case _FileGrantModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FileGrantModel value)?  $default,){
final _that = this;
switch (_that) {
case _FileGrantModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileId,  String title,  String kind,  String extension,  String mimeType,  String url,  DateTime expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FileGrantModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileId,  String title,  String kind,  String extension,  String mimeType,  String url,  DateTime expiresAt)  $default,) {final _that = this;
switch (_that) {
case _FileGrantModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileId,  String title,  String kind,  String extension,  String mimeType,  String url,  DateTime expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _FileGrantModel() when $default != null:
return $default(_that.fileId,_that.title,_that.kind,_that.extension,_that.mimeType,_that.url,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FileGrantModel extends FileGrantModel {
  const _FileGrantModel({required this.fileId, required this.title, required this.kind, required this.extension, required this.mimeType, required this.url, required this.expiresAt}): super._();
  factory _FileGrantModel.fromJson(Map<String, dynamic> json) => _$FileGrantModelFromJson(json);

@override final  String fileId;
@override final  String title;
@override final  String kind;
@override final  String extension;
@override final  String mimeType;
@override final  String url;
@override final  DateTime expiresAt;

/// Create a copy of FileGrantModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileGrantModelCopyWith<_FileGrantModel> get copyWith => __$FileGrantModelCopyWithImpl<_FileGrantModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FileGrantModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileGrantModel&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.title, title) || other.title == title)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.extension, extension) || other.extension == extension)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.url, url) || other.url == url)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,fileId,title,kind,extension,mimeType,url,expiresAt);
}

@override
String toString() {
    return 'FileGrantModel(fileId: $fileId, title: $title, kind: $kind, extension: $extension, mimeType: $mimeType, url: $url, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$FileGrantModelCopyWith<$Res> implements $FileGrantModelCopyWith<$Res> {
  factory _$FileGrantModelCopyWith(_FileGrantModel value, $Res Function(_FileGrantModel) _then) = __$FileGrantModelCopyWithImpl;
@override @useResult
$Res call({
 String fileId, String title, String kind, String extension, String mimeType, String url, DateTime expiresAt
});




}
/// @nodoc
class __$FileGrantModelCopyWithImpl<$Res>
    implements _$FileGrantModelCopyWith<$Res> {
  __$FileGrantModelCopyWithImpl(this._self, this._then);

  final _FileGrantModel _self;
  final $Res Function(_FileGrantModel) _then;

/// Create a copy of FileGrantModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileId = null,Object? title = null,Object? kind = null,Object? extension = null,Object? mimeType = null,Object? url = null,Object? expiresAt = null,}) {
  return _then(_FileGrantModel(
fileId: null == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,extension: null == extension ? _self.extension : extension // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
