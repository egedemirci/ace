import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:project_ace/page_routes/add_post.dart';
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
  final String postId;
  final FirebaseAnalytics analytics;
  static const String routeName = "/comment";

  const CommentView({Key? key, required this.postId, required this.analytics})
      : super(key: key);

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final _controller = TextEditingController();
  UserServices userService = UserServices();
  PostService postService = PostService();
  String comment = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    setCurrentScreen(widget.analytics, "Comments View", "comment_view.dart");
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
          toolbarHeight: screenHeight(context) * 0.08,
          elevation: 0,
          centerTitle: true,
          foregroundColor: AppColors.welcomeScreenBackgroundColor,
          title: Row(
            children: [
              SizedBox(
                  width: screenWidth(context) * 0.60,
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Comments", style: feedHeader,))),
              // TODO: Implement sizes for IconButton

            ],
          ),
          backgroundColor: AppColors.profileScreenBackgroundColor,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: postService.postsRef.doc(widget.postId).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot){
              if (snapshot.hasError) {
                return const Center(child: Text("Oops, something went wrong"));
              }
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.data() != null){
                List<dynamic> comments = (snapshot.data!.data() as Map<String, dynamic>)["comments"];
                Post myPost = Post.fromJson(snapshot.data!.data() as Map<String, dynamic>);

                return Column(
                  children: [Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(20),
                      itemCount: comments.length,
                      itemBuilder: (BuildContext context, int index){
                        Comment comment = Comment.fromJson(
                            comments.reversed.toList()[index]);
                        return CommentCard(comment: comment);
                      },
                    ),
                  ),
                    Container(
                      color: AppColors.profileScreenBackgroundColor,
                      height: screenHeight(context) * 0.110,
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                                controller: _controller,
                                textCapitalization: TextCapitalization.sentences,
                                autocorrect: true,
                                enableSuggestions: true,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: 'Type your comment',
                                  labelStyle: writeSomething,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 0),
                                    gapPadding: screenHeight(context) * 0.0115,
                                    borderRadius:
                                    BorderRadius.circular(screenHeight(context) * 0.028),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    comment = value;
                                  });
                                }),
                          ),
                          SizedBox(width: screenWidth(context) * 0.048),
                          IconButton(
                              onPressed: comment.trim().isEmpty
                                  ? null
                                  : () {
                                postService.sendCommendTo(user.uid, myPost.userId, myPost.postId, Comment(text: comment, userId: user.uid, createdAt: DateTime.now()));
                                comment = "";
                                _controller.clear();
                                FocusScope.of(context).unfocus();
                              },
                              icon: Container(
                                  padding: const EdgeInsets.fromLTRB(6, 4, 8, 8),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue,
                                  ),
                                  // TODO: Icon sizes
                                  child: const Icon(
                                    Icons.send, color: Colors.white,
                                    // size: screenHeight(context) * ,
                                  ))),
                        ],
                      ),
                    )
                  ]
                );
              }
              return const CircularProgressIndicator();
            }

        )
    );
  }
}
