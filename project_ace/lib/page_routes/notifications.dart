import 'package:firebase_analytics/firebase_analytics.dart';
import "package:flutter/material.dart";
import 'package:project_ace/services/analytics.dart';
import "package:project_ace/templates/notif.dart";
import 'package:project_ace/user_interfaces/notification_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.analytics})
      : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = '/notifications';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // TODO: Extend the implementation of Screen Sizes
  List<AppNotification> allNotifications = [
    AppNotification(
        text: "started to follow you!",
        icon: const Icon(
          Icons.person_add_alt_1_rounded,
          size: 50.0,
        ),
        type: false,
        userName: "harrymaguire"),
    AppNotification(
        text: "wants to follow you!",
        icon: const Icon(
          Icons.person_add_alt_1_rounded,
          size: 50.0,
        ),
        type: true,
        userName: "taners"),
    AppNotification(
        text: "liked your photo!",
        icon: const Icon(
          Icons.favorite,
          size: 50.0,
        ),
        type: false,
        userName: "afu"),
    AppNotification(
        text: "started to follow you!",
        icon: const Icon(
          Icons.person_add_alt_1_rounded,
          size: 50.0,
        ),
        type: false,
        userName: "tuzun"),
  ];

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(
        widget.analytics, "Notifications View", "notifications.dart");
    return Scaffold(
      backgroundColor: AppColors.profileScreenBackgroundColor,
      appBar: AppBar(
        foregroundColor: AppColors.welcomeScreenBackgroundColor,
        elevation: 0,
        title: SizedBox(
          width: screenWidth(context) * 0.6,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Notifications",
              style: notificationsHeader,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.profileScreenBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
              children: allNotifications
                  .map((myNotif) => NotificationsCard(myNotification: myNotif))
                  .toList()),
        ),
      ),
    );
  }
}
