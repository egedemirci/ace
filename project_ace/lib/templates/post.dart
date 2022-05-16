import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'post.g.dart';

class Post {
  String text;
  int likes;
  String fullName;
  String userName;
  String imageSource;

  Post({
    required this.text,
    required this.fullName,
    required this.likes,
    required this.userName,
    this.imageSource = "default",
  });
}

@JsonSerializable()
class JSONPost {
  String title, body;
  @JsonKey(name: "userId", defaultValue: 0)
  int userID;
  @JsonKey(name: "id")
  int postID;

  JSONPost({
    required this.title,
    required this.body,
    required this.userID,
    required this.postID,
  });

  factory JSONPost.fromJSON(Map<String, dynamic> JSON) =>
      _$JSONPostFromJson(JSON);
  Map<String, dynamic> toJSON() => _$JSONPostToJson(this);

  @override
  String toString() {
    return 'Post ID: $postID\nUser ID: $userID\nTitle: $title\nBody: $body';
  }
}
