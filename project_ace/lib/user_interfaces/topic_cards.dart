import 'package:flutter/material.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:project_ace/templates/topic.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({Key? key, required this.topic}) : super(key: key);
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    // TODO: Extend the implementation of Screen Sizes
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              top: Radius.zero, bottom: Radius.circular(0))),
      color: AppColors.searchScreenBackground,
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
                Text(
                  topic.text,
                  style: searchTopicText,
                ),
                const SizedBox(width: 6),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 13, 0, 0),
              child: Divider(
                  height: 10,
                  thickness: 1,
                  color: AppColors.welcomeScreenBackgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}
