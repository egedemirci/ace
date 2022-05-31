
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/notif.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:project_ace/utilities/screen_sizes.dart';

class NotificationsCard extends StatefulWidget {
  final AppNotification myNotification;
  const NotificationsCard({Key? key, required this.myNotification})
      : super(key: key);

  @override
  State<NotificationsCard> createState() => _NotificationsCardState();
}

class _NotificationsCardState extends State<NotificationsCard> {
  String userName = " ";
  UserServices userService = UserServices();
  Future getUserName() async {
    final uname =
    await userService.getUsername(widget.myNotification.subjectId);
    setState(() {
      userName = "@$uname";
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.myNotification.notifType == "followRequest") {
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 8, 4),
                    child: CircleAvatar(
                      foregroundColor: AppColors.notificationIconColor,
                      backgroundColor: AppColors.profileScreenBackgroundColor,
                      radius: 30,
                      child: ClipOval(child: Icon(
                        Icons.person_add_alt_1_rounded,
                        size: 50.0,
                      ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Text(
                     userName,
                      style: notificationText,
                    ),
                  ),
                  Container(
                    constraints:
                    BoxConstraints(maxWidth: screenWidth(context) * 0.65),
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Column(children: [
                      Text(
                        "wants to follow you!",
                        maxLines: 3,
                        style: notificationText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
                  ),
                  const SizedBox(width: 6),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 80,
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          primary: AppColors.profileSettingsButtonTextColor,
                          backgroundColor: AppColors.decisionButtonColor,
                          fixedSize: const Size(80, 8)),
                      child: Text(
                        "Accept!",
                        style: acceptAndReject,
                      ),
                    ),

                    const SizedBox(
                      width: 15,
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          primary: AppColors.profileSettingsButtonTextColor,
                          backgroundColor: AppColors.decisionButtonColor,
                          fixedSize: const Size(80, 8)),
                      child: Text("Reject!", style: acceptAndReject),
                    )
                  ],
                ),
              ),
              const Divider(
                  height: 1,
                  thickness: 1.5,
                  color: AppColors.notificationIconColor),
            ],
          ),
        ),
      );
    }
    else if (widget.myNotification.notifType == "followedYou") {
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 8, 4),
                    child: CircleAvatar(
                      foregroundColor: AppColors.notificationIconColor,
                      backgroundColor: AppColors.profileScreenBackgroundColor,
                      radius: 30,
                      child: ClipOval(child: Icon(
                        Icons.person_add_alt_1_rounded,
                        size: 50.0,
                      ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Text(
                      userName,
                      style: notificationText,
                    ),
                  ),
                  Container(
                    constraints:
                    BoxConstraints(maxWidth: screenWidth(context) * 0.65),
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Column(children: [
                      Text(
                        "started to follow you!",
                        maxLines: 3,
                        style: notificationText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
                  ),
                  const SizedBox(width: 6),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 80,
                    ),

                    SizedBox(
                      width: 15,
                    ),

                  ],
                ),
              ),
              const Divider(
                  height: 1,
                  thickness: 1.5,
                  color: AppColors.notificationIconColor),
            ],
          ),
        ),
      );
    }
    else if (widget.myNotification.notifType == "likedPost") {
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 8, 4),
                    child: CircleAvatar(
                      foregroundColor: AppColors.notificationIconColor,
                      backgroundColor: AppColors.profileScreenBackgroundColor,
                      radius: 30,
                      child: ClipOval(child: Icon(
                        Icons.favorite,
                        size: 50.0,
                      ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Text(
                      userName,
                      style: notificationText,
                    ),
                  ),
                  Container(
                    constraints:
                    BoxConstraints(maxWidth: screenWidth(context) * 0.65),
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Column(children: [
                      Text(
                        "liked your post!",
                        maxLines: 3,
                        style: notificationText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
                  ),
                  const SizedBox(width: 6),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 80,
                    ),

                    SizedBox(
                      width: 15,
                    ),

                  ],
                ),
              ),
              const Divider(
                  height: 1,
                  thickness: 1.5,
                  color: AppColors.notificationIconColor),
            ],
          ),
        ),
      );
    }
    else if (widget.myNotification.notifType=="commentedToPost"){
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 8, 4),
                    child: CircleAvatar(
                      foregroundColor: AppColors.notificationIconColor,
                      backgroundColor: AppColors.profileScreenBackgroundColor,
                      radius: 30,
                      child: ClipOval(child: Icon(
                        Icons.comment_outlined,
                        size: 50.0,
                      ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Text(
                      userName,
                      style: notificationText,
                    ),
                  ),
                  Container(
                    constraints:
                    BoxConstraints(maxWidth: screenWidth(context) * 0.65),
                    padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                    child: Column(children: [
                      Text(
                        "commented your post!",
                        maxLines: 3,
                        style: notificationText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
                  ),
                  const SizedBox(width: 6),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(
                      width: 80,
                    ),

                    SizedBox(
                      width: 15,
                    ),

                  ],
                ),
              ),
              const Divider(
                  height: 1,
                  thickness: 1.5,
                  color: AppColors.notificationIconColor),
            ],
          ),
        ),
      );
    }
    else  {
      return Container();
    }
    /*
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
@ -109,5 +439,6 @@ class NotificationsCard extends StatelessWidget {
        ),
      ),
    );
    */
  }
}