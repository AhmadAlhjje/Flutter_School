// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InboxNotification {

 String get id; NotificationKind get kind; String get title; String get body; DateTime get createdAt; DateTime? get readAt; String? get sessionId; String? get subjectId;
/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InboxNotificationCopyWith<InboxNotification> get copyWith => _$InboxNotificationCopyWithImpl<InboxNotification>(this as InboxNotification, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InboxNotification;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InboxNotification&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.readAt, _this.readAt) || other.readAt == _this.readAt)&&(identical(other.sessionId, _this.sessionId) || other.sessionId == _this.sessionId)&&(identical(other.subjectId, _this.subjectId) || other.subjectId == _this.subjectId));
}


@override
int get hashCode {
  final _this = this as InboxNotification;
  return Object.hash(runtimeType,_this.id,_this.kind,_this.title,_this.body,_this.createdAt,_this.readAt,_this.sessionId,_this.subjectId);
}

@override
String toString() {
  final _this = this as InboxNotification;
  return 'InboxNotification(id: ${_this.id}, kind: ${_this.kind}, title: ${_this.title}, body: ${_this.body}, createdAt: ${_this.createdAt}, readAt: ${_this.readAt}, sessionId: ${_this.sessionId}, subjectId: ${_this.subjectId})';
}


}

/// @nodoc
abstract mixin class $InboxNotificationCopyWith<$Res>  {
  factory $InboxNotificationCopyWith(InboxNotification value, $Res Function(InboxNotification) _then) = _$InboxNotificationCopyWithImpl;
@useResult
$Res call({
 String id, NotificationKind kind, String title, String body, DateTime createdAt, DateTime? readAt, String? sessionId, String? subjectId
});




}
/// @nodoc
class _$InboxNotificationCopyWithImpl<$Res>
    implements $InboxNotificationCopyWith<$Res> {
  _$InboxNotificationCopyWithImpl(this._self, this._then);

  final InboxNotification _self;
  final $Res Function(InboxNotification) _then;

/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? body = null,Object? createdAt = null,Object? readAt = freezed,Object? sessionId = freezed,Object? subjectId = freezed,}) {
  return _then(InboxNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as NotificationKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InboxNotification].
extension InboxNotificationPatterns on InboxNotification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InboxNotification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InboxNotification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InboxNotification value)  $default,){
final _that = this;
switch (_that) {
case _InboxNotification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InboxNotification value)?  $default,){
final _that = this;
switch (_that) {
case _InboxNotification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  NotificationKind kind,  String title,  String body,  DateTime createdAt,  DateTime? readAt,  String? sessionId,  String? subjectId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InboxNotification() when $default != null:
return $default(_that.id,_that.kind,_that.title,_that.body,_that.createdAt,_that.readAt,_that.sessionId,_that.subjectId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  NotificationKind kind,  String title,  String body,  DateTime createdAt,  DateTime? readAt,  String? sessionId,  String? subjectId)  $default,) {final _that = this;
switch (_that) {
case _InboxNotification():
return $default(_that.id,_that.kind,_that.title,_that.body,_that.createdAt,_that.readAt,_that.sessionId,_that.subjectId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  NotificationKind kind,  String title,  String body,  DateTime createdAt,  DateTime? readAt,  String? sessionId,  String? subjectId)?  $default,) {final _that = this;
switch (_that) {
case _InboxNotification() when $default != null:
return $default(_that.id,_that.kind,_that.title,_that.body,_that.createdAt,_that.readAt,_that.sessionId,_that.subjectId);case _:
  return null;

}
}

}

/// @nodoc


class _InboxNotification extends InboxNotification {
  const _InboxNotification({required this.id, required this.kind, required this.title, required this.body, required this.createdAt, this.readAt, this.sessionId, this.subjectId}): super._();
  

@override final  String id;
@override final  NotificationKind kind;
@override final  String title;
@override final  String body;
@override final  DateTime createdAt;
@override final  DateTime? readAt;
@override final  String? sessionId;
@override final  String? subjectId;

/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InboxNotificationCopyWith<_InboxNotification> get copyWith => __$InboxNotificationCopyWithImpl<_InboxNotification>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InboxNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,kind,title,body,createdAt,readAt,sessionId,subjectId);
}

@override
String toString() {
    return 'InboxNotification(id: $id, kind: $kind, title: $title, body: $body, createdAt: $createdAt, readAt: $readAt, sessionId: $sessionId, subjectId: $subjectId)';
}


}

