// This file is connected to the Draft Branch
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/bookmarks.dart';
import 'package:project_ace/page_routes/change_password.dart';
import 'package:project_ace/page_routes/delete_account.dart';
import 'package:project_ace/page_routes/edit_bio.dart';
import 'package:project_ace/page_routes/edit_post.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/notifications.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/profile_settings.dart';
import 'package:project_ace/page_routes/search.dart';
import 'package:project_ace/page_routes/signup.dart';
import 'package:project_ace/page_routes/walkthrough.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:project_ace/services/auth_services.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:project_ace/utilities/transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool seen = false;

Future<bool> checkFirstSeen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  seen = (prefs.getBool('seen') ?? false);
  if (!seen) {
    prefs.setBool("seen", true);
  }
  return seen;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyFirebaseApp());
}

class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text(
                  'No Server Connection!!! ${snapshot.error.toString()}',
                  style: feedHeader,
                ),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          FlutterError.onError =
              FirebaseCrashlytics.instance.recordFlutterError;
          return const AceBase();
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              backgroundColor: AppColors.profileScreenBackgroundColor,
              body: Center(
                  child: Text(
                "Connecting to the Servers...",
                style: feedHeader,
              ))),
        );
      },
    );
  }
}

class AceBase extends StatefulWidget {
  const AceBase({Key? key}) : super(key: key);

  @override
  _AceBaseState createState() => _AceBaseState();
}

class _AceBaseState extends State<AceBase> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final Future<bool> firstOpen = checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthServices().user,
      initialData: null,
      child: FutureBuilder(
        future: checkFirstSeen(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: (snapshot.data! == true)
                  ? Login.routeName
                  : Walkthrough.routeName,
              routes: {
                SignUp.routeName: (context) => SignUp(
                      analytics: analytics,
                    ),
                Login.routeName: (context) => Login(
                      analytics: analytics,
                    ),
                AddPost.routeName: (context) => AddPost(
                      analytics: analytics,
                    ),
                OwnProfileView.routeName: (context) => OwnProfileView(
                      analytics: analytics,
                    ),
                ProfileSettings.routeName: (context) => ProfileSettings(
                      analytics: analytics,
                    ),
                NotificationScreen.routeName: (context) => NotificationScreen(
                      analytics: analytics,
                    ),
                Walkthrough.routeName: (context) => Walkthrough(
                      analytics: analytics,
                    ),
                Feed.routeName: (context) => Feed(
                      analytics: analytics,
                    ),
                Search.routeName: (context) => Search(
                      analytics: analytics,
                    ),
                MessageScreen.routeName: (context) => MessageScreen(
                      analytics: analytics,
                    ),
                ChangePassword.routeName: (context) =>
                    ChangePassword(analytics: analytics),
                EditBioView.routeName: (context) =>
                    EditBioView(analytics: analytics),
                DeleteAccount.routeName: (context) =>
                    DeleteAccount(analytics: analytics),
                BookMarks.routeName: (context) =>
                    BookMarks(analytics: analytics),
                EditPostView.routeName: (context) =>
                    EditPostView(analytics: analytics),
              },
              theme: ThemeData(
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: NoTransitionsBuilder(),
                    TargetPlatform.iOS: NoTransitionsBuilder(),
                  },
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
