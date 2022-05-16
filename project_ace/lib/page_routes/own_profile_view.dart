import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/profile_settings.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/user_interfaces/post_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/firebase_auth.dart';

class OwnProfileView extends StatefulWidget {
  const OwnProfileView({Key? key}) : super(key: key);

  static const String routeName = '/own_profile_view';

  @override
  State<OwnProfileView> createState() => _OwnProfileViewState();
}

class _OwnProfileViewState extends State<OwnProfileView> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  List<Post> posts = [
    Post(
        text: "Hello man I hate Harry Maguire",
        fullName: "Efe Tuzun",
        likes: 128,
        userName: "efetuzun",
        imageSource:
            "https://images-na.ssl-images-amazon.com/images/I/417MahKs6fL.png"),
    Post(
        text: "Hello my dear friends. I am very lucky today.",
        fullName: "Efe Tuzun",
        likes: 128,
        userName: "efetuzun"),
    Post(
        text: "Hello man",
        fullName: "Efe Tuzun",
        likes: 128,
        userName: "efetuzun",
        imageSource:
            "https://images-na.ssl-images-amazon.com/images/I/417MahKs6fL.png"),
    Post(
        text: "Hello man",
        fullName: "Efe Tuzun",
        likes: 128,
        userName: "efetuzun",
        imageSource:
            "https://images-na.ssl-images-amazon.com/images/I/417MahKs6fL.png"),
    Post(
        text: "Hello man",
        fullName: "Efe Tuzun",
        likes: 128,
        userName: "efetuzun"),
    Post(
        text: "Hello man",
        fullName: "Efe Tuzun",
        likes: 128,
        userName: "efetuzun"),
    Post(
        text: "Hello man",
        fullName: "Efe Tuzun",
        likes: 128,
        userName: "efetuzun",
        imageSource:
            "https://images-na.ssl-images-amazon.com/images/I/417MahKs6fL.png"),
    Post(
        text: "Hello man",
        fullName: "Efe Tuzun",
        likes: 128,
        userName: "efetuzun"),
    Post(
        text: "Hello man",
        fullName: "Efe Tuzun",
        likes: 128,
        userName: "efetuzun"),
  ];

  void _incrementLikes(Post post) {
    setState(() {
      post.likes++;
    });
  }

  void buttonClicked() {
    setState(() {});
  }

  void _decrementLikes(Post post) {
    setState(() {
      post.likes--;
    });
  }

  void addUserComment(Post post) {
    print('User would like to add a comment to this post!');
  }

  void followUser() {
    print('You would like to follow this user, he?');
  }

  void messageUser() {
    print('Would you really like to message this user?');
  }

  String userName = "userName";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.profileScreenTextColor,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await _auth.signOutUser();
                // Navigator.pushNamedAndRemoveUntil(context, Login.routeName, (route) => false);
              },
            ),
            const Spacer(),
            Text(
              '@$userName',
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: AppColors.profileScreenTextColor,
              ),
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
        /*actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOutUser();
              // Navigator.pushNamedAndRemoveUntil(context, Login.routeName, (route) => false);
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
            icon: const Icon(
              Icons.notifications_active,
              color: AppColors.notificationIconColor,
            ),
          )
        ],
         */
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.welcomeScreenBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                  onPressed: () {}),
              const Spacer(),
              IconButton(
                  tooltip: "Search",
                  iconSize: 40,
                  icon: const Icon(
                    Icons.search,
                    color: AppColors.userNameColor,
                  ),
                  onPressed: () {
                    // Navigator.push(context, Search.routeName);
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
      backgroundColor: AppColors.profileScreenBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: CircleAvatar(
                        backgroundColor: AppColors.welcomeScreenBackgroundColor,
                        child: ClipOval(
                          child: Image.network(
                            'https://images-na.ssl-images-amazon.com/images/I/417MahKs6fL.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        radius: 60,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(
                            '###',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Posts',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(
                            '###',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Followers',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Text(
                            '###',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          'Following',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
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
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, ProfileSettings.routeName);
                                },
                                icon: const Icon(
                                  Icons.settings,
                                  color: AppColors.welcomeScreenBackgroundColor,
                                ),
                                label: const Text(
                                  "Profile Settings",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        AppColors.welcomeScreenBackgroundColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 2.0,
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.photo_outlined,
                            color: AppColors.welcomeScreenBackgroundColor,
                          ),
                          style: OutlinedButton.styleFrom(
                              elevation: 0, side: BorderSide.none),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: VerticalDivider(
                            color: Colors.blueGrey, thickness: 4, width: 10),
                      ),
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.wine_bar,
                            color: AppColors.welcomeScreenBackgroundColor,
                          ),
                          style: OutlinedButton.styleFrom(
                              elevation: 0, side: BorderSide.none),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.blueGrey,
                  thickness: 2.0,
                  height: 20,
                ),
                Column(
                  children: posts
                      .map((post) => PostCard(
                            post: post,
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
