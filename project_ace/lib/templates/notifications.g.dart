// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppNotification _$$_AppNotificationFromJson(Map<String, dynamic> json) =>
    _$_AppNotification(
      notifType: json['notifType'] as String,
      subjectId: json['subjectId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_AppNotificationToJson(_$_AppNotification instance) =>
    <String, dynamic>{
      'notifType': instance.notifType,
      'subjectId': instance.subjectId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
