// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      commentId: json['commentId'] as String,
      text: json['text'] as String,
      urlAvatar: json['urlAvatar'] as String? ?? "default",
      username: json['username'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'text': instance.text,
      'urlAvatar': instance.urlAvatar,
      'username': instance.username,
      'createdAt': instance.createdAt.toIso8601String(),
    };
