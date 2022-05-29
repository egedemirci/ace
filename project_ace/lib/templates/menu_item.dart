import 'package:flutter/material.dart';

class PostMenuItem {
  final String text;
  final IconData icon;

  const PostMenuItem({required this.text, required this.icon});
}

class PostMenuItems {
  static const reportPost =
      PostMenuItem(text: "Report this post", icon: Icons.report_outlined);
  static const editPost =
      PostMenuItem(text: "Edit this post", icon: Icons.edit_outlined);
  static const reSharePost =
      PostMenuItem(text: "Share this post", icon: Icons.repeat);
  static const bookmarkPost =
      PostMenuItem(text: "Bookmark this post", icon: Icons.bookmark_border);
  static const deletePost =
      PostMenuItem(text: "Delete this post", icon: Icons.delete);
  static const List<PostMenuItem> userPostList = [editPost, deletePost];
  static const List<PostMenuItem> otherUsersPostList = [
    reSharePost,
    bookmarkPost,
    reportPost
  ];
}
