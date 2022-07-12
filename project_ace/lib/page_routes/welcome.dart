import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = "/welcome";

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(analytics, "Welcome View", "welcome.dart");
    return Scaffold(
      backgroundColor: AppColors.welcomeScreenBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRect(
                child: Image(
                    image: const NetworkImage(
                        'https://i.hizliresim.com/bxfjezq.png'),
                    width: screenWidth(context) * 0.5,
                    height: screenHeight(context) * 0.25),
              ),
              Text("Welcome to Ace!", style: welcomeScreenText)
            ],
          ),
        ),
      ),
    );
  }
}
