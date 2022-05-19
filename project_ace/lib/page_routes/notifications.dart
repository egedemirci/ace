import "package:flutter/material.dart";
import "package:project_ace/templates/notif.dart";
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  static const String routeName = '/notifications';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
    return Scaffold(
      backgroundColor: AppColors.profileScreenBackgroundColor,
      appBar: AppBar(
        foregroundColor: AppColors.welcomeScreenBackgroundColor,
        elevation: 0,
        title: Text(
          "NOTIFICATIONS",
          style: notificationsHeader,
        ),
        centerTitle: true,
        backgroundColor: AppColors.profileScreenBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            //mapping
            children: allNotifications
                .map((myNotification) => Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.zero, bottom: Radius.circular(0))),
                      color: AppColors.profileScreenBackgroundColor,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 0, 8, 0),
                                  child: CircleAvatar(
                                    foregroundColor:
                                        AppColors.notificationIconColor,
                                    backgroundColor:
                                        AppColors.profileScreenBackgroundColor,
                                    child: ClipOval(child: myNotification.icon),
                                    radius: 30,
                                  ),
                                ),

                                Container(
                                  constraints: const BoxConstraints(maxWidth: 270),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 1, 0, 0),
                                  child: Column(children: [
                                    Text(
                                      myNotification.userName+" " +myNotification.text,
                                      maxLines: 3,
                                      style: notificationText,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ]),
                                ),
                                const SizedBox(width: 6),
                              ],
                            ),
                            //print(myNotification.type);
                            //myNotification.type ? OutlinedButton(onPressed: (){}, child: Text("Accept!")):Text("a") ,
                            //OutlinedButton(onPressed: (){}, child: Text("Reject!")),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 80,
                                ),
                                Visibility(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Accept!",
                                      style: acceptAndReject,
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        primary: AppColors
                                            .profileSettingsButtonTextColor,
                                        backgroundColor:
                                            AppColors.decisionButtonColor,
                                        fixedSize: const Size(80, 8)),
                                  ),
                                  visible: myNotification.type,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Visibility(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    child:
                                        Text("Reject!", style: acceptAndReject),
                                    style: OutlinedButton.styleFrom(
                                        primary: AppColors
                                            .profileSettingsButtonTextColor,
                                        backgroundColor:
                                            AppColors.decisionButtonColor,
                                        fixedSize: const Size(80, 8)),
                                  ),
                                  visible: myNotification.type,
                                ),
                              ],
                            ),
                            //const SizedBox(width: 50,),
                            const Divider(
                                height: 10,
                                thickness: 1.5,
                                color: AppColors.notificationIconColor),
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
