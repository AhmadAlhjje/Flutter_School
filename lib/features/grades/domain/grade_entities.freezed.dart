// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grade_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GradeSummary {

 String get id; String get name; int get subjectsCount;
/// Create a copy of GradeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeSummaryCopyWith<GradeSummary> get copyWith => _$GradeSummaryCopyWithImpl<GradeSummary>(this as GradeSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GradeSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.subjectsCount, _this.subjectsCount) || other.subjectsCount == _this.subjectsCount));
}


@override
int get hashCode {
  final _this = this as GradeSummary;
  return Object.hash(runtimeType,_this.id,_this.name,_this.subjectsCount);
}

@override
String toString() {
  final _this = this as GradeSummary;
  return 'GradeSummary(id: ${_this.id}, name: ${_this.name}, subjectsCount: ${_this.subjectsCount})';
}


}

/// @nodoc
abstract mixin class $GradeSummaryCopyWith<$Res>  {
  factory $GradeSummaryCopyWith(GradeSummary value, $Res Function(GradeSummary) _then) = _$GradeSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String name, int subjectsCount
});




}
/// @nodoc
class _$GradeSummaryCopyWithImpl<$Res>
    implements $GradeSummaryCopyWith<$Res> {
  _$GradeSummaryCopyWithImpl(this._self, this._then);

  final GradeSummary _self;
  final $Res Function(GradeSummary) _then;

/// Create a copy of GradeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? subjectsCount = null,}) {
  return _then(GradeSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,subjectsCount: null == subjectsCount ? _self.subjectsCount : subjectsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GradeSummary].
extension GradeSummaryPatterns on GradeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeSummary value)  $default,){
final _that = this;
switch (_that) {
case _GradeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _GradeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int subjectsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeSummary() when $default != null:
return $default(_that.id,_that.name,_that.subjectsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int subjectsCount)  $default,) {final _that = this;
switch (_that) {
case _GradeSummary():
return $default(_that.id,_that.name,_that.subjectsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int subjectsCount)?  $default,) {final _that = this;
switch (_that) {
case _GradeSummary() when $default != null:
return $default(_that.id,_that.name,_that.subjectsCount);case _:
  return null;

}
}

}

/// @nodoc


class _GradeSummary implements GradeSummary {
  const _GradeSummary({required this.id, required this.name, required this.subjectsCount});
  

@override final  String id;
@override final  String name;
@override final  int subjectsCount;

/// Create a copy of GradeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeSummaryCopyWith<_GradeSummary> get copyWith => __$GradeSummaryCopyWithImpl<_GradeSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.subjectsCount, subjectsCount) || other.subjectsCount == subjectsCount));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,subjectsCount);
}

@override
String toString() {
    return 'GradeSummary(id: $id, name: $name, subjectsCount: $subjectsCount)';
}


}

/// @nodoc
abstract mixin class _$GradeSummaryCopyWith<$Res> implements $GradeSummaryCopyWith<$Res> {
  factory _$GradeSummaryCopyWith(_GradeSummary value, $Res Function(_GradeSummary) _then) = __$GradeSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int subjectsCount
});




}
/// @nodoc
class __$GradeSummaryCopyWithImpl<$Res>
    implements _$GradeSummaryCopyWith<$Res> {
  __$GradeSummaryCopyWithImpl(this._self, this._then);

  final _GradeSummary _self;
  final $Res Function(_GradeSummary) _then;

/// Create a copy of GradeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? subjectsCount = null,}) {
  return _then(_GradeSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,subjectsCount: null == subjectsCount ? _self.subjectsCount : subjectsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$GradeSubjects {

 String get gradeId; String get gradeName; List<SubjectCard> get subjects;
/// Create a copy of GradeSubjects
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeSubjectsCopyWith<GradeSubjects> get copyWith => _$GradeSubjectsCopyWithImpl<GradeSubjects>(this as GradeSubjects, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GradeSubjects;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeSubjects&&(identical(other.gradeId, _this.gradeId) || other.gradeId == _this.gradeId)&&(identical(other.gradeName, _this.gradeName) || other.gradeName == _this.gradeName)&&const DeepCollectionEquality().equals(other.subjects, _this.subjects));
}


@override
int get hashCode {
  final _this = this as GradeSubjects;
  return Object.hash(runtimeType,_this.gradeId,_this.gradeName,const DeepCollectionEquality().hash(_this.subjects));
}

@override
String toString() {
  final _this = this as GradeSubjects;
  return 'GradeSubjects(gradeId: ${_this.gradeId}, gradeName: ${_this.gradeName}, subjects: ${_this.subjects})';
}


}

/// @nodoc
abstract mixin class $GradeSubjectsCopyWith<$Res>  {
  factory $GradeSubjectsCopyWith(GradeSubjects value, $Res Function(GradeSubjects) _then) = _$GradeSubjectsCopyWithImpl;
@useResult
$Res call({
 String gradeId, String gradeName, List<SubjectCard> subjects
});




}
/// @nodoc
class _$GradeSubjectsCopyWithImpl<$Res>
    implements $GradeSubjectsCopyWith<$Res> {
  _$GradeSubjectsCopyWithImpl(this._self, this._then);

  final GradeSubjects _self;
  final $Res Function(GradeSubjects) _then;

/// Create a copy of GradeSubjects
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gradeId = null,Object? gradeName = null,Object? subjects = null,}) {
  return _then(GradeSubjects(
gradeId: null == gradeId ? _self.gradeId : gradeId // ignore: cast_nullable_to_non_nullable
as String,gradeName: null == gradeName ? _self.gradeName : gradeName // ignore: cast_nullable_to_non_nullable
as String,subjects: null == subjects ? _self.subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<SubjectCard>,
  ));
}

}


