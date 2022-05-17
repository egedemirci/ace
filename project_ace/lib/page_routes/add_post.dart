import 'package:flutter/material.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  static const String routeName = "/addPost";

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.welcomeScreenBackgroundColor,
        title: Text(
          "Add New Post",
          style: addPostTitle,
        ),
        backgroundColor: AppColors.profileScreenBackgroundColor,
      ),
      backgroundColor: AppColors.profileScreenBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  color: AppColors.userNameColor,
                ),
                width: 400,
                height: 300,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none),
                      maxLines: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      "Ace!",
                      style: aceButton,
                    ),
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(250, 50),
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
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.userNameColor,
        elevation: 0,
        child: SizedBox(
          width: 20,
          height: 80,
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
