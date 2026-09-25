// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentAccount {

 String get id; String get name; String get phone; String? get gradeName;
/// Create a copy of StudentAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentAccountCopyWith<StudentAccount> get copyWith => _$StudentAccountCopyWithImpl<StudentAccount>(this as StudentAccount, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StudentAccount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentAccount&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.gradeName, _this.gradeName) || other.gradeName == _this.gradeName));
}


@override
int get hashCode {
  final _this = this as StudentAccount;
  return Object.hash(runtimeType,_this.id,_this.name,_this.phone,_this.gradeName);
}

@override
String toString() {
  final _this = this as StudentAccount;
  return 'StudentAccount(id: ${_this.id}, name: ${_this.name}, phone: ${_this.phone}, gradeName: ${_this.gradeName})';
}


}

/// @nodoc
abstract mixin class $StudentAccountCopyWith<$Res>  {
  factory $StudentAccountCopyWith(StudentAccount value, $Res Function(StudentAccount) _then) = _$StudentAccountCopyWithImpl;
@useResult
$Res call({
 String id, String name, String phone, String? gradeName
});




}
/// @nodoc
class _$StudentAccountCopyWithImpl<$Res>
    implements $StudentAccountCopyWith<$Res> {
  _$StudentAccountCopyWithImpl(this._self, this._then);

  final StudentAccount _self;
  final $Res Function(StudentAccount) _then;

/// Create a copy of StudentAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? gradeName = freezed,}) {
  return _then(StudentAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,gradeName: freezed == gradeName ? _self.gradeName : gradeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentAccount].
extension StudentAccountPatterns on StudentAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentAccount value)  $default,){
final _that = this;
switch (_that) {
case _StudentAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentAccount value)?  $default,){
final _that = this;
switch (_that) {
case _StudentAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String phone,  String? gradeName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentAccount() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.gradeName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String phone,  String? gradeName)  $default,) {final _that = this;
switch (_that) {
case _StudentAccount():
return $default(_that.id,_that.name,_that.phone,_that.gradeName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String phone,  String? gradeName)?  $default,) {final _that = this;
switch (_that) {
case _StudentAccount() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.gradeName);case _:
  return null;

}
}

}

/// @nodoc


class _StudentAccount implements StudentAccount {
  const _StudentAccount({required this.id, required this.name, required this.phone, this.gradeName});
  

@override final  String id;
@override final  String name;
@override final  String phone;
@override final  String? gradeName;

/// Create a copy of StudentAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentAccountCopyWith<_StudentAccount> get copyWith => __$StudentAccountCopyWithImpl<_StudentAccount>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.gradeName, gradeName) || other.gradeName == gradeName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,phone,gradeName);
}

@override
String toString() {
    return 'StudentAccount(id: $id, name: $name, phone: $phone, gradeName: $gradeName)';
}


}

