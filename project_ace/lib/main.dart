//It is in draft name
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/page_routes/profile_view.dart';
import 'package:project_ace/page_routes/signup.dart';
import 'package:project_ace/page_routes/welcome.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:project_ace/utilities/analytics.dart';
import 'package:project_ace/utilities/bloc_observer.dart';
import 'package:project_ace/utilities/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:project_ace/page_routes/homePage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyFirebaseApp(), routes: {
    SignUp.routeName: (context) => const SignUp(),
    Login.routeName: (context) => const Login(),
    ProfileView.routeName: (context) => const ProfileView(),
  }));
}

class MyFirebaseApp extends StatelessWidget {
  MyFirebaseApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          ErrorScreen(
            message: snapshot.error.toString(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<User?>.value(
            value: FirebaseAuthService().user,
            initialData: null,
            child: const AuthenticationStatus(),
          );
        }
        return const WelcomePage();
      },
    );
  }
}

class AuthenticationStatus extends StatefulWidget {
  const AuthenticationStatus({Key? key}) : super(key: key);

  @override
  State<AuthenticationStatus> createState() => _AuthenticationStatusState();
}

class _AuthenticationStatusState extends State<AuthenticationStatus> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return const Login();
    } else {
      return const ProfileView();
    }
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Ace"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

/*
// Shared Preferences -> Keys are string, values can be dynamic.
    SharedPreferences? prefs;
    prefs = await SharedPreferences.getInstance();
    prefs!.setInt(key, value);
    prefs!.getInt(key);
    await prefs!.remove(key);

// Firebase Analytics
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({Key? key}) : super(key: key);

    static FirebaseAnalytics analytic = AppAnalytics.analytics;

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: "Firebase Analytics",
        home: MyHomePage(
          title: "Firebase Analytics",
          analytics: analytic,
        ),
      );
    }
  }

  class MyHomePage extends StatefulWidget {
    const MyHomePage({Key? key, required this.title, required this.analytics})
        : super(key: key);

    final String title;
    final FirebaseAnalytics analytics;

    @override
    State<MyHomePage> createState() => _MyHomePageState();
  }

  class _MyHomePageState extends State<MyHomePage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                  onPressed: () async {
                    await AppAnalytics.setUserID("123456789");
                  },
                  child: const Text("Test Set User ID")),
              MaterialButton(
                  onPressed: () async {
                    await AppAnalytics.setScreenName("Analytics Screen");
                  },
                  child: const Text("Test Set Screen Name")),
              MaterialButton(
                  onPressed: () async {
                    await AppAnalytics.logCustomEvent(
                        "Test_Log_Custom_Event", <String, dynamic>{
                      'key1': 'value1',
                      'key2': 1,
                      'key3': true,
                      'key4': 1.45,
                      'key5': 123456789012345,
                    });
                  },
                  child: const Text("Test Custom Log Event")),
            ],
          ),
        ),
      );
    }
  }
// Streams and Providers
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

efefefefefefefeef
 */