/// Adds pattern-matching-related methods to [GradeSubjects].
extension GradeSubjectsPatterns on GradeSubjects {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeSubjects value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeSubjects() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeSubjects value)  $default,){
final _that = this;
switch (_that) {
case _GradeSubjects():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeSubjects value)?  $default,){
final _that = this;
switch (_that) {
case _GradeSubjects() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String gradeId,  String gradeName,  List<SubjectCard> subjects)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeSubjects() when $default != null:
return $default(_that.gradeId,_that.gradeName,_that.subjects);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String gradeId,  String gradeName,  List<SubjectCard> subjects)  $default,) {final _that = this;
switch (_that) {
case _GradeSubjects():
return $default(_that.gradeId,_that.gradeName,_that.subjects);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String gradeId,  String gradeName,  List<SubjectCard> subjects)?  $default,) {final _that = this;
switch (_that) {
case _GradeSubjects() when $default != null:
return $default(_that.gradeId,_that.gradeName,_that.subjects);case _:
  return null;

}
}

}

/// @nodoc


class _GradeSubjects implements GradeSubjects {
  const _GradeSubjects({required this.gradeId, required this.gradeName, required  List<SubjectCard> subjects}): _subjects = subjects;
  

@override final  String gradeId;
@override final  String gradeName;
 final  List<SubjectCard> _subjects;
@override List<SubjectCard> get subjects {
  if (_subjects is EqualUnmodifiableListView) return _subjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subjects);
}


/// Create a copy of GradeSubjects
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeSubjectsCopyWith<_GradeSubjects> get copyWith => __$GradeSubjectsCopyWithImpl<_GradeSubjects>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeSubjects&&(identical(other.gradeId, gradeId) || other.gradeId == gradeId)&&(identical(other.gradeName, gradeName) || other.gradeName == gradeName)&&const DeepCollectionEquality().equals(other.subjects, _subjects));
}


@override
int get hashCode {
    return Object.hash(runtimeType,gradeId,gradeName,const DeepCollectionEquality().hash(_subjects));
}

@override
String toString() {
    return 'GradeSubjects(gradeId: $gradeId, gradeName: $gradeName, subjects: $subjects)';
}


}

/// @nodoc
abstract mixin class _$GradeSubjectsCopyWith<$Res> implements $GradeSubjectsCopyWith<$Res> {
  factory _$GradeSubjectsCopyWith(_GradeSubjects value, $Res Function(_GradeSubjects) _then) = __$GradeSubjectsCopyWithImpl;
@override @useResult
$Res call({
 String gradeId, String gradeName, List<SubjectCard> subjects
});




}
/// @nodoc
class __$GradeSubjectsCopyWithImpl<$Res>
    implements _$GradeSubjectsCopyWith<$Res> {
  __$GradeSubjectsCopyWithImpl(this._self, this._then);

  final _GradeSubjects _self;
  final $Res Function(_GradeSubjects) _then;

/// Create a copy of GradeSubjects
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gradeId = null,Object? gradeName = null,Object? subjects = null,}) {
  return _then(_GradeSubjects(
gradeId: null == gradeId ? _self.gradeId : gradeId // ignore: cast_nullable_to_non_nullable
as String,gradeName: null == gradeName ? _self.gradeName : gradeName // ignore: cast_nullable_to_non_nullable
as String,subjects: null == subjects ? _self._subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<SubjectCard>,
  ));
}


}

// dart format on
