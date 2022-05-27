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
    @Default("https://firebasestorage.googleapis.com/v0/b/sucial-ff03d.appspot.com/o/user%2Fprofile%2FprofilePic%2Fnopp.png?alt=media&token=eaebea99-fc2d-4ede-893d-070e2d2595b0") String profilepicture,
    required String fullName,
    @Default(<dynamic>[]) subscribedTopics,
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