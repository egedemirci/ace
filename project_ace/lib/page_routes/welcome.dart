import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = "/welcome";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user!=null){
      setUserId(analytics, user.uid);
    }
    setCurrentScreen(analytics, "Welcome View", "welcome.dart");
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
