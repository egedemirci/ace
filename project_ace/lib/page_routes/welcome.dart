import 'package:flutter/material.dart';
import 'package:project_ace/utilities/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  static const String routeName = "/welcome";

  @override
  Widget build(BuildContext context) {
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
