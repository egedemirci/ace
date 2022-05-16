import 'package:flutter/material.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/utilities/colors.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({required this.post});

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
                  padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
                  child: CircleAvatar(
                    backgroundColor: AppColors.welcomeScreenBackgroundColor,
                    child: post.profileImageSource != "default"
                        ? ClipRect(
                            child: Image.network(
                              post.profileImageSource,
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : ClipRect(
                            child: Image.network(
                              "https://minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg",
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                    radius: 15,
                  ),
                ),
                // TODO: Add the correct text style here
                Text(
                  post.fullName,
                  style: const TextStyle(fontSize: 10),
                ),
                const SizedBox(width: 6),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                  child: Text(
                    "@${post.userName}",
                    style: const TextStyle(fontSize: 8),
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
                    style: const TextStyle(fontSize: 15),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                  child: IconButton(
                    icon: const Icon(Icons.thumb_up_alt_outlined),
                    onPressed: () {},
                    iconSize: 10,
                    splashRadius: 10,
                  ),
                ),
                Text(
                  "${post.likes}",
                  style: const TextStyle(fontSize: 10),
                )
              ],
            ),
            Center(
              child: post.postImageSource != "default"
                  ? ClipRect(
                      child: Image.network(
                        post.postImageSource,
                        width: double.infinity,
                        height: 250,
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
