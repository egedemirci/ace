// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String get senderUsername => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get urlAvatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res>;
  $Res call(
      {String senderUsername,
      String message,
      DateTime createdAt,
      String urlAvatar});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res> implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  final Message _value;
  // ignore: unused_field
  final $Res Function(Message) _then;

  @override
  $Res call({
    Object? senderUsername = freezed,
    Object? message = freezed,
    Object? createdAt = freezed,
    Object? urlAvatar = freezed,
  }) {
    return _then(_value.copyWith(
      senderUsername: senderUsername == freezed
          ? _value.senderUsername
          : senderUsername // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      urlAvatar: urlAvatar == freezed
          ? _value.urlAvatar
          : urlAvatar // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$_MessageCopyWith(
          _$_Message value, $Res Function(_$_Message) then) =
      __$$_MessageCopyWithImpl<$Res>;
  @override
  $Res call(
      {String senderUsername,
      String message,
      DateTime createdAt,
      String urlAvatar});
}

/// @nodoc
class __$$_MessageCopyWithImpl<$Res> extends _$MessageCopyWithImpl<$Res>
    implements _$$_MessageCopyWith<$Res> {
  __$$_MessageCopyWithImpl(_$_Message _value, $Res Function(_$_Message) _then)
      : super(_value, (v) => _then(v as _$_Message));

  @override
  _$_Message get _value => super._value as _$_Message;

  @override
  $Res call({
    Object? senderUsername = freezed,
    Object? message = freezed,
    Object? createdAt = freezed,
    Object? urlAvatar = freezed,
  }) {
    return _then(_$_Message(
      senderUsername: senderUsername == freezed
          ? _value.senderUsername
          : senderUsername // ignore: cast_nullable_to_non_nullable
              as String,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      urlAvatar: urlAvatar == freezed
          ? _value.urlAvatar
          : urlAvatar // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Message implements _Message {
  const _$_Message(
      {required this.senderUsername,
      required this.message,
      required this.createdAt,
      required this.urlAvatar});

  factory _$_Message.fromJson(Map<String, dynamic> json) =>
      _$$_MessageFromJson(json);

  @override
  final String senderUsername;
  @override
  final String message;
  @override
  final DateTime createdAt;
  @override
  final String urlAvatar;

  @override
  String toString() {
    return 'Message(senderUsername: $senderUsername, message: $message, createdAt: $createdAt, urlAvatar: $urlAvatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Message &&
            const DeepCollectionEquality()
                .equals(other.senderUsername, senderUsername) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.urlAvatar, urlAvatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(senderUsername),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(urlAvatar));

  @JsonKey(ignore: true)
  @override
  _$$_MessageCopyWith<_$_Message> get copyWith =>
      __$$_MessageCopyWithImpl<_$_Message>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageToJson(this);
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {required final String senderUsername,
      required final String message,
      required final DateTime createdAt,
      required final String urlAvatar}) = _$_Message;

  factory _Message.fromJson(Map<String, dynamic> json) = _$_Message.fromJson;

  @override
  String get senderUsername => throw _privateConstructorUsedError;
  @override
  String get message => throw _privateConstructorUsedError;
  @override
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  String get urlAvatar => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MessageCopyWith<_$_Message> get copyWith =>
      throw _privateConstructorUsedError;
}
