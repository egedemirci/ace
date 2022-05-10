import 'package:flutter/material.dart';

class Message {
  String fullName, userName, text;
  Image profilePicture;
  Message(
      {required this.fullName,
      required this.text,
      required this.userName,
      required this.profilePicture});
}
