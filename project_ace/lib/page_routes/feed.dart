import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/firestore_search.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/user_interfaces/post_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = "/feed";

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Post> posts = [];
  UserServices userService = UserServices();
  PostService postService = PostService();

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Feed View", "feed.dart");
    final user = Provider.of<User?>(context);
    if (user == null) {
      return Login(
        analytics: widget.analytics,
      );
    } else {
      setUserId(widget.analytics, user.uid);
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
                  style: messageHeader,
                ),
              ),
            ),
            toolbarHeight: screenHeight(context) * 0.08,
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
                        Navigator.pushNamedAndRemoveUntil(context,
                            FirestoreSearch.routeName, (route) => false);
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
                      onPressed: () {},
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
                    // TODO: Implement sizes for IconButton
                    IconButton(
                      tooltip: "Profile",
                      iconSize: screenWidth(context) * 0.08,
                      icon: const Icon(
                        Icons.person_outline,
                        color: AppColors.bottomNavigationBarIconOutlineColor,
                      ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            OwnProfileView.routeName, (route) => false);
                      },
                      splashRadius: screenWidth(context) * 0.07,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: FutureBuilder<DocumentSnapshot>(
            future: userService.usersRef.doc(user.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("Oops, something went wrong"));
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
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          List<dynamic> postsList = querySnapshot.data!.docs
                              .where((QueryDocumentSnapshot<Object?> element) {
                                return ((myUser.following
                                        .contains(element["userId"])) &&
                                    !element["isDisabled"]);
                              })
                              .map((data) => (data["posts"]))
                              .toList();
                          List<dynamic> followingPosts = [];
                          for (int j = 0; j < postsList.length; j++) {
                            for (int k = 0; k < postsList[j].length; k++) {
                              followingPosts += [postsList[j][k]];
                            }
                          }
                          followingPosts.sort((a, b) =>
                              a["createdAt"].compareTo(b["createdAt"]));
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
                                              deletePost: () {
                                                setState(() {
                                                  postService.deletePost(
                                                      user.uid, post);
                                                });
                                              },
                                              incrementLike: () {
                                                postService.likePost(
                                                    myUser.userId,
                                                    post["userId"],
                                                    post["postId"]);
                                              },
                                              incrementComment: () {
                                                // TODO: COMMENT VIEW
                                              },
                                              incrementDislike: () {
                                                postService.dislikePost(
                                                    myUser.userId,
                                                    post["userId"],
                                                    post["postId"]);
                                              },
                                              reShare: () {
                                                // TODO: Re-share
                                              },
                                              myUserId: user.uid,
                                            ))
                                        .toList()
                                        .reversed,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      });
                } else {
                  return const Center(
                      child: Text("Your account is not active."));
                }
              }
              return const Center(child: CircularProgressIndicator());
            },
          ));
    }
  }
}
