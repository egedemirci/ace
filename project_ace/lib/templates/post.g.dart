// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      assetUrl: json['assetUrl'] as String? ?? "default",
      urlAvatar: json['urlAvatar'] as String? ?? "default",
      text: json['text'] as String,
      commentCount: json['commentCount'] as int,
      dislikes: json['dislikes'] as int,
      likes: json['likes'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      topicId: json['topicId'] as String?,
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'assetUrl': instance.assetUrl,
      'urlAvatar': instance.urlAvatar,
      'text': instance.text,
      'commentCount': instance.commentCount,
      'dislikes': instance.dislikes,
      'likes': instance.likes,
      'createdAt': instance.createdAt.toIso8601String(),
      'username': instance.username,
      'fullName': instance.fullName,
      'topicId': instance.topicId,
    };
