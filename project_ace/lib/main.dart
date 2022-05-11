// This file is connected to the Draft Branch
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/page_routes/notifications.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/profile_settings.dart';
import 'package:project_ace/page_routes/profile_view.dart';
import 'package:project_ace/page_routes/signup.dart';
import 'package:project_ace/page_routes/welcome.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:project_ace/utilities/analytics.dart';
import 'package:project_ace/utilities/bloc_observer.dart';
import 'package:project_ace/utilities/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:project_ace/page_routes/homePage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyFirebaseApp(), routes: {
    SignUp.routeName: (context) => const SignUp(),
    Login.routeName: (context) => const Login(),
    ProfileView.routeName: (context) => const ProfileView(),
    AddPost.routeName: (context) => const AddPost(),
    OwnProfileView.routeName: (context) => const OwnProfileView(),
    ProfileSettings.routeName: (context) => const ProfileSettings(),
    NotificationScreen.routeName: (context) => const NotificationScreen(),
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
      return const OwnProfileView();
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

// Firestore
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
            home: Scaffold(
              body: Center(
                child: Text(
                    'No Firebase Connection: ${snapshot.error.toString()}'),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(
            home: MyApp(),
          );
        }
        return const MaterialApp(
          home: Center(
            child: Text('Connecting to Firebase'),
          ),
        );
      },
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_image!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    try {
      await firebaseStorageRef.putFile(File(_image!.path));
      print("Upload complete");
      setState(() {
        _image = null;
      });
    } on FirebaseException catch (e) {
      print('ERROR: ${e.code} - ${e.message}');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CS310 Firebase'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text('Connected to Firebase')),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: _image != null
                            ? Image.file(File(_image!.path))
                            : TextButton(
                                child: const Icon(
                                  Icons.add_a_photo,
                                  size: 150,
                                ),
                                onPressed: pickImage,
                              )),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_image != null)
                  OutlinedButton(
                    onPressed: () {
                      uploadImageToFirebase(context);
                    },
                    child: const Text('Upload image'),
                  ),
                const SizedBox(
                  width: 16,
                ),
                if (_image != null)
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _image = null;
                      });
                    },
                    child: const Text('Cancel'),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
 */
