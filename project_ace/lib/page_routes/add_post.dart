import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key, required this.analytics}) : super(key: key);

  static const String routeName = "/addPost";
  final FirebaseAnalytics analytics;

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _controller = TextEditingController();
  final _controllerUrl = TextEditingController();
  final ScrollController scrollController = ScrollController();
  PostService postService = PostService();
  String postText = '';
  String topic = '';
  UserServices userServices = UserServices();

  void sendPost() async {
    setState(() {
      FocusScope.of(context).unfocus();
      _controller.clear();
    });
  }

  void _scrollDown() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  final ImagePicker _picker = ImagePicker();
  File? _image;
  File? _video;

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      final imageTemporary = File(image!.path);
      setState(() {
        _image = imageTemporary;
      });
    } catch (e) {
      FirebaseCrashlytics.instance.log(e.toString());
    }
  }

  // TODO : Add the correct video player
  Future pickVideo() async {
    try {
      final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
      final videoTemp = File(video!.path);
      setState(() {
        _video = videoTemp;
      });
    } catch (e) {
      FirebaseCrashlytics.instance.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User?>(context);
    setCurrentScreen(widget.analytics, "Add Post View", "add_post.dart");

    if (currentUser == null) {

      return const Center(child: CircularProgressIndicator());
    } else {
      setUserId(widget.analytics, currentUser.uid);
      // TODO: Extend the implementation of Screen Sizes
      return FutureBuilder(
          future: userServices.usersRef.doc(currentUser.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              MyUser myUser = MyUser.fromJson(
                  snapshot.data!.data() as Map<String, dynamic>);
              return Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      }),
                  toolbarHeight: 80,
                  elevation: 0,
                  centerTitle: true,
                  foregroundColor: AppColors.welcomeScreenBackgroundColor,
                  title: SizedBox(
                    width: screenWidth(context) * 0.65,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Add New Post",
                        style: addPostTitle,
                      ),
                    ),
                  ),
                  backgroundColor: AppColors.profileScreenBackgroundColor,
                ),
                backgroundColor: AppColors.profileScreenBackgroundColor,
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight(context) * 0.02,
                          ),
                          Container(
                              constraints: BoxConstraints(
                                  maxHeight: screenHeight(context) * 0.4),
                              margin: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                color: AppColors.userNameColor,
                              ),
                              width: screenWidth(context) * 0.9,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: TextField(
                                  minLines: 15,
                                  maxLines: 15,
                                  onTap: () async {
                                    await Future.delayed(
                                        const Duration(milliseconds: 500));
                                    _scrollDown();
                                  },
                                  controller: _controller,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autocorrect: true,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'What do you want to tell?',
                                    hintStyle: writeSomething,
                                  ),
                                  onChanged: (value) => setState(() {
                                    postText = value;
                                  }),
                                ),
                              )),
                          Container(
                              constraints: BoxConstraints(
                                  maxHeight: screenHeight(context) * 0.4),
                              margin: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                color: AppColors.userNameColor,
                              ),
                              width: screenWidth(context) * 0.9,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                child: TextField(
                                  onTap: () async {
                                    await Future.delayed(
                                        const Duration(milliseconds: 500));
                                    _scrollDown();
                                  },
                                  controller: _controllerUrl,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  autocorrect: true,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Topic',
                                    hintStyle: writeSomething,
                                  ),
                                  onChanged: (value) => setState(() {
                                    topic = value;
                                  }),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          if (_image != null)
                            Center(
                                child: ClipRect(
                              child: Image.file(
                                _image!,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.fitHeight,
                              ),
                            ))
                          else if (_video != null)
                            const Center()
                          else
                            Container(),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              OutlinedButton(
                                onPressed: () async {
                                  String url = "default";
                                  if (_image != null) {
                                    url = await postService.uploadPostPicture(
                                        currentUser,
                                        _image!,
                                        (myUser.posts.length + 1).toString());
                                  }
                                  Post userPost = Post(
                                      assetUrl: url,
                                      postId:
                                          (myUser.posts.length + 1).toString(),
                                      userId: currentUser.uid,
                                      text: postText,
                                      comments: [],
                                      likes: [],
                                      dislikes: [],
                                      createdAt: DateTime.now(),
                                      username: myUser.username,
                                      fullName: myUser.fullName,
                                      topic: topic);
                                  postService.createPost(
                                      currentUser.uid, userPost);
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    _controller.clear();
                                    _controllerUrl.clear();
                                    postText = "";
                                    topic = "";
                                  });
                                  Navigator.pop(context);
                                },
                                style: OutlinedButton.styleFrom(
                                  fixedSize: Size(screenWidth(context) * 0.5,
                                      screenHeight(context) * 0.07),
                                  elevation: 0,
                                  backgroundColor: AppColors.sharePostColor,
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                child: Text(
                                  "Ace!",
                                  style: aceButton,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
                  color: AppColors.userNameColor,
                  elevation: 0,
                  child: SizedBox(
                    width: 20,
                    height: screenHeight(context) * 0.095,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Spacer(),
                          IconButton(
                              onPressed: () async {
                                await pickImage();
                              },
                              icon: const Icon(
                                Icons.camera_alt_rounded,
                                size: 30,
                              )),
                          const Spacer(),
                          const SizedBox(
                            width: 40,
                            height: 40,
                            child: VerticalDivider(
                              width: 0,
                              thickness: 3,
                              color: AppColors.postTextColor,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () async {
                                await pickVideo();
                              },
                              icon: const Icon(
                                Icons.video_collection,
                                size: 30,
                              )),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          });
    }
  }
}
