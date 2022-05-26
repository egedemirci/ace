// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyUser _$$_MyUserFromJson(Map<String, dynamic> json) => _$_MyUser(
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      urlAvatar: json['urlAvatar'] as String? ??
          "https://upload.wikimedia.org/wikipedia/commons/1/18/Color-white.JPG",
      userName: json['userName'] as String,
      bio: json['bio'] as String? ?? "",
    );

Map<String, dynamic> _$$_MyUserToJson(_$_MyUser instance) => <String, dynamic>{
      'email': instance.email,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'urlAvatar': instance.urlAvatar,
      'userName': instance.userName,
      'bio': instance.bio,
    };
