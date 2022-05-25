import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/page_routes/signup.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/analytics.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({Key? key,required this.analytics}) : super(key: key);
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
    setCurrentScreen(widget.analytics, "Walkthrough View", "walkthroughView");
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
        const SizedBox(height: 10),
        ClipRect(
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
