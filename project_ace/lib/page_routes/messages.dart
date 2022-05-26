import 'package:firebase_analytics/firebase_analytics.dart';
import "package:flutter/material.dart";
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/search.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/current_user.dart';
import 'package:project_ace/services/database.dart';
import 'package:project_ace/templates/chat_room.dart';
import 'package:project_ace/user_interfaces/chat_room_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import "package:project_ace/templates/message.dart";

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = '/messages';

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  //TODO Get chat_rooms that contain current user
  List<ChatRoom> chatRooms = [];

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Messages View", "messagesView");
    return Scaffold(
      backgroundColor: AppColors.profileScreenBackgroundColor,
      bottomNavigationBar: SizedBox(
        height: screenHeight(context) * 0.095,
        child: BottomAppBar(
          color: AppColors.welcomeScreenBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    tooltip: "Messages",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.email,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {}),
                const Spacer(),
                IconButton(
                    tooltip: "Search",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Search.routeName);
                    }),
                const Spacer(),
                IconButton(
                    tooltip: "Home",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.home,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Feed.routeName, (route) => false);
                    }),
                const Spacer(),
                IconButton(
                    tooltip: "Add Post",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AddPost.routeName);
                    }),
                const Spacer(),
                IconButton(
                    tooltip: "Profile",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.person_outline,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, OwnProfileView.routeName, (route) => false);
                    }),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: AppColors.profileScreenTextColor,
        backgroundColor: AppColors.profileScreenBackgroundColor,
        title: Row(
          children: [
            const Spacer(),
            SizedBox(
              width: screenWidth(context) * 0.6,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Messages",
                  style: messageHeader,
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notifications');
              },
              icon: const Icon(
                Icons.notifications_active,
                color: AppColors.bottomNavigationBarBackgroundColor,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
                children: chatRooms
                    .map((chatRoom) => ChatRoomCard(myChatRoom: chatRoom, otherUser: CurrentUser.sharedPreferenceUserNameKey == chatRoom.usersChatting[0] ? DatabaseMethods().searchByName(chatRoom.usersChatting[1]).docs[0] : DatabaseMethods().searchByName(chatRoom.usersChatting[0]).docs[0]))
                    .toList())),
      ),
    );
  }
}
