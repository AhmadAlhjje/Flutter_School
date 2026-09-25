// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_entities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentProfile {

 String get name; String get phone; int get openSubjectsCount; int get openTeachersCount; String? get gradeName; String? get deviceModel; String? get devicePlatform; DateTime? get deviceBoundAt;
/// Create a copy of StudentProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentProfileCopyWith<StudentProfile> get copyWith => _$StudentProfileCopyWithImpl<StudentProfile>(this as StudentProfile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudentProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentProfile&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.openSubjectsCount, _this.openSubjectsCount) || other.openSubjectsCount == _this.openSubjectsCount)&&(identical(other.openTeachersCount, _this.openTeachersCount) || other.openTeachersCount == _this.openTeachersCount)&&(identical(other.gradeName, _this.gradeName) || other.gradeName == _this.gradeName)&&(identical(other.deviceModel, _this.deviceModel) || other.deviceModel == _this.deviceModel)&&(identical(other.devicePlatform, _this.devicePlatform) || other.devicePlatform == _this.devicePlatform)&&(identical(other.deviceBoundAt, _this.deviceBoundAt) || other.deviceBoundAt == _this.deviceBoundAt));
}


@override
int get hashCode {
  final _this = this as StudentProfile;
  return Object.hash(runtimeType,_this.name,_this.phone,_this.openSubjectsCount,_this.openTeachersCount,_this.gradeName,_this.deviceModel,_this.devicePlatform,_this.deviceBoundAt);
}

@override
String toString() {
  final _this = this as StudentProfile;
  return 'StudentProfile(name: ${_this.name}, phone: ${_this.phone}, openSubjectsCount: ${_this.openSubjectsCount}, openTeachersCount: ${_this.openTeachersCount}, gradeName: ${_this.gradeName}, deviceModel: ${_this.deviceModel}, devicePlatform: ${_this.devicePlatform}, deviceBoundAt: ${_this.deviceBoundAt})';
}


}

