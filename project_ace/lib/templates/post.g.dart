// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      assetUrl: json['assetUrl'] as String? ?? "default",
      urlAvatar: json['urlAvatar'] as String? ?? "default",
      mediaType: json['mediaType'] as String? ?? "default",
      text: json['text'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      comments: json['comments'] ?? const <dynamic>[],
      likes: json['likes'] ?? const <dynamic>[],
      dislikes: json['dislikes'] ?? const <dynamic>[],
      isShared: json['isShared'] as bool? ?? false,
      fromWho: json['fromWho'] as String? ?? "",
      topic: json['topic'] as String? ?? "",
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'postId': instance.postId,
      'userId': instance.userId,
      'assetUrl': instance.assetUrl,
      'urlAvatar': instance.urlAvatar,
      'mediaType': instance.mediaType,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'username': instance.username,
      'fullName': instance.fullName,
      'comments': instance.comments,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'isShared': instance.isShared,
      'fromWho': instance.fromWho,
      'topic': instance.topic,
    };
