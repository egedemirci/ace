import 'package:flutter/material.dart';
import 'package:project_ace/templates/comment.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:project_ace/utilities/screen_sizes.dart';

class CommentCard extends StatelessWidget {
  const CommentCard(
      {Key? key,
        required this.comment})
      : super(key: key);
  final Comment comment;


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
                    child: comment.urlAvatar != "default"
                        ? ClipOval(
                      child: Image.network(
                        comment.urlAvatar,
                      ),
                    )
                        : ClipOval(
                      child: Image.network(
                        "https://minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg",
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    "@${comment.username}",
                    style: postCardUserName,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // TODO: Add the correct text style here
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      comment.text,
                      maxLines: 3,
                      style: postText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: comment.urlAvatar != "default"
                  ? ClipRect(
                child: Image.network(
                  comment.urlAvatar,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fitHeight,
                ),
              )
                  : Container(),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(children:[
                Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                    child: Text(comment.createdAt.toLocal().toString().substring(
                        0, comment.createdAt.toLocal().toString().length - 7))),
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
