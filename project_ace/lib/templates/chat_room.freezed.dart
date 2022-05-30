// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return _ChatRoom.fromJson(json);
}

/// @nodoc
mixin _$ChatRoom {
  String get chatRoomId => throw _privateConstructorUsedError;
  List<dynamic> get texts => throw _privateConstructorUsedError;
  String get lastMessage => throw _privateConstructorUsedError;
  String get lastSenderUsername => throw _privateConstructorUsedError;
  DateTime get lastMessageCreatedAt => throw _privateConstructorUsedError;
  List<String> get usersChatting => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatRoomCopyWith<ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomCopyWith<$Res> {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) then) =
      _$ChatRoomCopyWithImpl<$Res>;
  $Res call(
      {String chatRoomId,
      List<dynamic> texts,
      String lastMessage,
      String lastSenderUsername,
      DateTime lastMessageCreatedAt,
      List<String> usersChatting});
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res> implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  final ChatRoom _value;
  // ignore: unused_field
  final $Res Function(ChatRoom) _then;

  @override
  $Res call({
    Object? chatRoomId = freezed,
    Object? texts = freezed,
    Object? lastMessage = freezed,
    Object? lastSenderUsername = freezed,
    Object? lastMessageCreatedAt = freezed,
    Object? usersChatting = freezed,
  }) {
    return _then(_value.copyWith(
      chatRoomId: chatRoomId == freezed
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String,
      texts: texts == freezed
          ? _value.texts
          : texts // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      lastMessage: lastMessage == freezed
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastSenderUsername: lastSenderUsername == freezed
          ? _value.lastSenderUsername
          : lastSenderUsername // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageCreatedAt: lastMessageCreatedAt == freezed
          ? _value.lastMessageCreatedAt
          : lastMessageCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      usersChatting: usersChatting == freezed
          ? _value.usersChatting
          : usersChatting // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$$_ChatRoomCopyWith<$Res> implements $ChatRoomCopyWith<$Res> {
  factory _$$_ChatRoomCopyWith(
          _$_ChatRoom value, $Res Function(_$_ChatRoom) then) =
      __$$_ChatRoomCopyWithImpl<$Res>;
  @override
  $Res call(
      {String chatRoomId,
      List<dynamic> texts,
      String lastMessage,
      String lastSenderUsername,
      DateTime lastMessageCreatedAt,
      List<String> usersChatting});
}

/// @nodoc
class __$$_ChatRoomCopyWithImpl<$Res> extends _$ChatRoomCopyWithImpl<$Res>
    implements _$$_ChatRoomCopyWith<$Res> {
  __$$_ChatRoomCopyWithImpl(
      _$_ChatRoom _value, $Res Function(_$_ChatRoom) _then)
      : super(_value, (v) => _then(v as _$_ChatRoom));

  @override
  _$_ChatRoom get _value => super._value as _$_ChatRoom;

  @override
  $Res call({
    Object? chatRoomId = freezed,
    Object? texts = freezed,
    Object? lastMessage = freezed,
    Object? lastSenderUsername = freezed,
    Object? lastMessageCreatedAt = freezed,
    Object? usersChatting = freezed,
  }) {
    return _then(_$_ChatRoom(
      chatRoomId: chatRoomId == freezed
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String,
      texts: texts == freezed
          ? _value._texts
          : texts // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      lastMessage: lastMessage == freezed
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastSenderUsername: lastSenderUsername == freezed
          ? _value.lastSenderUsername
          : lastSenderUsername // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageCreatedAt: lastMessageCreatedAt == freezed
          ? _value.lastMessageCreatedAt
          : lastMessageCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      usersChatting: usersChatting == freezed
          ? _value._usersChatting
          : usersChatting // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatRoom implements _ChatRoom {
  const _$_ChatRoom(
      {required this.chatRoomId,
      final List<dynamic> texts = const <dynamic>[],
      this.lastMessage = "",
      this.lastSenderUsername = "",
      required this.lastMessageCreatedAt,
      required final List<String> usersChatting})
      : _texts = texts,
        _usersChatting = usersChatting;

  factory _$_ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$$_ChatRoomFromJson(json);

  @override
  final String chatRoomId;
  final List<dynamic> _texts;
  @override
  @JsonKey()
  List<dynamic> get texts {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_texts);
  }

  @override
  @JsonKey()
  final String lastMessage;
  @override
  @JsonKey()
  final String lastSenderUsername;
  @override
  final DateTime lastMessageCreatedAt;
  final List<String> _usersChatting;
  @override
  List<String> get usersChatting {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_usersChatting);
  }

  @override
  String toString() {
    return 'ChatRoom(chatRoomId: $chatRoomId, texts: $texts, lastMessage: $lastMessage, lastSenderUsername: $lastSenderUsername, lastMessageCreatedAt: $lastMessageCreatedAt, usersChatting: $usersChatting)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatRoom &&
            const DeepCollectionEquality()
                .equals(other.chatRoomId, chatRoomId) &&
            const DeepCollectionEquality().equals(other._texts, _texts) &&
            const DeepCollectionEquality()
                .equals(other.lastMessage, lastMessage) &&
            const DeepCollectionEquality()
                .equals(other.lastSenderUsername, lastSenderUsername) &&
            const DeepCollectionEquality()
                .equals(other.lastMessageCreatedAt, lastMessageCreatedAt) &&
            const DeepCollectionEquality()
                .equals(other._usersChatting, _usersChatting));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(chatRoomId),
      const DeepCollectionEquality().hash(_texts),
      const DeepCollectionEquality().hash(lastMessage),
      const DeepCollectionEquality().hash(lastSenderUsername),
      const DeepCollectionEquality().hash(lastMessageCreatedAt),
      const DeepCollectionEquality().hash(_usersChatting));

  @JsonKey(ignore: true)
  @override
  _$$_ChatRoomCopyWith<_$_ChatRoom> get copyWith =>
      __$$_ChatRoomCopyWithImpl<_$_ChatRoom>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatRoomToJson(this);
  }
}

abstract class _ChatRoom implements ChatRoom {
  const factory _ChatRoom(
      {required final String chatRoomId,
      final List<dynamic> texts,
      final String lastMessage,
      final String lastSenderUsername,
      required final DateTime lastMessageCreatedAt,
      required final List<String> usersChatting}) = _$_ChatRoom;

  factory _ChatRoom.fromJson(Map<String, dynamic> json) = _$_ChatRoom.fromJson;

  @override
  String get chatRoomId => throw _privateConstructorUsedError;
  @override
  List<dynamic> get texts => throw _privateConstructorUsedError;
  @override
  String get lastMessage => throw _privateConstructorUsedError;
  @override
  String get lastSenderUsername => throw _privateConstructorUsedError;
  @override
  DateTime get lastMessageCreatedAt => throw _privateConstructorUsedError;
  @override
  List<String> get usersChatting => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ChatRoomCopyWith<_$_ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}
