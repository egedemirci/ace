import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/topic_posts.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:project_ace/templates/topic.dart';
import 'package:provider/provider.dart';

class TopicCard extends StatefulWidget {
  const TopicCard(
      {Key? key,
      required this.topic,
      required this.isSearch,
      required this.userId,
      required this.analytics})
      : super(key: key);
  final Topic topic;
  final bool isSearch;
  final String userId;
  final FirebaseAnalytics analytics;

  @override
  State<TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  UserServices userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamBuilder(
      stream: userServices.usersRef.doc(widget.userId).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Oops, something went wrong"));
        }
        if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.data() != null) {
          MyUser myUser = MyUser.fromJson((snapshot.data!.data() ??
              Map<String, dynamic>.identity()) as Map<String, dynamic>);
          if (widget.isSearch) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
              child: Row(
                children: [
                  SizedBox(
                    width: screenWidth(context) * 0.60,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TopicPostsView(
                                    topic: widget.topic,
                                    analytics: widget.analytics)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Text(
                                '#${widget.topic.text}',
                                style: topicText,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.profileSettingButtonFillColor,
                    ),
                    width: screenWidth(context) * 0.3,
                    height: screenHeight(context) * 0.05,
                    child: TextButton.icon(
                      onPressed: () {
                        userServices.subscribeTopic(
                            widget.topic.text, user!.uid);
                      },
                      icon: myUser.subscribedTopics.contains(widget.topic.text)
                          ? const Icon(
                              Icons.remove_circle,
                              color: AppColors.profileSettingsButtonIconColor,
                            )
                          : const Icon(
                              Icons.add_circle_outlined,
                              color: AppColors.profileSettingsButtonIconColor,
                            ),
                      label: FittedBox(
                        fit: BoxFit.scaleDown,
                        child:
                            myUser.subscribedTopics.contains(widget.topic.text)
                                ? Text(
                                    "Unsubscribe",
                                    style: profileViewProfileSettingsButton,
                                  )
                                : Text(
                                    "Subscribe",
                                    style: profileViewProfileSettingsButton,
                                  ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TopicPostsView(
                            topic: widget.topic, analytics: widget.analytics)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Text(
                        '#${widget.topic.text}',
                        style: topicText,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
