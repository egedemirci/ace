// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notif.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppNotification _$$_AppNotificationFromJson(Map<String, dynamic> json) =>
    _$_AppNotification(
      notifType: json['notifType'] as String,
      subjectUsername: json['subjectUsername'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_AppNotificationToJson(_$_AppNotification instance) =>
    <String, dynamic>{
      'notifType': instance.notifType,
      'subjectUsername': instance.subjectUsername,
      'createdAt': instance.createdAt.toIso8601String(),
    };
