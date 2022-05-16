import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/user_interfaces/post_card.dart';
import 'package:project_ace/utilities/colors.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  static const String routeName = "/feed";
  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.profileScreenBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ace",
          style: TextStyle(
              color: AppColors.welcomeScreenBackgroundColor, fontSize: 30),
        ),
        elevation: 0,
        backgroundColor: AppColors.profileScreenBackgroundColor,
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.welcomeScreenBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  tooltip: "Feed",
                  iconSize: 40,
                  icon: const Icon(
                    Icons.email,
                    color: AppColors.userNameColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Feed.routeName, (route) => false);
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
                    // Navigator.push(context, Search.routeName);
                  }),
              const Spacer(),
              IconButton(
                  tooltip: "Topics",
                  iconSize: 40,
                  icon: const Icon(
                    Icons.tag,
                    color: AppColors.userNameColor,
                  ),
                  onPressed: () {
                    // Navigator.push(context, Topic.routeName);
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: posts
                  .map((post) => PostCard(
                        post: post,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