/// @nodoc
abstract mixin class _$InboxNotificationCopyWith<$Res> implements $InboxNotificationCopyWith<$Res> {
  factory _$InboxNotificationCopyWith(_InboxNotification value, $Res Function(_InboxNotification) _then) = __$InboxNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, NotificationKind kind, String title, String body, DateTime createdAt, DateTime? readAt, String? sessionId, String? subjectId
});




}
/// @nodoc
class __$InboxNotificationCopyWithImpl<$Res>
    implements _$InboxNotificationCopyWith<$Res> {
  __$InboxNotificationCopyWithImpl(this._self, this._then);

  final _InboxNotification _self;
  final $Res Function(_InboxNotification) _then;

/// Create a copy of InboxNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? title = null,Object? body = null,Object? createdAt = null,Object? readAt = freezed,Object? sessionId = freezed,Object? subjectId = freezed,}) {
  return _then(_InboxNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as NotificationKind,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$InboxPage {

 List<InboxNotification> get items; int get page; int get totalPages;
/// Create a copy of InboxPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InboxPageCopyWith<InboxPage> get copyWith => _$InboxPageCopyWithImpl<InboxPage>(this as InboxPage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InboxPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InboxPage&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.totalPages, _this.totalPages) || other.totalPages == _this.totalPages));
}


@override
int get hashCode {
  final _this = this as InboxPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.items),_this.page,_this.totalPages);
}

@override
String toString() {
  final _this = this as InboxPage;
  return 'InboxPage(items: ${_this.items}, page: ${_this.page}, totalPages: ${_this.totalPages})';
}


}

/// @nodoc
abstract mixin class $InboxPageCopyWith<$Res>  {
  factory $InboxPageCopyWith(InboxPage value, $Res Function(InboxPage) _then) = _$InboxPageCopyWithImpl;
@useResult
$Res call({
 List<InboxNotification> items, int page, int totalPages
});




}
/// @nodoc
class _$InboxPageCopyWithImpl<$Res>
    implements $InboxPageCopyWith<$Res> {
  _$InboxPageCopyWithImpl(this._self, this._then);

  final InboxPage _self;
  final $Res Function(InboxPage) _then;

/// Create a copy of InboxPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? page = null,Object? totalPages = null,}) {
  return _then(InboxPage(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<InboxNotification>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [InboxPage].
extension InboxPagePatterns on InboxPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InboxPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InboxPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InboxPage value)  $default,){
final _that = this;
switch (_that) {
case _InboxPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InboxPage value)?  $default,){
final _that = this;
switch (_that) {
case _InboxPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<InboxNotification> items,  int page,  int totalPages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InboxPage() when $default != null:
return $default(_that.items,_that.page,_that.totalPages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<InboxNotification> items,  int page,  int totalPages)  $default,) {final _that = this;
switch (_that) {
case _InboxPage():
return $default(_that.items,_that.page,_that.totalPages);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<InboxNotification> items,  int page,  int totalPages)?  $default,) {final _that = this;
switch (_that) {
case _InboxPage() when $default != null:
return $default(_that.items,_that.page,_that.totalPages);case _:
  return null;

}
}

}

/// @nodoc


class _InboxPage implements InboxPage {
  const _InboxPage({required  List<InboxNotification> items, required this.page, required this.totalPages}): _items = items;
  

 final  List<InboxNotification> _items;
@override List<InboxNotification> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int page;
@override final  int totalPages;

/// Create a copy of InboxPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InboxPageCopyWith<_InboxPage> get copyWith => __$InboxPageCopyWithImpl<_InboxPage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InboxPage&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),page,totalPages);
}

@override
String toString() {
    return 'InboxPage(items: $items, page: $page, totalPages: $totalPages)';
}


}

/// @nodoc
abstract mixin class _$InboxPageCopyWith<$Res> implements $InboxPageCopyWith<$Res> {
  factory _$InboxPageCopyWith(_InboxPage value, $Res Function(_InboxPage) _then) = __$InboxPageCopyWithImpl;
@override @useResult
$Res call({
 List<InboxNotification> items, int page, int totalPages
});




}
/// @nodoc
class __$InboxPageCopyWithImpl<$Res>
    implements _$InboxPageCopyWith<$Res> {
  __$InboxPageCopyWithImpl(this._self, this._then);

  final _InboxPage _self;
  final $Res Function(_InboxPage) _then;

/// Create a copy of InboxPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? page = null,Object? totalPages = null,}) {
  return _then(_InboxPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<InboxNotification>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
