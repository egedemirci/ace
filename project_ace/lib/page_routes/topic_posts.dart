import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/search.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/templates/topic.dart';
import 'package:project_ace/user_interfaces/post_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';

class TopicPostsView extends StatefulWidget {
  const TopicPostsView({Key? key, required this.topic, required this.analytics})
      : super(key: key);
  final Topic topic;
  final FirebaseAnalytics analytics;

  @override
  State<TopicPostsView> createState() => _TopicPostsViewState();
}

class _TopicPostsViewState extends State<TopicPostsView> {
  PostServices postService = PostServices();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Topic Posts", "topic_posts.dart");
    final user = Provider.of<User?>(context);
    return Scaffold(
        backgroundColor: AppColors.profileScreenBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
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
          title: SizedBox(
            width: screenWidth(context) * 0.6,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "#${widget.topic.text}",
                style: messageHeader,
              ),
            ),
          ),
          toolbarHeight: screenHeight(context) * 0.08,
          elevation: 0,
          backgroundColor: AppColors.profileScreenBackgroundColor,
          foregroundColor: AppColors.profileScreenTextColor,
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
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, MessageScreen.routeName);
                    },
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
                      Navigator.pushNamed(context, Search.routeName);
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
        body: StreamBuilder<QuerySnapshot>(
            stream: UserServices().usersRef.snapshots().asBroadcastStream(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> querySnapshot) {
              if (!querySnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                List<dynamic> postsList = querySnapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) {
                      return (!element["isDisabled"]);
                    })
                    .map((data) => (data["posts"]))
                    .toList();
                List<dynamic> followingPosts = [];
                for (int j = 0; j < postsList.length; j++) {
                  for (int k = 0; k < postsList[j].length; k++) {
                    if (widget.topic.postIdList
                        .contains(postsList[j][k]['postId'])) {
                      followingPosts += [postsList[j][k]];
                    }
                  }
                }
                followingPosts
                    .sort((a, b) => a["createdAt"].compareTo(b["createdAt"]));
                return SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: List.from(
                          followingPosts
                              .map((post) => PostCard(
                                    post: Post.fromJson(post),
                                    isMyPost: false,
                                    deletePost: () {},
                                    incrementLike: () {
                                      postService.likePost(user!.uid,
                                          post["userId"], post["postId"]);
                                    },
                                    incrementDislike: () {
                                      postService.dislikePost(user!.uid,
                                          post["userId"], post["postId"]);
                                    },
                                    myUserId: user!.uid,
                                    analytics: widget.analytics,
                                  ))
                              .toList()
                              .reversed,
                        ),
                      ),
                    ),
                  ),
                );
              }
            }));
  }
}
