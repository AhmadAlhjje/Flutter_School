// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountModel {

 String get id; String get name; String get phone; GradeRefModel? get grade;
/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountModelCopyWith<AccountModel> get copyWith => _$AccountModelCopyWithImpl<AccountModel>(this as AccountModel, _$identity);

  /// Serializes this AccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AccountModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.grade, _this.grade) || other.grade == _this.grade));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AccountModel;
  return Object.hash(runtimeType,_this.id,_this.name,_this.phone,_this.grade);
}

@override
String toString() {
  final _this = this as AccountModel;
  return 'AccountModel(id: ${_this.id}, name: ${_this.name}, phone: ${_this.phone}, grade: ${_this.grade})';
}


}

/// @nodoc
abstract mixin class $AccountModelCopyWith<$Res>  {
  factory $AccountModelCopyWith(AccountModel value, $Res Function(AccountModel) _then) = _$AccountModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String phone, GradeRefModel? grade
});


$GradeRefModelCopyWith<$Res>? get grade;

}
/// @nodoc
class _$AccountModelCopyWithImpl<$Res>
    implements $AccountModelCopyWith<$Res> {
  _$AccountModelCopyWithImpl(this._self, this._then);

  final AccountModel _self;
  final $Res Function(AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? grade = freezed,}) {
  return _then(AccountModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as GradeRefModel?,
  ));
}
/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GradeRefModelCopyWith<$Res>? get grade {
    if (_self.grade == null) {
    return null;
  }

  return $GradeRefModelCopyWith<$Res>(_self.grade!, (value) {
    return _then(_self.copyWith(grade: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountModel].
extension AccountModelPatterns on AccountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountModel value)  $default,){
final _that = this;
switch (_that) {
case _AccountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String phone,  GradeRefModel? grade)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.grade);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String phone,  GradeRefModel? grade)  $default,) {final _that = this;
switch (_that) {
case _AccountModel():
return $default(_that.id,_that.name,_that.phone,_that.grade);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String phone,  GradeRefModel? grade)?  $default,) {final _that = this;
switch (_that) {
case _AccountModel() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.grade);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountModel extends AccountModel {
  const _AccountModel({required this.id, required this.name, required this.phone, this.grade}): super._();
  factory _AccountModel.fromJson(Map<String, dynamic> json) => _$AccountModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String phone;
@override final  GradeRefModel? grade;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountModelCopyWith<_AccountModel> get copyWith => __$AccountModelCopyWithImpl<_AccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.grade, grade) || other.grade == grade));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,phone,grade);
}

@override
String toString() {
    return 'AccountModel(id: $id, name: $name, phone: $phone, grade: $grade)';
}


}

/// @nodoc
abstract mixin class _$AccountModelCopyWith<$Res> implements $AccountModelCopyWith<$Res> {
  factory _$AccountModelCopyWith(_AccountModel value, $Res Function(_AccountModel) _then) = __$AccountModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String phone, GradeRefModel? grade
});


@override $GradeRefModelCopyWith<$Res>? get grade;

}
/// @nodoc
class __$AccountModelCopyWithImpl<$Res>
    implements _$AccountModelCopyWith<$Res> {
  __$AccountModelCopyWithImpl(this._self, this._then);

  final _AccountModel _self;
  final $Res Function(_AccountModel) _then;

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? grade = freezed,}) {
  return _then(_AccountModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as GradeRefModel?,
  ));
}

/// Create a copy of AccountModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GradeRefModelCopyWith<$Res>? get grade {
    if (_self.grade == null) {
    return null;
  }

  return $GradeRefModelCopyWith<$Res>(_self.grade!, (value) {
    return _then(_self.copyWith(grade: value));
  });
}
}


/// @nodoc
mixin _$GradeRefModel {

 String get id; String get name;
/// Create a copy of GradeRefModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradeRefModelCopyWith<GradeRefModel> get copyWith => _$GradeRefModelCopyWithImpl<GradeRefModel>(this as GradeRefModel, _$identity);

  /// Serializes this GradeRefModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as GradeRefModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradeRefModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as GradeRefModel;
  return Object.hash(runtimeType,_this.id,_this.name);
}

