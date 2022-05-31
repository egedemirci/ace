import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_ace/page_routes/edit_post.dart';
import 'package:project_ace/page_routes/screen_arguments.dart';
import 'package:project_ace/services/auth_services.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/services/report_services.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/menu_item.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';


class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback deletePost;
  final VoidCallback incrementLike;
  final VoidCallback incrementComment;
  final VoidCallback incrementDislike;
  final VoidCallback reShare;
  final bool isMyPost;

  const PostCard({
    Key? key,
    required this.post,
    required this.deletePost,
    required this.incrementLike,
    required this.incrementComment,
    required this.incrementDislike,
    required this.reShare,
    required this.isMyPost,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  final AuthServices _auth = AuthServices();
  final ReportService _reportService = ReportService();
  final UserServices _userServices = UserServices();
  final PostService _postService = PostService();
  //final FirebaseAnalytics analytics;

  PopupMenuItem<PostMenuItem> buildItem(PostMenuItem item) => PopupMenuItem(
        value: item,
        child: Row(
          children: [
            Icon(item.icon),
            const SizedBox(
              width: 10,
            ),
            Text(item.text),
          ],
        ),
      );

  Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(message),
                    ],
                  )),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(message),
                    ],
                  )),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        });
  }

  void onSelected(BuildContext context, PostMenuItem item) async{
    switch (item) {
      case PostMenuItems.reportPost:
        await _reportService.reportPost(widget.post.postId, widget.post.userId);
        _showDialog("Reported!", "You successfully reported ${widget.post.username}'s post!");
        break;
      case PostMenuItems.bookmarkPost:
        await _userServices.addBookmark(FirebaseAuth.instance.currentUser!.uid, widget.post);
        _showDialog("Bookmark Added!", "You successfully added  ${widget.post.username}'s post into your bookmark list!");
        break;
      case PostMenuItems.reSharePost:
        break; // TODO: Implement here
      case PostMenuItems.deletePost:
        await _postService.deletePost(FirebaseAuth.instance.currentUser!.uid, widget.post.toJson());
        _showDialog("Deleted!", "You successfully deleted the post!");
        break;
      case PostMenuItems.editPost:
        Navigator.pushNamed(context, EditPostView.routeName,arguments: ScreenArguments(widget.post.postId));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Extend the implementation of Screen Sizes
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.zero, bottom: Radius.circular(0))),
      color: AppColors.profileScreenBackgroundColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: CircleAvatar(
                    backgroundColor: AppColors.welcomeScreenBackgroundColor,
                    radius: 20,
                      backgroundImage: (widget.post.urlAvatar != "default") ? NetworkImage(widget.post.urlAvatar): const NetworkImage( "https://minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,2,0,0),
                  child: Text(
                    widget.post.fullName,
                    style: postCardUserRealName,
                  ),
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    "@${widget.post.username}",
                    style: postCardUserName,
                  ),
                ),
                const Spacer(),
                PopupMenuButton<PostMenuItem>(
                    onSelected: (item) => onSelected(context, item),
                    itemBuilder: (context) => (widget.isMyPost == true)
                        ? [
                            ...PostMenuItems.userPostList
                                .map(buildItem)
                                .toList(),
                          ]
                        : [
                            ...PostMenuItems.otherUsersPostList
                                .map(buildItem)
                                .toList(),
                          ]),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // TODO: Add the correct text style here
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.post.text,
                        maxLines: 3,
                        style: postText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: widget.post.assetUrl != "default"
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                        widget.post.assetUrl,
                        width: screenWidth(context) * 0.9708737864,
                        height: screenHeight(context) * 0.4602991945,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  onPressed: widget.incrementLike,
                  iconSize: 20,
                  splashRadius: 20,
                ),
                Text(
                  widget.post.likes.length.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                  child: IconButton(
                    icon: const Icon(Icons.thumb_down_alt_outlined),
                    onPressed: widget.incrementDislike,
                    iconSize: 20,
                    splashRadius: 20,
                  ),
                ),
                Text(
                  widget.post.dislikes.length.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                  child: IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: widget.incrementComment,
                    iconSize: 20,
                    splashRadius: 20,
                  ),
                ),
                Text(
                  widget.post.comments.length.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                    child: Text(DateFormat('kk:mm - yyyy-MM-dd').format(widget.post.createdAt))
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
                height: 10,
                thickness: 0.5,
                color: AppColors.welcomeScreenBackgroundColor),
          ],
        ),
      ),
    );
  }
}
