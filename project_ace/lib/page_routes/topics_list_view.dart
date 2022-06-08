import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/topic.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/user_interfaces/topic_cards.dart';
import 'package:project_ace/user_interfaces/user_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';

class TopicListView extends StatefulWidget {
  final List<dynamic> topicList;
  final FirebaseAnalytics analytics;

  const TopicListView(
      {Key? key,
        required this.topicList,
        required this.analytics})
      : super(key: key);

  @override
  State<TopicListView> createState() => _TopicListViewState();
}

class _TopicListViewState extends State<TopicListView> {
  PostServices postServices = PostServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      backgroundColor: AppColors.profileScreenBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: screenHeight(context) * 0.025,
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
          splashRadius: screenHeight(context) * 0.03,
        ),
        centerTitle: true,
        title: SizedBox(
          width: screenWidth(context) * 0.6,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Subscribed Topics',
              style: messageHeader,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.profileScreenBackgroundColor,
        foregroundColor: AppColors.profileScreenTextColor,
        toolbarHeight: screenHeight(context) * 0.08,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: postServices.topicsRef.snapshots().asBroadcastStream(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> querySnapshot) {
            if (!querySnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              List<dynamic> topicList = querySnapshot.data!.docs
                  .where((QueryDocumentSnapshot<Object?> element) {
                return (widget.topicList.contains(element["text"]));
              }).toList();
              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: List.from(topicList
                          .map((topic) => TopicCard(
                        topic: Topic.fromJson(
                            topic.data() as Map<String, dynamic>),
                        isSearch: false, analytics: widget.analytics, userId: user!.uid,
                      ))
                          .toList()),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
