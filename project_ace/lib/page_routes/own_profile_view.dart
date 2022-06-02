import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/bookmarks.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/firestore_search.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/profile_settings.dart';
import 'package:project_ace/page_routes/user_list_view.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/user_interfaces/post_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/services/auth_services.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:provider/provider.dart';

class OwnProfileView extends StatefulWidget {
  const OwnProfileView({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = '/own_profile_view';

  @override
  State<OwnProfileView> createState() => _OwnProfileViewState();
}

class _OwnProfileViewState extends State<OwnProfileView> {
  final AuthServices _auth = AuthServices();

  String userName = " ";
  UserServices userService = UserServices();
  PostService postService = PostService();

  Future getUserName() async {
    final uname =
        await userService.getUsername(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      userName = "@$uname";
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    //rebuildAllChildren(context);
    setCurrentScreen(
        widget.analytics, "Own Profile View", "own_profile_view.dart");
    final user = Provider.of<User?>(context);
    if (user == null) {
      return Login(
        analytics: widget.analytics,
      );
    } else {
      setUserId(widget.analytics, user.uid);
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
                SizedBox(
                  width: screenWidth(context) * 0.6,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      userName,
                      style: profileViewHeader,
                    ),
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
                        iconSize: screenWidth(context) * 0.08,
                        icon: const Icon(
                          Icons.email,
                          color: AppColors.bottomNavigationBarIconOutlineColor,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, MessageScreen.routeName);
                        }),
                    const Spacer(),
                    IconButton(
                        tooltip: "Search",
                        iconSize: screenWidth(context) * 0.08,
                        icon: const Icon(
                          Icons.search,
                          color: AppColors.bottomNavigationBarIconOutlineColor,
                        ),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              FirestoreSearch.routeName, (route) => false);
                        }),
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
                        }),
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
                        }),
                    const Spacer(),
                    IconButton(
                        tooltip: "Profile",
                        iconSize: screenWidth(context) * 0.08,
                        icon: const Icon(
                          Icons.person_outline,
                          color: AppColors.bottomNavigationBarIconOutlineColor,
                        ),
                        onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: AppColors.profileScreenBackgroundColor,
          body: StreamBuilder<QuerySnapshot>(
                  stream:
                  userService.usersRef.snapshots().asBroadcastStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> querySnapshot) {
                    if (!querySnapshot.hasData) {
                      return const Center(
                          child: CircularProgressIndicator());
                    } else {
                      List<dynamic> userList = querySnapshot.data!.docs
                          .where(
                              (QueryDocumentSnapshot<Object?> element) {
                            return element["userId"] == user.uid;
                          }
                      ).toList();

                      MyUser myUser = MyUser.fromJson(userList[0].data() as Map<String, dynamic>);

                      List<dynamic> postsList = querySnapshot.data!.docs
                          .where((QueryDocumentSnapshot<Object?> element) {
                        return (element["userId"] == myUser.userId);
                      })
                          .map((data) => (data["posts"]))
                          .toList();
                      List<dynamic> followingPosts = [];
                      for (int j = 0; j < postsList.length; j++) {
                        for (int k = 0; k < postsList[j].length; k++) {
                          followingPosts += [postsList[j][k]];
                        }
                      }
                      followingPosts.sort((a, b) =>
                          a["createdAt"].compareTo(b["createdAt"]));

                      return SingleChildScrollView(
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
                                      child: InkWell(
                                        child: CircleAvatar(
                                          backgroundColor:
                                          AppColors.welcomeScreenBackgroundColor,
                                          radius: screenWidth(context) * 0.14,
                                          backgroundImage:
                                          NetworkImage(myUser.profilepicture),
                                          /*
                                child: ClipOval(
                                  child: Image.network(
                                    myUser.profilepicture,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                */
                                        ),
                                        onTap: () => showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor:
                                            AppColors.signUpScreenBackgroundColor,
                                            content: Stack(
                                              alignment: Alignment.center,
                                              children: <Widget>[
                                                Image.network(
                                                  myUser.profilepicture,
                                                  width: screenWidth(context) * 0.97,
                                                  height:
                                                  screenHeight(context) * 0.46,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.fromLTRB(0, 24, 0, 0),
                                          child: Text(
                                            myUser.posts.length.toString(),
                                            style: postsFollowersFollowingsCounts,
                                          ),
                                        ),
                                        Text(
                                          'Posts',
                                          style: postsFollowersFollowings,
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => UserListView(
                                                  userIdList: myUser.followers,
                                                  title: "Followers",
                                                  isNewChat: false,
                                                  analytics: widget.analytics,
                                                )));
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 24, 0, 0),
                                            child: Text(
                                              myUser.followers.length.toString(),
                                              style: postsFollowersFollowingsCounts,
                                            ),
                                          ),
                                          Text(
                                            'Followers',
                                            style: postsFollowersFollowings,
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => UserListView(
                                                  userIdList: myUser.following,
                                                  title: "Following",
                                                  isNewChat: false,
                                                  analytics: widget.analytics,
                                                )));
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 24, 0, 0),
                                            child: Text(
                                              myUser.following.length.toString(),
                                              style: postsFollowersFollowingsCounts,
                                            ),
                                          ),
                                          Text(
                                            'Following',
                                            style: postsFollowersFollowings,
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // TODO: Show topics list.
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 24, 0, 0),
                                            child: Text(
                                              myUser.subscribedTopics.length
                                                  .toString(),
                                              style: postsFollowersFollowingsCounts,
                                            ),
                                          ),
                                          Text(
                                            'Topics',
                                            style: postsFollowersFollowings,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 16, 16, 3),
                                  child: Row(
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                            maxWidth: screenWidth(context) * 0.85),
                                        child: Text(
                                          myUser.fullName,
                                          style: smallNameUnderProfile,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 16, 0),
                                  child: Row(
                                    children: [
                                      Container(
                                          constraints: BoxConstraints(
                                              maxWidth: screenWidth(context) * 0.85),
                                          child: Text(
                                            myUser.biography,
                                            style: biography,
                                          ))
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  color: AppColors
                                                      .profileSettingButtonFillColor,
                                                ),
                                                width: screenWidth(context) * 0.8,
                                                height: screenHeight(context) * 0.075,
                                                child: TextButton.icon(
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        ProfileSettings.routeName);
                                                  },
                                                  icon: const Icon(
                                                    Icons.settings,
                                                    color: AppColors
                                                        .profileSettingsButtonIconColor,
                                                  ),
                                                  label: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      "Profile Settings",
                                                      style:
                                                      profileViewProfileSettingsButton,
                                                    ),
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
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                              elevation: 0, side: BorderSide.none),
                                          child: const Icon(
                                            Icons.list_outlined,
                                            color: AppColors
                                                .welcomeScreenBackgroundColor,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: VerticalDivider(
                                            color: AppColors
                                                .welcomeScreenBackgroundColor,
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
                                            color: AppColors
                                                .welcomeScreenBackgroundColor,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: VerticalDivider(
                                            color: AppColors
                                                .welcomeScreenBackgroundColor,
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
                                            Icons.photo_outlined,
                                            color: AppColors
                                                .welcomeScreenBackgroundColor,
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: VerticalDivider(
                                            color: AppColors
                                                .welcomeScreenBackgroundColor,
                                            thickness: 2,
                                            width: 10),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, BookMarks.routeName);
                                          },
                                          style: OutlinedButton.styleFrom(
                                              elevation: 0, side: BorderSide.none),
                                          child: const Icon(
                                            Icons.bookmark,
                                            color: AppColors
                                                .welcomeScreenBackgroundColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight(context) * 0.0115,
                                ),
                                Column(
                                  children: List.from(
                                    followingPosts
                                        .map((post) => PostCard(
                                        post: Post.fromJson(post),
                                        isMyPost: true,
                                        deletePost: () {
                                          setState(() {
                                            postService.deletePost(
                                                user.uid, post);
                                          });
                                        },
                                        incrementLike: () {
                                          setState(() {
                                            postService.likePost(user.uid,
                                                myUser.userId, post["postId"]);
                                          });
                                        },
                                        incrementComment: () {
                                          // TODO: Comments View
                                        },
                                        incrementDislike: () {
                                          setState(() {
                                            postService.dislikePost(user.uid,
                                                myUser.userId, post["postId"]);
                                          });
                                        },
                                        reShare: () {
                                          //TODO: Implement re-share
                                        }, myUserId: user.uid,))
                                        .toList()
                                        .reversed,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  })
                  );
            }
    }
  }
