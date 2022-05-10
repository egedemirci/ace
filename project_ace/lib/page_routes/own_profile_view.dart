import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/page_routes/profileSettings.dart';
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
        text: "Hello man I fucking hate Harry Maguire",
        fullName: "Efe Tuzun",
        likes: 128,
        userName: "efetuzun"),
    Post(
        text: "Hello man my dick is very long. Looking for sexual partners.",
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
        title: Text(
          '@$userName',
          style: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: AppColors.welcomeScreenBackgroundColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainAppSmallUsernameColor,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOutUser();
              // Navigator.pushNamedAndRemoveUntil(context, Login.routeName, (route) => false);
            },
          )
        ],
      ),
      backgroundColor: AppColors.mainAppSmallUsernameColor,
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
                        backgroundColor: Colors.pink,
                        child: ClipOval(
                          child: Image.network(
                            'https://scontent.fist2-4.fna.fbcdn.net/v/t1.6435-9/158915922_1835177049983620_7867840742222695097_n.jpg?stp=cp0_dst-jpg_e15_p640x640_q65&_nc_cat=107&ccb=1-5&_nc_sid=110474&efg=eyJpIjoidCJ9&_nc_ohc=xewcz6_AcSoAX-HqTcf&tn=yL3fhD3XrmMMdYqA&_nc_ht=scontent.fist2-4.fna&oh=00_AT972WOBWpIHv-2oGq6ghOgkcHrFiivzT1Ghtw--wIb8AQ&oe=626A0233',
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
                                onPressed: (){
                                    Navigator.pushNamed(context, ProfileSettings.routeName);
                                },
                                icon: const Icon(Icons.settings),
                                label: const Text(
                                  "Profile Settings",
                                  style: TextStyle(
                                    fontSize: 20,
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
                          child: const Icon(Icons.photo_outlined),
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 0,
                                  color: AppColors.mainAppSmallUsernameColor)),
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
                          child: const Icon(Icons.wine_bar),
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 0,
                                  color: AppColors.mainAppSmallUsernameColor)),
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
                            decrementLikes: () {
                              _decrementLikes(post);
                            },
                            incrementLikes: () {
                              _incrementLikes(post);
                            },
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
