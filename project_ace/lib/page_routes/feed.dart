import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/search.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/user_interfaces/post_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  static const String routeName = "/feed";
  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Post> posts = [
    Post(
        text:
            "Hello man I hate Harry Maguire. This a picture of Tobey Maguire, who has no relation at all.",
        fullName: "Efe Tuzun",
        likes: 128,
        userName: "efetuzun",
        postImageSource:
            "https://upload.wikimedia.org/wikipedia/commons/9/90/Spiderman.JPG"),
    Post(
        text: "Ronaldo is out of this world! 2 goals in 4 minutes?",
        fullName: "HarryNotMaguire",
        likes: 128,
        userName: "maguireNotHarry",
        postImageSource:
            "https://www.juventus.com/images/image/private/t_editorial_landscape_12_desktop/f_auto/dev/nyuf6tne3npisv92zetr.jpg"),
    Post(
        text:
            "Hello my dear friends. I am very lucky today to annouce the birth of my son, Bradley.",
        fullName: "Landon Donovan",
        likes: 128,
        userName: "donovan.landon"),
    Post(
        text: "HERE WE GO!",
        fullName: "Fabrizio Romano",
        likes: 128,
        userName: "fabrizio",
        postImageSource:
            "https://sportsdias.com/wp-content/uploads/2022/04/MAN-UTD-20.jpg",
        profileImageSource:
            "https://pbs.twimg.com/profile_images/1486761402853380113/3ifAqala.jpg"),
    Post(
        text:
            "Messi is out of this world! 7 Ballon d'Ors? Surely no one can match that!",
        fullName: "Messi is Life",
        likes: 128,
        userName: "messifanboy123",
        postImageSource:
            "https://img.fanatik.com.tr/img/78/740x418/610c6938ae298b8328517710.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.profileScreenBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Feed",
          style: feedHeader,
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
                  onPressed: () {}),
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
