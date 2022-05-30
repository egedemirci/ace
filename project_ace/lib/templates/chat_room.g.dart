// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatRoom _$$_ChatRoomFromJson(Map<String, dynamic> json) => _$_ChatRoom(
      chatRoomId: json['chatRoomId'] as String,
      texts: json['texts'] as List<dynamic>? ?? const <dynamic>[],
      lastMessage: json['lastMessage'] as String? ?? "",
      lastSenderUsername: json['lastSenderUsername'] as String? ?? "",
      lastMessageCreatedAt:
          DateTime.parse(json['lastMessageCreatedAt'] as String),
      usersChatting: (json['usersChatting'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_ChatRoomToJson(_$_ChatRoom instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'texts': instance.texts,
      'lastMessage': instance.lastMessage,
      'lastSenderUsername': instance.lastSenderUsername,
      'lastMessageCreatedAt': instance.lastMessageCreatedAt.toIso8601String(),
      'usersChatting': instance.usersChatting,
    };
