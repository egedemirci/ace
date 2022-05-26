import 'package:flutter/material.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required this.post, required this.user}) : super(key: key);
  final Post post;
  final MyUser user;

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
                    child: post.urlAvatar != "default"
                        ? ClipOval(
                            child: Image.network(
                              post.urlAvatar,
                            ),
                          )
                        : ClipOval(
                            child: Image.network(
                              "https://minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg",
                            ),
                          ),
                  ),
                ),
                // TODO: Add the correct text style here
                Text(
                  post.fullName,
                  style: postCardUserRealName,
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    "@${post.username}",
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
                  child: Text(
                    post.text,
                    maxLines: 3,
                    style: postText,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                  child: IconButton(
                    icon: const Icon(Icons.thumb_up_alt_outlined),
                    onPressed: () {},
                    iconSize: 20,
                    splashRadius: 20,
                  ),
                ),
                Text(
                  "${post.likes}",
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
            Center(
              child: post.assetUrl != "default"
                  ? ClipRect(
                      child: Image.network(
                        post.assetUrl,
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
