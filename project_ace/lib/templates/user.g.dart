// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyUser _$$_MyUserFromJson(Map<String, dynamic> json) => _$_MyUser(
      userId: json['userId'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      urlAvatar: json['urlAvatar'] as String? ??
          "https://upload.wikimedia.org/wikipedia/commons/1/18/Color-white.JPG",
      username: json['username'] as String,
      bio: json['bio'] as String? ?? "",
      isPrivate: json['isPrivate'] as bool? ?? false,
      followers: json['followers'] ?? const <dynamic>[],
      following: json['following'] ?? const <dynamic>[],
      requests: json['requests'] ?? const <dynamic>[],
      notifications: json['notifications'] ?? const <dynamic>[],
      bookmarks: json['bookmarks'] ?? const <dynamic>[],
      isDisabled: json['isDisabled'] as bool? ?? false,
      posts: json['posts'] ?? const <dynamic>[],
    );

Map<String, dynamic> _$$_MyUserToJson(_$_MyUser instance) => <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'fullName': instance.fullName,
      'urlAvatar': instance.urlAvatar,
      'username': instance.username,
      'bio': instance.bio,
      'isPrivate': instance.isPrivate,
      'followers': instance.followers,
      'following': instance.following,
      'requests': instance.requests,
      'notifications': instance.notifications,
      'bookmarks': instance.bookmarks,
      'isDisabled': instance.isDisabled,
      'posts': instance.posts,
    };
