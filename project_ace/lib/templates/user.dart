import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@Freezed()

class MyUser with _$MyUser{
  const factory MyUser({
    required String email,
    required String fullName,
    required String phoneNumber,
    @Default("https://upload.wikimedia.org/wikipedia/commons/1/18/Color-white.JPG") String urlAvatar,
    required String userName,
    @Default("") String bio,
  }) = _MyUser;

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);
}
