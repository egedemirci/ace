import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/search.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/services/user_services.dart';
import "package:project_ace/templates/comment.dart";
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/user_interfaces/comment_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';

class CommentView extends StatefulWidget {
  final Post post;
  final FirebaseAnalytics analytics;
  static const String routeName = "/comment";

  const CommentView({Key? key, required this.post, required this.analytics})
      : super(key: key);

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  UserServices userService = UserServices();
  PostService postService = PostService();
  String comment = "";

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Comments View", "comment_view.dart");
    final user = Provider.of<User?>(context);
    if(user!=null){
      setUserId(widget.analytics, user.uid);
    }
    if (user == null) {
      return Login(
        analytics: widget.analytics,
      );
    } else {
      return Scaffold(
          backgroundColor: AppColors.profileScreenBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: SizedBox(
              width: screenWidth(context) * 0.6,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Comments",
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
                          Navigator.pushNamedAndRemoveUntil(context,
                              OwnProfileView.routeName, (route) => false);
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
                  children: List.from(
                    widget.post.comments.map(
                      (comment) =>
                          CommentCard(comment: Comment.fromJson(comment)),
                    ),
                  ),
                ),
              ),
            ),
          ));
    }
  }
}
