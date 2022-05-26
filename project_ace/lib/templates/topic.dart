import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic.g.dart';
part 'topic.freezed.dart';

@Freezed()

class Topic with _$Topic{
  const factory Topic({
    required String topicName,
    required List<dynamic> postIdList,
  }) = _Topic;

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
}
