import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/chat.dart';
import 'package:project_ace/templates/message.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';

import '../utilities/screen_sizes.dart';

class MessageCard extends StatelessWidget {
  final Message myMessage;
  const MessageCard({required this.myMessage});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.zero, bottom: Radius.circular(0))),
      color: AppColors.profileScreenBackgroundColor,
      elevation: 0,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ChatPage.routeName);
            },
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //photo
                CircleAvatar(
                  foregroundColor: AppColors.notificationIconColor,
                  backgroundColor: AppColors.profileScreenBackgroundColor,
                  child: ClipOval(child: Image.network(myMessage.urlAvatar)),
                  radius: screenWidth(context)*0.10,
                ),
                //text ve name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 12, 6),
                      child: Row(
                        children: [
                          Text(
                            "${myMessage.fullName} ",
                            style: messageUserRealName,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "@${myMessage.username} ",
                            style: messageUserName,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 0, 15),
                      constraints: BoxConstraints(maxWidth: screenWidth(context)*0.65),
                      child: Column(
                        children: [
                          Text(
                            "${myMessage.message} ",
                            style: messageText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.0,
            height: 1,
            color: AppColors.notificationIconColor,
          ),
        ],
      ),
    );
  }
}
