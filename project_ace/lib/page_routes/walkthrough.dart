import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Walkthrough extends StatefulWidget {
  const Walkthrough({Key? key}) : super(key: key);

  static const String routeName = "/walkthrough";

  @override
  State<Walkthrough> createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {
  final pc = PageController(initialPage: 0);
  final List images = [
    'https://i.hizliresim.com/bxfjezq.png',
    'https://i.hizliresim.com/bxfjezq.png',
    'https://i.hizliresim.com/bxfjezq.png',
    'https://i.hizliresim.com/bxfjezq.png',
  ];
  final List titles = [
    "Page 1",
    "Page 2",
    "Page 3",
    "Page 4",
  ];
  final List texts = [
    "This is page 1.",
    "This is page 2.",
    "This is page 3.",
    "This is page 4.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        scrollDirection: Axis.horizontal,
        children: [
          pageBuilder(0),
          pageBuilder(1),
          pageBuilder(2),
          pageBuilder(3),
        ],
      ),
    );
  }

  Widget pageBuilder(int i) {
    bool lastPage = (i == images.length - 1);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Spacer(flex: 1),
            Text(titles[i]),
            const SizedBox(
              height: 10,
            ),
            Image.network(images[i]),
            const SizedBox(),
            Text(texts[i]),
            lastPage
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () async {
                            var prefs = await SharedPreferences.getInstance();
                            if (prefs.getBool("firstLoad") == null) {
                              prefs.setBool("firstLoad", false);
                            }
                            Navigator.pushNamedAndRemoveUntil(
                                context, Login.routeName, (route) => false);
                          },
                          child: const Text("Log In")),
                    ],
                  )
                : Container(),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
