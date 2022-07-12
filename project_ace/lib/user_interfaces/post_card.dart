import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_ace/page_routes/comment_view.dart';
import 'package:project_ace/page_routes/edit_post.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/services/report_services.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/menu_item.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/templates/screen_arguments.dart';
import 'package:project_ace/templates/video_items.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:video_player/video_player.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final VoidCallback deletePost;
  final VoidCallback incrementLike;
  final VoidCallback incrementDislike;
  final bool isMyPost;
  final String myUserId;
  final FirebaseAnalytics analytics;

  const PostCard({
    Key? key,
    required this.post,
    required this.deletePost,
    required this.incrementLike,
    required this.incrementDislike,
    required this.isMyPost,
    required this.myUserId,
    required this.analytics,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final ReportService _reportService = ReportService();
  final UserServices _userServices = UserServices();
  final PostServices _postService = PostServices();
  String userProfilePicture = "default";
  String userNameForReShare = "";

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

  void onSelected(BuildContext context, PostMenuItem item) async {
    switch (item) {
      case PostMenuItems.reportPost:
        await _reportService.reportPost(widget.myUserId, widget.post.postId,
            widget.post.userId, widget.post.username);
        _showDialog("Reported!",
            "You successfully reported ${widget.post.username}'s post!");
        break;
      case PostMenuItems.bookmarkPost:
        await _userServices.addBookmark(
            FirebaseAuth.instance.currentUser!.uid, widget.post.postId);
        break;
      case PostMenuItems.reSharePost:
        await _postService.reSharePost(
            FirebaseAuth.instance.currentUser!.uid, widget.post);
        break;
      case PostMenuItems.deletePost:
        await _postService.deletePost(
            FirebaseAuth.instance.currentUser!.uid, widget.post.toJson());
        _showDialog("Deleted!", "You successfully deleted the post!");
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, OwnProfileView.routeName, (route) => false);
        break;
      case PostMenuItems.editPost:
        Navigator.pushNamed(context, EditPostView.routeName,
            arguments: ScreenArguments(widget.post.postId));
        break;
    }
  }

  Future getUserPP() async {
    if (widget.post.isShared) {
      final upp =
          await _userServices.getUserProfilePicture(widget.post.fromWho);
      setState(() {
        userProfilePicture = upp;
      });
    } else {
      final upp = await _userServices.getUserProfilePicture(widget.post.userId);
      setState(() {
        userProfilePicture = upp;
      });
    }
  }

  getUserName() async {
    final uname = await _userServices.getUsername(widget.post.userId);
    setState(() {
      userNameForReShare = '@$uname';
    });
  }

  @override
  void initState() {
    getUserPP();
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.zero, bottom: Radius.circular(0))),
      color: AppColors.profileScreenBackgroundColor,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.post.isShared == true)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.repeat,
                        color: AppColors.reshareColor,
                        size: screenWidth(context) * 0.039),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text("Re-shared by $userNameForReShare",
                          style: reshare),
                    ),
                  ],
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: CircleAvatar(
                    backgroundColor: AppColors.welcomeScreenBackgroundColor,
                    radius: 20,
                    backgroundImage: (userProfilePicture != "default")
                        ? NetworkImage(userProfilePicture)
                        : const NetworkImage(
                            "https://minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 10, 1, 0),
                  child: Text(
                    widget.post.fullName,
                    style: postCardUserRealName,
                  ),
                ),
                SizedBox(width: screenWidth(context) * 0.015),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "@${widget.post.username}",
                    style: postCardUserName,
                  ),
                ),
                SizedBox(width: screenWidth(context) * 0.015),
                const Spacer(),
                PopupMenuButton<PostMenuItem>(
                    splashRadius: screenWidth(context) * 0.045,
                    onSelected: (item) => onSelected(context, item),
                    itemBuilder: (context) => (widget.post.isShared &&
                            widget.post.userId == widget.myUserId
                        ? [
                            ...PostMenuItems.resharedPostList
                                .map(buildItem)
                                .toList(),
                          ]
                        : (widget.isMyPost
                            ? [
                                ...PostMenuItems.userPostList
                                    .map(buildItem)
                                    .toList()
                              ]
                            : [
                                ...PostMenuItems.otherUsersPostList
                                    .map(buildItem)
                                    .toList(),
                              ]))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                  Row(children: [
                    if (widget.post.topic.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Text(
                          '#${widget.post.topic}',
                          style: topicText,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    const Spacer(),
                    if (widget.post.location.isNotEmpty)
                      Icon(
                        Icons.location_on_outlined,
                        size: screenWidth(context) * 0.034,
                        color: AppColors.profileSettingButtonFillColor,
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 3, 0, 0),
                      child: Text(
                        widget.post.location,
                        style: location,
                      ),
                    ),
                    SizedBox(width: screenWidth(context) * 0.024),
                  ])
                ],
              ),
            ),
            Center(
              child: widget.post.assetUrl != "default"
                  ? (widget.post.mediaType == "video"
                      ? SizedBox(
                          width: screenWidth(context) * 0.97,
                          height: screenHeight(context) * 0.46,
                          child: VideoItems(
                            videoPlayerController:
                                VideoPlayerController.network(
                                    widget.post.assetUrl),
                            looping: false,
                            autoplay: false,
                          ))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            widget.post.assetUrl,
                            width: screenWidth(context) * 0.97,
                            height: screenHeight(context) * 0.46,
                            fit: BoxFit.cover,
                          ),
                        ))
                  : Container(),
            ),
            SizedBox(
              height: screenHeight(context) * 0.012,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up_alt_outlined,
                      color: AppColors.reshareColor),
                  onPressed: widget.incrementLike,
                  iconSize: screenHeight(context) * 0.023,
                  splashRadius: screenHeight(context) * 0.024,
                ),
                Text(widget.post.likes.length.toString(), style: bottomPost),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: IconButton(
                    icon: const Icon(Icons.thumb_down_alt_outlined,
                        color: AppColors.reshareColor),
                    onPressed: widget.incrementDislike,
                    iconSize: screenHeight(context) * 0.023,
                    splashRadius: screenHeight(context) * 0.024,
                  ),
                ),
                Text(
                  widget.post.dislikes.length.toString(),
                  style: bottomPost,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: IconButton(
                    icon: const Icon(Icons.comment,
                        color: AppColors.reshareColor),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentView(
                                    postId: widget.post.postId,
                                    analytics: widget.analytics,
                                  )));
                    },
                    iconSize: screenHeight(context) * 0.023,
                    splashRadius: screenHeight(context) * 0.024,
                  ),
                ),
                Text(
                  widget.post.comments.length.toString(),
                  style: bottomPost,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                      DateFormat('kk:mm - yyyy-MM-dd')
                          .format(widget.post.createdAt),
                      style: bottomPost),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight(context) * 0.012,
            ),
            Divider(
                height: screenHeight(context) * 0.012,
                thickness: screenHeight(context) * 0.000575,
                color: AppColors.welcomeScreenBackgroundColor),
          ],
        ),
      ),
    );
  }
}
