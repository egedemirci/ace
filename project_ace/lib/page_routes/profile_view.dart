import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/search.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/services/auth_services.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = '/profile_view';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final AuthServices _auth = AuthServices();

  List<Post> posts = [];

  void followUser() {
    print('You would like to follow this user, he?');
  }

  void messageUser() {
    print('Would you really like to message this user?');
  }

  String userName = "userName";

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Profile View", "profileView");
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.profileScreenTextColor,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await _auth.signOutUser();
              },
            ),
            const Spacer(),
            Text(
              '@$userName',
              style: profileViewHeader,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notifications');
              },
              icon: const Icon(
                Icons.notifications_active,
                color: AppColors.bottomNavigationBarBackgroundColor,
              ),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColors.profileScreenBackgroundColor,
        elevation: 0.0,
      ),
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
                    iconSize: 40,
                    icon: const Icon(
                      Icons.email,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, MessageScreen.routeName);
                    }),
                const Spacer(),
                IconButton(
                    tooltip: "Search",
                    iconSize: 40,
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Search.routeName);
                    }),
                const Spacer(),
                IconButton(
                    tooltip: "Home",
                    iconSize: 40,
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
                    iconSize: 40,
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.userNameColor,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AddPost.routeName);
                    }),
                const Spacer(),
                IconButton(
                    tooltip: "Profile",
                    iconSize: 40,
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
      backgroundColor: AppColors.profileScreenBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: CircleAvatar(
                        backgroundColor: AppColors.welcomeScreenBackgroundColor,
                        radius: 60,
                        child: ClipOval(
                          child: Image.network(
                            'https://images-na.ssl-images-amazon.com/images/I/417MahKs6fL.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(
                            '###',
                            style: postsFollowersFollowingsCounts,
                          ),
                        ),
                        Text(
                          'Posts',
                          style: postsFollowersFollowings,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(
                            '###',
                            style: postsFollowersFollowingsCounts,
                          ),
                        ),
                        Text(
                          'Followers',
                          style: postsFollowersFollowings,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(
                            '###',
                            style: postsFollowersFollowingsCounts,
                          ),
                        ),
                        Text(
                          'Following',
                          style: postsFollowersFollowings,
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton.icon(
                                onPressed: followUser,
                                icon: const Icon(
                                  Icons.group_add,
                                  color: AppColors.welcomeScreenBackgroundColor,
                                ),
                                label: const Text(
                                  "Follow",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        AppColors.welcomeScreenBackgroundColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextButton.icon(
                                  onPressed: messageUser,
                                  icon: const Icon(
                                    Icons.mail,
                                    color:
                                        AppColors.welcomeScreenBackgroundColor,
                                  ),
                                  label: const Text(
                                    "Message",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors
                                          .welcomeScreenBackgroundColor,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.profileImageTextPostViewButton,
                  ),
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              elevation: 0, side: BorderSide.none),
                          child: const Icon(
                            Icons.photo_outlined,
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
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              elevation: 0, side: BorderSide.none),
                          child: const Icon(
                            Icons.text_fields,
                            color: AppColors.welcomeScreenBackgroundColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                    //children: posts
                    //  .map((post) => PostCard(
                    //        post: post,
                    //      ))
                    // .toList(),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
