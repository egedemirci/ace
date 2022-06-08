import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/templates/topic.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/user_interfaces/post_card.dart';
import 'package:project_ace/user_interfaces/topic_cards.dart';
import 'package:project_ace/user_interfaces/user_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = '/search';

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  UserServices userServices = UserServices();
  PostServices postServices = PostServices();
  String query = "";

  int currentSearchLoc = 0;

  changeCurrentSearchLoc(int i) {
    setState(() {
      currentSearchLoc = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    setCurrentScreen(widget.analytics, "Search View", "search.dart");
    setUserId(widget.analytics, user!.uid);
    return Scaffold(
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
            elevation: 0,
            toolbarHeight: screenHeight(context) * 0.08,
            backgroundColor: AppColors.searchScreenBackground,
            foregroundColor: AppColors.welcomeScreenBackgroundColor,
            title: Container(
              width: double.infinity,
              height: screenHeight(context) * 0.046,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextFormField(
                  key: _formKey,
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelStyle: searchFormText,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _controller.clear();
                      },
                      splashRadius: 1,
                    ),
                    hintText: 'Search',
                  ),
                ),
              ),
            )),
        backgroundColor: AppColors.searchScreenBackground,
        bottomNavigationBar: SizedBox(
          height: screenHeight(context) * 0.095,
          child: BottomAppBar(
            color: AppColors.welcomeScreenBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    tooltip: "Messages",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.email,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, MessageScreen.routeName);
                    },
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Search",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {},
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Home",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.home,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Feed.routeName, (route) => false);
                    },
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Add Post",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AddPost.routeName);
                    },
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: "Profile",
                    iconSize: screenWidth(context) * 0.08,
                    icon: const Icon(
                      Icons.person_outline,
                      color: AppColors.bottomNavigationBarIconOutlineColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, OwnProfileView.routeName, (route) => false);
                    },
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: currentSearchLoc == 2
                ? postServices.topicsRef.snapshots().asBroadcastStream()
                : userServices.usersRef.snapshots().asBroadcastStream(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> querySnapshot) {
              if (!querySnapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                List<dynamic> queryUserList = [];
                List<dynamic> queryPosts = [];
                List<dynamic> topicList = [];
                if (currentSearchLoc == 2) {
                  if (query.trim().isNotEmpty) {
                    topicList = querySnapshot.data!.docs
                        .where((QueryDocumentSnapshot<Object?> element) {
                      return (element["text"]
                          .toString()
                          .toLowerCase()
                          .contains(query.toLowerCase()));
                    }).toList();
                  }
                } else {
                  if (query.trim().isNotEmpty) {
                    queryUserList = querySnapshot.data!.docs
                        .where((QueryDocumentSnapshot<Object?> element) {
                      return (element['isDisabled'] == false &&
                          element["username"]
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()));
                    }).toList();
                    List<dynamic> postsList = querySnapshot.data!.docs
                        .where((QueryDocumentSnapshot<Object?> element) {
                          return (!element["isDisabled"] && element["userId"] != user.uid);
                        })
                        .map((data) => (data["posts"]))
                        .toList();
                    for (int j = 0; j < postsList.length; j++) {
                      for (int k = 0; k < postsList[j].length; k++) {
                        if (postsList[j][k]['text']
                            .toString()
                            .toLowerCase()
                            .contains(query)) {
                          queryPosts += [postsList[j][k]];
                        }
                      }
                    }
                    queryPosts.sort(
                        (a, b) => a["createdAt"].compareTo(b["createdAt"]));
                  }
                }
                return SingleChildScrollView(
                    child: SafeArea(
                        child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.profileImageTextPostViewButton,
                      ),
                      width: double.infinity,
                      height: screenHeight(context) * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                changeCurrentSearchLoc(0);
                              },
                              style: OutlinedButton.styleFrom(
                                  elevation: 0, side: BorderSide.none),
                              child: const Icon(
                                Icons.people_alt_outlined,
                                color: AppColors.welcomeScreenBackgroundColor,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            child: VerticalDivider(
                                color: AppColors.welcomeScreenBackgroundColor,
                                thickness: 2,
                                width: 10),
                          ),
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {
                                changeCurrentSearchLoc(1);
                              },
                              style: OutlinedButton.styleFrom(
                                  elevation: 0, side: BorderSide.none),
                              child: const Icon(
                                Icons.text_fields,
                                color: AppColors.welcomeScreenBackgroundColor,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                            child: VerticalDivider(
                                color: AppColors.welcomeScreenBackgroundColor,
                                thickness: 2,
                                width: 10),
                          ),
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {
                                changeCurrentSearchLoc(2);
                              },
                              style: OutlinedButton.styleFrom(
                                  elevation: 0, side: BorderSide.none),
                              child: const Icon(
                                Icons.tag,
                                color: AppColors.welcomeScreenBackgroundColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(context) * 0.0115,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight(context) * 0.0115,
                    ),
                    currentSearchLoc == 0
                        ? Column(
                            children: List.from(
                              queryUserList
                                  .map((user) => UserCard(
                                        user: MyUser.fromJson(user.data()
                                            as Map<String, dynamic>),
                                        isNewChat: false,
                                        analytics: widget.analytics,
                                      ))
                                  .toList()
                                  .reversed,
                            ),
                          )
                        : (currentSearchLoc == 1
                            ? Column(
                                children: List.from(
                                  queryPosts
                                      .map((post) => PostCard(
                                            post: Post.fromJson(post),
                                            isMyPost: false,
                                            deletePost: () {},
                                            incrementLike: () {
                                              postServices.likePost(
                                                  user.uid,
                                                  post["userId"],
                                                  post["postId"]);
                                            },
                                            incrementDislike: () {
                                              postServices.dislikePost(
                                                  user.uid,
                                                  post["userId"],
                                                  post["postId"]);
                                            },
                                            reShare: () {
                                              // TODO: Re-share
                                            },
                                            myUserId: user.uid,
                                            analytics: widget.analytics,
                                          ))
                                      .toList()
                                      .reversed,
                                ),
                              )
                            : Column(
                                children: List.from(
                                  topicList
                                      .map((topic) => TopicCard(
                                          topic: Topic.fromJson(topic.data()
                                              as Map<String, dynamic>), userId: user.uid, analytics: widget.analytics, isSearch: true,))
                                      .toList()
                                      .reversed,
                                ),
                    )),
                              ]),
                        )));
    }
               })

    );
  }
}
