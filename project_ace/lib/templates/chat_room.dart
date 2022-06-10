import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_room.g.dart';
part 'chat_room.freezed.dart';

@Freezed()
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String chatRoomId,
    @Default(<dynamic>[]) List<dynamic> texts,
    @Default("") String lastMessage,
    @Default("") String lastSenderUsername,
    required DateTime lastMessageCreatedAt,
    required List<String> usersChatting,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomFromJson(json);
}
