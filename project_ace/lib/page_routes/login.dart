import 'dart:convert';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/profile_view.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/page_routes/signup.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/firebase_auth.dart';
import 'package:project_ace/utilities/screenSizes.dart';
import "package:project_ace/utilities/api.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  static const String routeName = "/login";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';
  late String s;

  final FirebaseAuthService _auth = FirebaseAuthService();

  Future<dynamic> loginUser() async {
    dynamic result = await _auth.signInWithEmailPassword(_email, _password);
    if (result is String) {
      _showDialog("Login Error", result);
    } else if (result is User) {
      // user is signed in.
      // Navigator.pushNamedAndRemoveUntil(context, ProfileView.routeName, (route) => false);
    } else {
      _showDialog("Login Error", result.toString());
    }
  }

  Future getUsers() async {
    final url = Uri.parse(API.allUsers);
    final response = await http.get(Uri.https(url.authority, url.path));
    //_showDialog("Response", "${response.statusCode}");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Successful
      // _showDialog("HTTP Response: ${response.statusCode}", response.body);
      /*
      Map<String, dynamic> post = jsonDecode(response.body);
      print('User ID: ${post["userId"]}');
      print('Title: ${post["title"]}');
      print('Body: ${post["body"]}');
      JSONPost newPost = JSONPost(
          title: post["title"],
          body: post["body"],
          userID: post["userId"],
          postID: post["id"]);
      print(newPost);
      */
      var responseList = jsonDecode(response.body) as List;
      /*
      print("Post Count: ${responseList.length}");
      List<JSONPost> postItems =
          responseList.map((postItem) => JSONPost.fromJSON(postItem)).toList();
      print("${postItems[10]}");
       */
      List<MyUser> users =
          responseList.map((user) => MyUser.fromJSON(user)).toList();
      print("Latitude: ${users[1].address.geo.lat}");
      print("Longitude: ${users[1].address.geo.lng}");
    } else {
      // Unsuccessful
      _showDialog("HTTP Response: ${response.statusCode}", response.body);
    }
  }

  Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                children: [
                  Text(message),
                ],
              )),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                children: [
                  Text(message),
                ],
              )),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    s = '';
    /*_auth.authStateChanges().listen((user) {
      if (user == null) {
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, ProfileView.routeName, (route) => false);
      }
    });
     */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.loginScreenBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            ClipRect(
              child: Image.asset(
                "assets/images/ace_logo_edited.png",
                scale: 1.075,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: screenWidth(context) - 80,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            color: AppColors.loginFormTextColor),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [Text("e-mail")],
                        ),
                        fillColor: AppColors.loginFormBackgroundColor,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Cannot leave email empty!';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email address!';
                          }
                        }
                      },
                      onSaved: (value) {
                        _email = value ?? "";
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autocorrect: false,
                      enableSuggestions: false,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                            color: AppColors.loginFormTextColor),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [Text("password")],
                        ),
                        fillColor: AppColors.loginFormBackgroundColor,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'Cannot leave password empty!';
                          }
                          if (value.length < 6) {
                            return 'Password is too short!';
                          }
                        }
                      },
                      onSaved: (value) {
                        _password = value ?? "";
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await loginUser();
                    } else {
                      _showDialog(
                          'Form Error', "Your email or password is invalid!");
                    }
                  },
                  child: const Text(
                    "LOG IN",
                    style: TextStyle(
                      color: AppColors.loginSignupButtonTextColor,
                      fontSize: 20,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.loginSignupButtonBackgroundColor,
                    fixedSize: const Size(125, 40),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "OR CONNECT WITH",
                  style: TextStyle(
                      color: AppColors.loginPageTextColor, fontSize: 12),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: Image.asset("assets/images/meta.png", scale: 25),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors
                              .loginPageMetaGoogleOptionBackgroundColor,
                          fixedSize: const Size(150, 40)),
                    ),
                    const SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () {},
                      child: Image.asset("assets/images/google.png", scale: 25),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors
                              .loginPageMetaGoogleOptionBackgroundColor,
                          fixedSize: const Size(150, 40)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "NEED ACCOUNT?",
                  style: TextStyle(
                    color: AppColors.loginPageTextColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, SignUp.routeName, (route) => false);
                  },
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(
                        color: AppColors.welcomeScreenBackgroundColor,
                        fontSize: 20),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.loginSignupButtonBackgroundColor,
                    fixedSize: const Size(125, 40),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
