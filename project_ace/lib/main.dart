// This file is connected to the Draft Branch
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_ace/page_routes/add_post.dart';
import 'package:project_ace/page_routes/bookmarks.dart';
import 'package:project_ace/page_routes/change_password.dart';
import 'package:project_ace/page_routes/chat.dart';
import 'package:project_ace/page_routes/delete_account.dart';
import 'package:project_ace/page_routes/edit_bio.dart';
import 'package:project_ace/page_routes/edit_post.dart';
import 'package:project_ace/page_routes/feed.dart';
import 'package:project_ace/page_routes/firestore_search.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/page_routes/messages.dart';
import 'package:project_ace/page_routes/notifications.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/profile_settings.dart';
import 'package:project_ace/page_routes/profile_view.dart';
import 'package:project_ace/page_routes/search.dart';
import 'package:project_ace/page_routes/signup.dart';
import 'package:project_ace/page_routes/walkthrough.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:project_ace/services/auth_services.dart';
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
            home: Scaffold(
              body: Center(
                child: Text(
                    'No Firebase Connection!!! ${snapshot.error.toString()}'),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          //FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
          return const AceBase();
        }
        return const MaterialApp(
          home: Center(child: Text("Connecting to Firebase...")),
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
  // static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
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
              initialRoute: (snapshot.data == true)
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
                FirestoreSearch.routeName: (context) => FirestoreSearch(
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
          } else {
            // TODO: Find a way to add the WelcomePage here!
            return Container();
          }
        },
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

// Useful Widgets
void main() {
  runApp(const MyApp());
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pc = PageController(initialPage: 3);
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: PageView(
        controller: pc,
        children: [
          pageOne(context),
          myWrap(),
          myRow(),
          myTable(context),
          chipBuilder(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget pageOne(BuildContext context) {
    return Center(
        child: Text(
      "Hello",
      style: Theme.of(context).textTheme.headline1,
    ));
  }

  Widget myContainer() {
    return Container(
      width: 80,
      height: 80,
      color: Colors.green,
    );
  }

  Widget myRow() {
    return Row(
      children: [
        myContainer(),
        myContainer(),
        myContainer(),
      ],
    );
  }

  Widget chipBuilder(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: [
        myChip("Gamer", const Color(0xFFFF0000), context),
        myChip("Hacker", const Color(0xFF00FF00), context),
        myChip("Pro Developer", const Color(0xFF0000FF), context),
        myChip("F1 Racer", const Color(0xFFFF00FF), context),
        myInputChip(),
      ],
    );
  }

  Widget myChip(String label, Color color, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: Theme.of(context).textTheme.headline6!.fontSize,
          ),
        ),
        backgroundColor: color,
        elevation: 2,
        shadowColor: Colors.grey[60],
        padding: const EdgeInsets.all(4),
        labelPadding: const EdgeInsets.all(4),
        avatar: CircleAvatar(
            backgroundColor: Colors.white70,
            child: Text(label[0].toUpperCase())),
        deleteIcon: const Icon(Icons.cancel),
        deleteIconColor: Colors.white70,
        onDeleted: () {
          print('delete');
        },
      ),
    );
  }

  Widget myInputChip() {
    return InputChip(
      padding: const EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.pink.shade600,
        child: const Text('FD'),
      ),
      label: Text(
        'Flutter Devs',
        style: TextStyle(
          color: _isSelected ? Colors.white : Colors.black,
        ),
      ),
      selected: _isSelected,
      onSelected: (bool selected) {
        setState(() {
          _isSelected = selected;
        });
      },
    );
  }

  Widget myWrap() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            spacing: 10,
            runSpacing: 10,
            children: [
              myContainer(),
              myContainer(),
            ]),
      ),
    );
  }

  Widget myTable(BuildContext context) {
    return Table(
      defaultColumnWidth: const FixedColumnWidth(64),
      // const IntrinsicColumnWidth(), const FixedColumnWidth(64), const FractionColumnWidth(0.3), const FlexColumnWidth(1.0),
      border: TableBorder.all(
        color: Theme.of(context).primaryColor,
        width: 8,
      ),
      children: [
        TableRow(children: [
          myWrap(),
        ]),
        TableRow(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Hello",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ]),
      ],
    );
  }
}

 */
