import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/chat.dart';
import 'package:project_ace/templates/message.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:project_ace/utilities/screen_sizes.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({Key? key, required this.myMessage}) : super(key: key);
  final Message myMessage;

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
          // TODO: Extend the implementation of Screen Sizes
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, ChatPage.routeName);
            },
            child: Row(
              children: [
                CircleAvatar(
                  foregroundColor: AppColors.notificationIconColor,
                  backgroundColor: AppColors.profileScreenBackgroundColor,
                  radius: screenWidth(context) * 0.10,
                  child: ClipOval(child: Image.network(myMessage.urlAvatar)),
                ),
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
                      constraints:
                          BoxConstraints(maxWidth: screenWidth(context) * 0.65),
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
