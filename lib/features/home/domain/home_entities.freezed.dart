// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeSummary {

 String get studentName; String get instituteName; int get unreadNotifications; List<SubjectCard> get subjects;
/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSummaryCopyWith<HomeSummary> get copyWith => _$HomeSummaryCopyWithImpl<HomeSummary>(this as HomeSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSummary&&(identical(other.studentName, _this.studentName) || other.studentName == _this.studentName)&&(identical(other.instituteName, _this.instituteName) || other.instituteName == _this.instituteName)&&(identical(other.unreadNotifications, _this.unreadNotifications) || other.unreadNotifications == _this.unreadNotifications)&&const DeepCollectionEquality().equals(other.subjects, _this.subjects));
}


@override
int get hashCode {
  final _this = this as HomeSummary;
  return Object.hash(runtimeType,_this.studentName,_this.instituteName,_this.unreadNotifications,const DeepCollectionEquality().hash(_this.subjects));
}

@override
String toString() {
  final _this = this as HomeSummary;
  return 'HomeSummary(studentName: ${_this.studentName}, instituteName: ${_this.instituteName}, unreadNotifications: ${_this.unreadNotifications}, subjects: ${_this.subjects})';
}


}

/// @nodoc
abstract mixin class $HomeSummaryCopyWith<$Res>  {
  factory $HomeSummaryCopyWith(HomeSummary value, $Res Function(HomeSummary) _then) = _$HomeSummaryCopyWithImpl;
@useResult
$Res call({
 String studentName, String instituteName, int unreadNotifications, List<SubjectCard> subjects
});




}
/// @nodoc
class _$HomeSummaryCopyWithImpl<$Res>
    implements $HomeSummaryCopyWith<$Res> {
  _$HomeSummaryCopyWithImpl(this._self, this._then);

  final HomeSummary _self;
  final $Res Function(HomeSummary) _then;

/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? studentName = null,Object? instituteName = null,Object? unreadNotifications = null,Object? subjects = null,}) {
  return _then(HomeSummary(
studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,instituteName: null == instituteName ? _self.instituteName : instituteName // ignore: cast_nullable_to_non_nullable
as String,unreadNotifications: null == unreadNotifications ? _self.unreadNotifications : unreadNotifications // ignore: cast_nullable_to_non_nullable
as int,subjects: null == subjects ? _self.subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<SubjectCard>,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeSummary].
extension HomeSummaryPatterns on HomeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeSummary value)  $default,){
final _that = this;
switch (_that) {
case _HomeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String studentName,  String instituteName,  int unreadNotifications,  List<SubjectCard> subjects)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
return $default(_that.studentName,_that.instituteName,_that.unreadNotifications,_that.subjects);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String studentName,  String instituteName,  int unreadNotifications,  List<SubjectCard> subjects)  $default,) {final _that = this;
switch (_that) {
case _HomeSummary():
return $default(_that.studentName,_that.instituteName,_that.unreadNotifications,_that.subjects);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String studentName,  String instituteName,  int unreadNotifications,  List<SubjectCard> subjects)?  $default,) {final _that = this;
switch (_that) {
case _HomeSummary() when $default != null:
return $default(_that.studentName,_that.instituteName,_that.unreadNotifications,_that.subjects);case _:
  return null;

}
}

}

/// @nodoc


class _HomeSummary implements HomeSummary {
  const _HomeSummary({required this.studentName, required this.instituteName, required this.unreadNotifications, required  List<SubjectCard> subjects}): _subjects = subjects;
  

@override final  String studentName;
@override final  String instituteName;
@override final  int unreadNotifications;
 final  List<SubjectCard> _subjects;
@override List<SubjectCard> get subjects {
  if (_subjects is EqualUnmodifiableListView) return _subjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subjects);
}


/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeSummaryCopyWith<_HomeSummary> get copyWith => __$HomeSummaryCopyWithImpl<_HomeSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeSummary&&(identical(other.studentName, studentName) || other.studentName == studentName)&&(identical(other.instituteName, instituteName) || other.instituteName == instituteName)&&(identical(other.unreadNotifications, unreadNotifications) || other.unreadNotifications == unreadNotifications)&&const DeepCollectionEquality().equals(other.subjects, _subjects));
}


@override
int get hashCode {
    return Object.hash(runtimeType,studentName,instituteName,unreadNotifications,const DeepCollectionEquality().hash(_subjects));
}

@override
String toString() {
    return 'HomeSummary(studentName: $studentName, instituteName: $instituteName, unreadNotifications: $unreadNotifications, subjects: $subjects)';
}


}

/// @nodoc
abstract mixin class _$HomeSummaryCopyWith<$Res> implements $HomeSummaryCopyWith<$Res> {
  factory _$HomeSummaryCopyWith(_HomeSummary value, $Res Function(_HomeSummary) _then) = __$HomeSummaryCopyWithImpl;
@override @useResult
$Res call({
 String studentName, String instituteName, int unreadNotifications, List<SubjectCard> subjects
});




}
/// @nodoc
class __$HomeSummaryCopyWithImpl<$Res>
    implements _$HomeSummaryCopyWith<$Res> {
  __$HomeSummaryCopyWithImpl(this._self, this._then);

  final _HomeSummary _self;
  final $Res Function(_HomeSummary) _then;

/// Create a copy of HomeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? studentName = null,Object? instituteName = null,Object? unreadNotifications = null,Object? subjects = null,}) {
  return _then(_HomeSummary(
studentName: null == studentName ? _self.studentName : studentName // ignore: cast_nullable_to_non_nullable
as String,instituteName: null == instituteName ? _self.instituteName : instituteName // ignore: cast_nullable_to_non_nullable
as String,unreadNotifications: null == unreadNotifications ? _self.unreadNotifications : unreadNotifications // ignore: cast_nullable_to_non_nullable
as int,subjects: null == subjects ? _self._subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<SubjectCard>,
  ));
}


}

// dart format on
