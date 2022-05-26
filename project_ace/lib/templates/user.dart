import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@Freezed()

class MyUser with _$MyUser{
  const factory MyUser({
    required String userId,
    required String email,
    required String fullName,
    @Default("https://upload.wikimedia.org/wikipedia/commons/1/18/Color-white.JPG") String urlAvatar,
    required String username,
    @Default("") String bio,
    @Default(false) bool isPrivate,
    @Default(<dynamic>[]) followers,
    @Default(<dynamic>[]) following,
    @Default(<dynamic>[]) requests,
    @Default(<dynamic>[]) notifications,
    @Default(<dynamic>[]) bookmarks,
    @Default(false) bool isDisabled,
    @Default(<dynamic>[]) posts,
  }) = _MyUser;

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);
}
