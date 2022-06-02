import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/user_services.dart';
import "package:project_ace/templates/notif.dart";
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/user_interfaces/notification_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';

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
  UserServices userService = UserServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    setUserId(widget.analytics, user!.uid);
    setCurrentScreen(
        widget.analytics, "Notifications View", "notifications.dart");
    return Scaffold(
        backgroundColor: AppColors.profileScreenBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: screenHeight(context) * 0.025,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            splashRadius: screenHeight(context) * 0.03,
          ),
          centerTitle: true,
          title: SizedBox(
            width: screenWidth(context) * 0.6,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Notifications",
                style: messageHeader,
              ),
            ),
          ),
          foregroundColor: AppColors.welcomeScreenBackgroundColor,
          elevation: 0,
          backgroundColor: AppColors.profileScreenBackgroundColor,
          toolbarHeight: screenHeight(context) * 0.08,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: userService.usersRef.snapshots().asBroadcastStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              else {
                List<dynamic> userList = snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) {
                  return element["userId"] == user.uid;
                }).toList();
                MyUser myUser = MyUser.fromJson(userList[0].data() as Map<String, dynamic>);
                return SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                        children: myUser.notifications.reversed
                            .map((myNotif) => NotificationsCard(
                                myNotification:
                                    AppNotification.fromJson(myNotif)))
                            .toList()),
                  ),
                );
              }
              return const CircularProgressIndicator();
            }));
  }
}
