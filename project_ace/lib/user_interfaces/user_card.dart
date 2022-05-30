import 'package:flutter/material.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';


class UserCard extends StatelessWidget {
  final MyUser user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 16, backgroundImage: NetworkImage(user.profilepicture)),
        const SizedBox(width: 32),
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(8),
          constraints: BoxConstraints(maxWidth: screenWidth(context) * 0.80),
          child:
              Column(
                children: [
                  Text(
                    user.username,
                    style: messageUserName,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.fullName,
                    style: messageUserRealName,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
          ),
      ],
    );
  }
}
