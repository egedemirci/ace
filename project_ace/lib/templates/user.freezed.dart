// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyUser _$MyUserFromJson(Map<String, dynamic> json) {
  return _MyUser.fromJson(json);
}

/// @nodoc
mixin _$MyUser {
  String get email => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get phoneNumber => throw _privateConstructorUsedError;
  String get urlAvatar => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyUserCopyWith<MyUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyUserCopyWith<$Res> {
  factory $MyUserCopyWith(MyUser value, $Res Function(MyUser) then) =
      _$MyUserCopyWithImpl<$Res>;
  $Res call(
      {String email,
      String fullName,
      String phoneNumber,
      String urlAvatar,
      String userName,
      String bio});
}

/// @nodoc
class _$MyUserCopyWithImpl<$Res> implements $MyUserCopyWith<$Res> {
  _$MyUserCopyWithImpl(this._value, this._then);

  final MyUser _value;
  // ignore: unused_field
  final $Res Function(MyUser) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? fullName = freezed,
    Object? phoneNumber = freezed,
    Object? urlAvatar = freezed,
    Object? userName = freezed,
    Object? bio = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      urlAvatar: urlAvatar == freezed
          ? _value.urlAvatar
          : urlAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      bio: bio == freezed
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_MyUserCopyWith<$Res> implements $MyUserCopyWith<$Res> {
  factory _$$_MyUserCopyWith(_$_MyUser value, $Res Function(_$_MyUser) then) =
      __$$_MyUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String email,
      String fullName,
      String phoneNumber,
      String urlAvatar,
      String userName,
      String bio});
}

/// @nodoc
class __$$_MyUserCopyWithImpl<$Res> extends _$MyUserCopyWithImpl<$Res>
    implements _$$_MyUserCopyWith<$Res> {
  __$$_MyUserCopyWithImpl(_$_MyUser _value, $Res Function(_$_MyUser) _then)
      : super(_value, (v) => _then(v as _$_MyUser));

  @override
  _$_MyUser get _value => super._value as _$_MyUser;

  @override
  $Res call({
    Object? email = freezed,
    Object? fullName = freezed,
    Object? phoneNumber = freezed,
    Object? urlAvatar = freezed,
    Object? userName = freezed,
    Object? bio = freezed,
  }) {
    return _then(_$_MyUser(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: fullName == freezed
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      urlAvatar: urlAvatar == freezed
          ? _value.urlAvatar
          : urlAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      userName: userName == freezed
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      bio: bio == freezed
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MyUser implements _MyUser {
  const _$_MyUser(
      {required this.email,
      required this.fullName,
      required this.phoneNumber,
      this.urlAvatar =
          "https://upload.wikimedia.org/wikipedia/commons/1/18/Color-white.JPG",
      required this.userName,
      this.bio = ""});

  factory _$_MyUser.fromJson(Map<String, dynamic> json) =>
      _$$_MyUserFromJson(json);

  @override
  final String email;
  @override
  final String fullName;
  @override
  final String phoneNumber;
  @override
  @JsonKey()
  final String urlAvatar;
  @override
  final String userName;
  @override
  @JsonKey()
  final String bio;

  @override
  String toString() {
    return 'MyUser(email: $email, fullName: $fullName, phoneNumber: $phoneNumber, urlAvatar: $urlAvatar, userName: $userName, bio: $bio)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyUser &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.fullName, fullName) &&
            const DeepCollectionEquality()
                .equals(other.phoneNumber, phoneNumber) &&
            const DeepCollectionEquality().equals(other.urlAvatar, urlAvatar) &&
            const DeepCollectionEquality().equals(other.userName, userName) &&
            const DeepCollectionEquality().equals(other.bio, bio));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(fullName),
      const DeepCollectionEquality().hash(phoneNumber),
      const DeepCollectionEquality().hash(urlAvatar),
      const DeepCollectionEquality().hash(userName),
      const DeepCollectionEquality().hash(bio));

  @JsonKey(ignore: true)
  @override
  _$$_MyUserCopyWith<_$_MyUser> get copyWith =>
      __$$_MyUserCopyWithImpl<_$_MyUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MyUserToJson(this);
  }
}

abstract class _MyUser implements MyUser {
  const factory _MyUser(
      {required final String email,
      required final String fullName,
      required final String phoneNumber,
      final String urlAvatar,
      required final String userName,
      final String bio}) = _$_MyUser;

  factory _MyUser.fromJson(Map<String, dynamic> json) = _$_MyUser.fromJson;

  @override
  String get email => throw _privateConstructorUsedError;
  @override
  String get fullName => throw _privateConstructorUsedError;
  @override
  String get phoneNumber => throw _privateConstructorUsedError;
  @override
  String get urlAvatar => throw _privateConstructorUsedError;
  @override
  String get userName => throw _privateConstructorUsedError;
  @override
  String get bio => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MyUserCopyWith<_$_MyUser> get copyWith =>
      throw _privateConstructorUsedError;
}
