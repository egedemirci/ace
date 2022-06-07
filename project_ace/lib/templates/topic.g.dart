// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Topic _$$_TopicFromJson(Map<String, dynamic> json) => _$_Topic(
      text: json['text'] as String,
      postIdList: json['postIdList'] as List<dynamic>? ?? const <dynamic>[],
    );

Map<String, dynamic> _$$_TopicToJson(_$_Topic instance) => <String, dynamic>{
      'text': instance.text,
      'postIdList': instance.postIdList,
    };
