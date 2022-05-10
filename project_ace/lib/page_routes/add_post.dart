import 'package:flutter/material.dart';
import 'package:project_ace/utilities/colors.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  static const String routeName = "/addPost";

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("New Post"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [Text("Welcome to post screen'")],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.camera_alt_rounded)),
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
              IconButton(onPressed: () {}, icon: const Icon(Icons.text_fields)),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
