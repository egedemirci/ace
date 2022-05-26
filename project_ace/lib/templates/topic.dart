import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic.g.dart';
part 'topic.freezed.dart';

@Freezed()

class Topic with _$Topic{
  const factory Topic({
    required String text,
    required int count,
    required String area,
  }) = _Topic;

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
}
