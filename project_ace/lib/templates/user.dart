import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@Freezed()
class MyUser with _$MyUser{
  const factory MyUser({
    required String username,
    required String usernameLower,
    required String userId,
    @Default("") String biography,
    @Default("default") String profilepicture,
    required String fullName,
    @Default(<dynamic>[]) List<dynamic> subscribedTopics,
    @Default(false) bool isPrivate,
    @Default(<dynamic>[]) List<dynamic> followers,
    @Default(<dynamic>[]) List<dynamic> following,
    @Default(<dynamic>[]) List<dynamic> requests,
    @Default(<dynamic>[]) List<dynamic> notifications,
    @Default(<dynamic>[]) List<dynamic> bookmarks,
    @Default(false) bool isDisabled,
    @Default(false) bool isThereNewNotif,
    @Default(<dynamic>[]) List<dynamic> posts,
  }) = _MyUser;
  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);
}