import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/search.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/database.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/user_interfaces/post_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = "/feed";

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  //TODO Get the posts of the users that current user following
  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Feed View", "feedView");
    return Scaffold(
      backgroundColor: AppColors.profileScreenBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: screenWidth(context) * 0.6,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Feed",
              style: feedHeader,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.profileScreenBackgroundColor,
      ),
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
                    onPressed: () {
                      Navigator.pushNamed(context, MessageScreen.routeName);
                    }),
                const Spacer(),
                IconButton(
                    tooltip: "Search",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
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
                    onPressed: () {}),
                const Spacer(),
                IconButton(
                    tooltip: "Add Post",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: posts
                  .map((post) => PostCard(
                        post: post,
                        //TODO sanki yanlış bu
                        user: DatabaseMethods().searchByName(post.username).docs[0]
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
