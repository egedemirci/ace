import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.g.dart';
part 'post.freezed.dart';

@Freezed()
class Post with _$Post {
  const factory Post({
    required String postId,
    required String userId,
    @Default("default") String assetUrl,
    @Default("default") String urlAvatar,
    @Default("default") String mediaType,
    required String text,
    required DateTime createdAt,
    required String username,
    required String fullName,
    @Default(<dynamic>[]) comments,
    @Default(<dynamic>[]) likes,
    @Default(<dynamic>[]) dislikes,
    @Default(false) bool isShared,
    @Default("") String fromWho,
    @Default("") String topic,
  }) = _Post;
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
