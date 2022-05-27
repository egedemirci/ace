import 'package:flutter/material.dart';

class AppNotification {
  String text;
  Icon icon;
  bool type;
  String userName;

  AppNotification({
    required this.text,
    required this.icon,
    required this.type,
    required this.userName,
  });
}
