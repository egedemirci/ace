import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = "/walkthrough";

  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  final pc = PageController(initialPage: 0);

  final List images = [
    'https://i.hizliresim.com/5dm4a13.png',
    'https://i.hizliresim.com/4s015vi.png',
    'https://i.hizliresim.com/qbzfn2w.png',
  ];

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Walkthrough View", "walkthrough.dart");
    return Scaffold(
      backgroundColor: AppColors.signUpScreenBackgroundColor,
      body: SafeArea(
        child: PageView(
          controller: pc,
          scrollDirection: Axis.horizontal,
          children: [
            pageBuilder(0),
            pageBuilder(1),
            pageBuilder(2),
          ],
        ),
      ),
    );
  }

  Widget pageBuilder(int i) {
    bool lastPage = (i == images.length - 1);
    return Column(
      children: [
        SizedBox(height: screenHeight(context) * 0.0115),
        ClipRect(
          // TODO: Implement the correct image size
          child: Image.network(
            images[i],
            scale: 2,
          ),
        ),
        lastPage
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      // TODO: Edit button and text styles
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Login.routeName, (route) => false);
                      },
                      child: const Text("Log In")),
                ],
              )
            : Container(),
      ],
    );
  }
}
