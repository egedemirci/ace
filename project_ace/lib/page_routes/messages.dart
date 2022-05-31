import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/search.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/message_services.dart';
import 'package:project_ace/templates/chat_room.dart';
import 'package:project_ace/user_interfaces/chat_room_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import "package:project_ace/templates/message.dart";
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = '/messages';

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Message> allMessages = [];
  MessageService messageService = MessageService();

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Messages View", "messages.dart");
    final user = Provider.of<User?>(context);
    setUserId(widget.analytics, user!.uid);
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
                        Navigator.pushNamedAndRemoveUntil(context,
                            OwnProfileView.routeName, (route) => false);
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
        body: StreamBuilder(
            stream: messageService.chatRoomReference
                .snapshots()
                .asBroadcastStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return SingleChildScrollView(
                    child: SafeArea(
                        child: Column(
                            children: List.from(snapshot.data!.docs
                                .where((element) =>
                                    element["usersChatting"].contains(user.uid))
                                .map((chat) {
                                  String otherChatter =
                                      chat["usersChatting"][0] == user.uid
                                          ? chat["usersChatting"][1]
                                          : chat["usersChatting"][0];

                                  return ChatRoomCard(
                                    myChatRoom: ChatRoom.fromJson(
                                        chat.data() as Map<String, dynamic>),
                                    otherUserId: otherChatter,
                                    analytics: widget.analytics,
                                  );
                                })
                                .toList()
                                .reversed))));
              }
            }));
  }
}
