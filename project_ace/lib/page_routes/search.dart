import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/templates/topic.dart';
import 'package:project_ace/user_interfaces/topic_cards.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';

import '../services/analytics.dart';
import '../utilities/screen_sizes.dart';

class Search extends StatefulWidget {
  const Search({Key? key,required this.analytics}) : super(key: key);
  final FirebaseAnalytics analytics;
  static const String routeName = '/search';
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Topic> topics = [
    Topic(text: "#Wimbledon2018", area: "tennis"),
    Topic(text: "#Federer", area: "tennis"),
    Topic(text: "#YaGunnersYa", area: "football"),
    Topic(text: "#ThankYouTomBrady", area: "nfl"),
    Topic(text: "#GreekFreak", area: "nba"),
  ];

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Search View", "searchView");
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(
            color: AppColors.postTextColor,
          ),
          elevation: 0,
          backgroundColor: AppColors.searchScreenBackground,
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                    labelStyle: searchFormText,
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: (){
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search',
                    border: InputBorder.none),
              ),
            ),
          )),
      backgroundColor: AppColors.searchScreenBackground,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: topics
                  .map((Topic) => TopicCard(
                        topic: Topic,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: screenHeight(context)*0.095,
        child: BottomAppBar(
          color: AppColors.welcomeScreenBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    tooltip: "Messages",
                    iconSize: screenWidth(context)*0.08,
                    icon: const Icon(
                      Icons.email,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, MessageScreen.routeName);
                    }),
                const Spacer(),
                IconButton(
                    tooltip: "Search",
                    iconSize: screenWidth(context)*0.08,
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {}),
                const Spacer(),
                IconButton(
                    tooltip: "Home",
                    iconSize: screenWidth(context)*0.08,
                    icon: const Icon(
                      Icons.home,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Feed.routeName, (route) => false);
                    }),
                const Spacer(),
                IconButton(
                    tooltip: "Add Post",
                    iconSize: screenWidth(context)*0.08,
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AddPost.routeName);
                    }),
                const Spacer(),
                IconButton(
                    tooltip: "Profile",
                    iconSize: screenWidth(context)*0.08,
                    icon: const Icon(
                      Icons.person_outline,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, OwnProfileView.routeName, (route) => false);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
