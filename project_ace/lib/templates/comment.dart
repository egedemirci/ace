import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.g.dart';
part 'comment.freezed.dart';

@Freezed()
class Comment with _$Comment {
  const factory Comment({
    required String commentId,
    required String text,
    @Default("default") String urlAvatar,
    required String username,
    required DateTime createdAt,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
