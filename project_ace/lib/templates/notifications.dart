import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifications.g.dart';
part 'notifications.freezed.dart';

@Freezed()
class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String notifType,
    required String subjectId,
    required DateTime createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}