@override
String toString() {
  final _this = this as GradeRefModel;
  return 'GradeRefModel(id: ${_this.id}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $GradeRefModelCopyWith<$Res>  {
  factory $GradeRefModelCopyWith(GradeRefModel value, $Res Function(GradeRefModel) _then) = _$GradeRefModelCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$GradeRefModelCopyWithImpl<$Res>
    implements $GradeRefModelCopyWith<$Res> {
  _$GradeRefModelCopyWithImpl(this._self, this._then);

  final GradeRefModel _self;
  final $Res Function(GradeRefModel) _then;

/// Create a copy of GradeRefModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(GradeRefModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GradeRefModel].
extension GradeRefModelPatterns on GradeRefModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradeRefModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradeRefModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradeRefModel value)  $default,){
final _that = this;
switch (_that) {
case _GradeRefModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradeRefModel value)?  $default,){
final _that = this;
switch (_that) {
case _GradeRefModel() when $default != null:
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
case _GradeRefModel() when $default != null:
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
case _GradeRefModel():
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
case _GradeRefModel() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradeRefModel implements GradeRefModel {
  const _GradeRefModel({required this.id, required this.name});
  factory _GradeRefModel.fromJson(Map<String, dynamic> json) => _$GradeRefModelFromJson(json);

@override final  String id;
@override final  String name;

/// Create a copy of GradeRefModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradeRefModelCopyWith<_GradeRefModel> get copyWith => __$GradeRefModelCopyWithImpl<_GradeRefModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradeRefModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradeRefModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name);
}

@override
String toString() {
    return 'GradeRefModel(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$GradeRefModelCopyWith<$Res> implements $GradeRefModelCopyWith<$Res> {
  factory _$GradeRefModelCopyWith(_GradeRefModel value, $Res Function(_GradeRefModel) _then) = __$GradeRefModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$GradeRefModelCopyWithImpl<$Res>
    implements _$GradeRefModelCopyWith<$Res> {
  __$GradeRefModelCopyWithImpl(this._self, this._then);

  final _GradeRefModel _self;
  final $Res Function(_GradeRefModel) _then;

/// Create a copy of GradeRefModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_GradeRefModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AppSessionModel {

 String get accessToken; String get refreshToken; AccountModel? get user;
/// Create a copy of AppSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSessionModelCopyWith<AppSessionModel> get copyWith => _$AppSessionModelCopyWithImpl<AppSessionModel>(this as AppSessionModel, _$identity);

  /// Serializes this AppSessionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AppSessionModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSessionModel&&(identical(other.accessToken, _this.accessToken) || other.accessToken == _this.accessToken)&&(identical(other.refreshToken, _this.refreshToken) || other.refreshToken == _this.refreshToken)&&(identical(other.user, _this.user) || other.user == _this.user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AppSessionModel;
  return Object.hash(runtimeType,_this.accessToken,_this.refreshToken,_this.user);
}

@override
String toString() {
  final _this = this as AppSessionModel;
  return 'AppSessionModel(accessToken: ${_this.accessToken}, refreshToken: ${_this.refreshToken}, user: ${_this.user})';
}


}

/// @nodoc
abstract mixin class $AppSessionModelCopyWith<$Res>  {
  factory $AppSessionModelCopyWith(AppSessionModel value, $Res Function(AppSessionModel) _then) = _$AppSessionModelCopyWithImpl;
@useResult
$Res call({
 String accessToken, String refreshToken, AccountModel? user
});


$AccountModelCopyWith<$Res>? get user;

}
/// @nodoc
class _$AppSessionModelCopyWithImpl<$Res>
    implements $AppSessionModelCopyWith<$Res> {
  _$AppSessionModelCopyWithImpl(this._self, this._then);

  final AppSessionModel _self;
  final $Res Function(AppSessionModel) _then;

/// Create a copy of AppSessionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? refreshToken = null,Object? user = freezed,}) {
  return _then(AppSessionModel(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AccountModel?,
  ));
}
/// Create a copy of AppSessionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AccountModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppSessionModel].
extension AppSessionModelPatterns on AppSessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSessionModel value)  $default,){
final _that = this;
switch (_that) {
case _AppSessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _AppSessionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken,  String refreshToken,  AccountModel? user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSessionModel() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken,  String refreshToken,  AccountModel? user)  $default,) {final _that = this;
switch (_that) {
case _AppSessionModel():
return $default(_that.accessToken,_that.refreshToken,_that.user);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken,  String refreshToken,  AccountModel? user)?  $default,) {final _that = this;
switch (_that) {
case _AppSessionModel() when $default != null:
return $default(_that.accessToken,_that.refreshToken,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppSessionModel implements AppSessionModel {
  const _AppSessionModel({required this.accessToken, required this.refreshToken, this.user});
  factory _AppSessionModel.fromJson(Map<String, dynamic> json) => _$AppSessionModelFromJson(json);

@override final  String accessToken;
@override final  String refreshToken;
@override final  AccountModel? user;

/// Create a copy of AppSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSessionModelCopyWith<_AppSessionModel> get copyWith => __$AppSessionModelCopyWithImpl<_AppSessionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppSessionModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSessionModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,accessToken,refreshToken,user);
}

@override
String toString() {
    return 'AppSessionModel(accessToken: $accessToken, refreshToken: $refreshToken, user: $user)';
}


}

/// @nodoc
abstract mixin class _$AppSessionModelCopyWith<$Res> implements $AppSessionModelCopyWith<$Res> {
  factory _$AppSessionModelCopyWith(_AppSessionModel value, $Res Function(_AppSessionModel) _then) = __$AppSessionModelCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, String refreshToken, AccountModel? user
});


@override $AccountModelCopyWith<$Res>? get user;

}
/// @nodoc
class __$AppSessionModelCopyWithImpl<$Res>
    implements _$AppSessionModelCopyWith<$Res> {
  __$AppSessionModelCopyWithImpl(this._self, this._then);

  final _AppSessionModel _self;
  final $Res Function(_AppSessionModel) _then;

/// Create a copy of AppSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,Object? user = freezed,}) {
  return _then(_AppSessionModel(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AccountModel?,
  ));
}

