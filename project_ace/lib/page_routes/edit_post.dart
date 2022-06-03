import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/templates/screen_arguments.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';

class EditPostView extends StatefulWidget {
  const EditPostView({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const routeName = "/edit_post";

  @override
  State<EditPostView> createState() => _EditPostViewState();
}

class _EditPostViewState extends State<EditPostView> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  final _controller = TextEditingController();
  String editedPost = "";
  UserServices userService = UserServices();
  PostServices postService = PostServices();

  void _scrollDown() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

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

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    setCurrentScreen(widget.analytics, "Edit Post View", "edit_post.dart");
    final user = Provider.of<User?>(context);
    setUserId(widget.analytics, user!.uid);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.profileScreenBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: screenHeight(context) * 0.034,
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
          splashRadius: screenHeight(context) * 0.035,
        ),
        toolbarHeight: screenHeight(context) * 0.092,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.welcomeScreenBackgroundColor,
        title: SizedBox(
          width: screenWidth(context) * 0.65,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Edit Your Post",
              style: messageHeader,
            ),
          ),
        ),
        backgroundColor: AppColors.profileScreenBackgroundColor,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: screenWidth(context) * 0.75,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight(context) * 0.023),
                      Container(
                          constraints: BoxConstraints(
                              maxHeight: screenHeight(context) * 0.4),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(screenHeight(context) * 0.0575),
                            ),
                            color: AppColors.userNameColor,
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
                              textCapitalization: TextCapitalization.sentences,
                              autocorrect: true,
                              enableSuggestions: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Write some things...",
                                hintStyle: writeSomething,
                              ),
                              onChanged: (value) => setState(() {
                                editedPost = value;
                              }),
                            ),
                          )),
                      SizedBox(height: screenHeight(context) * 0.023),
                      OutlinedButton(
                        onPressed: () async {
                          await postService.editPost(
                              user.uid, args.id, editedPost);
                          await _showDialog("Success!",
                              "Your post has been changed successfully.");
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          fixedSize: Size(screenWidth(context) * 0.5,
                              screenHeight(context) * 0.07),
                          elevation: 0,
                          backgroundColor: AppColors.sharePostColor,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  screenHeight(context) * 0.0575)),
                        ),
                        child: Text(
                          "Save your edited post!",
                          style: aceButton,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
