import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.g.dart';
part 'post.freezed.dart';

@Freezed()

class Post with _$Post{
  const factory Post({
    @Default("default") String assetUrl,
    @Default("default") String urlAvatar,
    required String text,
    required int commentCount,
    required int dislikes,
    required int likes,
    required DateTime createdAt,
    required String username,
    required String fullName,
    String? topicId,

  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}