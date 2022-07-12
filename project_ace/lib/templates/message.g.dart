// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      senderUsername: json['senderUsername'] as String,
      message: json['message'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      urlAvatar: json['urlAvatar'] as String,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'senderUsername': instance.senderUsername,
      'message': instance.message,
      'createdAt': instance.createdAt.toIso8601String(),
      'urlAvatar': instance.urlAvatar,
    };
