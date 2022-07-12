// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyUser _$$_MyUserFromJson(Map<String, dynamic> json) => _$_MyUser(
      username: json['username'] as String,
      usernameLower: json['usernameLower'] as String,
      userId: json['userId'] as String,
      biography: json['biography'] as String? ?? "",
      profilepicture: json['profilepicture'] as String? ?? "default",
      fullName: json['fullName'] as String,
      subscribedTopics:
          json['subscribedTopics'] as List<dynamic>? ?? const <dynamic>[],
      isPrivate: json['isPrivate'] as bool? ?? false,
      followers: json['followers'] as List<dynamic>? ?? const <dynamic>[],
      following: json['following'] as List<dynamic>? ?? const <dynamic>[],
      requests: json['requests'] as List<dynamic>? ?? const <dynamic>[],
      notifications:
          json['notifications'] as List<dynamic>? ?? const <dynamic>[],
      bookmarks: json['bookmarks'] as List<dynamic>? ?? const <dynamic>[],
      isDisabled: json['isDisabled'] as bool? ?? false,
      isThereNewNotif: json['isThereNewNotif'] as bool? ?? false,
      posts: json['posts'] as List<dynamic>? ?? const <dynamic>[],
    );

Map<String, dynamic> _$$_MyUserToJson(_$_MyUser instance) => <String, dynamic>{
      'username': instance.username,
      'usernameLower': instance.usernameLower,
      'userId': instance.userId,
      'biography': instance.biography,
      'profilepicture': instance.profilepicture,
      'fullName': instance.fullName,
      'subscribedTopics': instance.subscribedTopics,
      'isPrivate': instance.isPrivate,
      'followers': instance.followers,
      'following': instance.following,
      'requests': instance.requests,
      'notifications': instance.notifications,
      'bookmarks': instance.bookmarks,
      'isDisabled': instance.isDisabled,
      'isThereNewNotif': instance.isThereNewNotif,
      'posts': instance.posts,
    };
