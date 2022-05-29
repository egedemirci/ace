import 'package:flutter/material.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';

class PostCard extends StatelessWidget {
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
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                  splashRadius: 20,
                )
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
                      post.text,
                      maxLines: 3,
                      style: postText,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
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
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  onPressed: incrementLike,
                  iconSize: 20,
                  splashRadius: 20,
                ),
                Text(
                  "${post.likeCount}",
                  style: const TextStyle(fontSize: 14),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                  child: IconButton(
                    icon: const Icon(Icons.thumb_down_alt_outlined),
                    onPressed: incrementDislike,
                    iconSize: 20,
                    splashRadius: 20,
                  ),
                ),
                Text(
                  "${post.dislikeCount}",
                  style: const TextStyle(fontSize: 14),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                  child: IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: incrementComment,
                    iconSize: 20,
                    splashRadius: 20,
                  ),
                ),
                Text(
                  "${post.commentCount}",
                  style: const TextStyle(fontSize: 14),
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                    child: Text(post.createdAt.toLocal().toString().substring(
                        0, post.createdAt.toLocal().toString().length - 7))),
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
