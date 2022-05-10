// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JSONPost _$JSONPostFromJson(Map<String, dynamic> json) => JSONPost(
      title: json['title'] as String,
      body: json['body'] as String,
      userID: json['userId'] as int? ?? 0,
      postID: json['id'] as int,
    );

Map<String, dynamic> _$JSONPostToJson(JSONPost instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'userId': instance.userID,
      'id': instance.postID,
    };
