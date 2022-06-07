import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/bookmarks.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/profile_settings.dart';
import 'package:project_ace/page_routes/search.dart';
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
  AuthServices auth = AuthServices();
  UserServices userServices = UserServices();
  PostServices postServices = PostServices();
  String userName = " ";
  int postType = 0;

  /*
  final location = Location();
  LocationData? _locData;
  bool? _serviceEnabled;
  bool _loading = false;
  StreamSubscription<LocationData>? _locDataStream;
  PermissionStatus? _permissionStatus;
  String? _error;
  Future _checkPermissions() async {
    final PermissionStatus status = await location.hasPermission();
    setState(() {
      _permissionStatus = status;
    });
  }

  Future _requestPermissions() async {
    if (_permissionStatus != PermissionStatus.granted) {
      final PermissionStatus status = await location.requestPermission();
      setState(() {
        _permissionStatus = status;
      });
    }
  }

  Future _checkService() async {
    final bool service = await location.serviceEnabled();
    setState(() {
      _serviceEnabled = service;
    });
  }

  Future _requestService() async {
    if (_serviceEnabled == true) {
      return;
    }
    final bool serviceRequest = await location.requestService();
    setState(() {
      _serviceEnabled = serviceRequest;
    });
  }

  Future _getLocation() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      final LocationData locResults = await location.getLocation();
      setState(() {
        _locData = locResults;
        _loading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future _listenLocation() async {
    _locDataStream = location.onLocationChanged.handleError((dynamic e) {
      if (e is PlatformException) {
        setState(() {
          _error = e.toString();
        });
      }
      _locDataStream?.cancel();
      setState(() {
        _locDataStream = null;
      });
    }).listen((LocationData current) {
      setState(() {
        _error = null;
        _locData = current;
      });
    });
    setState(() {});
  }

  Future _stopListen() async {
    _locDataStream?.cancel();
    setState(() {
      _locDataStream = null;
    });
  }

  @override
  void dispose() {
    _locDataStream?.cancel();
    setState(() {
      _locDataStream = null;
    });
    super.dispose();
  }
   */

  Future getUserName() async {
    final uname =
        await userServices.getUsername(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      userName = "@$uname";
    });
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  changePostType(int i) {
    if (postType != i) {
      setState(() {
        postType = i;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          title: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.logout,
                  size: screenWidth(context) * 0.05,
                ),
                splashRadius: screenWidth(context) * 0.06,
                onPressed: () async {
                  await auth.signOutUser();
                },
              ),
              const Spacer(),
              SizedBox(
                width: screenWidth(context) * 0.6,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    userName,
                    style: messageHeader,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
                icon: Icon(
                  Icons.notifications_active,
                  color: AppColors.bottomNavigationBarBackgroundColor,
                  size: screenHeight(context) * 0.03,
                ),
                splashRadius: screenHeight(context) * 0.032,
              ),
            ],
          ),
          elevation: 0.0,
          centerTitle: true,
          toolbarHeight: screenHeight(context) * 0.08,
          backgroundColor: AppColors.profileScreenBackgroundColor,
          foregroundColor: AppColors.profileScreenTextColor,
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
                    onPressed: () {
                      Navigator.pushNamed(context, Search.routeName);
                    },
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
                    onPressed: () {},
                    splashRadius: screenWidth(context) * 0.07,
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.profileScreenBackgroundColor,
        body: StreamBuilder<QuerySnapshot>(
            stream: userServices.usersRef.snapshots().asBroadcastStream(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> querySnapshot) {
              if (!querySnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                List<dynamic> userList = querySnapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) {
                  return element["userId"] == user.uid;
                }).toList();
                MyUser myUser =
                    MyUser.fromJson(userList[0].data() as Map<String, dynamic>);
                List<dynamic> postsList = querySnapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) {
                      return (element["userId"] == myUser.userId);
                    })
                    .map((data) => (data["posts"]))
                    .toList();
                List<dynamic> myPosts = [];
                for (int j = 0; j < postsList.length; j++) {
                  for (int k = 0; k < postsList[j].length; k++) {
                    if (postType == 0) {
                      myPosts += [postsList[j][k]];
                    } else if (postType == 1) {
                      if (postsList[j][k]["assetUrl"] == "default") {
                        myPosts += [postsList[j][k]];
                      }
                    } else {
                      if (postsList[j][k]["assetUrl"] != "default") {
                        myPosts += [postsList[j][k]];
                      }
                    }
                  }
                }
                myPosts
                    .sort((a, b) => a["createdAt"].compareTo(b["createdAt"]));
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
                                        const EdgeInsets.fromLTRB(2, 15, 2, 0),
                                    child: Text(
                                      myUser.posts.length.toString(),
                                      style: postsFollowersFollowingsCounts,
                                    ),
                                  ),
                                  Text(
                                    'Posts',
                                    style: postsFollowersFollowings,
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(bottom: 15))
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
                                          2, 15, 2, 0),
                                      child: Text(
                                        myUser.followers.length.toString(),
                                        style: postsFollowersFollowingsCounts,
                                      ),
                                    ),
                                    Text(
                                      'Followers',
                                      style: postsFollowersFollowings,
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 15))
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
                                          2, 15, 2, 0),
                                      child: Text(
                                        myUser.following.length.toString(),
                                        style: postsFollowersFollowingsCounts,
                                      ),
                                    ),
                                    Text(
                                      'Following',
                                      style: postsFollowersFollowings,
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 15))
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
                                          2, 15, 2, 0),
                                      child: Text(
                                        myUser.subscribedTopics.length
                                            .toString(),
                                        style: postsFollowersFollowingsCounts,
                                      ),
                                    ),
                                    Text(
                                      'Topics',
                                      style: postsFollowersFollowings,
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 15))
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
                                    onPressed: () {
                                      changePostType(0);
                                    },
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
                                    onPressed: () {
                                      changePostType(1);
                                    },
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
                                    onPressed: () {
                                      changePostType(2);
                                    },
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
                              myPosts
                                  .map((post) => PostCard(
                                        post: Post.fromJson(post),
                                        isMyPost: true,
                                        deletePost: () {
                                          setState(() {
                                            postServices.deletePost(
                                                user.uid, post);
                                          });
                                        },
                                        incrementLike: () {
                                          setState(() {
                                            postServices.likePost(user.uid,
                                                myUser.userId, post["postId"]);
                                          });
                                        },
                                        incrementDislike: () {
                                          setState(() {
                                            postServices.dislikePost(user.uid,
                                                myUser.userId, post["postId"]);
                                          });
                                        },
                                        reShare: () {
                                          //TODO: Implement re-share
                                        },
                                        myUserId: user.uid,
                                        analytics: widget.analytics,
                                      ))
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
            }),
      );
    }
  }
}
