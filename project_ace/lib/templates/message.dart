import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.g.dart';
part 'message.freezed.dart';

@Freezed()

class Message with _$Message{
  const factory Message({
    required String senderUsername,
    required String message,
    required DateTime createdAt,
    required String urlAvatar,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}
