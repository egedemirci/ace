// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      userId: json['userId'] as String,
      assetUrl: json['assetUrl'] as String? ?? "default",
      urlAvatar: json['urlAvatar'] as String? ?? "default",
      text: json['text'] as String,
      dislikeCount: json['dislikeCount'] as int,
      likeCount: json['likeCount'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      comments: json['comments'] ?? const <dynamic>[],
      isShared: json['isShared'] as bool? ?? false,
      fromWho: json['fromWho'] as String? ?? "",
      topic: json['topic'] as String? ?? "",
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'userId': instance.userId,
      'assetUrl': instance.assetUrl,
      'urlAvatar': instance.urlAvatar,
      'text': instance.text,
      'dislikeCount': instance.dislikeCount,
      'likeCount': instance.likeCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'username': instance.username,
      'fullName': instance.fullName,
      'comments': instance.comments,
      'isShared': instance.isShared,
      'fromWho': instance.fromWho,
      'topic': instance.topic,
    };
