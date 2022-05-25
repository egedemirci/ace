import 'package:flutter/cupertino.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';

import '../services/analytics.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key, required this.analytics}) : super(key: key);

  static const String routeName = "/addPost";
  final FirebaseAnalytics analytics;
  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  String postText = '';

  void sendPost() async {
    setState(() {
      FocusScope.of(context).unfocus();
      _controller.clear();
    });
  }

  void _scrollDown() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }
  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Add Post View", "addPostView");
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
          width: screenWidth(context)*0.65,
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
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight(context)*0.09,
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: screenHeight(context)*0.4),
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    color: AppColors.userNameColor,
                  ),
                  width: screenWidth(context)*0.9,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: TextField(

                      minLines: 15,
                      maxLines: 15,
                      onTap: ()async{
                        await Future.delayed(const Duration(milliseconds: 500));
                        _scrollDown();
                      },
                      controller: _controller,
                      textCapitalization: TextCapitalization.sentences,
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
                  )
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        sendPost();
                      },
                      child: Text(
                        "Ace!",
                        style: aceButton,
                      ),
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size(screenWidth(context)*0.5, screenHeight(context)*0.07),
                        elevation: 0,
                        backgroundColor: AppColors.sharePostColor,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
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
          height: screenHeight(context)*0.095,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Spacer(),
                IconButton(
                    onPressed: () {},
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.text_fields,
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
}
