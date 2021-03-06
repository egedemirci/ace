import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/geoCity.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = "/addPost";

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _controller = TextEditingController();
  final _controllerUrl = TextEditingController();
  final ScrollController scrollController = ScrollController();
  UserServices userServices = UserServices();
  PostServices postServices = PostServices();
  String postText = '';
  String postTopic = '';
  final ImagePicker _picker = ImagePicker();
  File? _image;
  File? _video;

  final Location location = Location();
  LocationData? _locData;
  PermissionStatus? permissionStatus;
  bool? serviceEnabled;
  bool loading = false;
  String? error;
  String city = "";
  bool isLocationShared = false;

  Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                children: [
                  Text(message),
                ],
              )),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                children: [
                  Text(message),
                ],
              )),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        });
  }

  void _scrollDown() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      final imageTemp = File(image!.path);
      setState(() {
        _image = imageTemp;
      });
    } catch (e) {
      FirebaseCrashlytics.instance.log(e.toString());
    }
  }

  Future pickVideo() async {
    try {
      final video = await _picker.pickVideo(source: ImageSource.gallery);
      final videoTemp = File(video!.path);
      setState(() {
        _video = videoTemp;
      });
    } catch (e) {
      FirebaseCrashlytics.instance.log(e.toString());
    }
  }

  Future<void> _getLocation() async {
    bool permissionGranted = false;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.unableToDetermine || permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (!(permission == LocationPermission.deniedForever) ||
          !(permission == LocationPermission.denied)) {
        await _showDialog("Success", "Thank you for sharing your location!");
        permissionGranted = true;
      }
    } else if (permission == PermissionStatus.granted ||
        permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      permissionGranted = true;
    }
    if (permissionGranted) {
      setState(() {
        error = null;
        loading = true;
      });
      try {
        final LocationData locResult = await location.getLocation();
        setState(() {
          _locData = locResult;
          loading = false;
        });
      } on PlatformException catch (e) {
        setState(() {
          error = e.toString();
          loading = false;
        });
      }
    } else {
      await _showDialog("Location Services Denied",
          "From your settings, enable location services for this app to share your location.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    setCurrentScreen(widget.analytics, "Add Post View", "add_post.dart");
    setUserId(widget.analytics, user!.uid);
    return FutureBuilder(
        future: userServices.usersRef.doc(user.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            MyUser myUser =
                MyUser.fromJson(snapshot.data!.data() as Map<String, dynamic>);

            if (myUser.isDisabled){
              return Scaffold(
                  backgroundColor: AppColors.profileScreenBackgroundColor,
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
                    toolbarHeight: screenHeight(context) * 0.08,
                    elevation: 0,
                    centerTitle: true,
                    foregroundColor: AppColors.welcomeScreenBackgroundColor,
                    title: SizedBox(
                      width: screenWidth(context) * 0.65,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Add New Post",
                          style: messageHeader,
                        ),
                      ),
                    ),
                    backgroundColor: AppColors.profileScreenBackgroundColor,
                  ),
              body: const Center(child: Text("Your account is not active."))
              );
            }
            else{
            return Scaffold(
              resizeToAvoidBottomInset: true,
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
                toolbarHeight: screenHeight(context) * 0.08,
                elevation: 0,
                centerTitle: true,
                foregroundColor: AppColors.welcomeScreenBackgroundColor,
                title: SizedBox(
                  width: screenWidth(context) * 0.65,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Add New Post",
                      style: messageHeader,
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(screenHeight(context) * 0.058),
                              ),
                              color: AppColors.addPostColor,
                            ),
                            width: screenWidth(context) * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: TextField(
                                minLines: 1,
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(screenHeight(context) * 0.058),
                              ),
                              color: AppColors.addPostColor,
                            ),
                            width: screenWidth(context) * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                                  postTopic = value;
                                }),
                              ),
                            )),
                        SizedBox(
                          height: screenHeight(context) * 0.023,
                        ),
                        if (isLocationShared)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              "Your location is: $city",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        if (_image != null)
                          Center(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                screenHeight(context) * 0.017),
                            child: Image.file(
                              _image!,
                              width: screenWidth(context) * 0.97,
                              height: screenHeight(context) * 0.46,
                              fit: BoxFit.cover,
                            ),
                          ))
                        else if (_video != null)
                          const Center(
                              child: Text("Your video is ready to upload!"))
                        else
                          Container(),
                        SizedBox(
                          height: screenHeight(context) * 0.023,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: () async {
                                String url = "default";
                                String media = "default";
                                if (_image != null) {
                                  url = await postServices.uploadPostPicture(
                                      user,
                                      _image!,
                                      (myUser.posts.length + 1).toString());
                                  media = "photo";
                                }
                                if (_video != null) {
                                  url = await postServices.uploadPostVideo(
                                      user,
                                      _video!,
                                      (myUser.posts.length + 1).toString());
                                  media = "video";
                                }
                                Post userPost = Post(
                                    assetUrl: url,
                                    urlAvatar: myUser.profilepicture,
                                    postId: myUser.userId +
                                        (myUser.posts.length + 1).toString(),
                                    userId: user.uid,
                                    text: postText,
                                    comments: [],
                                    likes: [],
                                    dislikes: [],
                                    mediaType: media,
                                    createdAt: DateTime.now(),
                                    username: myUser.username,
                                    fullName: myUser.fullName,
                                    topic: postTopic,
                                    fromWho: myUser.userId,
                                    location: city.isNotEmpty ? city : "");
                                postServices.createPost(user.uid, userPost);
                                setState(() {
                                  FocusScope.of(context).unfocus();
                                  _controller.clear();
                                  _controllerUrl.clear();
                                  postText = "";
                                  postTopic = "";
                                });
                                if (!mounted) return;
                                Navigator.pop(context);
                                Navigator.pushNamedAndRemoveUntil(context,
                                    OwnProfileView.routeName, (route) => false);
                              },
                              style: OutlinedButton.styleFrom(
                                fixedSize: Size(screenWidth(context) * 0.4,
                                    screenHeight(context) * 0.07),
                                elevation: 0,
                                backgroundColor: AppColors.sharePostColor,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenHeight(context) * 0.0345)),
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Ace!",
                                  style: aceButton,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth(context) * 0.048,
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                fixedSize: Size(screenWidth(context) * 0.4,
                                    screenHeight(context) * 0.07),
                                elevation: 0,
                                backgroundColor: AppColors.sharePostColor,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        screenHeight(context) * 0.0345)),
                              ),
                              onPressed: () async {
                                if (isLocationShared) {
                                  setState(() {
                                    _locData = null;
                                    isLocationShared = false;
                                    city = "";
                                  });
                                } else {
                                  await _getLocation();
                                  final g = GeoCity(
                                      lt: _locData!.latitude!,
                                      lg: _locData!.longitude!);
                                  String place = await g.getPlace() as String;
                                  setState(() {
                                    city = place;
                                    isLocationShared = true;
                                  });
                                }
                              },
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Add Location",
                                  style: aceButton,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                color: AppColors.addPostColor,
                elevation: 0,
                child: SizedBox(
                  width: screenWidth(context) * 0.048,
                  height: screenHeight(context) * 0.095,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            if (_image == null) {
                              await pickImage();
                            } else {
                              setState(() {
                                _image = null;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.camera_alt_rounded,
                            size: screenHeight(context) * 0.0345,
                          ),
                          splashRadius: screenHeight(context) * 0.035,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: screenWidth(context) * 0.097,
                          height: screenHeight(context) * 0.046,
                          child: VerticalDivider(
                            width: 0,
                            thickness: screenHeight(context) * 0.0035,
                            color: AppColors.postTextColor,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            if (_video == null) {
                              await pickVideo();
                            } else {
                              setState(() {
                                _video = null;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.video_collection,
                            size: screenHeight(context) * 0.0345,
                          ),
                          splashRadius: screenHeight(context) * 0.035,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
            }
          }
        });
  }
}