/// Create a copy of AppSessionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountModelCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $AccountModelCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$PublicConfigModel {

 String get instituteName; bool get studentSelfRegistration; String? get institutePhone;
/// Create a copy of PublicConfigModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicConfigModelCopyWith<PublicConfigModel> get copyWith => _$PublicConfigModelCopyWithImpl<PublicConfigModel>(this as PublicConfigModel, _$identity);

  /// Serializes this PublicConfigModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PublicConfigModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicConfigModel&&(identical(other.instituteName, _this.instituteName) || other.instituteName == _this.instituteName)&&(identical(other.studentSelfRegistration, _this.studentSelfRegistration) || other.studentSelfRegistration == _this.studentSelfRegistration)&&(identical(other.institutePhone, _this.institutePhone) || other.institutePhone == _this.institutePhone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PublicConfigModel;
  return Object.hash(runtimeType,_this.instituteName,_this.studentSelfRegistration,_this.institutePhone);
}

@override
String toString() {
  final _this = this as PublicConfigModel;
  return 'PublicConfigModel(instituteName: ${_this.instituteName}, studentSelfRegistration: ${_this.studentSelfRegistration}, institutePhone: ${_this.institutePhone})';
}


}

/// @nodoc
abstract mixin class $PublicConfigModelCopyWith<$Res>  {
  factory $PublicConfigModelCopyWith(PublicConfigModel value, $Res Function(PublicConfigModel) _then) = _$PublicConfigModelCopyWithImpl;
@useResult
$Res call({
 String instituteName, bool studentSelfRegistration, String? institutePhone
});




}
/// @nodoc
class _$PublicConfigModelCopyWithImpl<$Res>
    implements $PublicConfigModelCopyWith<$Res> {
  _$PublicConfigModelCopyWithImpl(this._self, this._then);

  final PublicConfigModel _self;
  final $Res Function(PublicConfigModel) _then;

/// Create a copy of PublicConfigModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? instituteName = null,Object? studentSelfRegistration = null,Object? institutePhone = freezed,}) {
  return _then(PublicConfigModel(
instituteName: null == instituteName ? _self.instituteName : instituteName // ignore: cast_nullable_to_non_nullable
as String,studentSelfRegistration: null == studentSelfRegistration ? _self.studentSelfRegistration : studentSelfRegistration // ignore: cast_nullable_to_non_nullable
as bool,institutePhone: freezed == institutePhone ? _self.institutePhone : institutePhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicConfigModel].
extension PublicConfigModelPatterns on PublicConfigModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicConfigModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicConfigModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicConfigModel value)  $default,){
final _that = this;
switch (_that) {
case _PublicConfigModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicConfigModel value)?  $default,){
final _that = this;
switch (_that) {
case _PublicConfigModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String instituteName,  bool studentSelfRegistration,  String? institutePhone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicConfigModel() when $default != null:
return $default(_that.instituteName,_that.studentSelfRegistration,_that.institutePhone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String instituteName,  bool studentSelfRegistration,  String? institutePhone)  $default,) {final _that = this;
switch (_that) {
case _PublicConfigModel():
return $default(_that.instituteName,_that.studentSelfRegistration,_that.institutePhone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String instituteName,  bool studentSelfRegistration,  String? institutePhone)?  $default,) {final _that = this;
switch (_that) {
case _PublicConfigModel() when $default != null:
return $default(_that.instituteName,_that.studentSelfRegistration,_that.institutePhone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicConfigModel extends PublicConfigModel {
  const _PublicConfigModel({required this.instituteName, this.studentSelfRegistration = true, this.institutePhone}): super._();
  factory _PublicConfigModel.fromJson(Map<String, dynamic> json) => _$PublicConfigModelFromJson(json);

@override final  String instituteName;
@override@JsonKey() final  bool studentSelfRegistration;
@override final  String? institutePhone;

/// Create a copy of PublicConfigModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicConfigModelCopyWith<_PublicConfigModel> get copyWith => __$PublicConfigModelCopyWithImpl<_PublicConfigModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicConfigModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicConfigModel&&(identical(other.instituteName, instituteName) || other.instituteName == instituteName)&&(identical(other.studentSelfRegistration, studentSelfRegistration) || other.studentSelfRegistration == studentSelfRegistration)&&(identical(other.institutePhone, institutePhone) || other.institutePhone == institutePhone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,instituteName,studentSelfRegistration,institutePhone);
}

@override
String toString() {
    return 'PublicConfigModel(instituteName: $instituteName, studentSelfRegistration: $studentSelfRegistration, institutePhone: $institutePhone)';
}


}

/// @nodoc
abstract mixin class _$PublicConfigModelCopyWith<$Res> implements $PublicConfigModelCopyWith<$Res> {
  factory _$PublicConfigModelCopyWith(_PublicConfigModel value, $Res Function(_PublicConfigModel) _then) = __$PublicConfigModelCopyWithImpl;
@override @useResult
$Res call({
 String instituteName, bool studentSelfRegistration, String? institutePhone
});




}
/// @nodoc
class __$PublicConfigModelCopyWithImpl<$Res>
    implements _$PublicConfigModelCopyWith<$Res> {
  __$PublicConfigModelCopyWithImpl(this._self, this._then);

  final _PublicConfigModel _self;
  final $Res Function(_PublicConfigModel) _then;

/// Create a copy of PublicConfigModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? instituteName = null,Object? studentSelfRegistration = null,Object? institutePhone = freezed,}) {
  return _then(_PublicConfigModel(
instituteName: null == instituteName ? _self.instituteName : instituteName // ignore: cast_nullable_to_non_nullable
as String,studentSelfRegistration: null == studentSelfRegistration ? _self.studentSelfRegistration : studentSelfRegistration // ignore: cast_nullable_to_non_nullable
as bool,institutePhone: freezed == institutePhone ? _self.institutePhone : institutePhone // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
