import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/firestore_search.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/user_list_view.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/message_services.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/chat_room.dart';
import 'package:project_ace/templates/user.dart';
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
  UserServices userService = UserServices();

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
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {},
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Search",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, FirestoreSearch.routeName, (route) => false);
                    },
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Home",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.home,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Feed.routeName, (route) => false);
                    },
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Add Post",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AddPost.routeName);
                    },
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Profile",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.person_outline,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, OwnProfileView.routeName, (route) => false);
                    },
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                ],
              ),
            ),
          ),
        ),
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
          toolbarHeight: screenHeight(context) * 0.08,
          elevation: 0,
          centerTitle: true,
          foregroundColor: AppColors.welcomeScreenBackgroundColor,
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
                icon: Icon(
                  Icons.notifications_active,
                  color: AppColors.bottomNavigationBarBackgroundColor,
                  size: screenHeight(context) * 0.03,
                ),
                splashRadius: screenHeight(context) * 0.032,
              ),
            ],
          ),
          backgroundColor: AppColors.profileScreenBackgroundColor,
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
            }),
        floatingActionButton: FutureBuilder<DocumentSnapshot>(
          future: userService.usersRef.doc(user.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.data() != null) {
              MyUser myUser = MyUser.fromJson((snapshot.data!.data() ??
                  Map<String, dynamic>.identity()) as Map<String, dynamic>);
              if (myUser.isDisabled == false) {
                return StreamBuilder<QuerySnapshot>(
                    stream:
                        userService.usersRef.snapshots().asBroadcastStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      if (!querySnapshot.hasData) {
                        return Container();
                      } else {
                        List<dynamic> userList = querySnapshot.data!.docs
                            .where((QueryDocumentSnapshot<Object?> element) {
                              return ((myUser.following
                                      .contains(element["userId"])) &&
                                  !element["isDisabled"]);
                            })
                            .map((data) => (data["userId"]))
                            .toList();

                        return FloatingActionButton(
                          backgroundColor:
                              AppColors.welcomeScreenBackgroundColor,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserListView(
                                          userIdList: userList,
                                          title: "New Chat",
                                          isNewChat: true,
                                          analytics: widget.analytics,
                                        )));
                          },
                          child: const Icon(Icons.add),
                        );
                      }
                    });
              } else {
                return Container();
              }
            }
            return Container();
          },
        ));
  }
}
