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
  //TODO get notifications of current user from Firestore
  List<AppNotification> allNotifications = [];

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(
        widget.analytics, "Notifications View", "notificationsView");
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
