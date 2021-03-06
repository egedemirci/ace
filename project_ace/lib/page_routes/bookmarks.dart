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
  UserServices userServices = UserServices();
  PostServices postServices = PostServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    setCurrentScreen(widget.analytics, "Bookmarks View", "bookmarks.dart");
    setUserId(widget.analytics, user!.uid);
    return Scaffold(
        backgroundColor: AppColors.profileScreenBackgroundColor,
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
          title: SizedBox(
            width: screenWidth(context) * 0.6,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Bookmarks",
                style: messageHeader,
              ),
            ),
          ),
          elevation: 0,
          centerTitle: true,
          toolbarHeight: screenHeight(context) * 0.08,
          foregroundColor: AppColors.welcomeScreenBackgroundColor,
          backgroundColor: AppColors.profileScreenBackgroundColor,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: userServices.usersRef.snapshots().asBroadcastStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<dynamic> userList = snapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) {
                return element["userId"] == user.uid;
              }).toList();
              MyUser myUser =
                  MyUser.fromJson(userList[0].data() as Map<String, dynamic>);
              if (myUser.isDisabled == false) {
                return StreamBuilder<QuerySnapshot>(
                    stream:
                        postServices.postsRef.snapshots().asBroadcastStream(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> querySnapshot) {
                      if (!querySnapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        List<dynamic> bookmarks = querySnapshot.data!.docs
                            .where((QueryDocumentSnapshot<Object?> element) {
                          return (myUser.bookmarks.contains(element["postId"]));
                        }).toList();
                        bookmarks.sort(
                            (a, b) => a["createdAt"].compareTo(b["createdAt"]));
                        if (bookmarks.isEmpty) {
                          return Center(
                            child: Text(
                              "You have no bookmarks.",
                              style: bookmarksScreenNoBookmarks,
                            ),
                          );
                        }
                        return SingleChildScrollView(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: List.from(
                                  bookmarks
                                      .map((post) => PostCard(
                                            post: Post.fromJson(post.data()
                                                as Map<String, dynamic>),
                                            isMyPost: false,
                                            deletePost: () {
                                              setState(() {
                                                postServices.deletePost(
                                                    user.uid, post);
                                              });
                                            },
                                            incrementLike: () {
                                              postServices.likePost(
                                                  myUser.userId,
                                                  post["userId"],
                                                  post["postId"]);
                                            },
                                            incrementDislike: () {
                                              postServices.dislikePost(
                                                  myUser.userId,
                                                  post["userId"],
                                                  post["postId"]);
                                            },
                                            myUserId: user.uid,
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
                    });
              } else {
                return const Center(child: Text("Your account is not active."));
              }
            }
          },
        ));
  }
}
