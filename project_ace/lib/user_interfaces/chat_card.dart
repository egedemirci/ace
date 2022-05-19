import 'package:flutter/material.dart';
import 'package:project_ace/templates/message.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';

import '../utilities/screen_sizes.dart';

class ChatCard extends StatelessWidget {
  final Message message;
  final bool isMe;

  const ChatCard({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(12);
    const borderRadius = BorderRadius.all(radius);

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        if (!isMe)
          CircleAvatar(
              radius: 16, backgroundImage: NetworkImage(message.urlAvatar)),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          constraints: BoxConstraints(maxWidth: screenWidth(context)*0.60),
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
