import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/chat.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/chat_room.dart';
import 'package:project_ace/templates/message.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:project_ace/utilities/screen_sizes.dart';

class ChatRoomCard extends StatefulWidget {
  const ChatRoomCard({Key? key,
    required this.myChatRoom,
    required this.otherUserId,
  required this.analytics}) : super(key: key);

  final ChatRoom myChatRoom;
  final String otherUserId;
  final FirebaseAnalytics analytics;

  @override
  State<ChatRoomCard> createState() => _ChatRoomCardState();
}

class _ChatRoomCardState extends State<ChatRoomCard> {
  UserServices userService = UserServices();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userService.usersRef.doc(widget.otherUserId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.connectionState != ConnectionState.done){
              return Container();
            }
          else{
            MyUser otherUser = MyUser.fromJson(((snapshot.data!.data() ?? Map<String,dynamic>.identity()) as Map<String,dynamic>));
            return  Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.zero, bottom: Radius.circular(0))),
              color: AppColors.profileScreenBackgroundColor,
              elevation: 0,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(chatId: widget.myChatRoom.chatRoomId, otherUserId: widget.otherUserId, analytics: widget.analytics,)));
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
                          backgroundImage: NetworkImage(otherUser.profilepicture),
                          //child: ClipOval(child: Image.network(otherUser.profilepicture)),
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
                                    otherUser.fullName,
                                    style: messageUserRealName,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    otherUser.username,
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
                                    "${widget.myChatRoom.lastMessage} ",
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
        });
  }
}

