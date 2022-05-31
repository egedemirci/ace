import 'package:flutter/material.dart';
import 'package:project_ace/templates/message.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:project_ace/utilities/screen_sizes.dart';

class ChatCard extends StatelessWidget {
  const ChatCard(
      {Key? key,
      required this.message,
      required this.isMe,
      required this.isSameUser,
      required this.urlAvatar})
      : super(key: key);
  final Message message;
  final bool isMe;
  final bool isSameUser;
  final String urlAvatar;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(24);
    const borderRadius = BorderRadius.all(radius);
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!isMe && !isSameUser)
          CircleAvatar(
              radius: 16, backgroundImage: NetworkImage(message.urlAvatar)),
        if (!isMe && isSameUser)const SizedBox(width: 32),
        Container(
          padding: const EdgeInsets.all(12),
          margin: !isSameUser
              ? const EdgeInsets.fromLTRB(8, 16, 8, 6)
              : const EdgeInsets.fromLTRB(8, 0, 8, 6),
          constraints: BoxConstraints(maxWidth: screenWidth(context) * 0.60),
          decoration: BoxDecoration(
            color: isMe
                ? AppColors.messagesFromUserFillColor
                : AppColors.messagesToUserFillColor,
            borderRadius: isMe
                ? borderRadius
                    .subtract(const BorderRadius.only(bottomRight: radius))
                : borderRadius
                    .subtract(const BorderRadius.only(bottomLeft: radius)),
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                message.message,
                style: isMe ? chatMessagesSent : chatMessagesTaken,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
