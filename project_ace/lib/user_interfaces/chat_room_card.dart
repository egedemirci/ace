import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/chat.dart';
import 'package:project_ace/templates/chat_room.dart';
import 'package:project_ace/templates/message.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';

import '../utilities/screen_sizes.dart';

class ChatRoomCard extends StatelessWidget {
  const ChatRoomCard({Key? key, required this.myChatRoom, required this.otherUser}) : super(key: key);
  final ChatRoom myChatRoom;
  final MyUser otherUser;

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
              //TODO navigate to this chatrooms chatpage
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
                  radius: screenWidth(context) * 0.10,
                  child: ClipOval(child: Image.network(otherUser.urlAvatar)),
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
                            "${otherUser.fullName} ",
                            style: messageUserRealName,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "@${otherUser.userName} ",
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
                            "${myChatRoom.lastMessage} ",
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
