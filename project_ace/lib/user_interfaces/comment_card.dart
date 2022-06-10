import 'package:flutter/material.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/comment.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({Key? key, required this.comment}) : super(key: key);
  final Comment comment;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  UserServices userService = UserServices();
  String otherUsername = " ";
  String otherUserpp = "default";

  Future getUserName() async {
    final uname = await userService.getUsername(widget.comment.userId);
    setState(() {
      otherUsername = "@$uname";
    });
  }

  Future getUserPP() async {
    final upp = await userService.getUserProfilePicture(widget.comment.userId);
    setState(() {
      otherUserpp = upp;
    });
  }

  @override
  void initState() {
    getUserName();
    getUserPP();
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
                    backgroundImage: (otherUserpp != "default")
                        ? NetworkImage(otherUserpp)
                        : const NetworkImage(
                            "https://minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg"),
                  ),
                ),
                SizedBox(width: screenWidth(context) * 0.015),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    otherUsername,
                    style: postCardUserName,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.comment.text,
                      maxLines: 3,
                      style: postText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                    child: Text(widget.comment.createdAt
                        .toLocal()
                        .toString()
                        .substring(
                            0,
                            widget.comment.createdAt
                                    .toLocal()
                                    .toString()
                                    .length -
                                7))),
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