/// @nodoc
abstract mixin class $StudentProfileCopyWith<$Res>  {
  factory $StudentProfileCopyWith(StudentProfile value, $Res Function(StudentProfile) _then) = _$StudentProfileCopyWithImpl;
@useResult
$Res call({
 String name, String phone, int openSubjectsCount, int openTeachersCount, String? gradeName, String? deviceModel, String? devicePlatform, DateTime? deviceBoundAt
});




}
/// @nodoc
class _$StudentProfileCopyWithImpl<$Res>
    implements $StudentProfileCopyWith<$Res> {
  _$StudentProfileCopyWithImpl(this._self, this._then);

  final StudentProfile _self;
  final $Res Function(StudentProfile) _then;

/// Create a copy of StudentProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? phone = null,Object? openSubjectsCount = null,Object? openTeachersCount = null,Object? gradeName = freezed,Object? deviceModel = freezed,Object? devicePlatform = freezed,Object? deviceBoundAt = freezed,}) {
  return _then(StudentProfile(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,openSubjectsCount: null == openSubjectsCount ? _self.openSubjectsCount : openSubjectsCount // ignore: cast_nullable_to_non_nullable
as int,openTeachersCount: null == openTeachersCount ? _self.openTeachersCount : openTeachersCount // ignore: cast_nullable_to_non_nullable
as int,gradeName: freezed == gradeName ? _self.gradeName : gradeName // ignore: cast_nullable_to_non_nullable
as String?,deviceModel: freezed == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String?,devicePlatform: freezed == devicePlatform ? _self.devicePlatform : devicePlatform // ignore: cast_nullable_to_non_nullable
as String?,deviceBoundAt: freezed == deviceBoundAt ? _self.deviceBoundAt : deviceBoundAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentProfile].
extension StudentProfilePatterns on StudentProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentProfile value)  $default,){
final _that = this;
switch (_that) {
case _StudentProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentProfile value)?  $default,){
final _that = this;
switch (_that) {
case _StudentProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String phone,  int openSubjectsCount,  int openTeachersCount,  String? gradeName,  String? deviceModel,  String? devicePlatform,  DateTime? deviceBoundAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentProfile() when $default != null:
return $default(_that.name,_that.phone,_that.openSubjectsCount,_that.openTeachersCount,_that.gradeName,_that.deviceModel,_that.devicePlatform,_that.deviceBoundAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String phone,  int openSubjectsCount,  int openTeachersCount,  String? gradeName,  String? deviceModel,  String? devicePlatform,  DateTime? deviceBoundAt)  $default,) {final _that = this;
switch (_that) {
case _StudentProfile():
return $default(_that.name,_that.phone,_that.openSubjectsCount,_that.openTeachersCount,_that.gradeName,_that.deviceModel,_that.devicePlatform,_that.deviceBoundAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String phone,  int openSubjectsCount,  int openTeachersCount,  String? gradeName,  String? deviceModel,  String? devicePlatform,  DateTime? deviceBoundAt)?  $default,) {final _that = this;
switch (_that) {
case _StudentProfile() when $default != null:
return $default(_that.name,_that.phone,_that.openSubjectsCount,_that.openTeachersCount,_that.gradeName,_that.deviceModel,_that.devicePlatform,_that.deviceBoundAt);case _:
  return null;

}
}

}

/// @nodoc


class _StudentProfile implements StudentProfile {
  const _StudentProfile({required this.name, required this.phone, required this.openSubjectsCount, required this.openTeachersCount, this.gradeName, this.deviceModel, this.devicePlatform, this.deviceBoundAt});
  

@override final  String name;
@override final  String phone;
@override final  int openSubjectsCount;
@override final  int openTeachersCount;
@override final  String? gradeName;
@override final  String? deviceModel;
@override final  String? devicePlatform;
@override final  DateTime? deviceBoundAt;

/// Create a copy of StudentProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentProfileCopyWith<_StudentProfile> get copyWith => __$StudentProfileCopyWithImpl<_StudentProfile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentProfile&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.openSubjectsCount, openSubjectsCount) || other.openSubjectsCount == openSubjectsCount)&&(identical(other.openTeachersCount, openTeachersCount) || other.openTeachersCount == openTeachersCount)&&(identical(other.gradeName, gradeName) || other.gradeName == gradeName)&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.devicePlatform, devicePlatform) || other.devicePlatform == devicePlatform)&&(identical(other.deviceBoundAt, deviceBoundAt) || other.deviceBoundAt == deviceBoundAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,phone,openSubjectsCount,openTeachersCount,gradeName,deviceModel,devicePlatform,deviceBoundAt);
}

@override
String toString() {
    return 'StudentProfile(name: $name, phone: $phone, openSubjectsCount: $openSubjectsCount, openTeachersCount: $openTeachersCount, gradeName: $gradeName, deviceModel: $deviceModel, devicePlatform: $devicePlatform, deviceBoundAt: $deviceBoundAt)';
}


}

/// @nodoc
abstract mixin class _$StudentProfileCopyWith<$Res> implements $StudentProfileCopyWith<$Res> {
  factory _$StudentProfileCopyWith(_StudentProfile value, $Res Function(_StudentProfile) _then) = __$StudentProfileCopyWithImpl;
@override @useResult
$Res call({
 String name, String phone, int openSubjectsCount, int openTeachersCount, String? gradeName, String? deviceModel, String? devicePlatform, DateTime? deviceBoundAt
});




}
/// @nodoc
class __$StudentProfileCopyWithImpl<$Res>
    implements _$StudentProfileCopyWith<$Res> {
  __$StudentProfileCopyWithImpl(this._self, this._then);

  final _StudentProfile _self;
  final $Res Function(_StudentProfile) _then;

/// Create a copy of StudentProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? phone = null,Object? openSubjectsCount = null,Object? openTeachersCount = null,Object? gradeName = freezed,Object? deviceModel = freezed,Object? devicePlatform = freezed,Object? deviceBoundAt = freezed,}) {
  return _then(_StudentProfile(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,openSubjectsCount: null == openSubjectsCount ? _self.openSubjectsCount : openSubjectsCount // ignore: cast_nullable_to_non_nullable
as int,openTeachersCount: null == openTeachersCount ? _self.openTeachersCount : openTeachersCount // ignore: cast_nullable_to_non_nullable
as int,gradeName: freezed == gradeName ? _self.gradeName : gradeName // ignore: cast_nullable_to_non_nullable
as String?,deviceModel: freezed == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String?,devicePlatform: freezed == devicePlatform ? _self.devicePlatform : devicePlatform // ignore: cast_nullable_to_non_nullable
as String?,deviceBoundAt: freezed == deviceBoundAt ? _self.deviceBoundAt : deviceBoundAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