/// @nodoc
abstract mixin class _$StudentAccountCopyWith<$Res> implements $StudentAccountCopyWith<$Res> {
  factory _$StudentAccountCopyWith(_StudentAccount value, $Res Function(_StudentAccount) _then) = __$StudentAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String phone, String? gradeName
});




}
/// @nodoc
class __$StudentAccountCopyWithImpl<$Res>
    implements _$StudentAccountCopyWith<$Res> {
  __$StudentAccountCopyWithImpl(this._self, this._then);

  final _StudentAccount _self;
  final $Res Function(_StudentAccount) _then;

/// Create a copy of StudentAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? gradeName = freezed,}) {
  return _then(_StudentAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,gradeName: freezed == gradeName ? _self.gradeName : gradeName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$PublicConfig {

 String get instituteName; bool get selfRegistration; String? get institutePhone;
/// Create a copy of PublicConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicConfigCopyWith<PublicConfig> get copyWith => _$PublicConfigCopyWithImpl<PublicConfig>(this as PublicConfig, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PublicConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicConfig&&(identical(other.instituteName, _this.instituteName) || other.instituteName == _this.instituteName)&&(identical(other.selfRegistration, _this.selfRegistration) || other.selfRegistration == _this.selfRegistration)&&(identical(other.institutePhone, _this.institutePhone) || other.institutePhone == _this.institutePhone));
}


@override
int get hashCode {
  final _this = this as PublicConfig;
  return Object.hash(runtimeType,_this.instituteName,_this.selfRegistration,_this.institutePhone);
}

@override
String toString() {
  final _this = this as PublicConfig;
  return 'PublicConfig(instituteName: ${_this.instituteName}, selfRegistration: ${_this.selfRegistration}, institutePhone: ${_this.institutePhone})';
}


}

/// @nodoc
abstract mixin class $PublicConfigCopyWith<$Res>  {
  factory $PublicConfigCopyWith(PublicConfig value, $Res Function(PublicConfig) _then) = _$PublicConfigCopyWithImpl;
@useResult
$Res call({
 String instituteName, bool selfRegistration, String? institutePhone
});




}
/// @nodoc
class _$PublicConfigCopyWithImpl<$Res>
    implements $PublicConfigCopyWith<$Res> {
  _$PublicConfigCopyWithImpl(this._self, this._then);

  final PublicConfig _self;
  final $Res Function(PublicConfig) _then;

/// Create a copy of PublicConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? instituteName = null,Object? selfRegistration = null,Object? institutePhone = freezed,}) {
  return _then(PublicConfig(
instituteName: null == instituteName ? _self.instituteName : instituteName // ignore: cast_nullable_to_non_nullable
as String,selfRegistration: null == selfRegistration ? _self.selfRegistration : selfRegistration // ignore: cast_nullable_to_non_nullable
as bool,institutePhone: freezed == institutePhone ? _self.institutePhone : institutePhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicConfig].
extension PublicConfigPatterns on PublicConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicConfig value)  $default,){
final _that = this;
switch (_that) {
case _PublicConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PublicConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String instituteName,  bool selfRegistration,  String? institutePhone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicConfig() when $default != null:
return $default(_that.instituteName,_that.selfRegistration,_that.institutePhone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String instituteName,  bool selfRegistration,  String? institutePhone)  $default,) {final _that = this;
switch (_that) {
case _PublicConfig():
return $default(_that.instituteName,_that.selfRegistration,_that.institutePhone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String instituteName,  bool selfRegistration,  String? institutePhone)?  $default,) {final _that = this;
switch (_that) {
case _PublicConfig() when $default != null:
return $default(_that.instituteName,_that.selfRegistration,_that.institutePhone);case _:
  return null;

}
}

}

/// @nodoc


class _PublicConfig implements PublicConfig {
  const _PublicConfig({required this.instituteName, required this.selfRegistration, this.institutePhone});
  

@override final  String instituteName;
@override final  bool selfRegistration;
@override final  String? institutePhone;

/// Create a copy of PublicConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicConfigCopyWith<_PublicConfig> get copyWith => __$PublicConfigCopyWithImpl<_PublicConfig>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicConfig&&(identical(other.instituteName, instituteName) || other.instituteName == instituteName)&&(identical(other.selfRegistration, selfRegistration) || other.selfRegistration == selfRegistration)&&(identical(other.institutePhone, institutePhone) || other.institutePhone == institutePhone));
}


@override
int get hashCode {
    return Object.hash(runtimeType,instituteName,selfRegistration,institutePhone);
}

@override
String toString() {
    return 'PublicConfig(instituteName: $instituteName, selfRegistration: $selfRegistration, institutePhone: $institutePhone)';
}


}

/// @nodoc
abstract mixin class _$PublicConfigCopyWith<$Res> implements $PublicConfigCopyWith<$Res> {
  factory _$PublicConfigCopyWith(_PublicConfig value, $Res Function(_PublicConfig) _then) = __$PublicConfigCopyWithImpl;
@override @useResult
$Res call({
 String instituteName, bool selfRegistration, String? institutePhone
});




}
/// @nodoc
class __$PublicConfigCopyWithImpl<$Res>
    implements _$PublicConfigCopyWith<$Res> {
  __$PublicConfigCopyWithImpl(this._self, this._then);

  final _PublicConfig _self;
  final $Res Function(_PublicConfig) _then;

/// Create a copy of PublicConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? instituteName = null,Object? selfRegistration = null,Object? institutePhone = freezed,}) {
  return _then(_PublicConfig(
instituteName: null == instituteName ? _self.instituteName : instituteName // ignore: cast_nullable_to_non_nullable
as String,selfRegistration: null == selfRegistration ? _self.selfRegistration : selfRegistration // ignore: cast_nullable_to_non_nullable
as bool,institutePhone: freezed == institutePhone ? _self.institutePhone : institutePhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$GradeOption {

 String get id; String get name;
/// Create a copy of GradeOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeOptionCopyWith<GradeOption> get copyWith => _$GradeOptionCopyWithImpl<GradeOption>(this as GradeOption, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GradeOption;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeOption&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name));
}


@override
int get hashCode {
  final _this = this as GradeOption;
  return Object.hash(runtimeType,_this.id,_this.name);
}

@override
String toString() {
  final _this = this as GradeOption;
  return 'GradeOption(id: ${_this.id}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $GradeOptionCopyWith<$Res>  {
  factory $GradeOptionCopyWith(GradeOption value, $Res Function(GradeOption) _then) = _$GradeOptionCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$GradeOptionCopyWithImpl<$Res>
    implements $GradeOptionCopyWith<$Res> {
  _$GradeOptionCopyWithImpl(this._self, this._then);

  final GradeOption _self;
  final $Res Function(GradeOption) _then;

/// Create a copy of GradeOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(GradeOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GradeOption].
extension GradeOptionPatterns on GradeOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeOption value)  $default,){
final _that = this;
switch (_that) {
case _GradeOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeOption value)?  $default,){
final _that = this;
switch (_that) {
case _GradeOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradeOption() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _GradeOption():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _GradeOption() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _GradeOption implements GradeOption {
  const _GradeOption({required this.id, required this.name});
  

@override final  String id;
@override final  String name;

/// Create a copy of GradeOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeOptionCopyWith<_GradeOption> get copyWith => __$GradeOptionCopyWithImpl<_GradeOption>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeOption&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name);
}

@override
String toString() {
    return 'GradeOption(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$GradeOptionCopyWith<$Res> implements $GradeOptionCopyWith<$Res> {
  factory _$GradeOptionCopyWith(_GradeOption value, $Res Function(_GradeOption) _then) = __$GradeOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$GradeOptionCopyWithImpl<$Res>
    implements _$GradeOptionCopyWith<$Res> {
  __$GradeOptionCopyWithImpl(this._self, this._then);

  final _GradeOption _self;
  final $Res Function(_GradeOption) _then;

/// Create a copy of GradeOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_GradeOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
