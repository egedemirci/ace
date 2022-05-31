import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

class BookMarks extends StatefulWidget {
  const BookMarks({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = "/bookmarks";

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  List<Post> posts = [];
  UserServices userService = UserServices();
  PostService postService = PostService();

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Bookmarks View", "bookmarks.dart");
    final user = Provider.of<User?>(context);
    setUserId(widget.analytics, user!.uid);
    return Scaffold(
        backgroundColor: AppColors.profileScreenBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: SizedBox(
            width: screenWidth(context) * 0.6,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Bookmarks",
                style: feedHeader,
              ),
            ),
          ),
          foregroundColor: AppColors.welcomeScreenBackgroundColor,
          elevation: 0,
          backgroundColor: AppColors.profileScreenBackgroundColor,
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: userService.usersRef.doc(user.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        List<dynamic> postsList = querySnapshot.data!.docs
                            .where((QueryDocumentSnapshot<Object?> element) {
                              return ((myUser.following
                                      .contains(element["userId"])) &&
                                  !element["isDisabled"]);
                            })
                            .map((data) => (data["bookmarks"]))
                            .toList();
                        List<dynamic> bookmarks = [];
                        for (int j = 0; j < postsList.length; j++) {
                          for (int k = 0; k < postsList[j].length; k++) {
                            bookmarks += [postsList[j][k]];
                          }
                        }
                        bookmarks.sort(
                            (a, b) => a["createdAt"].compareTo(b["createdAt"]));
                        return SingleChildScrollView(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: List.from(
                                  bookmarks
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
                                            postService.likePost(user.uid,
                                                myUser.userId, post["postId"]);
                                          },
                                          incrementComment: () {
                                            // TODO: COMMENT VIEW
                                          },
                                          incrementDislike: () {
                                            postService.dislikePost(user.uid,
                                                myUser.userId, post["postId"]);
                                          },
                                          reShare: () {
                                            // TODO: Re-share
                                          }))
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
                return const Center(child: Text("Your account is not active."));
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
