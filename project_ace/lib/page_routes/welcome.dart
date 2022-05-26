import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/utilities/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = "/welcome";

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(analytics, "Welcome View", "welcomeView");
    return Scaffold(
      backgroundColor: AppColors.welcomeScreenBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ClipRect(
                child: Image(
                    image: NetworkImage('https://i.hizliresim.com/bxfjezq.png'),
                    width: 200,
                    height: 200),
              )
            ],
          ),
        ),
      ),
    );
  }
}
