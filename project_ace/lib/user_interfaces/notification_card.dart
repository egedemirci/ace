import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/chat.dart';
import 'package:project_ace/templates/notif.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';

class NotificationsCard extends StatelessWidget {
  final AppNotification myNotification;

  const NotificationsCard({required this.myNotification});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
                  child: CircleAvatar(
                    foregroundColor: AppColors.notificationIconColor,
                    backgroundColor: AppColors.profileScreenBackgroundColor,
                    child: ClipOval(child: myNotification.icon),
                    radius: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                  child: Text(
                    "@${myNotification.userName} ",
                    style: notificationText,
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 270),
                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                  child: Column(children: [
                    Text(
                      myNotification.text,
                      maxLines: 3,
                      style: notificationText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
                ),
                const SizedBox(width: 6),
              ],
            ),
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
                        primary: AppColors.profileSettingsButtonTextColor,
                        backgroundColor: AppColors.decisionButtonColor,
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
                    child: Text("Reject!", style: acceptAndReject),
                    style: OutlinedButton.styleFrom(
                        primary: AppColors.profileSettingsButtonTextColor,
                        backgroundColor: AppColors.decisionButtonColor,
                        fixedSize: const Size(80, 8)),
                  ),
                  visible: myNotification.type,
                ),
              ],
            ),
            const Divider(
                height: 10,
                thickness: 1.5,
                color: AppColors.notificationIconColor),
          ],
        ),
      ),
    );
  }
}
